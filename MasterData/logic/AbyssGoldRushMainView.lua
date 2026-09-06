-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMainView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMainView", package.seeall)

local AbyssGoldRushMainView = class("AbyssGoldRushMainView", ViewComponent)

function AbyssGoldRushMainView:ctor()
	AbyssGoldRushMainView.super.ctor(self)
end

function AbyssGoldRushMainView:unbindEvents()
	AbyssGoldRushMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnBag)
end

function AbyssGoldRushMainView:bindEvents()
	AbyssGoldRushMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, GameUtil.handler(self._onClickBtnJump, self, "jumpShop"))
	GameUtil.addClickHandler(self._btnTask, GameUtil.handler(self._onClickBtnJump, self, "jumpTask"))
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
end

function AbyssGoldRushMainView:buildUI()
	AbyssGoldRushMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnRank = self:getGo("btnRank")
	self._redBtnRank = self:getGo("btnRank/redpoint")
	self._btnShop = self:getGo("btnShop")
	self._redBtnShop = self:getGo("btnShop/redpoint")
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/redpoint")
	self._btnStart = self:getGo("btnStart")
	self._redBtnStart = self:getGo("btnStart/redpoint")
	self._txtStartTime = self:getTxt("btnStart/txtTime")
	self._goldBar = self:getGo("goldBar")
	self._txtSuit = self:getTxt("holySpriteInfo/txtSuit")
	self._btnBag = self:getGo("holySpriteInfo/btnBag")
	self._holyStripeTableview = self:getGo("holySpriteInfo/holyStripeTableview")
	self._holyStripeTablecell = self:getGo("holySpriteInfo/holyStripeTableview/holyStripeTablecell")
	self._holyStripeTableList = ScrollerList.create(self._holyStripeTableview, self._holyStripeTablecell, GameUtil.handler(self._updateHolyStripeCell, self), GameUtil.handler(self._clearHolyStripeCell, self))
end

function AbyssGoldRushMainView:onExit()
	AbyssGoldRushMainView.super.onExit(self)
end

function AbyssGoldRushMainView:onEnter()
	AbyssGoldRushMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPresetRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushFinishGameRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 612001
	end

	self._activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_setTopGoldBar()
	self:_refreshView()

	if not AbyssGoldRushGameModel.instance:isInGame() then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushGetInfoReq(self._activityId)
	elseif AbyssGoldRushGameController.instance:isAfterBattle() then
		AbyssGoldRushGameController.instance:jumpViewAfterBattle(self._activityId)
	end

	RedPointController.instance:regRedPoint(self._redBtnTask, RedPointModel.ID_ABYSS_GOLD_RUSH_TASK)
end

function AbyssGoldRushMainView:_setTopGoldBar()
	if string.nilorempty(self._activityCfg.showItem) then
		return
	end

	local btnList = {}
	local array = string.split(self._activityCfg.showItem, "#")

	for i, v in ipairs(array) do
		table.insert(btnList, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btnList, false)
end

function AbyssGoldRushMainView:_refreshView()
	local info = AbyssGoldRushModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local bagMap = {}
	local holyStripeInfo = AbyssGoldRushModel.instance:getHolyStripeInfo(self._activityId)

	for i, v in ipairs(holyStripeInfo) do
		bagMap[v.left] = v.right
	end

	local dailyTimes = checknumber(self._activityCfg.dailyPrizeTimes)
	local usedTimes = checknumber(info.todayGainPrizeTimes)
	local leftTimes = Mathf.Max(dailyTimes - usedTimes, 0)

	self._txtStartTime.text = langPara("次数：%s/%s", leftTimes, dailyTimes)
	self._holyStripePreset = AbyssGoldRushModel.instance:getCurHolyStripePreset(self._activityId)
	self._holyStripeSlotCount = checknumber(self._activityCfg.fightWithHolyStripeLimit)

	local slotList = {}
	local useItem = {}

	for i = 1, self._holyStripeSlotCount do
		local id = self._holyStripePreset[i]

		if checknumber(useItem[id]) < checknumber(bagMap[id]) then
			table.insert(slotList, {
				index = i,
				holyStripeId = self._holyStripePreset[i]
			})

			useItem[id] = checknumber(useItem[id]) + 1
		else
			table.insert(slotList, {
				holyStripeId = -1,
				index = i
			})
		end
	end

	self._holyStripeTableList:reloadData(slotList)

	local presetPlanIndex = AbyssGoldRushModel.instance:getPresetPlanIndex(self._activityId)

	self._txtSuit.text = langPara("预设套组：方案%s", GameUtil.getChineseNumber(presetPlanIndex))
end

function AbyssGoldRushMainView:_buildStartHolyStripeIds()
	local bagMap = {}
	local holyStripeInfo = AbyssGoldRushModel.instance:getHolyStripeInfo(self._activityId)

	for i, v in ipairs(holyStripeInfo) do
		bagMap[v.left] = v.right
	end

	local holyStripeIds = {}
	local slotCount = checknumber(self._activityCfg.fightWithHolyStripeLimit)

	if not self._holyStripePreset then
		local preset = {}

		for i = 1, slotCount do
			local holyStripeId = checknumber(preset[i])

			if holyStripeId > 0 and bagMap[holyStripeId] > 0 then
				bagMap[holyStripeId] = bagMap[holyStripeId] - 1

				table.insert(holyStripeIds, holyStripeId)
			end
		end

		for i = 1, self._activityCfg.presetCount do
			if #holyStripeIds >= self._activityCfg.gameWithHolyStripeLimit then
				break
			end

			if i ~= AbyssGoldRushModel.instance:getUsePresetId(self._activityId) then
				local presetInfo = AbyssGoldRushModel.instance:getPresetInfo(self._activityId, i)

				for j = 1, slotCount do
					local holyStripeId = checknumber(presetInfo[j])

					if #holyStripeIds >= self._activityCfg.gameWithHolyStripeLimit then
						break
					end

					if holyStripeId > 0 and bagMap[holyStripeId] > 0 then
						bagMap[holyStripeId] = bagMap[holyStripeId] - 1

						table.insert(holyStripeIds, holyStripeId)
					end
				end
			end
		end

		return holyStripeIds
	end
end

function AbyssGoldRushMainView:_updateHolyStripeCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgIcon")
	local imgAdd = goutil.findChild(go, "imgAdd")
	local holyStripeId = checknumber(data.holyStripeId)
	local btn = goutil.findChild(go, "btn")
	local qualityColor = goutil.findChildComponent(imgIcon, "quality", "UIImageSpriteChange")

	GameUtil.rmClickHandler(btn)
	GameUtil.SetActive(btn, false)

	local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data.holyStripeId)

	if holyStripeCfg then
		local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

		MaterialMgr.setIcon(imgIcon, MatType.HolyStripe, targetCfg.id)

		local matType, matId, _ = MaterialMgr.getMatParams(holyStripeCfg.fakeItem)

		GameUtil.addClickHandler(btn, function()
			CommonTipsMgr.instance:openMaterialTips(btn, matType, matId)
		end)
		qualityColor:SetState(targetCfg.quality)
	else
		MaterialMgr.resetAll(imgIcon)
	end

	GameUtil.SetActive(imgIcon, holyStripeId > 0)
	GameUtil.SetActive(imgAdd, holyStripeId <= 0)
end

function AbyssGoldRushMainView:_clearHolyStripeCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local imgIcon = goutil.findChild(go, "imgIcon")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(imgIcon)
end

function AbyssGoldRushMainView:_onClickBtnJump(key)
	local jumpToStr = self._activityCfg[key]

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function AbyssGoldRushMainView:_onClickTip()
	TipsFacade.instance:openRulesView("abyss_gold_rush_rule")
end

function AbyssGoldRushMainView:_onClickBag()
	UIStateManager.instance:push(ViewName.AbyssGoldRushBagView, self._activityId)
end

function AbyssGoldRushMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.AbyssGoldRushRankView, self._activityId)
end

function AbyssGoldRushMainView:_onClickStart()
	local info = AbyssGoldRushModel.instance:getInfo(self._activityId)

	if not info then
		FloatWordMgr.instance:show(lang("未初始化"))

		return
	end

	local dailyTimes = checknumber(self._activityCfg.dailyPrizeTimes)
	local usedTimes = checknumber(info.todayGainPrizeTimes)

	if dailyTimes <= usedTimes then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("今日奖励次数已用完，是否继续挑战"), function()
			local holyStripeIds = self:_buildStartHolyStripeIds()

			UIStateManager.instance:push(ViewName.AbyssGoldRushMatchView, self._activityId, holyStripeIds)
		end)
	else
		local holyStripeIds = self:_buildStartHolyStripeIds()

		UIStateManager.instance:push(ViewName.AbyssGoldRushMatchView, self._activityId, holyStripeIds)
	end
end

return AbyssGoldRushMainView
