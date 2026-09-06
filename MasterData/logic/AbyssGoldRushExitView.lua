-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushExitView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushExitView", package.seeall)

local AbyssGoldRushExitView = class("AbyssGoldRushExitView", ViewComponent)
local FAILE_COIN_POS = {
	87,
	-28
}
local SUCCESS_COIN_POS = {
	87,
	11
}

function AbyssGoldRushExitView:ctor()
	AbyssGoldRushExitView.super.ctor(self)
end

function AbyssGoldRushExitView:unbindEvents()
	AbyssGoldRushExitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AbyssGoldRushExitView:bindEvents()
	AbyssGoldRushExitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function AbyssGoldRushExitView:buildUI()
	AbyssGoldRushExitView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._coin = self:getGo("coin")
	self._txtCoin = self:getTxt("coin/txtCoin")
	self._icon = self:getGo("coin/icon")
	self._txtTip = self:getTxt("tip/txtTip")
	self._txtDebt = self:getTxt("failInfo/txtDebt")
	self._holystripeTableview = self:getGo("sucInfo/holystripeTableview")
	self._holyStrpeTablecell = self:getGo("sucInfo/holystripeTableview/holyStrpeTablecell")
	self._holyStripeTableList = ScrollerList.create(self._holystripeTableview, self._holyStrpeTablecell, GameUtil.handler(self._updateHolyStrpeCell, self), GameUtil.handler(self._clearHolyStrpeCell, self))
	self._txtScore = self:getTxt("sucInfo/txtScore")
	self._bgFail = self:getGo("bgFail")
	self._bgSuc = self:getGo("bgSuc")
	self._sucInfo = self:getGo("sucInfo")
	self._failInfo = self:getGo("failInfo")
end

function AbyssGoldRushExitView:onExit()
	AbyssGoldRushExitView.super.onExit(self)
end

function AbyssGoldRushExitView:onEnter()
	AbyssGoldRushExitView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushFinishGameRes, self._PM_AbyssGoldRushFinishGameRes, self)

	self._activityId = checknumber(self:getFirstParam())

	local openParams = self:getOpenParam()

	self._selectHolyStripeList = openParams[2]
	self._isGetPrize = openParams[3]

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	if gameInfo.baseInfo.decCoin > 0 then
		local hasCoinCount = AbyssGoldRushModel.instance:getAbyssCoinCount(self._activityId) + gameInfo.baseInfo.curRoundAbyssCoin

		self._txtDebt.text = langPara("负债：%s-%s", hasCoinCount, gameInfo.baseInfo.decCoin)

		GameUtil.SetActive(self._txtDebt, true)
	else
		GameUtil.SetActive(self._txtDebt, false)
	end

	local activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	local isWin = gameInfo.baseInfo.battleResults[#gameInfo.baseInfo.battleResults] == 1

	self._txtCoin.text = langPara("x%s", (isWin or nil) and (gameInfo.baseInfo.curRoundAbyssCoin or checknumber(activityCfg.failFloorCoin)))

	if isWin then
		if not SUCCESS_COIN_POS then
			local pos = FAILE_COIN_POS

			GameUtil.setAnchoredPos(self._coin, pos[1], pos[2])
			GameUtil.SetActive(self._sucInfo, isWin)
			GameUtil.SetActive(self._failInfo, not isWin)
			GameUtil.SetActive(self._bgSuc, isWin)
			GameUtil.SetActive(self._bgFail, not isWin)

			local prizeList = {}

			if self._selectHolyStripeList ~= nil then
				local holyStripeCountMap = {}

				for i, v in ipairs(self._selectHolyStripeList) do
					holyStripeCountMap[v] = checknumber(holyStripeCountMap[v]) + 1
				end

				for i, v in pairs(holyStripeCountMap) do
					table.insert(prizeList, {
						id = i,
						num = v
					})
				end

				self._txtCoin.text = self._isGetPrize == true and langPara("x%s", (isWin or nil) and (gameInfo.baseInfo.curRoundAbyssCoin or checknumber(activityCfg.failFloorCoin))) or langPara("x%s", 0)
			else
				local holyStripeCountMap = {}

				for i, v in ipairs(gameInfo.baseInfo.dropHolyStripeIds or {}) do
					holyStripeCountMap[v] = checknumber(holyStripeCountMap[v]) + 1
				end

				for i, v in pairs(holyStripeCountMap) do
					table.insert(prizeList, {
						id = i,
						num = v
					})
				end

				self._txtCoin.text = langPara("x%s", (isWin or nil) and (gameInfo.baseInfo.curRoundAbyssCoin or checknumber(activityCfg.failFloorCoin)))
			end

			self._holyStripeTableList:reloadData(prizeList)

			local addScore = AbyssGoldRushGameController.instance:calcAddScoreAndResult(self._activityId)

			self._txtScore.text = addScore > 0 and langPara("积分：%s <color=#fef2bd>+%s</color>", AbyssGoldRushModel.instance:getLevelScore(self._activityId), addScore) or langPara("积分：%s", AbyssGoldRushModel.instance:getLevelScore(self._activityId))

			local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
			local matType, matId, _ = MaterialMgr.getMatParams(actCfg.fakeItem)

			MaterialMgr.setIcon(self._icon, matType, matId)
		end
	end
end

function AbyssGoldRushExitView:_updateHolyStrpeCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtCount = goutil.findChildTextComponent(go, "txtCount")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local qualityColor = goutil.findChildComponent(icon, "quality", "UIImageSpriteChange")
	local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data.id)
	local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

	MaterialMgr.setIcon(icon, MatType.HolyStripe, targetCfg.id)
	qualityColor:SetState(targetCfg.quality)

	txtName.text = targetCfg.name
	txtCount.text = string.format("x%s", data.num)
end

function AbyssGoldRushExitView:_clearHolyStrpeCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

function AbyssGoldRushExitView:_onClickClose()
	local info = AbyssGoldRushModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	if self._selectHolyStripeList == nil then
		local activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
		local dailyTimes = checknumber(activityCfg.dailyPrizeTimes)
		local usedTimes = checknumber(info.todayGainPrizeTimes)

		if dailyTimes <= usedTimes then
			TipsFacade.instance:openTipWindow(lang("提示"), lang("已无奖励次数"), function()
				AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, false)
			end)
		else
			TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认消耗次数获得当前奖励"), function()
				local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

				if gameInfo.baseInfo.dropHolyStripeIds then
					if #gameInfo.baseInfo.dropHolyStripeIds > activityCfg.onceGainHolyStripeLimit then
						UIStateManager.instance:push(ViewName.AbyssGoldRushHolyStripeGainView, self._activityId)
					else
						AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, true, gameInfo.baseInfo.dropHolyStripeIds)
					end
				else
					AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, true)
				end
			end, function()
				AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, false)
			end)
		end
	elseif self._isGetPrize == true then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, true, self._selectHolyStripeList)
	else
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, false)
	end
end

function AbyssGoldRushExitView:_PM_AbyssGoldRushFinishGameRes()
	self:close()
end

return AbyssGoldRushExitView
