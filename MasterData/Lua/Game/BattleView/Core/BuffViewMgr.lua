--
-- Author:luqucheng
-- Date: 2019-12-16 11:19:02
--
--
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local BuffView = import("Game.BattleView.Core.BuffView")
local Animator = CS.UnityEngine.Animator
local KTool = CS.Engine.Lib.KTool

local BuffViewMgr = {}
BuffViewMgr = Class("BuffViewMgr")

--@RefType [Game.BattleView.Entity.RoleView#RoleView]
BuffViewMgr.owner = nil
--@RefType [Game.BattleView.Core.BuffView#BuffView<>]
BuffViewMgr.buffs = nil
BuffViewMgr.statusAbility = nil--当前buff决定的能力状态，是否可以行动，放技能等

BuffViewMgr.loopFXs = nil--buff的循环特效的字典，同时存在的只能有一个

function  BuffViewMgr:__init(owner)
    self.owner = owner
    self.buffs = {}
    self.loopFXs = {}
    self.statusAbility = {}
    for k,v in pairs(Constants.StatusAbility) do
        self.statusAbility[k] = true
    end
end

function BuffViewMgr:AddBuff( uid, attackerId, buffId, star, lv, lay, remainRound, sourceType)
    --因为是显示层面的，所以无条件直接加就可以了
    local buffData = Core:GetBuffData(buffId, star, lv)
    local attacker = BattleViewMgr:FindRoleView(attackerId)
    --@RefType [Game.BattleView.Core.BuffView#BuffView]
    local buff = BuffView.New(self.owner, attacker, uid, buffData, lay, remainRound)
    table.insert(self.buffs, buff)
    buff:OnAdd()

    if self:HasSpeicalIdle(buff) then
        self:CheckSpecialIdle()
    end

    --刷新属性和状态
    -- Core:RefreshAttr(self.buffs, self.owner.attr)
    -- Core:RefreshStatus(self.buffs, self.statusAbility)
    -- Core:RefreshUnique(self.buffs)

    --发送消息
    Events.Broadcast(Constants.EventNames.BattleAddBuffShow, 
        {uid = uid, buffId = buffId, ownerId = self.owner.id, lay = lay, remain = remainRound, star = star, lv = lv, sourceType = sourceType})
end

function BuffViewMgr:RemoveBuff( uid )
    for i,v in ipairs(self.buffs) do
        if v.id == uid then
            v:OnRemove()
            table.remove( self.buffs, i )

            if self:HasSpeicalIdle(v) then
                self:CheckSpecialIdle()
            end
            --发送移除buff的消息
            Events.Broadcast(Constants.EventNames.BattleRemoveBuffShow, {uid = uid, ownerId = v.owner.id})
            return
        end
    end
end

--@buff: [Game.BattleView.Core.BuffView#BuffView]
function BuffViewMgr:HasSpeicalIdle(buff)
    for i,showId in ipairs(buff.data.showIds) do
        --添加buff的特效
        local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
        --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
        local skillEffectViewVo = setting:Get(showId)

        --如果有loop特效才处理
        --loop特效如果已经存在，无视
        if not skillEffectViewVo then
            return false
        end

        if skillEffectViewVo.specialIdle ~= 0 then
            return true
        end
    end
    return false
end

function BuffViewMgr:CheckSpecialIdle()
    local maxPriority = 0
    local maxSpecialIdle = 0
    --检查当前所有buff，找到优先级最高的，改变角色状态
    for j,buff in ipairs(self.buffs) do
        for i,showId in ipairs(buff.data.showIds) do
            --添加buff的特效
            local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
            --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
            local skillEffectViewVo = setting:Get(showId)
    
            --如果有loop特效才处理
            --loop特效如果已经存在，无视
            if skillEffectViewVo and skillEffectViewVo.specialIdle ~= 0 and skillEffectViewVo.specialIdlePriority > maxPriority then
                maxPriority = skillEffectViewVo.specialIdlePriority
                maxSpecialIdle = skillEffectViewVo.specialIdle
            end
        end
    end

    local idleType = Constants.IdleType.Normal
    if maxSpecialIdle == 101 then
        idleType = Constants.IdleType.SpecialIdle1
    elseif maxSpecialIdle == 201 then
        idleType = Constants.IdleType.Weak
    end

    self.owner:SwitchIdle(idleType)
end

function BuffViewMgr:OnTurnStart(  )
    --所有dot hot的持续时间减少
     --所有非dot hot的持续时间减少
    --  local Dot = Constants.BuffType.Dot
    --  local Hot = Constants.BuffType.Hot
    --  --身上所有的buff持续回合减一
    --  for i,v in ipairs(self.buffs) do
    --      --dot hot 类型在回合初减持续回合数
    --      if v.data.subEffectType == Dot
    --      or v.data.subEffectType == Hot then
    --         v:Change(v.layNum, v.remainRound - 1)
    --         v:OnTrigger()
    --      end
    --  end

    self:CheckSpecialIdle()
end

function BuffViewMgr:OnTurnEnd(  )
    --所有非dot hot的持续时间减少
    local Dot = Constants.BuffType.Dot
    local Hot = Constants.BuffType.Hot
    --身上所有的buff持续回合减一
    for i,v in ipairs(self.buffs) do
       
        --dot hot 类型在回合初减持续回合数
        if v.data.mainEffectType == Dot
        or v.data.mainEffectType == Hot then
            v:OnTrigger()
        end
    end

    self:CheckSpecialIdle()
end

function BuffViewMgr:ChangeBuff( uid, lay, remainRound )
    local buff = self:FindBuff(uid)
    if buff then
        buff:Change(lay, remainRound)
    end
end

--@return [Game.BattleView.Core.BuffView#BuffView]
function BuffViewMgr:FindBuff( uid )
    for i,v in ipairs(self.buffs) do
        if v.id == uid then
            return v
        end
    end
end

function BuffViewMgr:Clear(  )
    for i,v in fipairs(self.buffs) do
        v:OnRemove()
        table.remove(self.buffs, i)
    end

    -- self.buffs = nil
    -- self.owner = nil 
    -- self.statusAbility = nil
end
--@buff: [Game.BattleView.Core.BuffView#BuffView]
function BuffViewMgr:AddLoopFX( buffLoopFX )
    --添加buff的特效
    if buffLoopFX and buffLoopFX ~= 0 then
        local data = self.loopFXs[buffLoopFX]
        if not data then
            data = {fxUid = nil, count = 0, hasHurt = false}
        end
        --只有不存在的效果才加特效
        if data.count <= 0 then
            --判断是否是绑定骨骼的特效
            local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
            --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
            local FXResVo = setting:Get(buffLoopFX)
            -- print("AddLoopFX", FXResVo.id, FXResVo.fxType, FXResVo.resourcesId)
            data.fxType = FXResVo.fxType
            if FXResVo.fxType == Constants.FXType.Matcap then
                data.fxUid = FXResVo.resourcesId
                self.owner:ForcePlayMatCap(FXResVo.resourcesId, true)
            elseif FXResVo.fxType == Constants.FXType.Special then
                data.fxUid = FXResVo.resourcesId
                self:SpecialLoopFX(FXResVo.resourcesId, self.owner, true)
            else
                data.fxUid = BattleViewMgr.FXMgr:PlayFXOnRole(buffLoopFX, self.owner, true)
                data.hasHurt = FXResVo.ifHasHurtAnim == 1
            end
            -- print('BuffView add', buff.id, buff.owner.id, buff.buffID)
        end
        data.count = data.count + 1
        self.loopFXs[buffLoopFX] = data
    end
end

function BuffViewMgr:HasLoopFX( buffLoopFX )
    return buffLoopFX ~= 0 and self.loopFXs[buffLoopFX] and self.loopFXs[buffLoopFX].count > 0
end

--@buff: [Game.BattleView.Core.BuffView#BuffView]
function BuffViewMgr:RemoveLoopFX( buffLoopFX )
    if buffLoopFX and buffLoopFX ~= 0 then
        local data = self.loopFXs[buffLoopFX]
        if not data then
            return
        end
        data.count = data.count - 1
        if data.count <= 0 then
            --存在使用这个循环效果的buff已经没有了
            if data.fxType == Constants.FXType.Matcap then
                self.owner:ForcePlayMatCap(data.fxUid, false)
            elseif data.fxType == Constants.FXType.Special then
                self:SpecialLoopFX(data.fxUid, self.owner, false)
            else
                BattleViewMgr.FXMgr:RemoveFX(data.fxUid)
            end
            data.fxUid = nil
        end
        self.loopFXs[buffLoopFX] = data
    end
end

function BuffViewMgr:SpecialLoopFX(specialType, owner, isAdd)
    if not owner then
        return
    end
    if checkNumber(specialType) == Constants.FXTypeSpecial.Invisible then
        local InvisibleRoleState = KTool.GetOrAddComponent(owner.gameObject, typeof(CS.InvisibleRoleState))
        if isAdd then
            InvisibleRoleState:StartInvisible()
        else
            InvisibleRoleState:StopInvisible()
        end
    elseif checkNumber(specialType) == Constants.FXTypeSpecial.Freeze then
        owner:SetFreeze(isAdd)
    elseif checkNumber(specialType) == Constants.FXTypeSpecial.Unhurt then
        owner:SetUnhurt(isAdd)
    end
end

function BuffViewMgr:ShowLoopFXHurt()
    for k,data in pairs(self.loopFXs) do
        if data.hasHurt then
            local obj = BattleViewMgr.FXMgr:FindFX(data.fxUid)
            if obj then
                local animator = obj:GetComponent(typeof(Animator))
                if not isNull(animator) then
                    animator:Play("fx_buff_dun_hit", 1, 0)
                end
            end
        end
    end
end

--- 查找指定类型的buff，现在只有延迟给波次光环buff做表现的时候用到
---@param buffId any
function BuffViewMgr:FindSpecifyBuff(buffId)
    for i,v in ipairs(self.buffs) do
        if v.buffID == buffId then
            return v
        end
    end
end

return  BuffViewMgr