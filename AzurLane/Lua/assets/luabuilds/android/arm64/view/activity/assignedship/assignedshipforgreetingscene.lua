class = var_0_10000

local var_0_0 = "AssignedShipForGreetingScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseAssignedShipScene"))
local var_0_2 = {}
local var_0_3 = {}

Vector2 = var_3
var_0_3[1] = var_3(80, -110)
Vector2 = var_3
var_0_3[2] = var_3(80, -330)
Vector2 = var_3
var_0_3[3] = var_3(80, -550)
Vector2 = var_3
var_0_3[4] = var_3(80, -770)
Vector2 = var_3
var_0_3[5] = var_3(240, -160)
Vector2 = var_3
var_0_3[6] = var_3(240, -380)
Vector2 = var_3
var_0_3[7] = var_3(240, -600)
var_0_2.select_panel_7 = var_0_3

function var_0_1.getUIName(arg_1_0)
	return "AssignedShipUI6"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "layer")

	arg_2_0.backBtn = var_1.Find(var_2_1, "top/back")
	arg_2_0.confirmBtn = var_1:Find("confirm")
	arg_2_0.print = var_1:Find("print")
	arg_2_0.rtName = var_1:Find("name")
	arg_2_0.rtTitle = var_1:Find("top/title")
	arg_2_0.selectTarget = nil
	arg_2_0.count = 1
	arg_2_0.spList = {}
	arg_2_0.afterAnima = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.confirmBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		i18n = var_2_10004

		local var_5_3 = arg_3_0.strTip

		pg = var_2_10007
		var_5_2.content = var_2_10004(var_5_3, var_2_10007.ship_data_statistics[arg_3_0.selectedShipNumber].name)

		function var_5_2.onYes()
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			AssignedShipMediator = var_3_10003

			var_6_1(var_6_0, var_3_10003.ON_USE_ITEM, arg_3_0.itemVO.id, arg_3_0.count, {
				arg_3_0.idList[arg_3_0.selectTarget]
			})

			return
		end

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	setActive = var_1_10001

	var_1_10001(arg_3_0.rtTitle, arg_3_0.title)

	if arg_3_0.title then
		GetImageSpriteFromAtlasAsync = var_1

		var_1("extra_page/" .. arg_3_0.style .. "/" .. arg_3_0.title, "", arg_3_0.rtTitle, true)
	end

	local var_3_6 = #arg_3_0.shipIdList
	local var_3_7 = "select_panel_" .. var_3_6

	setActive = var_3

	local var_3_8 = arg_3_0._tf

	var_3(var_5.Find(var_3_8, "layer/" .. var_3_7), true)

	local var_3_9 = arg_3_0._tf

	arg_3_0.selectPanel = var_3.Find(var_3_9, "layer/" .. var_3_7 .. "/layout")
	UIItemList = var_3

	local var_3_10 = var_3.New
	local var_3_11 = arg_3_0.selectPanel
	local var_3_12 = arg_3_0.selectPanel

	arg_3_0.itemList = var_3_10(var_3_11, var_6.Find(var_3_12, "item"))

	local var_3_13 = arg_3_0.itemList

	var_3.make(var_3_13, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if var_0_2[var_3_7] then
			setAnchoredPosition = var_3

			var_3(arg_7_2, var_0_2[var_3_7][arg_7_1])
		end

		local var_7_0 = arg_3_0.shipIdList[arg_7_1]

		UIItemList = var_4

		if arg_7_0 == var_4.EventUpdate then
			GetImageSpriteFromAtlasAsync = var_7_4

			var_7_4("extra_page/" .. arg_3_0.style .. "/i_" .. var_7_0, "", arg_7_2:Find("unselected/icon"))

			GetImageSpriteFromAtlasAsync = var_7_4

			var_7_4("extra_page/" .. arg_3_0.style .. "/i_" .. var_7_0, "", arg_7_2:Find("selected/icon"))

			local var_7_4

			if arg_7_1 == 5 then
				local var_7_1 = arg_7_2:Find("unselected/icon")
				local var_7_2 = var_7_4.GetComponent(var_7_1, "Image")

				var_7_4.SetNativeSize(var_7_2)

				local var_7_3 = arg_7_2:Find("unselected/icon")

				var_7_4 = var_7_4.GetComponent(var_7_3, "Image").rectTransform
				Vector2 = var_2_10005
				var_7_4.sizeDelta = var_2_10005(96, 228)

				local var_7_5 = arg_7_2:Find("unselected/icon")

				var_7_4 = var_7_4.GetComponent(var_7_5, "Image").rectTransform
				Vector2 = var_5
				var_7_4.anchoredPosition = var_5(0, -20)
			end

			onToggle = var_7_4

			local var_7_6 = arg_3_0
			local var_7_7 = arg_7_2

			local function var_7_8(arg_8_0)
				if arg_8_0 and arg_3_0.selectTarget ~= arg_7_1 then
					local var_8_5

					if arg_7_1 == 5 then
						local var_8_0 = arg_7_2
						local var_8_1 = var_8_5.Find(var_8_0, "unselected/icon")
						local var_8_2 = var_8_5.GetComponent(var_8_1, "Image")

						var_8_5.SetNativeSize(var_8_2)

						local var_8_3 = arg_7_2
						local var_8_4 = var_8_5.Find(var_8_3, "unselected/icon")

						var_8_5 = var_8_5.GetComponent(var_8_4, "Image").rectTransform
						Vector2 = var_2
						var_8_5.sizeDelta = var_2(96, 228)

						local var_8_6 = arg_7_2
						local var_8_7 = var_8_5.Find(var_8_6, "unselected/icon")

						var_8_5 = var_8_5.GetComponent(var_8_7, "Image").rectTransform
						Vector2 = var_2
						var_8_5.anchoredPosition = var_2(0, -20)
					end

					LeanTween = var_8_5

					var_8_5.cancel(arg_3_0.print)

					if arg_3_0.rtName then
						LeanTween = var_1

						var_1.cancel(arg_3_0.rtName)
					end

					local var_8_8 = arg_3_0

					var_1.setSelectTarget(var_8_8, arg_7_1)
				end

				return
			end

			SFX_PANEL = var_9

			var_7_4(var_7_6, var_7_7, var_7_8, var_9)
		end

		return
	end)

	local var_3_14 = arg_3_0.itemList

	var_3.align(var_3_14, #arg_3_0.idList)

	triggerToggle = var_3

	local var_3_15 = arg_3_0.selectPanel

	var_3(var_5.GetChild(var_3_15, 0), true)

	return
end

return var_0_1
