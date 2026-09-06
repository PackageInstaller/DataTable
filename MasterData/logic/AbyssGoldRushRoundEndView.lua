-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushRoundEndView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushRoundEndView", package.seeall)

local AbyssGoldRushRoundEndView = class("AbyssGoldRushRoundEndView", ViewComponent)
local PRIZE_TYPE_COIN = 1
local PRIZE_TYPE_HOLYSTRIPE = 2

function AbyssGoldRushRoundEndView:ctor()
	AbyssGoldRushRoundEndView.super.ctor(self)
end

function AbyssGoldRushRoundEndView:unbindEvents()
	AbyssGoldRushRoundEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExit)
	GameUtil.rmClickHandler(self._btnNextRound)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnPrizeDetail)
end

function AbyssGoldRushRoundEndView:bindEvents()
	AbyssGoldRushRoundEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnNextRound, self._onClickNextRound, self)
	GameUtil.addClickHandler(self._btnExit, self._onClickExit, self)
	GameUtil.addClickHandler(self._btnPrizeDetail, self._onClickShowPrizeDetail, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AbyssGoldRushRoundEndView:buildUI()
	AbyssGoldRushRoundEndView.super.buildUI(self)

	self._curPrizeTableview = self:getGo("curPrizeTableview")
	self._curPrizeTablecell = self:getGo("curPrizeTableview/curPrizeTablecell")
	self._curPrizeTableList = ScrollerList.create(self._curPrizeTableview, self._curPrizeTablecell, GameUtil.handler(self._updateCurPrizeCell, self), GameUtil.handler(self._clearCurPrizeCell, self))
	self._teamTableview = self:getGo("bagPetInfo/teamTableview")
	self._teamtablecell = self:getGo("bagPetInfo/teamTableview/teamtablecell")
	self._teamTableList = ScrollerList.create(self._teamTableview, self._teamtablecell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._loserTag = self:getGo("btnNexRound/loserTag")
	self._bubblePrize = self:getGo("nextPrize/bubblePrize")
	self._customInput = UICustomInput.Get(self._bubblePrize)
	self._btnPrizeDetail = self:getGo("nextPrize/btnPrizeDetail")
	self._btnNextRound = self:getGo("btnNexRound")
	self._btnExit = self:getGo("btnExit")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._txtNextRoundPrize = self:getTxt("nextPrize/txtPrize")
	self._txtPrizeDesc = self:getTxt("nextPrize/bubblePrize/txtPrizeDesc")
end

function AbyssGoldRushRoundEndView:onExit()
	AbyssGoldRushRoundEndView.super.onExit(self)
end

function AbyssGoldRushRoundEndView:onEnter()
	AbyssGoldRushRoundEndView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPushStepRes, self._PM_AbyssGoldRushPushStepRes, self)

	self._activityId = checknumber(self:getFirstParam())

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	self._teamTableList:reloadData(gameInfo.petList)

	local prizeList = {}

	if gameInfo.baseInfo.curRoundAbyssCoin > 0 then
		table.insert(prizeList, {
			type = PRIZE_TYPE_COIN,
			num = gameInfo.baseInfo.curRoundAbyssCoin
		})
	end

	local holyStripeCountMap = {}

	for i, v in ipairs(gameInfo.baseInfo.dropHolyStripeIds or {}) do
		holyStripeCountMap[v] = checknumber(holyStripeCountMap[v]) + 1
	end

	for i, v in pairs(holyStripeCountMap) do
		table.insert(prizeList, {
			type = PRIZE_TYPE_HOLYSTRIPE,
			id = i,
			num = v
		})
	end

	self._curPrizeTableList:reloadData(prizeList)

	self._isLose = gameInfo.baseInfo.battleResults[#gameInfo.baseInfo.battleResults] == -1

	GameUtil.SetActive(self._loserTag, self._isLose)

	local stepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, gameInfo.baseInfo.curStepId)

	self._txtTitle.text = langPara("第%s层结束，请做出选择", GameUtil.getChineseNumber(stepCfg.roundId))

	local nextRoundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId + 1)

	self._txtNextRoundPrize.text = nextRoundCfg.prizeDesc

	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)

	self._txtPrizeDesc.text = actCfg.prizeDesc

	GameUtil.SetActive(self._bubblePrize, false)
end

function AbyssGoldRushRoundEndView:_updateCurPrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")
	local btn = goutil.findChild(go, "btn")
	local qualityColor = goutil.findChildComponent(icon, "quality", "UIImageSpriteChange")

	GameUtil.rmClickHandler(btn)

	if data.type == PRIZE_TYPE_COIN then
		local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
		local matType, matId, _ = MaterialMgr.getMatParams(actCfg.fakeItem)

		MaterialMgr.setIcon(icon, matType, matId)
		GameUtil.addClickHandler(btn, function()
			CommonTipsMgr.instance:openMaterialTips(btn, matType, matId)
		end)
		GameUtil.SetActive(qualityColor, false)
	elseif data.type == PRIZE_TYPE_HOLYSTRIPE then
		local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data.id)
		local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

		MaterialMgr.setIcon(icon, MatType.HolyStripe, targetCfg.id)

		local matType, matId, _ = MaterialMgr.getMatParams(holyStripeCfg.fakeItem)

		GameUtil.addClickHandler(btn, function()
			CommonTipsMgr.instance:openMaterialTips(btn, matType, matId)
		end)
		GameUtil.SetActive(qualityColor, true)
		qualityColor:SetState(targetCfg.quality)
	end

	txtCount.text = string.format("x%s", data.num)
end

function AbyssGoldRushRoundEndView:_clearCurPrizeCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local btn = goutil.findChild(go, "btn")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushRoundEndView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local buff = goutil.findChild(go, "buff")
	local petCfg = AbyssGoldRushConfig.instance:getSupportPet(data.creepsId)
	local proxy = MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	uGuiUtil.clearImage(buff)

	if data.withBuff == true then
		GameUtil.SetActive(buff, true)
		uGuiUtil.setSpriteToImage(buff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(petCfg.buffRes))
	else
		GameUtil.SetActive(buff, false)
	end
end

function AbyssGoldRushRoundEndView:_clearTeamCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AbyssGoldRushRoundEndView:_onClickExit()
	local info = AbyssGoldRushModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	local dailyTimes = checknumber(activityCfg.dailyPrizeTimes)
	local usedTimes = checknumber(info.todayGainPrizeTimes)

	if dailyTimes <= usedTimes then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("当前已无次数，是否撤离"), function()
			FloatWordMgr.instance:show(lang("撤离完成"))
			AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, false)
			self:close()
		end)
	else
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认消耗次数获得当前奖励"), function()
			local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

			if gameInfo.baseInfo.dropHolyStripeIds then
				if #gameInfo.baseInfo.dropHolyStripeIds > activityCfg.onceGainHolyStripeLimit then
					UIStateManager.instance:push(ViewName.AbyssGoldRushHolyStripeGainView, self._activityId, true)
				else
					UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, self._activityId, gameInfo.baseInfo.dropHolyStripeIds, true)
					self:close()
				end
			else
				UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, self._activityId, {}, true)
				self:close()
			end
		end, function()
			FloatWordMgr.instance:show(lang("兑换失败，不消耗次数"))
			AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, false)
			self:close()
		end)
	end
end

function AbyssGoldRushRoundEndView:_onClickNextRound()
	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)

	if self._isLose == true then
		local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
		local stepId = gameInfo.baseInfo.curStepId
		local curStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, stepId)
		local curRoundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, curStepCfg.roundId)
		local content = langPara("您可选择预支消耗%s游园币购买精灵宝箱以及灵纹宝箱（灵纹档位提升一档），注意：本局获得的收益将消失", curRoundCfg.failCostCoin)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, nextStepId)
		end)
	else
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认选择进入下一层，确认后本次收益将被清空"), function()
			AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, nextStepId)
		end)
	end
end

function AbyssGoldRushRoundEndView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._bubblePrize, false)
	end
end

function AbyssGoldRushRoundEndView:_onClickShowPrizeDetail()
	GameUtil.SetActive(self._bubblePrize, true)
end

function AbyssGoldRushRoundEndView:_PM_AbyssGoldRushPushStepRes()
	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
	local nextStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)

	if nextStepCfg.handleType == "holyStripeDrop" or nextStepCfg.handleType == "openPetBox" or nextStepCfg.handleType == "petSelect" then
		UIStateManager.instance:push(ViewName.AbyssGoldRushGainPrizeView, self._activityId)
		self:close()
	elseif nextStepCfg.handleType == "battle" then
		AbyssGoldRushGameController.instance:openMissionView(self._activityId)
		self:close()
	else
		self:close()
	end
end

return AbyssGoldRushRoundEndView
