local NewSlgEndShowLayer = class("NewSlgEndShowLayer", function()
	return fgui.GComponent:create({
		resName = "NewSlgEndShowLayer",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.RankAwardConst
local var_0_2 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE

function NewSlgEndShowLayer:ctor()
	self._endTime = g.core.model.User.newSlgData:getActShowEndTime()
	self._rankArr = {}

	self:addBg2(g.core.common.Path:getBackground("bg_saijijiesuan"))

	self._listRank = self:getChild("List_rank")

	self._listRank:setVirtual(self)
	self._listRank:setItemRenderer(handler(self, self._onRenderListRankCell))

	self._listHelp = self:getChild("List_help")

	self._listHelp:setVirtual(self)
	self._listHelp:setItemRenderer(handler(self, self._onRenderListHelpCell))

	self._btnRank = self:getChild("Btn_rank")

	self._btnRank:addClickListener(handler(self, self._onClickBtnRank))

	self._btnBurn = self:getChild("Btn_burn")

	self._btnBurn:addClickListener(handler(self, self._onClickBtnBurn))

	self._btnShop = self:getChild("Btn_shop")

	self._btnShop:addClickListener(handler(self, self._onClickBtnShop))

	self._compTop = self:getChild("Comp_top")
	self._txtTime = self:getChild("Txt_time")
	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = 0
	self._burnRankIdx = 4
	self._compTab1 = self:getChild("Comp_tab1")
	self._compTab2 = self:getChild("Comp_tab2")
	self._compTab3 = self:getChild("Comp_tab3")
	self._txtRankTip = self:getChild("Txt_rankTip")
	self._tabNumCtrl = self:getController("tab_num")
	self._compSummary = self:getChild("Comp_summary")
end

function NewSlgEndShowLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWRANKSTATISTIC, handler(self, self._onRcvShowRank), self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserShowRankStatistic({})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BURN_CAMP_GETRANKLIST, handler(self, self._onRcvBurnRank), self)
	g.core.network.GameNetProxy:send_C2S_BurnCamp_GetRankList({
		size = 0
	})
	self:_updateRankView({})

	self._schedule = self:newSchedule(handler(self, self._updateCountDown), 1)

	self:_updateCountDown()
	self:_updateSeasonData()
end

function NewSlgEndShowLayer:_onCtrlTabChange()
	local var_4_0 = self._tabCtrl:getSelectedIndex()

	if var_4_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_4_0

	self:_updateSeasonData()
end

function NewSlgEndShowLayer:_updateSeasonData()
	self._tabConfigArr = {}
	self._tabConfigArr[#self._tabConfigArr + 1] = {
		tp = 1,
		title = g.core.lang:get("NEW_SLG_END_TAB_TITLE1")
	}

	if g.core.model.User.newSlgData:getSName() == "S1" then
		self:_updateView(1)
	else
		self._tabConfigArr[#self._tabConfigArr + 1] = {
			tp = 2,
			title = g.core.lang:get("NEW_SLG_END_TAB_TITLE2")
		}

		self:_updateView(2)
	end

	self._tabNumCtrl:setSelectedIndex(#self._tabConfigArr - 1)

	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(self._tabConfigArr) do
		self["_compTab" .. iter_5_0]:setTitle(iter_5_1.title)

		if self._tabIndex + 1 == iter_5_0 then
			var_5_0 = iter_5_1
		end
	end

	local var_5_1 = 1

	if var_5_0 then
		var_5_1 = var_5_0.tp
	end

	self._listRank:setVisible(false)
	self._listHelp:setVisible(false)
	self._compSummary:setVisible(false)
	self._txtRankTip:setVisible(false)

	if var_5_1 == 1 then
		self._listRank:setVisible(true)
		self._txtRankTip:setVisible(true)
	elseif var_5_1 == 2 then
		self._compSummary:setVisible(true)
		self._txtRankTip:setVisible(true)
	elseif var_5_1 == 3 then
		self._listHelp:setVisible(true)
	end
end

function NewSlgEndShowLayer:_updateCountDown()
	local var_6_0 = self._endTime - g.core.common.ServerTime:getTime()

	if var_6_0 > 0 then
		self._txtTime:setText(g.core.common.ServerTime:getCountDownBySecond(var_6_0))
	else
		self:cancelSchedule(self._schedule)

		self._schedule = nil

		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function NewSlgEndShowLayer:_onRcvShowRank(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:_updateRankView(arg_7_4)
end

function NewSlgEndShowLayer:_onRcvBurnRank(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0

	if arg_8_4.self_unit then
		var_8_0 = arg_8_4.self_unit.rank or 0
	end

	local var_8_1 = g.core.common.RankAward:getAwardByTypeAndRank(var_0_1.BURN, var_8_0)
	local var_8_2

	if arg_8_4.self_unit then
		var_8_2 = arg_8_4.self_unit.score or 0
	end

	local var_8_3 = self._rankArr
	local var_8_4 = self._burnRankIdx
	local var_8_5 = {
		typeCtrl = 1,
		title = g.core.lang:get(428965)
	}
	local var_8_6 = {
		rank = var_8_0
	}

	var_8_6.num = bit64.rshift(var_8_2, 32) or 0
	var_8_6.num2 = bit64.band(var_8_2, 4294967295) or 0
	var_8_5.rankData = var_8_6

	if var_8_1 then
		var_8_5.awardArr = var_8_1.data or {}
	end

	var_8_3[var_8_4] = var_8_5

	self._listRank:setNumItems(#self._rankArr)
	self:_updateView()
end

function NewSlgEndShowLayer:_updateRankViewS1(arg_9_1)
	local var_9_0 = arg_9_1.person_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[1] = {
		typeCtrl = 0,
		title = g.core.lang:get(428962),
		rankData = var_9_0,
		awardArr = g.core.model.User.newSlgData:getRankAwardByTypeAndValueAndRank(var_0_2.PERSONAL_ALL, var_9_0.rank)
	}

	local var_9_1 = arg_9_1.alliance_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[2] = {
		typeCtrl = 0,
		title = g.core.lang:get(428963),
		rankData = var_9_1,
		awardArr = g.core.model.User.newSlgData:getRankAwardByTypeAndValueAndRank(var_0_2.UNION, var_9_1.rank)
	}

	local var_9_2 = arg_9_1.final_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[3] = {
		typeCtrl = 0,
		title = g.core.lang:get(428964),
		rankData = var_9_2,
		awardArr = g.core.model.User.newSlgData:getRankAwardByTypeAndValueAndRank(var_0_2.FINAL_DRAGON, var_9_2.rank)
	}
	self._burnRankIdx = 4
end

function NewSlgEndShowLayer:_updateRankViewS2(arg_10_1)
	local var_10_0 = arg_10_1.person_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[1] = {
		typeCtrl = 0,
		title = g.core.lang:get("NEW_SLG_END_SHOW_RANK_TITLE_1"),
		rankData = var_10_0,
		awardArr = g.core.model.User.newSlgData:getRankAwardByTypeAndValueAndRank(var_0_2.PERSONAL_ALL, var_10_0.rank)
	}

	local var_10_1 = arg_10_1.alliance_contribute or {
		rank = 0,
		num = 0
	}

	self._rankArr[2] = {
		typeCtrl = 0,
		title = g.core.lang:get("NEW_SLG_END_SHOW_RANK_TITLE_5"),
		rankData = var_10_1,
		awardArr = g.core.model.User.newSlgData:getRankAwardByTypeAndValueAndRank(var_0_2.S2_ALLIANCE, var_10_1.rank)
	}
	self._burnRankIdx = 3
end

function NewSlgEndShowLayer:_updateRankView(arg_11_1)
	if g.core.model.User.newSlgData:getSName() == "S1" then
		self:_updateRankViewS1(arg_11_1)
	else
		self:_updateRankViewS2(arg_11_1)
	end
end

function NewSlgEndShowLayer:_getHelpInfoArrById(arg_12_1)
	local var_12_0 = {}

	repeat
		local var_12_1 = g.core.config.help_text_info.fetch(arg_12_1, 1)

		if var_12_1 and var_12_1.text ~= "0" then
			table.insert(var_12_0, var_12_1)
		end
	until not var_12_1

	return var_12_0
end

function NewSlgEndShowLayer:_updateView(arg_13_1)
	self._helpInfoArr = self:_getHelpInfoArrById(g.const.HelpConst.HELP_TYPE["NEW_SLG_" .. arg_13_1])

	if #self._helpInfoArr > 0 then
		self._listHelp:setNumItems(#self._helpInfoArr)
	else
		self._tabConfigArr[#self._tabConfigArr + 1] = {
			tp = 3,
			title = g.core.lang:get("NEW_SLG_END_TAB_TITLE3")
		}
	end
end

function NewSlgEndShowLayer:_onRenderListRankCell(arg_14_1, arg_14_2)
	arg_14_2:updateCell(self._rankArr[arg_14_1 + 1])
end

function NewSlgEndShowLayer:_onRenderListHelpCell(arg_15_1, arg_15_2)
	arg_15_2:updateCell(self._helpInfoArr[arg_15_1 + 1])
end

function NewSlgEndShowLayer:_onClickBtnRank()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK)
end

function NewSlgEndShowLayer:_onClickBtnBurn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BURN_END_SHOW_LAYER)
end

function NewSlgEndShowLayer:_onClickBtnShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP_SCORE, {
		type = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.NEW_SLG
	})
end

return NewSlgEndShowLayer
