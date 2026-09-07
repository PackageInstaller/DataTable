local GuildMemberInfoPage = class("GuildMemberInfoPage", import(".GuildMemberBasePage"))

function GuildMemberInfoPage:getUIName()
	return "GuildMemberInfoPage"
end

local var_0_1 = {
	{
		value = "shipCount",
		type = 1,
		tag = i18n("friend_resume_ship_count")
	},
	{
		type = 3,
		tag = i18n("friend_resume_collection_rate"),
		value = {
			"collectionCount"
		}
	},
	{
		value = "attackCount",
		type = 1,
		tag = i18n("friend_resume_attack_count")
	},
	{
		type = 2,
		tag = i18n("friend_resume_attack_win_rate"),
		value = {
			"attackCount",
			"winCount"
		}
	},
	{
		value = "pvp_attack_count",
		type = 1,
		tag = i18n("friend_resume_manoeuvre_count")
	},
	{
		type = 2,
		tag = i18n("friend_resume_manoeuvre_win_rate"),
		value = {
			"pvp_attack_count",
			"pvp_win_count"
		}
	},
	{
		value = "collect_attack_count",
		type = 1,
		tag = i18n("friend_event_count")
	}
}

function GuildMemberInfoPage:OnLoaded()
	GuildMemberInfoPage.super.OnLoaded(self)

	self.infonameTF = self._tf:Find("frame/info/name/Text"):GetComponent(typeof(Text))
	self.infoiconTF = self._tf:Find("frame/info/shipicon/icon"):GetComponent(typeof(Image))
	self.infoduty = self._tf:Find("frame/duty"):GetComponent(typeof(Image))
	self.infostarsTF = self._tf:Find("frame/info/shipicon/stars")
	self.infostarTF = self._tf:Find("frame/info/shipicon/stars/star")
	self.infolevelTF = self._tf:Find("frame/info/level/Text"):GetComponent(typeof(Text))
	self.circle = self._tf:Find("frame/info/shipicon/frame")
	self.resumeInfo = self._tf:Find("frame/content")

	return
end

function GuildMemberInfoPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function GuildMemberInfoPage:Show(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.guildVO = arg_5_1
	self.playerVO = arg_5_2
	self.memberVO = arg_5_3

	self:emit(GuildMemberMediator.OPEN_DESC_INFO, arg_5_3)

	if arg_5_4 then
		arg_5_4()
	end

	return
end

function GuildMemberInfoPage:Flush(arg_6_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)
	self._tf:SetAsLastSibling()
	self.onShowCallBack(self.buttonPos)

	local var_6_1 = self.memberVO

	self.infonameTF.text = self.memberVO.name

	local var_6_2 = AttireFrame.attireFrameRes(var_6_1, var_6_1.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, var_6_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_2, var_6_2, true, function(arg_7_0)
		if IsNil(self._tf) then
			return
		end

		if self.circle then
			arg_7_0.name = var_6_2
			findTF(arg_7_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_7_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_2, var_6_2, arg_7_0)
		end

		return
	end)

	local var_6_3 = pg.ship_data_statistics[var_6_1.icon]

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_6_1.icon,
		skin_id = var_6_1.skinId
	}):getPainting(), function(arg_8_0)
		if not IsNil(self.infoiconTF) then
			self.infoiconTF.sprite = arg_8_0
		end

		return
	end)

	self.infoduty.sprite = GetSpriteFromAtlas("dutyicon", "icon_" .. var_6_1.duty)

	for iter_6_0 = self.infostarsTF.childCount, var_6_3.star - 1 do
		cloneTplTo(self.infostarTF, self.infostarsTF)
	end

	for iter_6_1 = 1, self.infostarsTF.childCount do
		setActive(self.infostarsTF:GetChild(iter_6_1 - 1), iter_6_1 <= var_6_3.star)
	end

	self.infolevelTF.text = "Lv." .. var_6_1.level

	for iter_6_2, iter_6_3 in ipairs(var_0_1) do
		local var_6_4 = self.resumeInfo:GetChild(iter_6_2 - 1)

		setText(var_6_4:Find("tag"), iter_6_3.tag)

		local var_6_5 = var_6_4:Find("tag (1)")

		if iter_6_3.type == 1 then
			setText(var_6_5, arg_6_1[iter_6_3.value])
		elseif iter_6_3.type == 2 then
			setText(var_6_5, string.format("%0.2f", math.max(arg_6_1[iter_6_3.value[2]], 0) / math.max(arg_6_1[iter_6_3.value[1]], 1) * 100) .. "%")
		elseif iter_6_3.type == 3 then
			local var_6_6 = arg_6_1[iter_6_3.value[1]]
			local var_6_7

			if not arg_6_1[iter_6_3.value[1]] then
				var_6_6 = 1
				var_6_7 = getProxy(CollectionProxy)
			end

			setText(var_6_5, string.format("%0.2f", var_6_6 / var_6_7:getCollectionTotal() * 100) .. "%")
		end
	end

	return
end

return GuildMemberInfoPage
