--
-- Author:luqucheng
-- Date: 2019-12-11 14:08:46
--
local SkillCardMgr = import('Game.Battle.SkillCard.SkillCardMgr')
local CardController = import('Game.Battle.Entity.CardController')

local InputProtectTime = 0.05


local OnlinePlayer = Class("OnlinePlayer", CardController)


function OnlinePlayer:__init(camp, playerId, initData)
    CardController.__init(self, camp, playerId, initData)
    if BattleInfo:IsMyPlayerId(self.playerId) then
        self.__OnUIInputFinished = Bind(self, self.OnUIInputFinished)
        self.__OnUIInput = Bind(self, self.OnUIInput)
        self.__OnCardAnimFinished = Bind(self, self.OnCardAnimFinished)

        Events.AddListener(Constants.EventNames.BattleInputFinished, self.__OnUIInputFinished)
        Events.AddListener(Constants.EventNames.BattleInputUse, self.__OnUIInput)
        -- auto出牌
        if BattleInfo.inputMode ~= Constants.InputMode.Replay then
            Events.AddListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
        end
    end
    self.__OnReceivedPackage = Bind(self, self.OnReceivedPackage)
    Events.AddListener(Constants.EventNames.BattleNetworkOnReceived, self.__OnReceivedPackage)

    self.lastInputTime = -1
    self.canSend = true
end

function OnlinePlayer:__delete(  )
    CardController.__delete(self)
    self.inputQueue = nil
    Events.RemoveListener(Constants.EventNames.BattleInputFinished, self.__OnUIInputFinished)
    Events.RemoveListener(Constants.EventNames.BattleInputUse, self.__OnUIInput)
    Events.RemoveListener(Constants.EventNames.BattleNetworkOnReceived, self.__OnReceivedPackage)
    if self.__OnCardAnimFinished then
        Events.RemoveListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
    end
end

function OnlinePlayer:OnReceivedPackage(packageId, packageData)
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

function OnlinePlayer:OnUIInputFinished()
    -- GameUtils.BeforeRequest()
    local statusCode = BattleMgr:GetStatusCode()
    local p = self:GenerateInputData(self.InputType.Finish, {}, -1)
    p.statusCode = statusCode
    BattleViewMgr.netMgr:Send(BattleViewMgr.netMgr.SendPackageIds.Input, p)
    -- print("[点击] 完成", p.seqId, CS.UnityEngine.Time.realtimeSinceStartup, table.dump(p, nil, 3))
end

function OnlinePlayer:OnUIInput( data )
    if not self.canSend then
        print("[输入]", self.baseSeqId, self.lastInputTime, CS.UnityEngine.Time.realtimeSinceStartup, debug.traceback())
        BattleViewMgr.netMgr:Log2File(string.format("[输入] %d, %f, %f", self.baseSeqId, self.lastInputTime, CS.UnityEngine.Time.realtimeSinceStartup))
        return
    end
    if CS.UnityEngine.Time.realtimeSinceStartup - self.lastInputTime < InputProtectTime then
        printError(string.format("[输入屏蔽] 歼灭战玩家产生时间间隔小于%0.2fs的输入, seqId: %d, lastTime: %f, thisTime: %f", InputProtectTime, self.baseSeqId, self.lastInputTime, CS.UnityEngine.Time.realtimeSinceStartup))
        return
    else
        self.lastInputTime = CS.UnityEngine.Time.realtimeSinceStartup
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

--卡牌动画播完，可以等待输入
function OnlinePlayer:OnCardAnimFinished(  )
    if not self.canSend then
        print("[输入]", self.baseSeqId, self.lastInputTime, CS.UnityEngine.Time.realtimeSinceStartup, debug.traceback())
        BattleViewMgr.netMgr:Log2File(string.format("[输入] %d, %f, %f", self.baseSeqId, self.lastInputTime, CS.UnityEngine.Time.realtimeSinceStartup))
        return
    end
    -- print("~~~~~~~~~~~~~~~~~~~~~~~~OnCardAnimFinished")
    --self.cardAnimFinished = true

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

return  OnlinePlayer