class = var_0_10000

local var_0_0 = var_0_10000("IslandTradeRankCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.mainTr = var_2.Find(var_1_0, "main")

	local var_1_1 = arg_1_0.mainTr

	arg_1_0.iconTF = var_2.Find(var_1_1, "icon_bg/icon")

	local var_1_2 = arg_1_0.mainTr
	local var_1_3 = var_2.Find(var_1_2, "name")
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_4(var_1_3, var_5(var_1_10007))

	local var_1_5 = arg_1_0.mainTr
	local var_1_6 = var_2.Find(var_1_5, "level")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.lvTxt = var_1_7(var_1_6, var_5(var_1_10007))

	local var_1_8 = arg_1_0.mainTr

	arg_1_0.numImg = var_2.Find(var_1_8, "num")

	local var_1_9 = arg_1_0.mainTr
	local var_1_10 = var_2.Find(var_1_9, "num_text")
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.numTxt = var_1_11(var_1_10, var_5(var_1_10007))

	local var_1_12 = arg_1_0.mainTr
	local var_1_13 = var_2.Find(var_1_12, "price/Text")
	local var_1_14 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.valueTxt = var_1_14(var_1_13, var_5(var_1_10007))

	local var_1_15 = arg_1_0.mainTr

	arg_1_0.visitBtn = var_2.Find(var_1_15, "visit")

	local var_1_16 = arg_1_0.mainTr

	arg_1_0.inviteBtn = var_2.Find(var_1_16, "invite")
	setText = var_2

	local var_1_17 = arg_1_0.mainTr
	local var_1_18 = var_4.Find(var_1_17, "island")

	i18n = var_5

	var_2(var_1_18, var_5("island_trade_rank_level_label"))

	GetOrAddComponent = var_2

	local var_1_19 = arg_1_0.mainTr

	typeof = var_5
	CanvasGroup = var_7
	arg_1_0.cg = var_2(var_1_19, var_5(var_7))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_2.id

	if arg_2_1 <= 3 then
		GetImageSpriteFromAtlasAsync = var_4

		var_4("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1, arg_2_0.numImg)

		GetImageSpriteFromAtlasAsync = var_4

		var_4("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1 .. "bg", arg_2_0.mainTr)
	else
		GetImageSpriteFromAtlasAsync = var_4

		var_4("ui/islandseasonrankui_atlas", "rank04bg", arg_2_0.mainTr)
	end

	local var_2_0 = arg_2_0.valueTxt
	local var_2_1

	if not (arg_2_2.value > 0) or not arg_2_2.value then
		var_2_1 = "-"
	end

	var_2_0.text = var_2_1

	local var_2_2 = arg_2_0.numTxt
	local var_2_3

	if not (arg_2_1 < 10) or not ("0" .. arg_2_1) then
		var_2_3 = arg_2_1
	end

	var_2_2.text = var_2_3
	arg_2_0.nameTxt.text = arg_2_2.name
	arg_2_0.lvTxt.text = "lv." .. arg_2_2.islandLevel

	local var_2_4 = "qicon/"

	pg = var_5

	local var_2_5 = var_2_4 .. var_5.ship_skin_template[arg_2_2.skinId].prefab

	GetImageSpriteFromAtlasAsync = var_5

	var_5(var_2_5, "", arg_2_0.iconTF)

	local var_2_6 = arg_2_2:IsSelf()

	setActive = var_6

	var_6(arg_2_0.visitBtn, not var_2_6)

	setActive = var_6

	var_6(arg_2_0.inviteBtn, var_2_6)

	setActive = var_6

	var_6(arg_2_0.numTxt.gameObject, arg_2_1 > 3)

	setActive = var_6

	var_6(arg_2_0.numImg, arg_2_1 <= 3)

	return
end

function var_0_0.CancelAnimation(arg_3_0)
	if arg_3_0.timer then
		local var_3_0 = arg_3_0.timer

		var_1.Stop(var_3_0)

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
