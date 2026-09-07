local GuildImpeachPage = class("GuildImpeachPage", import(".GuildMemberBasePage"))

function GuildImpeachPage:getUIName()
	return "GuildImpeachPage"
end

function GuildImpeachPage:OnLoaded()
	GuildImpeachPage.super.OnLoaded(self)

	self.impeachconfirmBtn = self._tf:Find("frame/confirm_btn")
	self.impeachcancelBtn = self._tf:Find("frame/cancel_btn")
	self.impeachnameTF = self._tf:Find("frame/info/name/Text"):GetComponent(typeof(Text))
	self.impeachiconTF = self._tf:Find("frame/info/shipicon/icon"):GetComponent(typeof(Image))
	self.impeachduty = self._tf:Find("frame/duty"):GetComponent(typeof(Image))
	self.impeachstarsTF = self._tf:Find("frame/info/shipicon/stars")
	self.impeachstarTF = self._tf:Find("frame/info/shipicon/stars/star")
	self.impeachlevelTF = self._tf:Find("frame/info/level/Text"):GetComponent(typeof(Text))
	self.circle = self._tf:Find("frame/info/shipicon/frame")

	return
end

function GuildImpeachPage:OnInit()
	onButton(self, self.impeachcancelBtn, function()
		self:Hide()

		return
	end, SFX_CONFIRM)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function GuildImpeachPage:OnShow()
	local var_6_1 = self.playerVO
	local var_6_2 = self.memberVO

	self.impeachnameTF.text = self.memberVO.name

	local var_6_3 = AttireFrame.attireFrameRes(var_6_2, var_6_2.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, var_6_2.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_3, var_6_3, true, function(arg_7_0)
		if IsNil(self._tf) then
			return
		end

		if self.cirCle then
			arg_7_0.name = var_6_3
			findTF(arg_7_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_7_0, self.cirCle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_3, var_6_3, arg_7_0)
		end

		return
	end)

	local var_6_4 = pg.ship_data_statistics[var_6_2.icon]

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_6_2.icon,
		skin_id = var_6_2.skinId
	}):getPainting(), function(arg_8_0)
		if not IsNil(self.impeachiconTF) then
			self.impeachiconTF.sprite = arg_8_0
		end

		return
	end)

	self.impeachduty.sprite = GetSpriteFromAtlas("dutyicon", "icon_" .. var_6_2.duty)

	for iter_6_0 = self.impeachstarsTF.childCount, var_6_4.star - 1 do
		cloneTplTo(self.impeachstarTF, self.impeachstarsTF)
	end

	for iter_6_1 = 1, self.impeachstarsTF.childCount do
		setActive(self.impeachstarsTF:GetChild(iter_6_1 - 1), iter_6_1 <= var_6_4.star)
	end

	self.impeachlevelTF.text = "Lv." .. var_6_2.level

	onButton(self, self.impeachconfirmBtn, function()
		if var_6_2.id == var_6_1.id then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_impeach_tip"),
			onYes = function()
				self:emit(GuildMemberMediator.IMPEACH, var_6_2.id)
				self:Hide()

				return
			end
		})

		return
	end, SFX_CONFIRM)

	return
end

return GuildImpeachPage
