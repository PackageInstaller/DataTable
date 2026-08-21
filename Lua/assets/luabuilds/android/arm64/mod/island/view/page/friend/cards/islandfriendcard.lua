local var_0_0 = class("IslandFriendCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.iconTr = arg_1_1.transform:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.giftTr = arg_1_1.transform:Find("gift")
	arg_1_0.nameTr = arg_1_1.transform:Find("name"):GetComponent(typeof(Text))
	arg_1_0.levelTr = arg_1_1.transform:Find("level"):GetComponent(typeof(Text))
	arg_1_0.descTxt = arg_1_1.transform:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.onlineTr = arg_1_1.transform:Find("online")
	arg_1_0.offlineTr = arg_1_1.transform:Find("offline")
	arg_1_0.offlineTxt = arg_1_1.transform:Find("offline/Text"):GetComponent(typeof(Text))
	arg_1_0.visitBtn = arg_1_1.transform:Find("visit")
	arg_1_0.moreBtn = arg_1_1.transform:Find("more")
	arg_1_0.cardBtn = arg_1_1.transform:Find("icon")

	setText(arg_1_0.visitBtn:Find("Text"), i18n("island_btn_label_visit"))
	setText(arg_1_0.moreBtn:Find("Text"), i18n("island_btn_label_more"))
	setText(arg_1_0.onlineTr:Find("Text"), i18n("island_btn_label_online"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_2_1.icon
	}):getPrefab(), function(arg_3_0)
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
	local var_4_0 = getProxy(IslandProxy):GetGiftTagInfoCache(arg_4_1.id)

	setActive(arg_4_0.giftTr, var_4_0 and var_4_0:ExistGift())

	local var_4_1 = arg_4_1:isOnline()

	setActive(arg_4_0.onlineTr, var_4_1)
	setActive(arg_4_0.offlineTr, not var_4_1)

	if not var_4_1 then
		arg_4_0.offlineTxt.text = getOfflineTimeStamp(arg_4_1.preOnLineTime)
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
