-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/controller/BountyPKCompeteController.lua

module("logic.extensions.bountypkcompete.controller.BountyPKCompeteController", package.seeall)

local BountyPKCompeteController = class("BountyPKCompeteController", BaseController)

BountyPKCompeteController.E_BountyPKGetInfoRes = "E_BountyPKGetInfoRes"
BountyPKCompeteController.E_BountyPKMatchRes = "E_BountyPKMatchRes"
BountyPKCompeteController.E_BountyPKCancelMatchRes = "E_BountyPKCancelMatchRes"
BountyPKCompeteController.E_BountyPKSetFormRes = "E_BountyPKSetFormRes"
BountyPKCompeteController.E_BountyPKSetBetRes = "E_BountyPKSetBetRes"
BountyPKCompeteController.E_BountyPKRetreatRes = "E_BountyPKRetreatRes"
BountyPKCompeteController.E_BountyPKDailyPrizeRes = "E_BountyPKDailyPrizeRes"
BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes = "E_BountyPKDailyTaskPrizeRes"
BountyPKCompeteController.E_BountyPKGetRecordRes = "E_BountyPKGetRecordRes"
BountyPKCompeteController.E_BountyPKGetRankInfoRes = "E_BountyPKGetRankInfoRes"
BountyPKCompeteController.E_BountyPKNotifyMatchingOverTimeRes = "E_BountyPKNotifyMatchingOverTimeRes"
BountyPKCompeteController.E_BountyPKNotifyMatchFailRes = "E_BountyPKNotifyMatchFailRes"
BountyPKCompeteController.E_BountyPKNotifyGameStartRes = "E_BountyPKNotifyGameStartRes"
BountyPKCompeteController.E_BountyPKNotifyGameEndRes = "E_BountyPKNotifyGameEndRes"
BountyPKCompeteController.E_BountyPKNotifyRoundStartRes = "E_BountyPKNotifyRoundStartRes"
BountyPKCompeteController.E_BountyPKNotifyShowFormRes = "E_BountyPKNotifyShowFormRes"

function BountyPKCompeteController:ctor()
	return
end

function BountyPKCompeteController:onInit()
	return
end

function BountyPKCompeteController:onReset()
	self._replayFromType = nil

	BountyPKCompeteModel.instance:onReset()
end

function BountyPKCompeteController:handleBountyPKGetInfoRes(status, msg)
	if status == 0 then
		BountyPKCompeteModel.instance:handleBountyPKGetInfoRes(msg)
		self:localNotify(BountyPKCompeteController.E_BountyPKGetInfoRes)
	end
end

function BountyPKCompeteController:handleBountyPKMatchRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.BPK_MatchingRes, status)

	if status ~= 0 then
		BountyPKCompeteAgent.instance:sendPM_BountyPKCancelMatchReq()
	end
end

function BountyPKCompeteController:handleBountyPKCancelMatchRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.BPK_CancelMatchingRes)
end

function BountyPKCompeteController:handleBountyPKSetFormRes(status, msg)
	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function BountyPKCompeteController:handleBountyPKNotifySetFormRes(status, msg)
	if status == 0 and msg.resultCode == 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:endOperatePet()
		FloatWordMgr.instance:show(lang("保存成功"))
		self:localNotify(BountyPKCompeteController.E_BountyPKSetFormRes)
	else
		FloatWordMgr.instance:show(langPara("保存阵型错误: %s", msg.resultCode))
	end
end

function BountyPKCompeteController:handleBountyPKSetBetRes(status, msg)
	if status == 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:endBet()
		self:localNotify(BountyPKCompeteController.E_BountyPKSetBetRes)
	end
end

function BountyPKCompeteController:handleBountyPKRetreatRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKRetreatRes)
	end
end

function BountyPKCompeteController:handleBountyPKDailyPrizeRes(status, msg)
	if status == 0 then
		BountyPKCompeteModel.instance:handleBountyPKDailyPrizeRes(msg)
		FloatWordMgr.instance:show(lang("领取成功"))
		self:localNotify(BountyPKCompeteController.E_BountyPKDailyPrizeRes)
	end
end

function BountyPKCompeteController:handleBountyPKDailyTaskPrizeRes(status, msg)
	if status == 0 then
		BountyPKCompeteModel.instance:handleBountyPKDailyTaskPrizeRes(msg)
		self:localNotify(BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes)
	end
end

function BountyPKCompeteController:handleBountyPKGetRecordRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKGetRecordRes, msg)
	end
end

function BountyPKCompeteController:handleBountyPKGetRankInfoRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKGetRankInfoRes, msg)
	end
end

function BountyPKCompeteController:handleBountyPKNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyMatchingOverTimeRes)
		GlobalDispatcher:dispatch(GlobalNotify.BPK_NotifyMatchingOverTimeRes)
	end
end

function BountyPKCompeteController:handleBountyPKNotifyMatchFailRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyMatchFailRes)
		GlobalDispatcher:dispatch(GlobalNotify.BPK_NotifyMatchFailRes)
	end
end

function BountyPKCompeteController:handleBountyPKNotifyGameStartRes(status, msg)
	if status == 0 then
		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyGameStartRes)
		GlobalDispatcher:dispatch(GlobalNotify.BPK_NotifyGameStartRes)

		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:initByParams(msg)
		UIStateManager.instance:push(ViewName.BountyPKCompetePrepareView, {
			players = {
				{
					score = phaseModel.myScore
				},
				{
					headInfo = phaseModel.opHeadInfo,
					score = phaseModel.opScore
				}
			},
			cdSec = BountyPKCompeteConfig.instance:getCommonValue("BEFORE_MATCH_TIME", true),
			callback = function()
				self:enterFightPrepare()
			end
		})
	end
end

function BountyPKCompeteController:handleBountyPKNotifyGameEndRes(status, msg)
	if status == 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		if phaseModel.roundId == 0 then
			return
		end

		phaseModel:parseGameEnd(msg)

		if phaseModel.state == 1 then
			-- block empty
		elseif phaseModel.state == 3 then
			self:_showChangeSetAndDispose()
		elseif phaseModel.state == 2 then
			self:_showChangeSetAndDispose()
		elseif phaseModel.state < 0 then
			self:_showChangeSetAndDispose()
		end

		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyGameEndRes)
	end
end

function BountyPKCompeteController:enterFight()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:clearAllTipsWindow()

	if phaseModel.state == 1 then
		BattleFacade.instance:startFightingByBtlResult(phaseModel.battleResult, GameEnum.BattleRecordEntry.BountyPkCompete)
		BattleModel.instance:setLeftTeamId(phaseModel.myTeamId)
		BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self, phaseModel.battleResult))
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.BountyPKCompete)
		BattleSettlementModel.instance:setChangeSetId(phaseModel.changeSetId)
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	end
end

function BountyPKCompeteController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIJumper.instance:pushOneStack(ViewName.BountyPKCompeteMainView, true)

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		UIStateManager.instance:push(ViewName.BountyPKCompeteFailView)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		UIStateManager.instance:push(ViewName.BountyPKCompeteFailView)
	else
		self:endFight()
	end

	return true
end

function BountyPKCompeteController:_showChangeSetAndDispose()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	if phaseModel.changeSetId then
		MaterialController.instance:showChangeSetInTemp(phaseModel.changeSetId)
	end

	UIStateManager.instance:popByName(ViewName.CustomMissionView)
	UIStateManager.instance:push(ViewName.BountyPKCompeteMainView)

	if phaseModel.state == 3 then
		TipsFacade.instance:openTipWindow(lang("tip"), langPara("bountypk__22", phaseModel:getChangeScoreStr()), nil, lang("tip_know"))
	elseif phaseModel.state == 2 then
		TipsFacade.instance:openTipWindow(lang("tip"), langPara("bountypk__21", phaseModel:getChangeScoreStr()), nil, lang("tip_know"))
	end

	self:endFight()
end

function BountyPKCompeteController:endFight()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:reset()
	BattleController.instance:endBattle()
end

function BountyPKCompeteController:handleBountyPKNotifyRoundStartRes(status, msg)
	if status == 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:enterOperatePet(msg)
		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyRoundStartRes)
	end
end

function BountyPKCompeteController:handleBountyPKNotifyShowFormRes(status, msg)
	if status == 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:enterBet(msg)
		self:localNotify(BountyPKCompeteController.E_BountyPKNotifyShowFormRes)
	end
end

function BountyPKCompeteController:showMatchDialog(level)
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:reset()

	local matchModel = BountyPKCompeteModel.instance:getMatchModel()

	function matchModel._reqStartMatchFunc()
		BountyPKCompeteAgent.instance:sendPM_BountyPKMatchReq(level)
	end

	function matchModel._reqCancelMathFunc()
		BountyPKCompeteAgent.instance:sendPM_BountyPKCancelMatchReq()
	end

	function matchModel._disposeMatchFunc(result)
		if result == BountyPkCompeteMatchModel.MatchSuccess then
			UIStateManager.instance:popByName(ViewName.BountyPKCompeteLevelView)
		end
	end

	matchModel._maxMatchTime = BountyPKCompeteConfig.instance:getCommonValue("MATCH_TIME", true)

	UIStateManager.instance:push(ViewName.BountyPKCompeteMatchView, matchModel)
end

function BountyPKCompeteController:enterFightPrepare()
	UIStateManager.instance:popByName(ViewName.BountyPKCompeteLevelView)
	UIStateManager.instance:popByName(ViewName.BountyPKCompeteMainView)

	local customFmtMo = BountyPKCompeteModel.instance:getPhaseModel().fmtMo

	CustomFmtController.instance:showMissionView(customFmtMo)
end

function BountyPKCompeteController:replayFight(battleId, replayFromType)
	if not string.nilorempty(battleId) and battleId ~= "0" then
		self._replayFromType = replayFromType

		BountyPKCompeteAgent.instance:sendPM_BountyPKGetBattleVideoReq(battleId)
	end
end

function BountyPKCompeteController:handleBountyPKGetBattleVideoRes(status, msg)
	if status == 0 then
		local battleResult = msg.battleResult

		BattleFacade.instance:startFightingByBtlResult(battleResult, GameEnum.BattleRecordEntry.BountyPkCompete)
		BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onReplayBattleEnd, self, battleResult))
	end
end

function BountyPKCompeteController:_onReplayBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleController.instance:endBattle()

	if self._replayFromType and self._replayFromType == 1 then
		UIStateManager.instance:push(ViewName.BountyPKCompeteMainView)
	end

	return true
end

BountyPKCompeteController.instance = BountyPKCompeteController.New()

return BountyPKCompeteController
