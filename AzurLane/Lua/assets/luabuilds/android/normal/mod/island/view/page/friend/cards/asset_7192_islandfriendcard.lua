class = var_0_10000

local var_0_0 = var_0_10000("IslandFriendCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.transform
	local var_1_1 = var_2.Find(var_1_0, "icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconTr = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_1.transform

	arg_1_0.giftTr = var_2.Find(var_1_3, "gift")

	local var_1_4 = arg_1_1.transform
	local var_1_5 = var_2.Find(var_1_4, "name")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTr = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_1.transform
	local var_1_8 = var_2.Find(var_1_7, "level")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTr = var_1_9(var_1_8, var_4(var_1_10005))

	local var_1_10 = arg_1_1.transform
	local var_1_11 = var_2.Find(var_1_10, "Text")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.descTxt = var_1_12(var_1_11, var_4(var_1_10005))

	local var_1_13 = arg_1_1.transform

	arg_1_0.onlineTr = var_2.Find(var_1_13, "online")

	local var_1_14 = arg_1_1.transform

	arg_1_0.offlineTr = var_2.Find(var_1_14, "offline")

	local var_1_15 = arg_1_1.transform
	local var_1_16 = var_2.Find(var_1_15, "offline/Text")
	local var_1_17 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.offlineTxt = var_1_17(var_1_16, var_4(var_1_10005))

	local var_1_18 = arg_1_1.transform

	arg_1_0.visitBtn = var_2.Find(var_1_18, "visit")

	local var_1_19 = arg_1_1.transform

	arg_1_0.moreBtn = var_2.Find(var_1_19, "more")

	local var_1_20 = arg_1_1.transform

	arg_1_0.cardBtn = var_2.Find(var_1_20, "icon")
	setText = var_2

	local var_1_21 = arg_1_0.visitBtn
	local var_1_22 = var_3.Find(var_1_21, "Text")

	i18n = var_1_21

	var_2(var_1_22, var_1_21("island_btn_label_visit"))

	setText = var_2

	local var_1_23 = arg_1_0.moreBtn
	local var_1_24 = var_3.Find(var_1_23, "Text")

	i18n = var_1_23

	var_2(var_1_24, var_1_23("island_btn_label_more"))

	setText = var_2

	local var_1_25 = arg_1_0.onlineTr
	local var_1_26 = var_3.Find(var_1_25, "Text")

	i18n = var_1_25

	var_2(var_1_26, var_1_25("island_btn_label_online"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1
	pg = var_1_10002

	local var_2_0 = var_1_10002.ship_data_statistics[arg_2_1.icon]

	Ship = var_3

	local var_2_1 = var_3.New({
		configId = arg_2_1.icon
	})

	LoadSpriteAsync = var_4

	var_4("qicon/" .. var_2_1:getPrefab(), function(arg_3_0)
		arg_2_0.iconTr.sprite = arg_3_0

		return
	end)

	arg_2_0.nameTr.text = arg_2_1.name
	arg_2_0.levelTr.text = "Lv." .. arg_2_1.level
	arg_2_0.descTxt.text = arg_2_1.manifesto

	arg_2_0:UpdateOnline(arg_2_1)

	return
end

function var_0_0.UpdateOnline(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.GetGiftTagInfoCache(var_4_0, arg_4_1.id)

	setActive = var_4_0

	var_4_0(arg_4_0.giftTr, var_4_1 and var_4_1:ExistGift())

	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.isOnline(var_4_2)

	setActive = var_4_2

	var_4_2(arg_4_0.onlineTr, var_4_3)

	setActive = var_4_2

	var_4_2(arg_4_0.offlineTr, not var_4_3)

	if not var_4_3 then
		local var_4_4 = arg_4_0.offlineTxt

		getOfflineTimeStamp = var_5
		var_4_4.text = var_5(arg_4_1.preOnLineTime)
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
