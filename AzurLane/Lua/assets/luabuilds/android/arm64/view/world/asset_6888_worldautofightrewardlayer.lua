class = var_0_10000

local var_0_0 = "WorldAutoFightRewardLayer"

BaseUI = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "WorldAutoFightRewardUI"
end

local var_0_2 = 0.1

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.window = var_1.Find(var_2_0, "Window")

	local var_2_1 = arg_2_0.window

	arg_2_0.boxView = var_1.Find(var_2_1, "Layout/Box/ScrollView")

	local var_2_2 = arg_2_0.window

	arg_2_0.emptyTip = var_1.Find(var_2_2, "Layout/Box/EmptyTip")

	local var_2_3 = arg_2_0.boxView

	arg_2_0.itemList = var_1.Find(var_2_3, "Content/ItemGrid")
	setText = var_1

	local var_2_4 = arg_2_0.emptyTip

	i18n = var_4

	var_1(var_2_4, var_4("autofight_rewards_none"))

	setText = var_1

	local var_2_5 = arg_2_0.window
	local var_2_6 = var_3.Find(var_2_5, "Fixed/top/bg/obtain/title")

	i18n = var_4

	var_1(var_2_6, var_4("autofight_rewards"))

	setText = var_1

	local var_2_7 = arg_2_0.boxView
	local var_2_8 = var_3.Find(var_2_7, "Content/Title/Text")

	i18n = var_4

	var_1(var_2_8, var_4("battle_end_subtitle1"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0

	arg_3_0.UpdateView(var_3_1)

	getProxy = var_1
	MetaCharacterProxy = var_3_1

	local var_3_2 = var_1(var_3_1)

	if var_1.getMetaTacticsInfoOnEnd(var_3_2) and #var_1 > 0 then
		MetaExpView = var_2

		local var_3_3 = var_2.New
		local var_3_4 = arg_3_0.window

		arg_3_0.metaExpView = var_3_3(var_4.Find(var_3_4, "Layout"), arg_3_0.event, arg_3_0.contextData)

		local var_3_5 = arg_3_0.metaExpView

		var_2.setData(var_3_5, var_1)
		var_2:Reset()
		var_2:Load()
		var_2:ActionInvoke("Show")
	end

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:SkipAnim()

	if arg_4_0.metaExpView then
		local var_4_0 = arg_4_0.metaExpView

		var_1.Destroy(var_4_0)
	end

	pg = var_1

	local var_4_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_1, arg_4_0._tf)

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

	setText = var_1_10002

	local var_5_3 = arg_5_0.window
	local var_5_4 = var_4.Find(var_5_3, "Fixed/ButtonExit/pic")

	i18n = var_5

	var_1_10002(var_5_4, var_5("autofight_leave"))

	onButton = var_1_10002

	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.window
	local var_5_7 = var_5.Find(var_5_6, "Fixed/ButtonExit")

	local function var_5_8()
		existCall = var_2_10000

		var_2_10000(var_5_0.onClose)

		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_5_6

	var_1_10002(var_5_5, var_5_7, var_5_8, var_5_6)

	nowWorld = var_1_10002

	local var_5_9 = var_1_10002().autoInfos

	var_2:InitAutoInfos()

	DropResultIntegration = var_4

	var_4(var_5_9.drops)

	underscore = var_4

	local var_5_10 = var_4.map(var_5_9.drops, function(arg_8_0)
		local var_8_0 = arg_8_0.type

		DROP_TYPE_WORLD_COLLECTION = var_2_10002

		if var_8_0 == var_2_10002 then
			assert = var_8_0
			WorldCollectionProxy = var_2_10003

			local var_8_1 = var_2_10003.GetCollectionType(arg_8_0.id)

			WorldCollectionProxy = var_2_10004

			local var_8_2 = var_8_1 == var_2_10004.WorldCollectionType.FILE

			string = var_4

			var_8_0(var_8_2, var_4.format("collection drop type error#%d", arg_8_0.id))

			table = var_8_0

			local var_8_3 = var_8_0.insert
			local var_8_4 = var_5_9.message

			i18n = var_4

			local var_8_5 = "autofight_file"

			WorldCollectionProxy = var_7

			var_8_3(var_8_4, var_4(var_8_5, var_7.GetCollectionTemplate(arg_8_0.id).name))
		else
			return {
				drop = arg_8_0
			}
		end

		return
	end)

	ipairs = var_5_7

	for iter_5_0, iter_5_1 in var_5_7(var_5_9.salvage) do
		DropResultIntegration = var_1_10010

		var_1_10010(iter_5_1)

		underscore = var_1_10010

		var_1_10010.each(iter_5_1, function(arg_9_0)
			table = var_2_10001

			var_2_10001.insert(var_5_10, {
				drop = arg_9_0,
				salvage = iter_5_0
			})

			return
		end)
	end

	local var_5_11 = true
	local var_5_12 = {}

	setActive = var_7

	local var_5_13 = arg_5_0.boxView

	var_7(var_9.Find(var_5_13, "Content/Title"), false)

	setActive = var_7

	var_7(arg_5_0.itemList, false)

	local var_5_14 = #var_5_10

	arg_5_0.hasRewards = 0 < var_5_14

	local var_5_15, var_5_21

	if arg_5_0.hasRewards then
		var_5_11 = false
		table = var_5_15

		var_5_15.insert(var_5_12, function(arg_10_0)
			setActive = var_2_10001

			local var_10_0 = arg_5_0.boxView

			var_2_10001(var_3.Find(var_10_0, "Content/Title"), true)

			setActive = var_2_10001

			var_2_10001(arg_5_0.itemList, true)
			arg_10_0()

			return
		end)

		CustomIndexLayer = var_5_15
		var_5_15 = var_5_15.Clone2Full(arg_5_0.itemList, #var_5_10)
		ipairs = var_5_21

		for iter_5_2, iter_5_3 in var_5_21(var_5_10) do
			local var_5_16 = iter_5_3.drop

			var_1_10014 = var_5_15[iter_5_2]
			updateDrop = var_1_10015

			var_1_10015(var_1_10014:Find("Shell/Icon"), var_5_16)

			onButton = var_1_10015

			local var_5_17 = arg_5_0
			local var_5_18 = var_1_10014
			local var_5_19 = var_1_10014.Find(var_5_18, "Shell/Icon")

			local function var_5_20()
				local var_11_0 = arg_5_0
				local var_11_1 = var_0.emit

				BaseUI = var_2_10003

				var_11_1(var_11_0, var_2_10003.ON_DROP, var_5_16)

				return
			end

			SFX_PANEL = var_5_18

			var_1_10015(var_5_17, var_5_19, var_5_20, var_5_18)

			setActive = var_1_10015

			var_1_10015(var_1_10014:Find("salvage"), iter_5_3.salvage)

			if iter_5_3.salvage then
				eachChild = var_1_10015

				var_1_10015(var_1_10014:Find("salvage"), function(arg_12_0)
					setActive = var_2_10001

					local var_12_0 = arg_12_0
					local var_12_1 = arg_12_0.name

					tostring = var_2_10005

					var_2_10001(var_12_0, var_12_1 == var_2_10005(iter_5_3.salvage))

					return
				end)
			end
		end

		arg_5_0.isRewardAnimating = true
		var_5_21 = {}

		for iter_5_4 = 1, #var_5_10 do
			local var_5_22 = var_5_15[iter_5_4]

			setActive = var_1_10014

			var_1_10014(var_5_22, false)

			table = var_1_10014

			var_1_10014.insert(var_5_12, function(arg_13_0)
				if arg_5_0.exited then
					return
				end

				setActive = var_1

				var_1(var_5_22, true)

				scrollTo = var_1

				local var_13_0 = arg_5_0.boxView

				var_1(var_3.Find(var_13_0, "Content"), {
					y = 0
				})

				local var_13_1 = arg_5_0

				LeanTween = var_2_10002

				local var_13_2 = var_2_10002.delayedCall
				local var_13_3 = var_0_2

				System = var_13_0
				var_13_1.LTid = var_13_2(var_13_3, var_13_0.Action(arg_13_0)).uniqueId

				return
			end)
		end
	end

	setActive = var_5_15

	local var_5_23 = arg_5_0.boxView

	var_5_15(var_9.Find(var_5_23, "Content/TextArea"), false)

	local var_5_24 = {}

	ipairs = var_5_21

	for iter_5_5, iter_5_6 in var_5_21(var_5_9.buffs) do
		if var_5_24[iter_5_6.id] then
			-- block empty
		else
			var_5_24[iter_5_6.id] = iter_5_6.before
		end
	end

	pg = var_8

	local var_5_25 = var_8.gameset.world_mapbuff_list.description

	underscore = var_9

	local var_5_26 = var_9.map(var_5_25, function(arg_14_0)
		if not var_5_24[arg_14_0] then
			return 0
		else
			local var_14_0 = var_0
			local var_14_1 = var_1.GetGlobalBuff(var_14_0, arg_14_0)

			return var_1.GetFloor(var_14_1) - var_5_24[arg_14_0]
		end

		return
	end)

	underscore = var_10

	if var_10.any(var_5_26, function(arg_15_0)
		return arg_15_0 ~= 0
	end) then
		table = var_10

		local var_5_27 = var_10.insert
		local var_5_28 = var_5_9.message

		i18n = var_13

		local var_5_29 = "autofight_effect"

		unpack = var_1_10016

		var_5_27(var_5_28, var_13(var_5_29, var_1_10016(var_5_26)))
	end

	arg_5_0.hasEventMsg = #var_5_9.message > 0

	if arg_5_0.hasEventMsg then
		var_5_11 = false
		setText = var_10

		local var_5_30 = arg_5_0.boxView
		local var_5_31 = var_12.Find(var_5_30, "Content/TextArea/Text")

		table = var_13

		var_10(var_5_31, var_13.concat(var_5_9.message, "\n"))

		table = var_10

		var_10.insert(var_5_12, function(arg_16_0)
			setActive = var_2_10001

			local var_16_0 = arg_5_0.boxView

			var_2_10001(var_3.Find(var_16_0, "Content/TextArea"), true)
			arg_16_0()

			return
		end)
	end

	setActive = var_10

	var_10(arg_5_0.boxView, not var_5_11)

	setActive = var_10

	var_10(arg_5_0.emptyTip, var_5_11)

	seriesAsync = var_10

	var_10(var_5_12, function()
		local var_17_0 = arg_5_0

		var_0.SkipAnim(var_17_0)

		return
	end)

	return
end

function var_0_1.SkipAnim(arg_18_0)
	if not arg_18_0.isRewardAnimating then
		return
	end

	arg_18_0.isRewardAnimating = nil

	if arg_18_0.LTid then
		LeanTween = var_1

		var_1.cancel(arg_18_0.LTid)

		arg_18_0.LTid = nil
	end

	eachChild = var_1

	var_1(arg_18_0.itemList, function(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0, true)

		return
	end)

	setActive = var_1

	local var_18_0 = arg_18_0.boxView

	var_1(var_3.Find(var_18_0, "Content/Title"), arg_18_0.hasRewards)

	setActive = var_1

	var_1(arg_18_0.itemList, arg_18_0.hasRewards)

	setActive = var_1

	local var_18_1 = arg_18_0.boxView

	var_1(var_3.Find(var_18_1, "Content/TextArea"), arg_18_0.hasEventMsg)

	return
end

return var_0_1
