--
-- Author:luqucheng
-- Date: 2019-12-11 14:08:46
--
local SkillCardMgr = import('Game.Battle.SkillCard.SkillCardMgr')
local CardController = import('Game.Battle.Entity.CardController')


local PVPPlayer = Class("PVPPlayer", CardController)

function PVPPlayer:__init(camp, playerId, initData)
    CardController.__init(self, camp, playerId, initData)
    if BattleInfo:IsMyPlayerId(self.playerId) then
        self.__OnReceveUseInput = Bind(self, self.OnUIInput)
        self.__OnUIInputFinished = Bind(self, self.OnUIInputFinished)
        self.__OnReceveResetInput = Bind(self, self.OnUIResetInput)
        
        Events.AddListener(Constants.EventNames.BattleInputUse, self.__OnReceveUseInput)
        Events.AddListener(Constants.EventNames.BattleInputFinished, self.__OnUIInputFinished)
        Events.AddListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)

        -- auto出牌
        if BattleInfo.inputMode ~= Constants.InputMode.Replay then
            self.__OnCardAnimFinished = Bind(self, self.OnCardAnimFinished)
            Events.AddListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
        end
    end
    self.__OnReceivedPackage = Bind(self, self.OnReceivedPackage)
    Events.AddListener(Constants.EventNames.BattleNetworkOnReceived, self.__OnReceivedPackage)

    self.canSend = true
end

function PVPPlayer:__delete(  )
    CardController.__delete(self)
    self.inputQueue = nil
    Events.RemoveListener(Constants.EventNames.BattleInputUse, self.__OnReceveUseInput)
    Events.RemoveListener(Constants.EventNames.BattleInputFinished, self.__OnUIInputFinished)
    Events.RemoveListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)
    Events.RemoveListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
    Events.RemoveListener(Constants.EventNames.BattleNetworkOnReceived, self.__OnReceivedPackage)
end

function PVPPlayer:OnReceivedPackage(packageId, packageData)
    local ReceivePackageIds = BattleViewMgr.netMgr.ReceivePackageIds
    if packageId == ReceivePackageIds.InputConfirm and packageData.playerId == self.playerId then
        if BattleViewMgr.battleState == Constants.BattleState.Processing then
            packageData.statusCode = nil
            self:HandleInputData(packageData)
            GameUtils.AfterRequest()
            self.canSend = true
        end
    end
    if packageId == ReceivePackageIds.InputFinished then
        if BattleViewMgr.battleState == Constants.BattleState.Processing then
            packageData.statusCode = nil
            self:OnInputFinished()
            GameUtils.AfterRequest()
        end
    end
    if packageId == ReceivePackageIds.PlayerHosting and packageData.playerId == self.playerId then
        -- if BattleViewMgr.battleState == Constants.BattleState.Processing then
            self:SetHosting(packageData.isOpen == 1)    -- 机器人的托管来的非常快，在processing之前就会发下来
        -- end
    end
end

function PVPPlayer:OnUIResetInput()
    if not self.canSend then
        return
    end
    
    local cardMgr = self.cardMgr
    local maxUseCount = cardMgr:GetSkillCardMaxUseCount()
    if cardMgr.usedSkillNum >= maxUseCount then
        return
    end

    GameUtils.BeforeRequest()
    local p = self:GenerateInputData(self.InputType.ResetInput, {}, -1)
    BattleViewMgr.netMgr:Send(BattleViewMgr.netMgr.SendPackageIds.Input, p)
    -- print("[点击] 重置", p.seqId, CS.UnityEngine.Time.realtimeSinceStartup, table.dump(p, nil, 3))
    self.canSend = false
end

function PVPPlayer:OnUIInput( data )
    if not self.canSend then
        return
    end
    -- print("OnReceveUseInput", table.toString(data, "data"))
    local cardMgr = self.cardMgr
    local maxUseCount = cardMgr:GetSkillCardMaxUseCount()
    if cardMgr.usedSkillNum >= maxUseCount then
        return
    end

    -- GameUtils.BeforeRequest()
    local p = self:GenerateInputData(self.InputType.UseCard, data, -1)
    -- local statusCode = BattleMgr:GetStatusCode()
    -- p.statusCode = statusCode
    BattleViewMgr.netMgr:Send(BattleViewMgr.netMgr.SendPackageIds.Input, p)
    -- print("[点击] 输入", p.seqId, CS.UnityEngine.Time.realtimeSinceStartup, table.dump(p, nil, 3))
    self.canSend = false
end

function PVPPlayer:OnUIInputFinished()
    -- GameUtils.BeforeRequest()
    local p = self:GenerateInputData(self.InputType.Finish, {}, -1)
    p.statusCode = BattleMgr:GetStatusCode()
    BattleViewMgr.netMgr:Send(BattleViewMgr.netMgr.SendPackageIds.Input, p)
end

--卡牌动画播完，可以等待输入
function PVPPlayer:OnCardAnimFinished(  )
    if not self.canSend then
        return
    end

    local pos, target, behaviorParams = AI:AIChooseSkillCard(self.cardMgr)
    local targetId = target and target.id or 0
    local data = {pos=pos, targetId = targetId}

    -- GameUtils.BeforeRequest()
    local p = self:GenerateInputData(self.InputType.UseCard, data, -1)
    -- local statusCode = BattleMgr:GetStatusCode()
    -- p.statusCode = statusCode
    BattleViewMgr.netMgr:Send(BattleViewMgr.netMgr.SendPackageIds.Input, p)
    -- print("[点击] 自动", p.seqId, CS.UnityEngine.Time.realtimeSinceStartup, table.dump(p, nil, 3))
    self.canSend = false
end

return  PVPPlayer