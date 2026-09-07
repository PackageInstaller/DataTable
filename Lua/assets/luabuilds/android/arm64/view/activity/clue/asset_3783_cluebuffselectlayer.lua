local ClueBuffSelectLayer = class("ClueBuffSelectLayer", import("view.base.BaseUI"))

ClueBuffSelectLayer.SP_STRA_MIN_RANGE = 201308
ClueBuffSelectLayer.SP_STRA_MAX_RANGE = 201320
ClueBuffSelectLayer.SP_STRATEGY_ID = 201321
ClueBuffSelectLayer.BOOST_ITEM_ID = 26
ClueBuffSelectLayer.PLYAER_PREF_KEY = "ClueBuffSelectedBySingleEnemyID_"

function ClueBuffSelectLayer:getUIName()
	return "ClueBuffSelectUI"
end

function ClueBuffSelectLayer:preloadUIList()
	return {
		self:getUIName(),
		"BossSingleFleetSelectView"
	}
end

function ClueBuffSelectLayer:init()
	self.closeBtn = self._tf:Find("Top/BackBtn")

	onButton(self, self.closeBtn, function()
		self:emit(ClueBuffSelectLayer.ON_BACK_PRESSED)

		return
	end)
	onButton(self, self._tf:Find("mask"), function()
		self:emit(ClueBuffSelectLayer.ON_BACK_PRESSED)

		return
	end)

	self.buffContainer = self._tf:Find("Buff/buff_list")
	self.buffTmp = self.buffContainer:Find("buff")
	self.buffTFs = {}
	self.strategyList = {}
	self.buffDescList = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = self._tf:Find("Buff/buff_desc_list/buff_desc_" .. iter_3_0)

		table.insert(self.buffDescList, var_3_0)
		setText(var_3_0:Find("unselect"), i18n("clue_buff_unselect"))
	end

	self.stageName = self._tf:Find("Stage/stage_name_text")
	self.stageLV = self._tf:Find("Stage/stage_level_text")

	setText(self._tf:Find("Stage/text_stage_reserach"), i18n("clue_buff_research"))
	setText(self._tf:Find("Stage/text_stage_loot"), i18n("clue_buff_stage_loot"))

	self.awards = self._tf:Find("Loot/awards")
	self.awardTpl = self._tf:Find("Loot/awards/award")
	self.goBtn = self._tf:Find("Combat/go_btn")

	onButton(self, self.goBtn, function()
		self:emit(ClueBuffSelectMediator.ON_FLEET_SELECT, self.singleID)

		return
	end)

	self.detailView = self._tf:Find("Detail")
	self.detailBtn = self._tf:Find("BuffDetail")

	setActive(self.detailBtn, false)

	self.detailList = UIItemList.New(self.detailView:Find("panel/list"), self.detailView:Find("panel/list/item"))

	onButton(self, self.detailBtn, function()
		self:openDetailView()

		return
	end)

	self.detailClose = self.detailView:Find("btnBack")

	onButton(self, self.detailClose, function()
		self:closeDetailView()

		return
	end)
	onButton(self, self.detailView:Find("mask"), function()
		self:closeDetailView()

		return
	end)

	self.ticket = self._tf:Find("Ticket")
	self.ticketTips = self._tf:Find("ticketTips")
	self.ticketCheckBox = self.ticket:Find("checkbox")
	self.useTicket = false

	onButton(self, self.ticket:Find("bg"), function()
		self:UpdateTicket()

		return
	end)
	setText(self.ticketTips, i18n("clue_buff_ticket_tips"))

	self.explore = self._tf:Find("exploreTarget")

	setActive(self.explore, true)
	BossSingleBattleFleetSelectViewComponent.AttachFleetSelect(self, ClueBuffSelectMediator)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ClueBuffSelectLayer:didEnter()
	self:updateBuffView()
	self:UpdateCluePanel()

	self.contextData.selectedBuffList = {}

	for iter_11_0, iter_11_1 in ipairs(self.preSelectedBuffList) do
		self:selectBuff(iter_11_1)
	end

	if self.contextData.editFleet then
		self:ShowNormalFleet(self.singleID)
	end

	return
end

function ClueBuffSelectLayer:show()
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ClueBuffSelectLayer:hide()
	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ClueBuffSelectLayer:openDetailView()
	setActive(self.detailView, true)
	self:updateDetailView()

	return
end

function ClueBuffSelectLayer:closeDetailView()
	setActive(self.detailView, false)

	return
end

function ClueBuffSelectLayer:updateBuffView()
	local var_16_0 = pg.activity_single_enemy[self.singleID]

	for iter_16_0, iter_16_1 in ipairs(pg.activity_single_enemy[self.singleID].strategy_id) do
		if not table.contains(self.strategyList, iter_16_1) then
			setActive(self.buffTFs[iter_16_1]:Find("selected"), false)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(self.buffDescList) do
		local var_16_1 = iter_16_3:Find("mask/desc")
		local var_16_2 = var_16_1:GetComponent("RectTransform")

		if iter_16_2 > var_16_0.strategy_num then
			iter_16_3:Find("bg"):GetComponent(typeof(CanvasGroup)).alpha = 0.05

			setActive(iter_16_3:Find("lock"), true)
			setActive(var_16_1, false)
			setActive(iter_16_3:Find("over_deco"), false)
			setActive(iter_16_3:Find("unselect"), false)
		else
			setActive(iter_16_3:Find("lock"), false)

			if self.strategyList[iter_16_2] then
				setActive(var_16_1, true)

				iter_16_3:Find("bg"):GetComponent(typeof(CanvasGroup)).alpha = 1

				setText(var_16_1:Find("index"), iter_16_2)
				setText(var_16_1:Find("name"), pg.strategy_data_template[self.strategyList[iter_16_2]].name)
				setText(var_16_1:Find("desc"), pg.strategy_data_template[self.strategyList[iter_16_2]].desc)
				setActive(iter_16_3:Find("lock"), false)
				setActive(iter_16_3:Find("unselect"), false)
				Canvas.ForceUpdateCanvases()
				setActive(iter_16_3:Find("over_deco"), var_16_2.rect.width > 560)
			else
				setActive(var_16_1, false)

				iter_16_3:Find("bg"):GetComponent(typeof(CanvasGroup)).alpha = 0.2

				setActive(iter_16_3:Find("unselect"), true)
				setActive(iter_16_3:Find("lock"), false)
				setActive(iter_16_3:Find("over_deco"), false)
			end
		end
	end

	for iter_16_4, iter_16_5 in pairs(self.buffTFs) do
		if table.contains(self.strategyList, iter_16_4) then
			setActive(iter_16_5:Find("selected"), true)
			setImageSprite(iter_16_5:Find("selected/counter"), LoadSprite("ui/cluebuffselectui_atlas", "buff_n_" .. table.indexof(self.strategyList, iter_16_4)), true)
		else
			setActive(iter_16_5:Find("selected"), false)
		end
	end

	setActive(self.detailBtn, #self.strategyList > 0)

	if self.ptAwardTF then
		setActive(self.ptAwardTF:Find("boost"), #self.strategyList > 0)
		setText(self.ptAwardTF:Find("boost/boost"), "+" .. 5 * #self.strategyList .. "%")
	end

	PlayerPrefs.SetString(ClueBuffSelectLayer.PLYAER_PREF_KEY .. self.singleID, (table.concat({
		unpack(self.strategyList)
	}, "|")))
	setText(self._tf:Find("Stage/text_stage_buff_count"), "(" .. #self.strategyList .. "/" .. var_16_0.strategy_num .. ")")

	return
end

function ClueBuffSelectLayer:UpdateCluePanel()
	local var_17_0 = PlayerPrefs.GetInt("investigatingGroupId_" .. ActivityConst.Valleyhospital_ACT_ID .. "_" .. getProxy(PlayerProxy):getRawData().id, 0)
	local var_17_1 = true
	local var_17_2
	local var_17_3 = 0

	if var_17_0 ~= 0 then
		var_17_2 = {
			pg.activity_clue[pg.activity_clue.get_id_list_by_group[var_17_0][1]],
			pg.activity_clue[pg.activity_clue.get_id_list_by_group[var_17_0][2]],
			pg.activity_clue[pg.activity_clue.get_id_list_by_group[var_17_0][3]]
		}
		var_17_3 = getProxy(TaskProxy):getTaskVO(tonumber(var_17_2[3].task_id)):getProgress()

		for iter_17_0 = 1, 3 do
			if not getProxy(TaskProxy):getFinishTaskById(tonumber(var_17_2[iter_17_0].task_id)) then
				var_17_1 = false

				break
			end
		end
	end

	if var_17_1 then
		setText(self.explore:Find("target/Text"), i18n("clue_unselect_tip"))
	else
		setText(self.explore:Find("target/Text"), var_17_2[1].unlock_desc .. var_17_2[1].unlock_num .. "/" .. var_17_2[2].unlock_num .. "/" .. var_17_2[3].unlock_num .. i18n("clue_task_tip", var_17_3))
	end

	return
end

function ClueBuffSelectLayer:updateDetailView()
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(self.strategyList) do
		table.insert(var_18_1, iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(self.strategyList) do
		if iter_18_3 >= ClueBuffSelectLayer.SP_STRA_MIN_RANGE and iter_18_3 <= ClueBuffSelectLayer.SP_STRA_MAX_RANGE then
			table.insert(var_18_1, ClueBuffSelectLayer.SP_STRATEGY_ID)

			break
		end
	end

	local var_18_2 = pg.strategy_data_template

	self.detailList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("strategyicon/" .. var_18_2[var_18_1[arg_19_1 + 1]].icon, "", arg_19_2:Find("icon"))
			setText(arg_19_2:Find("textBG/name"), var_18_2[var_18_1[arg_19_1 + 1]].name)
			setText(arg_19_2:Find("textBG/desc"), var_18_2[var_18_1[arg_19_1 + 1]].desc)
		end

		return
	end)
	self.detailList:align(#var_18_1)

	return
end

function ClueBuffSelectLayer:SetStageID(arg_20_1)
	self.singleID = arg_20_1

	local var_20_0 = pg.activity_single_enemy[self.singleID]

	setText(self.stageName, pg.activity_single_enemy[self.singleID].name)
	setText(self.stageLV, var_20_0.level)
	setText(self._tf:Find("Stage/text_stage_PTBoost"), i18n("clue_buff_pt_boost", var_20_0.strategy_num))

	for iter_20_0, iter_20_1 in ipairs(var_20_0.strategy_id) do
		local var_20_1 = cloneTplTo(self.buffTmp, self.buffContainer)

		setActive(var_20_1, true)
		GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[iter_20_1].icon, "", var_20_1:Find("icon"))
		setActive(var_20_1:Find("selected"), false)
		onButton(self, var_20_1, function()
			self:onStrategyClick(iter_20_1)

			return
		end)

		self.buffTFs[iter_20_1] = var_20_1
	end

	setImageSprite(self._tf:Find("Stage/stage_icon"), LoadSprite("ui/cluebuffselectui_atlas", var_20_0.icon), true)

	if var_20_0.type >= BossSingleVariableEnemyData.TYPE.SP then
		setActive(self._tf:Find("Stage/stage_type_icon"), false)
		setActive(self.ticket, true)
		setActive(self.ticketTips, true)
		GetImageSpriteFromAtlasAsync(pg.item_virtual_data_statistics[var_20_0.enter_cost].icon, "", self.ticket:Find("icon"), true)
		setText(self.ticket:Find("count"), getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID).data1)
	else
		setActive(self._tf:Find("Stage/stage_type_icon"), true)
		setActive(self.ticket, false)
		setActive(self.ticketTips, false)
		setImageSprite(self._tf:Find("Stage/stage_type_icon"), LoadSprite("ui/cluebuffselectui_atlas", "tier_" .. var_20_0.type), true)

		self.useTicket = false

		setActive(self.ticketCheckBox, self.useTicket)

		self.contextData.useTicket = self.useTicket
	end

	self:updateAwards(pg.expedition_data_template[var_20_0.expedition_id].award_display, self.awards, self.awardTpl)

	return
end

function ClueBuffSelectLayer:UpdateTicket()
	if getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID).data1 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("clue_buff_empty_ticket"))
	else
		self.useTicket = not self.useTicket

		setActive(self.ticketCheckBox, self.useTicket)

		self.contextData.useTicket = self.useTicket
	end

	return
end

function ClueBuffSelectLayer:SetPreSelectedBuff(arg_23_1)
	self.preSelectedBuffList = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		table.insert(self.preSelectedBuffList, iter_23_1)
	end

	return
end

function ClueBuffSelectLayer:onStrategyClick(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.strategyList) do
		if iter_24_1 == arg_24_1 then
			table.remove(self.strategyList, iter_24_0)
			table.remove(self.contextData.selectedBuffList, iter_24_0)
			self:updateBuffView()

			return
		end
	end

	self:selectBuff(arg_24_1)

	return
end

function ClueBuffSelectLayer:selectBuff(arg_25_1)
	if #self.strategyList >= pg.activity_single_enemy[self.singleID].strategy_num then
		pg.TipsMgr.GetInstance():ShowTips(i18n("clue_buff_reach_max"))

		return
	end

	table.insert(self.strategyList, arg_25_1)
	table.insert(self.contextData.selectedBuffList, arg_25_1)
	self:updateBuffView()

	return
end

function ClueBuffSelectLayer:updateAwards(arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0 = 1, #arg_26_1 do
		local var_26_0 = cloneTplTo(arg_26_3, arg_26_2)
		local var_26_1 = arg_26_1[iter_26_0]
		local var_26_2 = {
			type = arg_26_1[iter_26_0][1],
			id = arg_26_1[iter_26_0][2],
			count = arg_26_1[iter_26_0][3]
		}

		if arg_26_1[iter_26_0][2] == ClueBuffSelectLayer.BOOST_ITEM_ID then
			self.ptAwardTF = var_26_0
		end

		updateDrop(findTF(var_26_0, "mask"), var_26_2)
		onButton(self, var_26_0, function()
			local var_27_0 = Item.getConfigData(var_26_1[2])

			if var_27_0 and ({
				[99] = true
			})[var_27_0.type] then
				local var_27_1 = {}

				for iter_27_0, iter_27_1 in ipairs(var_27_0.display_icon) do
					var_27_1[#var_27_1 + 1] = {
						hideName = true,
						type = iter_27_1[1],
						id = iter_27_1[2]
					}
				end

				self:emit(ClueBuffSelectLayer.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_27_1,
					content = var_27_0.display
				})
			else
				self:emit(BaseUI.ON_DROP, var_26_2)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function ClueBuffSelectLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ClueBuffSelectLayer:onBackPressed()
	if isActive(self.detailView) then
		self:closeDetailView()
	else
		self:closeView()
	end

	return
end

return ClueBuffSelectLayer
