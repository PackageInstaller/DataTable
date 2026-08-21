local var_0_0 = class("IslandTradeRankCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.mainTr = arg_1_0._tf:Find("main")
	arg_1_0.iconTF = arg_1_0.mainTr:Find("icon_bg/icon")
	arg_1_0.nameTxt = arg_1_0.mainTr:Find("name"):GetComponent(typeof(Text))
	arg_1_0.lvTxt = arg_1_0.mainTr:Find("level"):GetComponent(typeof(Text))
	arg_1_0.numImg = arg_1_0.mainTr:Find("num")
	arg_1_0.numTxt = arg_1_0.mainTr:Find("num_text"):GetComponent(typeof(Text))
	arg_1_0.valueTxt = arg_1_0.mainTr:Find("price/Text"):GetComponent(typeof(Text))
	arg_1_0.visitBtn = arg_1_0.mainTr:Find("visit")
	arg_1_0.inviteBtn = arg_1_0.mainTr:Find("invite")

	setText(arg_1_0.mainTr:Find("island"), i18n("island_trade_rank_level_label"))

	arg_1_0.cg = GetOrAddComponent(arg_1_0.mainTr, typeof(CanvasGroup))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_2.id

	if arg_2_1 <= 3 then
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1, arg_2_0.numImg)
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1 .. "bg", arg_2_0.mainTr)
	else
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank04bg", arg_2_0.mainTr)
	end

	local var_2_0 = arg_2_0.valueTxt

	if arg_2_2.value > 0 then
		var_2_0.text = arg_2_2.value or "-"

		local var_2_1 = arg_2_0.numTxt

		if arg_2_1 < 10 then
			var_2_1.text = "0" .. arg_2_1 or arg_2_1
			arg_2_0.nameTxt.text = arg_2_2.name
			arg_2_0.lvTxt.text = "lv." .. arg_2_2.islandLevel

			GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[arg_2_2.skinId].prefab, "", arg_2_0.iconTF)

			local var_2_2 = arg_2_2:IsSelf()

			setActive(arg_2_0.visitBtn, not var_2_2)
			setActive(arg_2_0.inviteBtn, var_2_2)
			setActive(arg_2_0.numTxt.gameObject, arg_2_1 > 3)
			setActive(arg_2_0.numImg, arg_2_1 <= 3)

			return
		end
	end
end

function var_0_0.CancelAnimation(arg_3_0)
	if arg_3_0.timer then
		arg_3_0.timer:Stop()

		arg_3_0.timer = nil
	end

	return
end

function var_0_0.PlayAnimation(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:CancelAnimation()

	return
end

return var_0_0
