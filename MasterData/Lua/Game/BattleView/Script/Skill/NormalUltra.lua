--
-- Author:luqucheng
-- Date: 2019-12-10 10:50:22
--

local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local KTool = CS.Engine.Lib.KTool

local util = require "XLua.util"
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local ResourceModule = CS.Engine.Modules.ResourceModule

local NormalUltra = {}

--[[
    @desc: 
    author:luqucheng
    time:2019-12-10 11:10:14
    --@record:
	--@skillViewVo:[Game.Setting.Vo.SkillViewVo#SkillViewVo]
	--@target:[Game.BattleView.Entity.RoleView#RoleView]
	--@attacker:[Game.BattleView.Entity.RoleView#RoleView]
	--@star: 
    @return:
]]
function NormalUltra:Show(record, skillViewVo, actionVo, target, attacker, star, onHit)
    --先等待一秒cutin
    coroutine.yield( WaitForSeconds(1) )
   
    --等待cut in 的时候加载
    cs_coroutine.start(self.LoadFX, self, skillViewVo.attackFXs[1] )
    
    coroutine.yield( WaitForSeconds(1) )

    --如果两秒后还没加载完，还是要继续等待
    while not self.complete do
        coroutine.yield( WaitForEndOfFrame() )
    end
    Events.Broadcast(Constants.EventNames.BattleCutInEnd)
    
    
    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)

    --播放动画
    attacker:PlayAnimation(actionVo.actionName)
    cs_coroutine.start(self.HandleFX, self, attacker, targets, skillViewVo)
    -- self.gameObject:FindGameObjectByName('L_hit').transform
    
    --判定打击点
    local nowF = 0
    for i,v in ipairs(actionVo.hits) do
        local t = (v.frame - nowF) * AnimFrameTime
        coroutine.yield( WaitForSeconds(t) )
        onHit(i, actionVo)
        -- for p,tt in ipairs(targets) do
        --     --播放受击特效
        --     BattleViewMgr.FXMgr:PlayFX(skillViewVo.hitFX, tt.fxNode)
        -- end
        if skillViewVo.isAoe then
            BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX, BattleViewMgr:GetAoe(target.camp))
        end
    end

    local t = (actionVo.frame - nowF) * AnimFrameTime
    coroutine.yield( WaitForSeconds(t) )
    --CS.UnityEngine.Resources.UnloadUnusedAssets()
end

function NormalUltra:HandleFX( attacker, targets, skillViewVo )

    self.ultraFX.transform:SetParent(attacker.transform)
    KTool.ResetTransform(self.ultraFX.transform)
    self.ultraFX:SetActive(true)
    
     --设置角色层级
     self:ChangeAllLayer(attacker.gameObject, 10, 8)

     --所有目标都需要改变层级，同时还需要移动到对应的点
     for i,t in ipairs(targets) do
        self:ChangeAllLayer(t.gameObject, 10, 8)
     end
     --设置目标位置和层级
    local mainFX = self.ultraFX
    if mainFX then
        for i,t in ipairs(targets) do
            --是否能找到对应的特效点
            local tp = mainFX:FindGameObjectByName('targetpos'..i)
            if not tp then
                break
            end
            Tools.syncStand(t.transform, tp.transform)
        end
    end
        
    --相机和层级的隐藏显示时间跟着特效的时间走
    --判断是否是绑定骨骼的特效

    local mainFXId = -1
    
    
    --播放所有攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        if i == 1 then
            mainFXId = v
        else
            local uid = BattleViewMgr.FXMgr:PlayFXOnRole(v, attacker)
        end
    end

    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local FXResVo = setting:Get(mainFXId)
    local FXTime = FXResVo.fxTime

    
    

    --主相机隐藏
    BattleViewMgr.camera.gameObject:SetActive(false);

    coroutine.yield( WaitForSeconds(FXTime) )
    CS.UnityEngine.GameObject.Destroy(self.ultraFX)
    self.ultraFX = nil

    --设置角色层级
    self:ChangeAllLayer(attacker.gameObject, 8, 10)
    --恢复
    for i,t in ipairs(targets) do
        self:ChangeAllLayer(t.gameObject, 8, 10)
        Tools.syncStand(t.transform, t.defaultStand)
    end
    BattleViewMgr.camera.gameObject:SetActive(true);
end

function NormalUltra:LoadFX( fxId )
    self.complete = false
    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local FXResVo = setting:Get(fxId)

    local path = gameUtils.GetEffectFullPath(FXResVo.resourcesId)
    local loader = ResourceModule.LoadBundleAsync(path, nil, true)
    while not loader.IsSuccess do
        cs_coroutine.yield_return()
    end
    if not loader.IsError then
        ---这里还出现卡，人物的prefab需要优化
        -- local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
        local go = loader:Instantiate()
        go:SetActive(false)
        self.ultraFX = go
    end
    loader:Release()
    self.complete = true
end


function NormalUltra:Clear(  )

end

return  NormalUltra