--
-- Author:luqucheng
-- Date: 2019-12-16 14:52:40
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local cs_coroutine = import('XLua.cs_coroutine')
local BuffView = {}
BuffView = Class("BuffView")

BuffView.buffID = nil
BuffView.id = nil
BuffView.layNum = nil
--@RefType [Game.Battle.Data.EffectData#EffectData]
BuffView.data = nil--配置表内的数据，对应效果表
BuffView.remainRound = nil
--@RefType [Game.BattleView.Entity.RoleView#RoleView]
BuffView.owner = nil
BuffView.attacker = nil

BuffView.value = 0

function BuffView:__init(owner, attacker, uid, buffData, layNum, remainRound)
    self.layNum = layNum
    self.data = buffData
    self.buffID = self.data.id
    self.remainRound = remainRound
    self.id = uid
    self.owner = owner
    self.attacker = attacker
    self.enable = true
    -- print('add BuffView', self.buffID)
    self.showId = 0
    --读取表现id

end

function BuffView:OnAdd(  )
    if not self.data.showIds or #self.data.showIds <=0 then
        return
    end

    for i,showId in ipairs(self.data.showIds) do
        --添加buff的特效
        local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
        --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
        local skillEffectViewVo = setting:Get(showId)

        --如果有loop特效才处理
        --loop特效如果已经存在，无视
        if not skillEffectViewVo then
            return
        end

        --loop特效不存在，播放完开始特效之后，再播放loop
        local node, time = BattleViewMgr.FXMgr:PlayFXOnRole(skillEffectViewVo.addFX, self.owner)

        if isNotNull(skillEffectViewVo.buffLoopFX)then
            if time > 0 then
                self.addCo = cs_coroutine.start(function (  )
                    coroutine.yield( WaitForSeconds(time) )
                    self.owner.buffViewMgr:AddLoopFX(skillEffectViewVo.buffLoopFX)
                    self.addCo = nil
                end)
            else
                self.owner.buffViewMgr:AddLoopFX(skillEffectViewVo.buffLoopFX)
            end
        end

        if skillEffectViewVo.addControllerTrigPoint > 0 then
            self.owner:AddSwitchAnimatorControllerTag({
                trigPoint = skillEffectViewVo.addControllerTrigPoint,
                flagValue = self:SetFlagValue(skillEffectViewVo.addControllerTrigPoint),
                controllerName = skillEffectViewVo.addControllerName,
                initStateName = skillEffectViewVo.addControllerInitStateName,
            })
        end
        if skillEffectViewVo.removeControllerTrigPoint > 0 then
            self.owner:AddSwitchAnimatorControllerTag({
                trigPoint = skillEffectViewVo.removeControllerTrigPoint,
                flagValue = self:SetFlagValue(skillEffectViewVo.removeControllerTrigPoint),
                controllerName = skillEffectViewVo.removeControllerName,
                initStateName = skillEffectViewVo.removeControllerInitStateName,
            })
        end
    end
end

function BuffView:OnTrigger(  )
    -- print("OnTrigger")
    if not self.data.showIds or #self.data.showIds <=0 then
        return
    end
    for i,showId in ipairs(self.data.showIds) do
        --移除特效
        local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
        --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
        local skillEffectViewVo = setting:Get(showId)

        if skillEffectViewVo then
            -- print('BuffView add', self.id, self.owner.id, self.buffID)
            BattleViewMgr.FXMgr:PlayFXOnRole(skillEffectViewVo.buffTriggerFX, self.owner)
            -- print("OnTrigger", skillEffectViewVo.buffTriggerFX)
        end
    end
     
end

function BuffView:OnRemove(  )
    if self.addCo then
        cs_coroutine.stop(self.addCo)
        self.addCo = nil
    end

    if not self.data.showIds or #self.data.showIds <=0 then
        return
    end
    -- print('BuffView remove', self.id, self.owner.id)

    for i,showId in ipairs(self.data.showIds) do
        --移除特效
        local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
        --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
        local skillEffectViewVo = setting:Get(showId)

        if not skillEffectViewVo then
            return
        end
    
        self.owner.buffViewMgr:RemoveLoopFX(skillEffectViewVo.buffLoopFX)
        if skillEffectViewVo and not self.owner.buffViewMgr:HasLoopFX(skillEffectViewVo.buffLoopFX) then
            -- print('BuffView add', self.id, self.owner.id, self.buffID)
            BattleViewMgr.FXMgr:PlayFXOnRole(skillEffectViewVo.buffRemoveFX, self.owner)
        end

        -- buff移除时触发切换动画状态机
        self.owner:TrigSwitchAnimatorController(1, self.id)
    end
end

function BuffView:Change( nowLayer, nowRound )
    self.layNum = nowLayer
    self.remainRound  = nowRound
    Events.Broadcast(Constants.EventNames.BattleChangeBuffShow, {uid = self.id, ownerId = self.owner.id, lay = nowLayer, remain = nowRound})
end

function BuffView:SetFlagValue(trigPoint)
    if trigPoint == 1 then
        -- buff结束时
        return self.id  -- buff自增id
    elseif trigPoint == 2 then
        -- 技能结束时
        return self.owner.id -- 角色id
    end
    return 0
end

return  BuffView