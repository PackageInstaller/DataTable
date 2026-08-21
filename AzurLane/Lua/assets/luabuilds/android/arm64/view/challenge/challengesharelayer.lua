local var_0_0 = class("ChallengeShareLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChallengeShareUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.painting = arg_2_0._tf:Find("main/Painting")
	arg_2_0.shipList = arg_2_0._tf:Find("main/ship_list")
	arg_2_0.cardTF = arg_2_0.shipList:Find("ship_card")
	arg_2_0.itemList = UIItemList.New(arg_2_0.shipList, arg_2_0.cardTF)
	arg_2_0.wordTF = arg_2_0._tf:Find("main/word")
	arg_2_0.touchBtn = arg_2_0._tf:Find("touch_btn")

	pg.UIMgr.GetInstance():OverlayPanel(arg_2_0._tf)

	return
end

function var_0_0.setLevel(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1

	return
end

function var_0_0.setShipPaintList(arg_4_0, arg_4_1)
	arg_4_0.shipPaintList = arg_4_1

	return
end

function var_0_0.setFlagShipPaint(arg_5_0, arg_5_1)
	arg_5_0.flagShipPaint = arg_5_1

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.touchBtn, function()
		if arg_6_0.isLoading then
			return
		end

		arg_6_0:closeView()

		return
	end, SFX_PANEL)
	arg_6_0.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			table.insert(arg_6_0.funcs, function(arg_9_0)
				LoadSpriteAsync("shipYardIcon/" .. arg_6_0.shipPaintList[arg_8_1 + 1], function(arg_10_0)
					if not IsNil(arg_8_2) then
						setImageSprite(arg_8_2:Find("back/Image"), arg_10_0)
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

function var_0_0.flush(arg_11_0)
	arg_11_0.funcs = {}

	arg_11_0.itemList:align(#arg_11_0.shipPaintList)
	table.insert(arg_11_0.funcs, function(arg_12_0)
		setPaintingPrefabAsync(arg_11_0.painting, arg_11_0.flagShipPaint, "chuanwu", arg_12_0)

		return
	end)

	arg_11_0.isLoading = true

	parallelAsync(arg_11_0.funcs, function()
		arg_11_0.isLoading = false

		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeChallenge)

		return
	end)
	setText(arg_11_0.wordTF:Find("Text"), i18n("challenge_share_progress"))
	setText(arg_11_0.wordTF:Find("number/Text"), arg_11_0.level)
	setText(arg_11_0.wordTF:Find("Text2"), i18n("challenge_share"))

	return
end

function var_0_0.willExit(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
