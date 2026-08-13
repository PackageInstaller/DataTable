class = var_0_10000

local var_0_0 = "ChallengeShareLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChallengeShareUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.painting = var_1.Find(var_2_0, "main/Painting")

	local var_2_1 = arg_2_0._tf

	arg_2_0.shipList = var_1.Find(var_2_1, "main/ship_list")

	local var_2_2 = arg_2_0.shipList

	arg_2_0.cardTF = var_1.Find(var_2_2, "ship_card")
	UIItemList = var_1
	arg_2_0.itemList = var_1.New(arg_2_0.shipList, arg_2_0.cardTF)

	local var_2_3 = arg_2_0._tf

	arg_2_0.wordTF = var_1.Find(var_2_3, "main/word")

	local var_2_4 = arg_2_0._tf

	arg_2_0.touchBtn = var_1.Find(var_2_4, "touch_btn")
	pg = var_1

	local var_2_5 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_5, arg_2_0._tf)

	return
end

function var_0_1.setLevel(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1

	return
end

function var_0_1.setShipPaintList(arg_4_0, arg_4_1)
	arg_4_0.shipPaintList = arg_4_1

	return
end

function var_0_1.setFlagShipPaint(arg_5_0, arg_5_1)
	arg_5_0.flagShipPaint = arg_5_1

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.touchBtn

	local function var_6_2()
		if arg_6_0.isLoading then
			return
		end

		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	local var_6_3 = arg_6_0.itemList

	var_1.make(var_6_3, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			table = var_3

			var_3.insert(arg_6_0.funcs, function(arg_9_0)
				LoadSpriteAsync = var_3_10001

				var_3_10001("shipYardIcon/" .. arg_6_0.shipPaintList[arg_8_1 + 1], function(arg_10_0)
					IsNil = var_4_10001

					if not var_4_10001(arg_8_2) then
						setImageSprite = var_1

						local var_10_0 = arg_8_2

						var_1(var_3.Find(var_10_0, "back/Image"), arg_10_0)
					end

					arg_9_0()

					return
				end)

				return
			end)
		end

		return
	end)
	arg_6_0:flush()

	return
end

function var_0_1.flush(arg_11_0)
	arg_11_0.funcs = {}

	local var_11_0 = arg_11_0.itemList

	var_1.align(var_11_0, #arg_11_0.shipPaintList)

	table = var_1

	var_1.insert(arg_11_0.funcs, function(arg_12_0)
		setPaintingPrefabAsync = var_2_10001

		var_2_10001(arg_11_0.painting, arg_11_0.flagShipPaint, "chuanwu", arg_12_0)

		return
	end)

	arg_11_0.isLoading = true
	parallelAsync = var_1

	var_1(arg_11_0.funcs, function()
		local var_13_0 = arg_11_0

		var_13_0.isLoading = false
		pg = var_13_0

		local var_13_1 = var_13_0.ShareMgr.GetInstance()
		local var_13_2 = var_0.Share

		pg = var_2_10003

		var_13_2(var_13_1, var_2_10003.ShareMgr.TypeChallenge)

		return
	end)

	setText = var_1

	local var_11_1 = arg_11_0.wordTF
	local var_11_2 = var_3.Find(var_11_1, "Text")

	i18n = var_4

	var_1(var_11_2, var_4("challenge_share_progress"))

	setText = var_1

	local var_11_3 = arg_11_0.wordTF

	var_1(var_3.Find(var_11_3, "number/Text"), arg_11_0.level)

	setText = var_1

	local var_11_4 = arg_11_0.wordTF
	local var_11_5 = var_3.Find(var_11_4, "Text2")

	i18n = var_4

	var_1(var_11_5, var_4("challenge_share"))

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)

	return
end

return var_0_1
