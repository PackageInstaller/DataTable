class = var_0_10000

local var_0_0 = "BaseAssignedShipScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.TipWords = {
	shrine_year = "seven_choose_one",
	login_year = "nine_choose_one",
	login_santa = "five_choose_one",
	shrine_year_winterfestival_2025 = "seven_choose_one",
	greeting_year = "spring_invited_2021"
}

function var_0_1.getUIName(arg_1_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.setItemVO(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1

	local var_2_0 = arg_2_0.itemVO

	arg_2_0.idList = var_2.getConfig(var_2_0, "usage_arg")
	underscore = var_2
	arg_2_0.shipIdList = var_2.map(arg_2_0.idList, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.item_usage_invitation[arg_3_0].ship_id
	end)
	unpack = var_2

	local var_2_1 = arg_2_0.itemVO

	arg_2_0.style, arg_2_0.title = var_2(var_3.getConfig(var_2_1, "open_ui"))
	arg_2_0.strTip = var_0_1.TipWords[arg_2_0.style]

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "layer")

	arg_4_0.backBtn = var_1.Find(var_4_1, "back")
	arg_4_0.confirmBtn = var_1:Find("confirm")
	arg_4_0.print = var_1:Find("print")
	arg_4_0.rtName = var_1:Find("name")
	arg_4_0.rtTitle = var_1:Find("title")
	arg_4_0.selectPanel = var_1:Find("select_panel/layout")
	UIItemList = var_2

	local var_4_2 = var_2.New
	local var_4_3 = arg_4_0.selectPanel
	local var_4_4 = arg_4_0.selectPanel

	arg_4_0.itemList = var_4_2(var_4_3, var_4.Find(var_4_4, "item"))

	local var_4_5 = arg_4_0.itemList

	var_2.make(var_4_5, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		local var_5_0 = arg_4_0.shipIdList[arg_5_1]

		UIItemList = var_2_10004

		if arg_5_0 == var_2_10004.EventUpdate then
			GetImageSpriteFromAtlasAsync = var_4

			var_4("extra_page/" .. arg_4_0.style .. "/i_" .. var_5_0, "", arg_5_2)

			GetImageSpriteFromAtlasAsync = var_4

			local var_5_1 = "extra_page/" .. arg_4_0.style .. "/is_" .. var_5_0
			local var_5_2 = ""
			local var_5_3 = arg_5_2

			var_4(var_5_1, var_5_2, arg_5_2.Find(var_5_3, "selected"))

			onToggle = var_4

			local var_5_4 = arg_4_0
			local var_5_5 = arg_5_2

			local function var_5_6(arg_6_0)
				if arg_6_0 and arg_4_0.selectTarget ~= arg_5_1 then
					LeanTween = var_1

					var_1.cancel(arg_4_0.print)

					if arg_4_0.rtName then
						LeanTween = var_1

						var_1.cancel(arg_4_0.rtName)
					end

					local var_6_0 = arg_4_0

					var_1.setSelectTarget(var_6_0, arg_5_1)
				end

				return
			end

			SFX_PANEL = var_5_3

			var_4(var_5_4, var_5_5, var_5_6, var_5_3)
		end

		return
	end)

	arg_4_0.selectTarget = nil
	arg_4_0.count = 1
	arg_4_0.spList = {}
	arg_4_0.afterAnima = {}

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.confirmBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10003

		local var_9_3 = arg_7_0.strTip

		pg = var_2_10005
		var_9_2.content = var_2_10003(var_9_3, var_2_10005.ship_data_statistics[arg_7_0.selectedShipNumber].name)

		function var_9_2.onYes()
			local var_10_0 = arg_7_0
			local var_10_1 = var_0.emit

			AssignedShipMediator = var_3_10002

			var_10_1(var_10_0, var_3_10002.ON_USE_ITEM, arg_7_0.itemVO.id, arg_7_0.count, {
				arg_7_0.idList[arg_7_0.selectTarget]
			})

			return
		end

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	local var_7_6 = arg_7_0.itemList

	var_1.align(var_7_6, #arg_7_0.idList)

	setActive = var_1

	var_1(arg_7_0.rtTitle, arg_7_0.title)

	if arg_7_0.title then
		GetImageSpriteFromAtlasAsync = var_1

		var_1("extra_page/" .. arg_7_0.style .. "/" .. arg_7_0.title, "", arg_7_0.rtTitle, true)
	end

	triggerToggle = var_1

	local var_7_7 = arg_7_0.selectPanel

	var_1(var_2.GetChild(var_7_7, 0), true)

	return
end

function var_0_1.checkAndSetSprite(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.spList[arg_11_1] and arg_11_0.afterAnima[arg_11_1] then
		setImageSprite = var_3

		var_3(arg_11_2, arg_11_0.spList[arg_11_1], true)

		local var_11_0 = arg_11_2
		local var_11_1 = arg_11_2.GetComponent

		typeof = var_5
		Image = var_6
		var_11_1(var_11_0, var_5(var_6)).enabled = true
		arg_11_0.spList[arg_11_1] = nil

		local var_11_2 = arg_11_0.afterAnima

		var_11_2[arg_11_1] = nil
		LeanTween = var_11_2

		local var_11_3 = var_11_2.alpha(arg_11_2, 1, 0.3)

		var_3.setFrom(var_11_3, 0)
	end

	return
end

function var_0_1.changeShowCharacter(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 then
		LeanTween = var_1_10004
		var_1_10004 = var_1_10004.alpha
		rtf = var_1_10005

		local var_12_0 = var_1_10004(var_1_10005(arg_12_2), 0, 0.3)

		var_1_10004 = var_1_10004.setOnComplete
		System = var_1_10006

		var_1_10004(var_12_0, var_1_10006.Action(function()
			local var_13_0 = arg_12_2
			local var_13_1 = var_0.GetComponent

			typeof = var_2_10002
			Image = var_2_10003
			var_13_1(var_13_0, var_2_10002(var_2_10003)).enabled = false
			arg_12_0.afterAnima[arg_12_1] = true

			local var_13_2 = arg_12_0

			var_0.checkAndSetSprite(var_13_2, arg_12_1, arg_12_2)

			return
		end))
	else
		local var_12_1 = arg_12_2

		var_1_10004 = arg_12_2.GetComponent
		typeof = var_1_10006
		Image = var_1_10007
		var_1_10004 = var_1_10004(var_12_1, var_1_10006(var_1_10007))
		var_1_10004.enabled = false
		var_1_10004 = arg_12_0.afterAnima
		var_1_10004[arg_12_1] = true
	end

	GetSpriteFromAtlasAsync = var_1_10004

	var_1_10004("extra_page/" .. arg_12_0.style .. "/" .. arg_12_1, "", function(arg_14_0)
		arg_12_0.spList[arg_12_1] = arg_14_0

		local var_14_0 = arg_12_0

		var_1.checkAndSetSprite(var_14_0, arg_12_1, arg_12_2)

		return
	end)

	return
end

function var_0_1.setSelectTarget(arg_15_0, arg_15_1)
	arg_15_0:changeShowCharacter("p_" .. arg_15_0.shipIdList[arg_15_1], arg_15_0.print, arg_15_0.selectTarget)

	if arg_15_0.rtName then
		arg_15_0:changeShowCharacter("n_" .. arg_15_0.shipIdList[arg_15_1], arg_15_0.rtName, arg_15_0.selectTarget)
	end

	arg_15_0.selectTarget = arg_15_1
	arg_15_0.selectedShipNumber = arg_15_0.shipIdList[arg_15_1]

	return
end

function var_0_1.willExit(arg_16_0)
	return
end

return var_0_1
