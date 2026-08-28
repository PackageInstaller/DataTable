--
-- Author:luqucheng
-- Date: 2019-12-11 14:05:09
--
local MonsterAI = import("Game.Battle.AI.MonsterAI")
local SkillCardMgr = import('Game.Battle.SkillCard.SkillCardMgr')
local CardController = import('Game.Battle.Entity.CardController')
local cs_coroutine = import('XLua.cs_coroutine')
local gameUtils = CS.GameUtils
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
--@SuperType [Game.Battle.Entity.Controller#Controller]
local Player = Class("Player", CardController)
local Role = import('Game.Battle.Entity.Role')

--@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
Player.cardMgr = nil

Player.inputCallback = nil
Player.cardAnimFinished = false
Player.usedSkillNum = 0
Player.unitSkillId = nil--合卡技ID
Player.nowTurnPerUnitCount = nil--操作前自动产生的合卡次数
Player.AISkills = nil
--@RefType [Game.Battle.Entity.Role#Role]
Player.agent = nil --替代释放技能的角色


function Player:__init(camp, playerId, initData)
    CardController.__init(self, camp, playerId, initData)

    if not BattleInfo:IsMyPlayerId(self.playerId) then
        return
    end
    self.__OnInputFinished = Bind(self, self.OnInputFinished)
    self.__OnReceveExchangeInput = Bind(self, self.OnReceveExchangeInput)
    self.__OnReceveUseInput = Bind(self, self.OnReceveUseInput)
    self.__OnReceveResetInput = Bind(self, self.OnReceveResetInput)
    --self.__OnAutoBattleChange = Bind(self, self.OnAutoBattleChange)
    self.__OnCardAnimFinished = Bind(self, self.OnCardAnimFinished)
    self.__OnChangeSkillTarget = Bind(self, self.OnChangeSkillTarget)
    self.__OnChangeAimTarget = Bind(self, self.OnChangeAimTarget)
    self.__OnReceiveAutoUseSkillCat = Bind(self, self.OnReceiveAutoUseSkillCat)
    if BattleInfo.inputMode ~= Constants.InputMode.Replay then
        Events.AddListener(Constants.EventNames.BattleInputFinished, self.__OnInputFinished)
    end
    Events.AddListener(Constants.EventNames.BattleInputExchange, self.__OnReceveExchangeInput)
    Events.AddListener(Constants.EventNames.BattleInputUse, self.__OnReceveUseInput)
    Events.AddListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)
    --Events.AddListener(Constants.EventNames.UIBattlingAuToBattleRunning, self.__OnAutoBattleChange)
    if BattleInfo.inputMode ~= Constants.InputMode.Replay then
        Events.AddListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
        Events.AddListener(Constants.EventNames.BattleInputAutoUseSkillCat, self.__OnReceiveAutoUseSkillCat)
    end
    Events.AddListener(Constants.EventNames.BattleChangeSkillTarget, self.__OnChangeSkillTarget)

    Events.AddListener(Constants.EventNames.UIBattlingSelectAttackTarget, self.__OnChangeAimTarget)

   
    -- Events.AddListener(Constants.EventNames.UIBattlingCameraSwipeEnd, OnSwipeEnd)
end



function Player:__delete(  )
    CardController.__delete(self)

    Events.RemoveListener(Constants.EventNames.BattleInputFinished, self.__OnInputFinished)
    Events.RemoveListener(Constants.EventNames.BattleInputExchange, self.__OnReceveExchangeInput)
    Events.RemoveListener(Constants.EventNames.BattleInputUse, self.__OnReceveUseInput)
    Events.RemoveListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)
    --Events.RemoveListener(Constants.EventNames.UIBattlingAuToBattleRunning, self.__OnAutoBattleChange)
    if BattleInfo.inputMode ~= Constants.InputMode.Replay then
        Events.RemoveListener(Constants.EventNames.UIBattlingPlayerInteractablePermission, self.__OnCardAnimFinished)
    end
    Events.RemoveListener(Constants.EventNames.BattleChangeSkillTarget, self.__OnChangeSkillTarget)
    Events.RemoveListener(Constants.EventNames.UIBattlingSelectAttackTarget, self.__OnChangeAimTarget)
end

function Player:AutoInput(  )
    --if BattleViewMgr.isAutoPlay and self.cardAnimFinished then
        self:AutoUseOneCard()
   -- end
end

function Player:SetForceCardQueue( teamData, forceQueue, isForceLoop )
    self.cardMgr:SetForceCardQueue(teamData, forceQueue, isForceLoop)
end

function Player:OnAutoBattleChange( isAuto )
    -- print("~~~~~~~~~~~~~~~~~~~~~~~~OnAutoBattleChange:" .. (isAuto and 1 or 0))
    BattleViewMgr.isAutoPlay = isAuto == 1
    self:AutoInput()
end

--卡牌动画播完，可以等待输入
function Player:OnCardAnimFinished(  )
    -- print("~~~~~~~~~~~~~~~~~~~~~~~~OnCardAnimFinished")
    --self.cardAnimFinished = true
    self:AutoInput()
end

function Player:OnChangeSkillTarget( data )
    -- print(table.toString(data, "OnChange skill target"))
    local index = data[1]
    local targetId = data[2]
    self.cardMgr:OnChangeUseCardTargetId(index, targetId)
end

function Player:OnChangeAimTarget( targetId )
    -- print("OnChangeAimTarget", targetId)
    BattleMgr.selectRoleID = targetId
end

return  Player