local LevelStageTotalRewardPanel = class("LevelStageTotalRewardPanel", import("view.level.BaseTotalRewardPanel"))

function LevelStageTotalRewardPanel:getUIName()
	return "LevelStageTotalRewardPanel"
end

local var_0_1 = 0.15

function LevelStageTotalRewardPanel:init()
	LevelStageTotalRewardPanel.super.init(self)

	self.itemList = self.boxView:Find("Content/ItemGrid")
	self.itemListSub = self.boxView:Find("Content/ItemGridSub")
	self.spList = self.window:Find("Fixed/SpList")

	setText(self.boxView:Find("Content/Title/Text"), i18n("battle_end_subtitle1"))
	setText(self.boxView:Find("Content/TitleSub/Text"), i18n("settle_rewards_text"))

	return
end

function LevelStageTotalRewardPanel:didEnter()
	LevelStageTotalRewardPanel.super.didEnter(self)

	if self.contextData.isAutoFight and PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
		LuaHelper.Vibrate()
	end

	local var_3_0 = getProxy(MetaCharacterProxy):getMetaTacticsInfoOnEnd()

	if var_3_0 and #var_3_0 > 0 then
		self.metaExpView = MetaExpView.New(self.window:Find("Layout"), self.event, self.contextData)

		self.metaExpView:setData(var_3_0)
		self.metaExpView:Reset()
		self.metaExpView:Load()
		self.metaExpView:ActionInvoke("Show")
	end

	return
end

function LevelStageTotalRewardPanel:willExit()
	self:SkipAnim()

	if self.metaExpView then
		self.metaExpView:Destroy()
	end

	LevelStageTotalRewardPanel.super.willExit(self)

	return
end

function LevelStageTotalRewardPanel:UpdateView()
	local var_5_0 = self.contextData

	onButton(self, self._tf:Find("BG"), function()
		if self.isRewardAnimating then
			self:SkipAnim()

			return
		end

		existCall(var_5_0.onClose)
		self:closeView()

		return
	end)
	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		if self.contextData.spItemID and PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) ~= 1 then
			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()

			local function var_7_0()
				self.contextData.spItemID = nil

				self:UpdateSPItem()

				return
			end

			self:HandleShowMsgBox({
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = var_7_0,
				onNo = var_7_0
			})

			return
		end

		PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(self.contextData.chapter.id), self.contextData.spItemID or 0)
		self:emit(LevelMediator2.ON_RETRACKING, self.contextData.chapter, true)
		self:closeView()

		return
	end, SFX_CONFIRM)
	onButton(self, self.window:Find("Fixed/ButtonExit"), function()
		existCall(var_5_0.onClose)
		self:closeView()

		return
	end, SFX_CANCEL)
	self:UpdateSPItem()

	local var_5_1 = self.contextData.rewards and #self.contextData.rewards > 0
	local var_5_2 = self.contextData.resultRewards and #self.contextData.resultRewards > 0
	local var_5_3 = self.contextData.events and #self.contextData.events > 0
	local var_5_4 = self.contextData.guildTasks and table.getCount(self.contextData.guildTasks) > 0
	local var_5_5 = self.contextData.guildAutoReceives and table.getCount(self.contextData.guildAutoReceives) > 0
	local var_5_6 = true
	local var_5_7 = {}

	setActive(self.boxView:Find("Content/Title"), false)
	setActive(self.itemList, false)

	if var_5_1 then
		var_5_6 = false
		self.hasRewards = true

		table.insert(var_5_7, function(arg_10_0)
			setActive(self.boxView:Find("Content/Title"), true)
			setActive(self.itemList, true)
			arg_10_0()

			return
		end)

		local var_5_8 = CustomIndexLayer.Clone2Full(self.itemList, #self.contextData.rewards)

		for iter_5_0, iter_5_1 in ipairs(var_5_8) do
			local var_5_9 = self.contextData.rewards[iter_5_0]

			updateDrop(var_5_8[iter_5_0]:Find("Shell/Icon"), self.contextData.rewards[iter_5_0])
			onButton(self, var_5_8[iter_5_0]:Find("Shell/Icon"), function()
				self:emit(BaseUI.ON_DROP, var_5_9)

				return
			end, SFX_PANEL)
		end

		self.isRewardAnimating = true

		for iter_5_2 = 1, #self.contextData.rewards do
			local var_5_10 = var_5_8[iter_5_2]

			setActive(var_5_8[iter_5_2], false)
			table.insert(var_5_7, function(arg_12_0)
				if self.exited then
					return
				end

				setActive(var_5_10, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_12_0)).uniqueId

				return
			end)
		end
	end

	setActive(self.boxView:Find("Content/TitleSub"), false)
	setActive(self.itemListSub, false)

	if var_5_2 then
		var_5_6 = false
		self.hasResultRewards = true

		table.insert(var_5_7, function(arg_13_0)
			setActive(self.boxView:Find("Content/TitleSub"), true)
			setActive(self.itemListSub, true)
			arg_13_0()

			return
		end)

		local var_5_11 = CustomIndexLayer.Clone2Full(self.itemListSub, #self.contextData.resultRewards)

		for iter_5_3, iter_5_4 in ipairs(var_5_11) do
			local var_5_12 = self.contextData.resultRewards[iter_5_3]

			updateDrop(var_5_11[iter_5_3]:Find("Shell/Icon"), self.contextData.resultRewards[iter_5_3])
			onButton(self, var_5_11[iter_5_3]:Find("Shell/Icon"), function()
				self:emit(BaseUI.ON_DROP, var_5_12)

				return
			end, SFX_PANEL)
		end

		self.isRewardAnimating = true

		for iter_5_5 = 1, #self.contextData.resultRewards do
			local var_5_14 = var_5_11[iter_5_5]

			setActive(var_5_11[iter_5_5], false)
			table.insert(var_5_7, function(arg_15_0)
				if self.exited then
					return
				end

				setActive(var_5_14, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_15_0)).uniqueId

				return
			end)
		end
	end

	setActive(self.boxView:Find("Content/TextArea"), false)

	local var_5_15 = {}

	if var_5_3 then
		for iter_5_6, iter_5_7 in ipairs(self.contextData.events) do
			table.insert(var_5_15, i18n("autofight_entrust", (pg.collection_template[iter_5_7] or nil) and (pg.collection_template[iter_5_7].title or "")))
		end
	end

	if var_5_4 then
		for iter_5_8, iter_5_9 in pairs(self.contextData.guildTasks) do
			table.insert(var_5_15, i18n("autofight_task", iter_5_9))
		end
	end

	if var_5_5 then
		for iter_5_10, iter_5_11 in pairs(self.contextData.guildAutoReceives) do
			table.insert(var_5_15, i18n("guild_task_autoaccept_1", iter_5_11))
		end
	end

	if #var_5_15 > 0 then
		var_5_6 = false
		self.hasEventMsg = true

		setText(self.boxView:Find("Content/TextArea/Text"), table.concat(var_5_15, "\n"))
		table.insert(var_5_7, function(arg_16_0)
			setActive(self.boxView:Find("Content/TextArea"), true)
			arg_16_0()

			return
		end)
	end

	setActive(self.boxView, not var_5_6)
	setActive(self.emptyTip, var_5_6)
	seriesAsync(var_5_7, function()
		self:SkipAnim()

		return
	end)

	return
end

function LevelStageTotalRewardPanel:UpdateSPItem()
	local var_18_0 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)
	local var_18_1 = noEmptyStr(self.contextData.chapter:getConfig("special_operation_list")) or {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.benefit_buff_template.get_id_list_by_benefit_type[Chapter.OPERATION_BUFF_TYPE_DESC]) do
		if table.contains(var_18_1, iter_18_1) then
			table.insert(var_18_2, pg.benefit_buff_template[iter_18_1])
		end
	end

	local var_18_3 = 1

	setActive(self.spList, #var_18_2 ~= 0 and self.contextData.chapter:GetRestDailyBonus() == 0)

	if #var_18_2 == 0 then
		return
	end

	UIItemList.StaticAlign(self.spList, self.spList:GetChild(0), var_18_3, function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_19_0 = var_18_2[arg_19_1 + 1]
		local var_19_1 = ActivityBuff.GetBenefitCondition(var_18_2[arg_19_1 + 1].benefit_condition)

		assert(var_19_1[1] == "item")

		local var_19_2 = var_19_1[2]

		setText(arg_19_2:Find("Active/Desc"), var_19_0.desc)

		local var_19_3 = _.detect(var_18_0, function(arg_20_0)
			return arg_20_0.configId == var_19_2
		end)
		local var_19_4 = var_19_3 and var_19_3.count > 0

		setActive(arg_19_2:Find("Active"), var_19_3 and var_19_3.count > 0)
		setActive(arg_19_2:Find("Block"), not var_19_4)

		if not var_19_4 then
			setText(arg_19_2:Find("Block"):Find("Desc"), i18n("levelScene_select_noitem"))

			return
		end

		setActive(arg_19_2:Find("Active/Item"), true)

		local var_19_6 = {
			id = var_19_1[2],
			type = DROP_TYPE_ITEM
		}

		if var_19_3 then
			var_19_6.count = var_19_3.count or 0
		end

		updateDrop(arg_19_2:Find("Active/Item/IconTpl"), Drop.New(var_19_6))
		onButton(self, arg_19_2, function()
			if not self.contextData.spItemID then
				self.contextData.spItemID = var_19_2 or nil
			end

			if self.contextData.spItemID then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_select_sp"))
			end

			self:UpdateSPItem()

			return
		end, SFX_PANEL)
		onButton(self, arg_19_2:Find("Active/Item/IconTpl"), function()
			self:emit(BaseUI.ON_ITEM, var_19_2)

			return
		end)
		setActive(arg_19_2:Find("Active/Checkbox/Mark"), tobool(self.contextData.spItemID))

		return
	end)

	return
end

function LevelStageTotalRewardPanel:SkipAnim()
	if not self.isRewardAnimating then
		return
	end

	self.isRewardAnimating = nil

	if self.LTid then
		LeanTween.cancel(self.LTid)

		self.LTid = nil
	end

	eachChild(self.itemList, function(arg_24_0)
		setActive(arg_24_0, true)

		return
	end)
	eachChild(self.itemListSub, function(arg_25_0)
		setActive(arg_25_0, true)

		return
	end)
	setActive(self.boxView:Find("Content/Title"), self.hasRewards)
	setActive(self.itemList, self.hasRewards)
	setActive(self.boxView:Find("Content/TitleSub"), self.hasResultRewards)
	setActive(self.itemListSub, self.hasResultRewards)
	setActive(self.boxView:Find("Content/TextArea"), self.hasEventMsg)

	return
end

return LevelStageTotalRewardPanel
