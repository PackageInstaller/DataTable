class = var_0_10000

local var_0_0 = "LevelStageTotalRewardPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.BaseTotalRewardPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageTotalRewardPanel"
end

local var_0_2 = 0.15

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0.boxView

	arg_2_0.itemList = var_1.Find(var_2_0, "Content/ItemGrid")

	local var_2_1 = arg_2_0.boxView

	arg_2_0.itemListSub = var_1.Find(var_2_1, "Content/ItemGridSub")

	local var_2_2 = arg_2_0.window

	arg_2_0.spList = var_1.Find(var_2_2, "Fixed/SpList")
	setText = var_1

	local var_2_3 = arg_2_0.boxView
	local var_2_4 = var_3.Find(var_2_3, "Content/Title/Text")

	i18n = var_4

	var_1(var_2_4, var_4("battle_end_subtitle1"))

	setText = var_1

	local var_2_5 = arg_2_0.boxView
	local var_2_6 = var_3.Find(var_2_5, "Content/TitleSub/Text")

	i18n = var_4

	var_1(var_2_6, var_4("settle_rewards_text"))

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	local var_3_0 = arg_3_0.contextData.isAutoFight

	PlayerPrefs = var_1_10002

	local var_3_1 = var_1_10002.GetInt

	AUTO_BATTLE_LABEL = var_1_10004

	local var_3_2 = var_3_1(var_1_10004, 0)
	local var_3_3 = 0 < var_3_2
	local var_3_4, var_3_5

	if var_3_0 and var_3_3 then
		pg = var_3_5
		var_3_4 = var_3_5.CriMgr.GetInstance()
		var_3_5 = var_3_5.PlaySoundEffect_V3
		SFX_AUTO_BATTLE = var_1_10006

		var_3_5(var_3_4, var_1_10006)

		LuaHelper = var_3_5

		var_3_5.Vibrate()
	end

	getProxy = var_3_5
	MetaCharacterProxy = var_3_4

	local var_3_6 = var_3_5(var_3_4)

	if var_3.getMetaTacticsInfoOnEnd(var_3_6) and #var_3 > 0 then
		MetaExpView = var_4

		local var_3_7 = var_4.New
		local var_3_8 = arg_3_0.window

		arg_3_0.metaExpView = var_3_7(var_6.Find(var_3_8, "Layout"), arg_3_0.event, arg_3_0.contextData)

		local var_3_9 = arg_3_0.metaExpView

		var_4.setData(var_3_9, var_3)
		var_4:Reset()
		var_4:Load()
		var_4:ActionInvoke("Show")
	end

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:SkipAnim()

	if arg_4_0.metaExpView then
		local var_4_0 = arg_4_0.metaExpView

		var_1.Destroy(var_4_0)
	end

	var_0_1.super.willExit(arg_4_0)

	return
end

function var_0_1.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	onButton = var_1_10002

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0._tf

	var_1_10002(var_5_1, var_5.Find(var_5_2, "BG"), function()
		if arg_5_0.isRewardAnimating then
			local var_6_0 = arg_5_0

			var_0.SkipAnim(var_6_0)

			return
		end

		existCall = var_0

		var_0(var_5_0.onClose)

		local var_6_1 = arg_5_0

		var_0.closeView(var_6_1)

		return
	end)

	onButton = var_1_10002

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.window
	local var_5_5 = var_5.Find(var_5_4, "Fixed/ButtonGO")

	local function var_5_6()
		if arg_5_0.contextData.spItemID then
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.GetInt("autoFight_firstUse_sp", 0) == 1

			if not var_2_10001 then
				PlayerPrefs = var_2_10002

				var_2_10002.SetInt("autoFight_firstUse_sp", 1)

				PlayerPrefs = var_2_10002

				var_2_10002.Save()

				function var_2_10002()
					arg_5_0.contextData.spItemID = nil

					local var_8_0 = arg_5_0

					var_0.UpdateSPItem(var_8_0)

					return
				end

				local var_7_0 = arg_5_0
				local var_7_1 = var_3.HandleShowMsgBox

				var_2_10006 = {
					hideNo = true
				}
				i18n = var_2_10007
				var_2_10006.content = var_2_10007("autofight_special_operation_tip")
				var_2_10006.onYes = var_2_10002
				var_2_10006.onNo = var_2_10002

				var_7_1(var_7_0, var_2_10006)

				return
			end
		end

		Chapter = var_2_10001

		local var_7_2 = var_2_10001.GetSPOperationItemCacheKey(arg_5_0.contextData.chapter.id)

		PlayerPrefs = var_2_10002

		local var_7_3 = var_2_10002.SetInt
		local var_7_4 = var_7_2
		local var_7_5

		if not arg_5_0.contextData.spItemID then
			var_7_5 = 0
		end

		var_7_3(var_7_4, var_7_5)

		local var_7_6 = true
		local var_7_7 = arg_5_0
		local var_7_8 = var_3.emit

		LevelMediator2 = var_2_10006

		var_7_8(var_7_7, var_2_10006.ON_RETRACKING, arg_5_0.contextData.chapter, var_7_6)

		local var_7_9 = arg_5_0

		var_3.closeView(var_7_9)

		return
	end

	SFX_CONFIRM = var_5_4

	var_1_10002(var_5_3, var_5_5, var_5_6, var_5_4)

	onButton = var_1_10002

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.window
	local var_5_9 = var_5.Find(var_5_8, "Fixed/ButtonExit")

	local function var_5_10()
		existCall = var_2_10000

		var_2_10000(var_5_0.onClose)

		local var_9_0 = arg_5_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_5_8

	var_1_10002(var_5_7, var_5_9, var_5_10, var_5_8)
	arg_5_0:UpdateSPItem()

	local var_5_11 = var_5_0.rewards
	local var_5_12 = var_5_0.resultRewards
	local var_5_13 = var_5_0.events
	local var_5_14 = var_5_0.guildTasks
	local var_5_15 = var_5_0.guildAutoReceives
	local var_5_16 = var_5_11 and #var_5_11 > 0
	local var_5_17 = var_5_12 and #var_5_12 > 0
	local var_5_19

	if var_5_13 then
		::label_5_0::

		local var_5_18 = #var_5_13

		var_5_19 = 0 < var_5_18
	end

	if var_5_14 then
		::label_5_1::

		table = var_1_10010
		var_1_10010 = var_1_10010.getCount(var_5_14)
		var_1_10010 = 0 < var_1_10010
	end

	if var_5_15 then
		::label_5_2::

		table = var_1_10011
		var_1_10011 = var_1_10011.getCount(var_5_15) > 0
	end

	local var_5_20 = true
	local var_5_21 = {}

	setActive = var_1_10014

	local var_5_22 = arg_5_0.boxView

	var_1_10014(var_16.Find(var_5_22, "Content/Title"), false)

	setActive = var_1_10014

	var_1_10014(arg_5_0.itemList, false)

	if var_5_16 then
		var_5_20 = false
		arg_5_0.hasRewards = true
		table = var_1_10014

		var_1_10014.insert(var_5_21, function(arg_10_0)
			setActive = var_2_10001

			local var_10_0 = arg_5_0.boxView

			var_2_10001(var_3.Find(var_10_0, "Content/Title"), true)

			setActive = var_2_10001

			var_2_10001(arg_5_0.itemList, true)
			arg_10_0()

			return
		end)

		CustomIndexLayer = var_1_10014
		var_1_10014 = var_1_10014.Clone2Full(arg_5_0.itemList, #var_5_11)
		ipairs = var_1_10015

		for iter_5_0, iter_5_1 in var_1_10015(var_1_10014) do
			var_1_10020 = var_5_11[iter_5_0]
			var_1_10021 = var_1_10014[iter_5_0]
			updateDrop = var_1_10022

			var_1_10022(var_1_10021:Find("Shell/Icon"), var_1_10020)

			onButton = var_1_10022
			var_1_10024 = arg_5_0

			local var_5_23 = var_1_10021
			local var_5_24 = var_1_10021.Find(var_5_23, "Shell/Icon")

			local function var_5_25()
				local var_11_0 = arg_5_0
				local var_11_1 = var_0.emit

				BaseUI = var_2_10003

				var_11_1(var_11_0, var_2_10003.ON_DROP, var_1_10020)

				return
			end

			SFX_PANEL = var_5_23

			var_1_10022(var_1_10024, var_5_24, var_5_25, var_5_23)
		end

		arg_5_0.isRewardAnimating = true

		for iter_5_2 = 1, #var_5_11 do
			local var_5_26 = var_1_10014[iter_5_2]

			setActive = var_1_10020

			var_1_10020(var_5_26, false)

			table = var_1_10020

			var_1_10020.insert(var_5_21, function(arg_12_0)
				if arg_5_0.exited then
					return
				end

				setActive = var_1

				var_1(var_5_26, true)

				scrollTo = var_1

				local var_12_0 = arg_5_0.boxView

				var_1(var_3.Find(var_12_0, "Content"), {
					y = 0
				})

				local var_12_1 = arg_5_0

				LeanTween = var_2_10002

				local var_12_2 = var_2_10002.delayedCall
				local var_12_3 = var_0_2

				System = var_12_0
				var_12_1.LTid = var_12_2(var_12_3, var_12_0.Action(arg_12_0)).uniqueId

				return
			end)
		end
	end

	setActive = var_1_10014

	local var_5_27 = arg_5_0.boxView

	var_1_10014(var_16.Find(var_5_27, "Content/TitleSub"), false)

	setActive = var_1_10014

	var_1_10014(arg_5_0.itemListSub, false)

	if var_5_17 then
		var_5_20 = false
		arg_5_0.hasResultRewards = true
		table = var_1_10014

		var_1_10014.insert(var_5_21, function(arg_13_0)
			setActive = var_2_10001

			local var_13_0 = arg_5_0.boxView

			var_2_10001(var_3.Find(var_13_0, "Content/TitleSub"), true)

			setActive = var_2_10001

			var_2_10001(arg_5_0.itemListSub, true)
			arg_13_0()

			return
		end)

		CustomIndexLayer = var_1_10014
		var_1_10014 = var_1_10014.Clone2Full(arg_5_0.itemListSub, #var_5_12)
		ipairs = var_1_10015

		for iter_5_3, iter_5_4 in var_1_10015(var_1_10014) do
			var_1_10020 = var_5_12[iter_5_3]
			var_1_10021 = var_1_10014[iter_5_3]
			updateDrop = var_1_10022

			var_1_10022(var_1_10021:Find("Shell/Icon"), var_1_10020)

			onButton = var_1_10022
			var_1_10024 = arg_5_0

			local var_5_28 = var_1_10021
			local var_5_29 = var_1_10021.Find(var_5_28, "Shell/Icon")

			local function var_5_30()
				local var_14_0 = arg_5_0
				local var_14_1 = var_0.emit

				BaseUI = var_2_10003

				var_14_1(var_14_0, var_2_10003.ON_DROP, var_1_10020)

				return
			end

			SFX_PANEL = var_5_28

			var_1_10022(var_1_10024, var_5_29, var_5_30, var_5_28)
		end

		arg_5_0.isRewardAnimating = true
		var_1_10015 = {}

		for iter_5_5 = 1, #var_5_12 do
			var_1_10020 = var_1_10014[iter_5_5]
			setActive = var_1_10021

			var_1_10021(var_1_10020, false)

			table = var_1_10021

			var_1_10021.insert(var_5_21, function(arg_15_0)
				if arg_5_0.exited then
					return
				end

				setActive = var_1

				var_1(var_1_10020, true)

				scrollTo = var_1

				local var_15_0 = arg_5_0.boxView

				var_1(var_3.Find(var_15_0, "Content"), {
					y = 0
				})

				local var_15_1 = arg_5_0

				LeanTween = var_2_10002

				local var_15_2 = var_2_10002.delayedCall
				local var_15_3 = var_0_2

				System = var_15_0
				var_15_1.LTid = var_15_2(var_15_3, var_15_0.Action(arg_15_0)).uniqueId

				return
			end)
		end
	end

	setActive = var_1_10014

	local iter_5_10 = arg_5_0.boxView

	var_1_10014(var_16.Find(iter_5_10, "Content/TextArea"), false)

	local var_5_32 = {}

	if var_5_19 then
		ipairs = var_1_10015

		for iter_5_10, iter_5_7 in var_1_10015(var_5_13) do
			pg = var_1_10020

			if var_1_10020.collection_template[iter_5_7] then
				pg = var_1_10020

				if not var_1_10020.collection_template[iter_5_7].title then
					var_1_10020 = ""
				end

				table = var_1_10021
				var_1_10021 = var_1_10021.insert
				var_1_10023 = var_5_32
				i18n = var_1_10024

				var_1_10021(var_1_10023, var_1_10024("autofight_entrust", var_1_10020))
			end
		end
	end

	if var_1_10010 then
		pairs = var_1_10015

		for iter_5_10, iter_5_9 in var_1_10015(var_5_14) do
			table = var_1_10020
			var_1_10020 = var_1_10020.insert

			local var_5_33 = var_5_32

			i18n = var_1_10023

			var_1_10020(var_5_33, var_1_10023("autofight_task", iter_5_9))
		end
	end

	if var_1_10011 then
		pairs = var_1_10015

		for iter_5_10, iter_5_11 in var_1_10015(var_5_15) do
			table = var_1_10020
			var_1_10020 = var_1_10020.insert

			local var_5_34 = var_5_32

			i18n = var_1_10023

			var_1_10020(var_5_34, var_1_10023("guild_task_autoaccept_1", iter_5_11))
		end
	end

	if #var_5_32 > 0 then
		var_5_20 = false
		arg_5_0.hasEventMsg = true
		setText = var_15

		local var_5_35 = arg_5_0.boxView
		local var_5_36 = var_17.Find(var_5_35, "Content/TextArea/Text")

		table = iter_5_10

		var_15(var_5_36, iter_5_10.concat(var_5_32, "\n"))

		table = var_15

		var_15.insert(var_5_21, function(arg_16_0)
			setActive = var_2_10001

			local var_16_0 = arg_5_0.boxView

			var_2_10001(var_3.Find(var_16_0, "Content/TextArea"), true)
			arg_16_0()

			return
		end)
	end

	setActive = var_15

	var_15(arg_5_0.boxView, not var_5_20)

	setActive = var_15

	var_15(arg_5_0.emptyTip, var_5_20)

	seriesAsync = var_15

	var_15(var_5_21, function()
		local var_17_0 = arg_5_0

		var_0.SkipAnim(var_17_0)

		return
	end)

	return
end

function var_0_1.UpdateSPItem(arg_18_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getItemsByType

	Item = var_1_10005

	local var_18_2 = var_18_1(var_18_0, var_1_10005.SPECIAL_OPERATION_TICKET)

	noEmptyStr = var_1_10003

	local var_18_3 = arg_18_0.contextData.chapter
	local var_18_4

	if not var_1_10003(var_5.getConfig(var_18_3, "special_operation_list")) then
		var_18_4 = {}
	end

	local var_18_5 = {}

	ipairs = var_5
	pg = var_18_3

	local var_18_6 = var_18_3.benefit_buff_template.get_id_list_by_benefit_type

	Chapter = var_8

	for iter_18_0, iter_18_1 in var_5(var_18_6[var_8.OPERATION_BUFF_TYPE_DESC]) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.benefit_buff_template[iter_18_1]
		table = var_1_10011

		if var_1_10011.contains(var_18_4, iter_18_1) then
			table = var_1_10011

			var_1_10011.insert(var_18_5, var_1_10010)
		end
	end

	local var_18_7 = 1

	setActive = var_6

	local var_18_8 = arg_18_0.spList

	if #var_18_5 ~= 0 then
		local var_18_9 = arg_18_0.contextData.chapter
		local var_18_10

		if var_9.GetRestDailyBonus(var_18_9) ~= 0 then
			var_18_10 = false
		else
			var_18_10 = true
		end

		var_6(var_18_8, var_18_10)

		if #var_18_5 == 0 then
			return
		end

		UIItemList = var_6

		local var_18_11 = var_6.StaticAlign
		local var_18_12 = arg_18_0.spList
		local var_18_13 = arg_18_0.spList

		var_18_11(var_18_12, var_9.GetChild(var_18_13, 0), var_18_7, function(arg_19_0, arg_19_1, arg_19_2)
			UIItemList = var_2_10003

			if arg_19_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_19_0 = var_18_5[arg_19_1 + 1]

			ActivityBuff = var_4

			local var_19_1 = var_4.GetBenefitCondition(var_19_0.benefit_condition)

			assert = var_2_10005

			var_2_10005(var_19_1[1] == "item")

			local var_19_2 = var_19_1[2]

			setText = var_6

			var_6(arg_19_2:Find("Active/Desc"), var_19_0.desc)

			_ = var_6

			local var_19_4

			if var_6.detect(var_18_2, function(arg_20_0)
				return arg_20_0.configId == var_19_2
			end) then
				::label_19_0::

				local var_19_3 = var_6.count

				var_19_4 = 0 < var_19_3
			end

			setActive = var_8

			var_8(arg_19_2:Find("Active"), var_19_4)

			setActive = var_8

			var_8(arg_19_2:Find("Block"), not var_19_4)

			if not var_19_4 then
				setText = var_8

				local var_19_5 = arg_19_2:Find("Block")
				local var_19_6 = var_10.Find(var_19_5, "Desc")

				i18n = var_11

				var_8(var_19_6, var_11("levelScene_select_noitem"))

				return
			end

			setActive = var_8

			var_8(arg_19_2:Find("Active/Item"), true)

			updateDrop = var_8

			local var_19_7 = arg_19_2:Find("Active/Item/IconTpl")

			Drop = var_11

			local var_19_8 = var_11.New
			local var_19_9 = {
				id = var_19_2
			}

			DROP_TYPE_ITEM = var_2_10014
			var_19_9.type = var_2_10014

			local var_19_10

			if not var_6 or not var_6.count then
				var_19_10 = 0
			end

			var_19_9.count = var_19_10

			var_8(var_19_7, var_19_8(var_19_9))

			onButton = var_8

			local var_19_11 = arg_18_0
			local var_19_12 = arg_19_2

			local function var_19_13()
				local var_21_0 = arg_18_0.contextData
				local var_21_1

				if arg_18_0.contextData.spItemID or not var_19_2 then
					var_21_1 = nil
				end

				var_21_0.spItemID = var_21_1

				if arg_18_0.contextData.spItemID then
					pg = var_0

					local var_21_2 = var_0.TipsMgr.GetInstance()
					local var_21_3 = var_0.ShowTips

					i18n = var_3_10003

					var_21_3(var_21_2, var_3_10003("levelScene_select_sp"))
				end

				local var_21_4 = arg_18_0

				var_0.UpdateSPItem(var_21_4)

				return
			end

			SFX_PANEL = var_19_9

			var_8(var_19_11, var_19_12, var_19_13, var_19_9)

			onButton = var_8

			var_8(arg_18_0, arg_19_2:Find("Active/Item/IconTpl"), function()
				local var_22_0 = arg_18_0
				local var_22_1 = var_0.emit

				BaseUI = var_3_10003

				var_22_1(var_22_0, var_3_10003.ON_ITEM, var_19_2)

				return
			end)

			setActive = var_8

			local var_19_14 = arg_19_2:Find("Active/Checkbox/Mark")

			tobool = var_11

			var_8(var_19_14, var_11(arg_18_0.contextData.spItemID))

			return
		end)

		return
	end
end

function var_0_1.SkipAnim(arg_23_0)
	if not arg_23_0.isRewardAnimating then
		return
	end

	arg_23_0.isRewardAnimating = nil

	if arg_23_0.LTid then
		LeanTween = var_1

		var_1.cancel(arg_23_0.LTid)

		arg_23_0.LTid = nil
	end

	eachChild = var_1

	var_1(arg_23_0.itemList, function(arg_24_0)
		setActive = var_2_10001

		var_2_10001(arg_24_0, true)

		return
	end)

	eachChild = var_1

	var_1(arg_23_0.itemListSub, function(arg_25_0)
		setActive = var_2_10001

		var_2_10001(arg_25_0, true)

		return
	end)

	setActive = var_1

	local var_23_0 = arg_23_0.boxView

	var_1(var_3.Find(var_23_0, "Content/Title"), arg_23_0.hasRewards)

	setActive = var_1

	var_1(arg_23_0.itemList, arg_23_0.hasRewards)

	setActive = var_1

	local var_23_1 = arg_23_0.boxView

	var_1(var_3.Find(var_23_1, "Content/TitleSub"), arg_23_0.hasResultRewards)

	setActive = var_1

	var_1(arg_23_0.itemListSub, arg_23_0.hasResultRewards)

	setActive = var_1

	local var_23_2 = arg_23_0.boxView

	var_1(var_3.Find(var_23_2, "Content/TextArea"), arg_23_0.hasEventMsg)

	return
end

return var_0_1
