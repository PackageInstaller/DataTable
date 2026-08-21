local var_0_0 = class("LevelStageTotalRewardPanel", import("view.level.BaseTotalRewardPanel"))

function var_0_0.getUIName(arg_1_0)
	return "LevelStageTotalRewardPanel"
end

local var_0_1 = 0.15

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.itemList = arg_2_0.boxView:Find("Content/ItemGrid")
	arg_2_0.itemListSub = arg_2_0.boxView:Find("Content/ItemGridSub")
	arg_2_0.spList = arg_2_0.window:Find("Fixed/SpList")

	setText(arg_2_0.boxView:Find("Content/Title/Text"), i18n("battle_end_subtitle1"))
	setText(arg_2_0.boxView:Find("Content/TitleSub/Text"), i18n("settle_rewards_text"))

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	local var_3_0 = PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0

	if arg_3_0.contextData.isAutoFight and var_3_0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
		LuaHelper.Vibrate()
	end

	local var_3_1 = getProxy(MetaCharacterProxy):getMetaTacticsInfoOnEnd()

	if var_3_1 and #var_3_1 > 0 then
		arg_3_0.metaExpView = MetaExpView.New(arg_3_0.window:Find("Layout"), arg_3_0.event, arg_3_0.contextData)

		arg_3_0.metaExpView:setData(var_3_1)
		arg_3_0.metaExpView:Reset()
		arg_3_0.metaExpView:Load()
		arg_3_0.metaExpView:ActionInvoke("Show")
	end

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:SkipAnim()

	if arg_4_0.metaExpView then
		arg_4_0.metaExpView:Destroy()
	end

	var_0_0.super.willExit(arg_4_0)

	return
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	onButton(arg_5_0, arg_5_0._tf:Find("BG"), function()
		if arg_5_0.isRewardAnimating then
			arg_5_0:SkipAnim()

			return
		end

		existCall(var_5_0.onClose)
		arg_5_0:closeView()

		return
	end)
	onButton(arg_5_0, arg_5_0.window:Find("Fixed/ButtonGO"), function()
		if arg_5_0.contextData.spItemID and PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) ~= 1 then
			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()
			arg_5_0:HandleShowMsgBox({
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = function()
					arg_5_0.contextData.spItemID = nil

					arg_5_0:UpdateSPItem()

					return
				end,
				onNo = function()
					arg_5_0.contextData.spItemID = nil

					arg_5_0:UpdateSPItem()

					return
				end
			})

			return
		end

		local var_7_0 = Chapter.GetSPOperationItemCacheKey(arg_5_0.contextData.chapter.id)
		local var_7_1 = arg_5_0.contextData.spItemID or 0

		PlayerPrefs.SetInt(var_7_0, var_7_1)
		arg_5_0:emit(LevelMediator2.ON_RETRACKING, arg_5_0.contextData.chapter, true)
		arg_5_0:closeView()

		return
	end, SFX_CONFIRM)
	onButton(arg_5_0, arg_5_0.window:Find("Fixed/ButtonExit"), function()
		existCall(var_5_0.onClose)
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	arg_5_0:UpdateSPItem()

	local var_5_1 = arg_5_0.contextData.rewards and #arg_5_0.contextData.rewards > 0
	local var_5_2 = arg_5_0.contextData.resultRewards and #arg_5_0.contextData.resultRewards > 0
	local var_5_3 = arg_5_0.contextData.events and #arg_5_0.contextData.events > 0
	local var_5_4 = arg_5_0.contextData.guildTasks and table.getCount(arg_5_0.contextData.guildTasks) > 0
	local var_5_5 = arg_5_0.contextData.guildAutoReceives and table.getCount(arg_5_0.contextData.guildAutoReceives) > 0
	local var_5_6 = true

	setActive(arg_5_0.boxView:Find("Content/Title"), false)
	setActive(arg_5_0.itemList, false)

	if var_5_1 then
		var_5_6 = false
		arg_5_0.hasRewards = true

		table.insert({}, function(arg_10_0)
			setActive(arg_5_0.boxView:Find("Content/Title"), true)
			setActive(arg_5_0.itemList, true)
			arg_10_0()

			return
		end)

		local var_5_7 = CustomIndexLayer.Clone2Full(arg_5_0.itemList, #arg_5_0.contextData.rewards)

		for iter_5_0, iter_5_1 in ipairs(var_5_7) do
			updateDrop(var_5_7[iter_5_0]:Find("Shell/Icon"), arg_5_0.contextData.rewards[iter_5_0])
			onButton(arg_5_0, var_5_7[iter_5_0]:Find("Shell/Icon"), function()
				arg_5_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		arg_5_0.isRewardAnimating = true

		for iter_5_2 = 1, #arg_5_0.contextData.rewards do
			setActive(var_5_7[iter_5_2], false)
			table.insert({}, function(arg_12_0)
				if arg_5_0.exited then
					return
				end

				setActive(var_0, true)
				scrollTo(arg_5_0.boxView:Find("Content"), {
					y = 0
				})

				arg_5_0.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_12_0)).uniqueId

				return
			end)
		end
	end

	setActive(arg_5_0.boxView:Find("Content/TitleSub"), false)
	setActive(arg_5_0.itemListSub, false)

	if var_5_2 then
		var_5_6 = false
		arg_5_0.hasResultRewards = true

		table.insert({}, function(arg_13_0)
			setActive(arg_5_0.boxView:Find("Content/TitleSub"), true)
			setActive(arg_5_0.itemListSub, true)
			arg_13_0()

			return
		end)

		local var_5_8 = CustomIndexLayer.Clone2Full(arg_5_0.itemListSub, #arg_5_0.contextData.resultRewards)

		for iter_5_3, iter_5_4 in ipairs(var_5_8) do
			updateDrop(var_5_8[iter_5_3]:Find("Shell/Icon"), arg_5_0.contextData.resultRewards[iter_5_3])
			onButton(arg_5_0, var_5_8[iter_5_3]:Find("Shell/Icon"), function()
				arg_5_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		arg_5_0.isRewardAnimating = true

		for iter_5_5 = 1, #arg_5_0.contextData.resultRewards do
			setActive(var_5_8[iter_5_5], false)
			table.insert({}, function(arg_15_0)
				if arg_5_0.exited then
					return
				end

				setActive(var_0, true)
				scrollTo(arg_5_0.boxView:Find("Content"), {
					y = 0
				})

				arg_5_0.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_15_0)).uniqueId

				return
			end)
		end
	end

	setActive(arg_5_0.boxView:Find("Content/TextArea"), false)

	local var_5_10 = {}

	if var_5_3 then
		for iter_5_6, iter_5_7 in ipairs(arg_5_0.contextData.events) do
			if pg.collection_template[iter_5_7] then
				table.insert(var_5_10, i18n("autofight_entrust", var_5_11))
			end
		end
	end

	if var_5_4 then
		for iter_5_8, iter_5_9 in pairs(arg_5_0.contextData.guildTasks) do
			table.insert(var_5_10, i18n("autofight_task", iter_5_9))
		end
	end

	if var_5_5 then
		for iter_5_10, iter_5_11 in pairs(arg_5_0.contextData.guildAutoReceives) do
			table.insert(var_5_10, i18n("guild_task_autoaccept_1", iter_5_11))
		end
	end

	if #var_5_10 > 0 then
		var_5_6 = false
		arg_5_0.hasEventMsg = true

		setText(arg_5_0.boxView:Find("Content/TextArea/Text"), table.concat(var_5_10, "\n"))
		table.insert({}, function(arg_16_0)
			setActive(arg_5_0.boxView:Find("Content/TextArea"), true)
			arg_16_0()

			return
		end)
	end

	setActive(arg_5_0.boxView, not var_5_6)
	setActive(arg_5_0.emptyTip, var_5_6)
	seriesAsync({}, function()
		arg_5_0:SkipAnim()

		return
	end)

	return
end

function var_0_0.UpdateSPItem(arg_18_0)
	local var_18_0 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)
	local var_18_1 = noEmptyStr(arg_18_0.contextData.chapter:getConfig("special_operation_list")) or {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.benefit_buff_template.get_id_list_by_benefit_type[Chapter.OPERATION_BUFF_TYPE_DESC]) do
		if table.contains(var_18_1, iter_18_1) then
			table.insert(var_18_2, pg.benefit_buff_template[iter_18_1])
		end
	end

	local var_18_3 = 1

	setActive(arg_18_0.spList, #var_18_2 ~= 0 and arg_18_0.contextData.chapter:GetRestDailyBonus() == 0)

	if #var_18_2 == 0 then
		return
	end

	UIItemList.StaticAlign(arg_18_0.spList, arg_18_0.spList:GetChild(0), var_18_3, function(arg_19_0, arg_19_1, arg_19_2)
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

		local var_19_6 = arg_19_2:Find("Active/Item/IconTpl")
		local var_19_8 = {
			id = var_19_1[2],
			type = DROP_TYPE_ITEM
		}

		if var_19_3 then
			var_19_8.count = var_19_3.count or 0

			var_19_5(var_19_6, var_19_7(var_19_8))
			onButton(arg_18_0, arg_19_2, function()
				local var_21_0 = arg_18_0.contextData

				if not arg_18_0.contextData.spItemID then
					var_21_0.spItemID = var_19_2 or nil

					if arg_18_0.contextData.spItemID then
						pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_select_sp"))
					end

					arg_18_0:UpdateSPItem()

					return
				end
			end, SFX_PANEL)
			onButton(arg_18_0, arg_19_2:Find("Active/Item/IconTpl"), function()
				arg_18_0:emit(BaseUI.ON_ITEM, var_19_2)

				return
			end)
			setActive(arg_19_2:Find("Active/Checkbox/Mark"), tobool(arg_18_0.contextData.spItemID))

			return
		end
	end)

	return
end

function var_0_0.SkipAnim(arg_23_0)
	if not arg_23_0.isRewardAnimating then
		return
	end

	arg_23_0.isRewardAnimating = nil

	if arg_23_0.LTid then
		LeanTween.cancel(arg_23_0.LTid)

		arg_23_0.LTid = nil
	end

	eachChild(arg_23_0.itemList, function(arg_24_0)
		setActive(arg_24_0, true)

		return
	end)
	eachChild(arg_23_0.itemListSub, function(arg_25_0)
		setActive(arg_25_0, true)

		return
	end)
	setActive(arg_23_0.boxView:Find("Content/Title"), arg_23_0.hasRewards)
	setActive(arg_23_0.itemList, arg_23_0.hasRewards)
	setActive(arg_23_0.boxView:Find("Content/TitleSub"), arg_23_0.hasResultRewards)
	setActive(arg_23_0.itemListSub, arg_23_0.hasResultRewards)
	setActive(arg_23_0.boxView:Find("Content/TextArea"), arg_23_0.hasEventMsg)

	return
end

return var_0_0
