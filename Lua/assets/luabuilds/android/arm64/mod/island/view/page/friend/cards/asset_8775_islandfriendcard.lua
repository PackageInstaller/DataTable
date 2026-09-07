local IslandFriendCard = class("IslandFriendCard")

function IslandFriendCard:Ctor(arg_1_1)
	self.iconTr = arg_1_1.transform:Find("icon"):GetComponent(typeof(Image))
	self.giftTr = arg_1_1.transform:Find("gift")
	self.nameTr = arg_1_1.transform:Find("name"):GetComponent(typeof(Text))
	self.levelTr = arg_1_1.transform:Find("level"):GetComponent(typeof(Text))
	self.descTxt = arg_1_1.transform:Find("Text"):GetComponent(typeof(Text))
	self.onlineTr = arg_1_1.transform:Find("online")
	self.offlineTr = arg_1_1.transform:Find("offline")
	self.offlineTxt = arg_1_1.transform:Find("offline/Text"):GetComponent(typeof(Text))
	self.visitBtn = arg_1_1.transform:Find("visit")
	self.moreBtn = arg_1_1.transform:Find("more")
	self.cardBtn = arg_1_1.transform:Find("icon")

	setText(self.visitBtn:Find("Text"), i18n("island_btn_label_visit"))
	setText(self.moreBtn:Find("Text"), i18n("island_btn_label_more"))
	setText(self.onlineTr:Find("Text"), i18n("island_btn_label_online"))

	return
end

function IslandFriendCard:Update(arg_2_1)
	self.player = arg_2_1

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_2_1.icon
	}):getPrefab(), function(arg_3_0)
		self.iconTr.sprite = arg_3_0

		return
	end)

	self.nameTr.text = arg_2_1.name
	self.levelTr.text = "Lv." .. arg_2_1.level
	self.descTxt.text = arg_2_1.manifesto

	self:UpdateOnline(arg_2_1)

	return
end

function IslandFriendCard:UpdateOnline(arg_4_1)
	local var_4_0 = getProxy(IslandProxy):GetGiftTagInfoCache(arg_4_1.id)

	setActive(self.giftTr, var_4_0 and var_4_0:ExistGift())

	local var_4_1 = arg_4_1:isOnline()

	setActive(self.onlineTr, var_4_1)
	setActive(self.offlineTr, not var_4_1)

	if not var_4_1 then
		self.offlineTxt.text = getOfflineTimeStamp(arg_4_1.preOnLineTime)
	end

	return
end

function IslandFriendCard:Dispose()
	return
end

return IslandFriendCard
