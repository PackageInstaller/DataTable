class = var_0_10000

local var_0_0 = "GetCommanderResultPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GetCommanderResultUI"
end

function var_0_1.OnLoaded(arg_2_0)
	CommanderTreePage = var_1_10001
	arg_2_0.treePanel = var_1_10001.New(arg_2_0._tf, arg_2_0.event)
	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "frame/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiList = var_2_0(var_2_2, var_3.Find(var_2_3, "frame/list/tpl"))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "frame/list1")
	local var_2_7 = arg_2_0._tf

	arg_2_0.uiList1 = var_2_4(var_2_6, var_3.Find(var_2_7, "frame/list/tpl"))
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/Text")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("word_click_to_close"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.paintings = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)
	arg_5_0:UpdateCommanders(arg_5_1)

	return
end

function var_0_1.UpdateCommanders(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.uiList

	var_2.align(var_6_0, 0)

	local var_6_1 = arg_6_0.uiList1

	var_2.align(var_6_1, 0)

	local var_6_2

	if not (#arg_6_1 <= 5) or not arg_6_0.uiList1 then
		var_6_2 = arg_6_0.uiList
	end

	var_6_2:make(function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0

			var_3.UpdateCommander(var_7_0, arg_6_1[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	local var_6_3

	if not (#arg_6_1 <= 5) or not #arg_6_1 then
		var_6_3 = 10
	end

	var_6_2:align(var_6_3)

	return
end

function var_0_1.UpdateCommander(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		var_1_10003 = {
			"",
			"",
			"R",
			"SR",
			"SSR"
		}

		local var_8_0 = arg_8_1
		local var_8_1 = arg_8_1.getRarity(var_8_0)

		GetSpriteFromAtlas = var_8_0

		local var_8_2 = var_8_0("ui/CommanderBuildResultUI_atlas", var_1_10003[var_8_1])
		local var_8_3 = arg_8_1:getPainting()
		local var_8_4 = arg_8_2:Find("info/mask/paint")
		local var_8_5 = arg_8_2:Find("info/frame")
		local var_8_6 = var_8.GetComponent

		typeof = var_10
		Image = var_1_10011

		local var_8_7 = var_8_6(var_8_5, var_10(var_1_10011))

		var_8_7.sprite = var_8_2
		setCommanderPaintingPrefab = var_8_7

		var_8_7(var_8_4, var_8_3, "result2")
		arg_8_0:UpdateTalent(arg_8_1, arg_8_2)

		local var_8_8 = arg_8_0.paintings

		var_8_8[var_8_3] = var_8_4
		setText = var_8_8

		var_8_8(arg_8_2:Find("info/Text"), arg_8_1:getName())
	end

	setActive = var_1_10003

	var_1_10003(arg_8_2:Find("empty"), arg_8_1 == nil)

	setActive = var_1_10003

	var_1_10003(arg_8_2:Find("info"), arg_8_1)

	return
end

function var_0_1.UpdateTalent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getTalents(var_9_0)

	UIItemList = var_9_0

	local var_9_2 = var_9_0.New(arg_9_2:Find("info/talent"), arg_9_2:Find("info/talent/tpl"))

	var_4.make(var_9_2, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_1[arg_10_1 + 1]

			GetImageSpriteFromAtlasAsync = var_4

			var_4("CommanderTalentIcon/" .. var_10_0:getConfig("icon"), "", arg_10_2)

			onButton = var_4

			local var_10_1 = arg_9_0
			local var_10_2 = arg_10_2

			local function var_10_3()
				local var_11_0 = arg_9_0.treePanel

				var_0.ExecuteAction(var_11_0, "Show", var_10_0)

				return
			end

			SFX_PANEL = var_8

			var_4(var_10_1, var_10_2, var_10_3, var_8)
		end

		return
	end)
	var_4:align(#var_9_1)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	if arg_12_0.treePanel then
		local var_12_0 = arg_12_0.treePanel

		var_1.Destroy(var_12_0)

		arg_12_0.treePanel = nil
	end

	ipairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.paintings) do
		retCommanderPaintingPrefab = var_1_10006

		var_1_10006(iter_12_1, iter_12_0)
	end

	arg_12_0.paintings = {}

	return
end

return var_0_1
