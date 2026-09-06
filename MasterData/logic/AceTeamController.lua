-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/controller/AceTeamController.lua

module("logic.extensions.aceteam.controller.AceTeamController", package.seeall)

local AceTeamController = class("AceTeamController", BaseController)
local localKey_hud = "aceteam_redpoint_hud"
local localKey_prize = "aceteam_redpoint_prize"
local localKey_exchange = "aceteam_redpoint_exchange"

AceTeamController.AceTeamFightBossRes = "AceTeamController.AceTeamFightBossRes"
AceTeamController.AceTeamSetMatchFormRes = "AceTeamController.AceTeamSetMatchFormRes"
AceTeamController.AceTeamViewMedalRankRes = "AceTeamController.AceTeamViewMedalRankRes"
AceTeamController.RankDataRes = "AceTeamController.RankDataRes"

function AceTeamController:ctor()
	AceTeamController.super.ctor(self)
end

function AceTeamController:onInit()
	self:onReset()
	MsgFlowMgr.instance:registerCustomHandledErrCode(-20201)
end

function AceTeamController:onReset()
	GameUtil.getUserDayData(localKey_hud, function(value)
		if checknumber(value) == 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_HUD, true)
		end
	end)
	GameUtil.getUserDayData(localKey_prize, function(value)
		if checknumber(value) == 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_PRIZE, true)
		end
	end)
	GameUtil.getUserDayData(localKey_exchange, function(value)
		if checknumber(value) == 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_EXCHANGE, true)
		end
	end)
end

function AceTeamController:closeRedPointHud()
	GameUtil.saveUserDayData(localKey_hud, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_HUD, false)
end

function AceTeamController:closeRedPointPrize()
	GameUtil.saveUserDayData(localKey_prize, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_PRIZE, false)
end

function AceTeamController:closeRedPointExchange()
	GameUtil.saveUserDayData(localKey_exchange, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ACETEAM_EXCHANGE, false)
end

function AceTeamController:openExchangeView()
	local activityType = AceTeamConfig.instance:getCommonValue("SHOP_ACTIVITYTYPE", true)
	local activityId = AceTeamConfig.instance:getCommonValue("SHOP_ACTIVITYID", true)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

	if isInTime then
		FuncOpenController.instance:openFunc(191, activityType, activityId)
	else
		FloatWordMgr.instance:show(AceTeamConfig.instance:getCommonValue("OPEN_TIME_TIPS"))
	end
end

function AceTeamController:getInfo()
	AceTeamModel.instance:getInfo()
end

function AceTeamController:sendSelectTeam(teamId)
	if checknumber(AceTeamModel.instance.teamId) > 0 then
		if checknumber(AceTeamModel.instance.teamId) ~= teamId then
			local changeLimit = checknumber(AceTeamConfig.instance:getCommonValue("DAILY_CHANGE_TEAM_TIMES"))
			local changedTeam = checknumber(AceTeamModel.instance.changedTeam)

			if changedTeam < changeLimit then
				local cost = AceTeamConfig.instance:getCommonValue("CHANGE_TEAM_COST")
				local type, id, num = MaterialMgr.getMatParams(cost)
				local content = langPara("aceteamcontroller__1", num, MaterialMgr.getMaterialsName(type, id))

				TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
					AceTeamModel.instance:sendSelectTeam(teamId)
				end)
			else
				TipsFacade.instance:openCommonTips(lang("aceteamcontroller__2"))
			end
		else
			TipsFacade.instance:openCommonTips(lang("aceteamcontroller__3"))
		end
	else
		local cfg = AceTeamConfig.instance:getSeasonCfg(AceTeamModel.instance.activityId) or {}
		local name = (AceTeamConfig.instance:getTeamCfgById(cfg.seasonId, teamId) or {}).name
		local content = langPara("aceteamcontroller__16", name)

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			AceTeamModel.instance:sendSelectTeam(teamId)
		end)
	end
end

function AceTeamController:onChangeTeam(msg)
	if checknumber(AceTeamModel.instance.teamId) > 0 then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("aceteamcontroller__17"), nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end

	AceTeamModel.instance:onChangeTeam(msg)
end

function AceTeamController:sendSaveForm()
	AceTeamModel.instance:sendSaveForm()
end

function AceTeamController:sendGoFight()
	UIStateManager.instance:push(ViewName.MatchingPopupView)
end

function AceTeamController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local title = ""
	local content = ""
	local score = 0
	local medal = 0
	local prizeStr
	local data = AceTeamConfig.instance:getSeasonCfg(AceTeamModel.instance:getCurrActivityId())
	local medalItemId = data and data.medalItemId

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		title = lang("aceteamcontroller__4")
		score = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_WIN_SCORE"))
		medal = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_WIN_MEDAL_NUM"))
		prizeStr = data and data.pvpWinPrize
		content = "你真棒！你与你的战队获得了胜利！"
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		title = lang("aceteamcontroller__6")
		score = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_TIE_SCORE"))
		medal = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_TIE_MEDAL_NUM"))
		prizeStr = data and data.pvpTiePrize
		content = "别气馁，再接再厉！\n强化好你的战队，布阵好阵型再战！"
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		title = lang("aceteamcontroller__6")
		score = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_LOSE_SCORE"))
		medal = checknumber(AceTeamConfig.instance:getCommonValue("MATCH_LOSE_MEDAL_NUM"))
		prizeStr = data and data.pvpLosePrize
		content = "别气馁，再接再厉！\n强化好你的战队，布阵好阵型再战！"
	end

	content = content .. string.format("\n战队积分+<color=#C54949>%s</color>", score)

	if not string.nilorempty(medalItemId) then
		local matType, matId, matNum = MatType.ACTIVITY_ITEM, medalItemId, medal
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		content = content .. string.format("\n%s+<color=#C54949>%s</color>", matName, matNum)
	end

	if not string.nilorempty(prizeStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		content = content .. string.format("\n%s+<color=#C54949>%s</color>", matName, matNum)
	end

	TipsFacade.instance:openTipWindowValidX(title, content, function()
		BattleController.instance:endBattle()
	end, lang("tip_know"), UnityEngine.TextAnchor.MiddleCenter)

	return true
end

function AceTeamController:sendGoMatch()
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	AceTeamModel.instance:sendGoMatch()
end

function AceTeamController:sendCancelMatch()
	BattleFacade.instance:registerResultHandler(nil, nil)
	AceTeamModel.instance:sendCancelMatch()
end

function AceTeamController:onMatchTimeOver()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("aceteamcontroller__8"))
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:popByName(ViewName.MatchingPopupView)
end

function AceTeamController:onMatchFail()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("aceteamcontroller__8"))
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:popByName(ViewName.MatchingPopupView)
end

function AceTeamController:aceTeamFightBossRes(status)
	GlobalDispatcher:dispatch(AceTeamController.AceTeamFightBossRes, status)

	if status == -20201 then
		FloatWordMgr.instance:show(AceTeamConfig.instance:getCommonValue("OPEN_TIME_TIPS"))
	end
end

function AceTeamController:aceTeamSetMatchFormRes(status)
	GlobalDispatcher:dispatch(AceTeamController.AceTeamSetMatchFormRes, status)
end

function AceTeamController:sendPM_AceTeamFightBossReq(simpleForm)
	AceTeamModel.instance:recordBattleBossId()
	AceTeamAgent.instance:sendPM_AceTeamFightBossReq(simpleForm)
end

function AceTeamController:sendStarGodLvlup(petId, slot, targetLv)
	AceTeamModel.instance:sendStarGodLvlup(petId, slot, targetLv)
end

function AceTeamController:sendSkillLvlup(petId, selectType, targetLv)
	AceTeamModel.instance:sendSkillLvlup(petId, selectType, targetLv)
end

function AceTeamController:sendEquipLvlup(petId, positionId, targetLv)
	AceTeamModel.instance:sendEquipLvlup(petId, positionId, targetLv)
end

function AceTeamController:sendAwakeLvlup(petId, targetLv)
	AceTeamModel.instance:sendAwakeLvlup(petId, targetLv)
end

function AceTeamController:sendHolyStripeLvlup(petId, positionId, targetLv)
	AceTeamModel.instance:sendHolyStripeLvlup(petId, positionId, targetLv)
end

function AceTeamController:sendAceTeamBuyMatchTimes()
	AceTeamAgent.instance:sendPM_AceTeamBuyMatchTimesReq()
end

function AceTeamController:sendChangeStarGod(petId, slot, id)
	AceTeamModel.instance:sendChangeStarGod(petId, slot, id)
end

function AceTeamController:sendChangeHolyStripe(petId, suitId)
	AceTeamModel.instance:sendChangeHolyStripe(petId, suitId)
end

function AceTeamController:sendAddPointCount()
	local buyPointTimes = checknumber(AceTeamModel.instance.buyPointTimes)
	local limitTime = checknumber(AceTeamConfig.instance:getCommonValue("DAILY_BUY_SCORE_TIMES"))
	local cfg

	if buyPointTimes < limitTime then
		local cfgStr = AceTeamConfig.instance:getCommonValue("BUY_SCORE_COST")
		local matType, id, num = MaterialMgr.getMatParams(cfgStr)

		if matType == MatType.Diamond_Consume then
			local price = GoodsConfig.instance:getCfgPrice(id)

			num = num * price
		end

		local sourceItem = MaterialMgr.createSerName(matType, id)
		local targetItem = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
		local sourceCost = checknumber(num)
		local targetGet = checknumber(AceTeamConfig.instance:getCommonValue("SCORE_PER_BUY"))
		local numMax = checknumber(limitTime - buyPointTimes)
		local content = langPara("aceteamcontroller__10", numMax, MaterialMgr.getMaterialsNameByCfg(targetItem))

		local function callBack(count)
			AceTeamModel.instance:sendAddPointCount(count)
		end

		UIStateManager.instance:push(ViewName.AceteambuyscoreView, sourceItem, targetItem, sourceCost, targetGet, numMax, content, callBack)
	else
		TipsFacade.instance:openCommonTips(lang("aceteamcontroller__11"))
	end
end

function AceTeamController:reqRankData(rankType, startRank, endRank)
	if rankType == AceteamrankView.TabDefine.Person then
		startRank = startRank or 1
		endRank = endRank or 100

		AceTeamAgent.instance:sendPM_AceTeamViewMedalRankReq(startRank, endRank)
	else
		AceTeamAgent.instance:sendPM_AceTeamViewTeamPowerRankReq()
	end
end

function AceTeamController:rankDataRes(rankType, msg)
	AceTeamModel.instance:rankDataRes(rankType, msg)
	GlobalDispatcher:dispatch(AceTeamController.RankDataRes)
end

function AceTeamController:checkPopupAceteamBossEndView()
	local flInfo = AceTeamModel.instance:getFightBossEndData()

	if flInfo and flInfo.bossId and flInfo.bossId > 0 then
		AceTeamModel.instance:clearFightBossEndData()

		local bossRestHp = flInfo.bossRestHp
		local desc = ""
		local addNumStr = langPara("aceteamcontroller__12", flInfo.addPoint, flInfo.addMedal)

		if bossRestHp > 0 then
			local curBossBattleTime = AceTeamModel.instance:getBossHasFightTimes()
			local monsterCfg = AceTeamConfig.instance:getMonsterCfg(flInfo.bossId)

			desc = curBossBattleTime >= monsterCfg.challengeTimes and langPara("aceteamcontroller__13", bossRestHp, addNumStr) or langPara("aceteamcontroller__14", bossRestHp)
		else
			desc = langPara("aceteamcontroller__15", bossRestHp, addNumStr)
		end

		TipsFacade.instance:openTipWindowNoX(lang("tip"), desc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

AceTeamController.instance = AceTeamController.New()

return AceTeamController
