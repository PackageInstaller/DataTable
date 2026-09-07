local GuildFirePage = class("GuildFirePage", import(".GuildMemberBasePage"))

function GuildFirePage:getUIName()
	return "GuildFirePage"
end

function GuildFirePage:OnLoaded()
	GuildFirePage.super.OnLoaded(self)

	self.fireconfirmBtn = self._tf:Find("frame/confirm_btn")
	self.firecancelBtn = self._tf:Find("frame/cancel_btn")
	self.firenameTF = self._tf:Find("frame/info/name/Text"):GetComponent(typeof(Text))
	self.fireiconTF = self._tf:Find("frame/info/shipicon/icon"):GetComponent(typeof(Image))
	self.fireduty = self._tf:Find("frame/duty"):GetComponent(typeof(Image))
	self.firestarsTF = self._tf:Find("frame/info/shipicon/stars")
	self.firestarTF = self._tf:Find("frame/info/shipicon/stars/star")
	self.firelevelTF = self._tf:Find("frame/info/level/Text"):GetComponent(typeof(Text))
	self.circle = self._tf:Find("frame/info/shipicon/frame")

	return
end

function GuildFirePage:OnInit()
	onButton(self, self.firecancelBtn, function()
		self:Hide()

		return
	end, SFX_CONFIRM)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function GuildFirePage:OnShow()
	local var_6_1 = self.playerVO
	local var_6_2 = self.memberVO

	self.firenameTF.text = self.memberVO.name

	local var_6_3 = AttireFrame.attireFrameRes(var_6_2, var_6_2.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, var_6_2.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_3, var_6_3, true, function(arg_7_0)
		if IsNil(self._tf) then
			return
		end

		if self.circle then
			arg_7_0.name = var_6_3
			findTF(arg_7_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_7_0, self.circle, false)
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
		if not IsNil(self.fireiconTF) then
			self.fireiconTF.sprite = arg_8_0
		end

		return
	end)

	self.fireduty.sprite = GetSpriteFromAtlas("dutyicon", "icon_" .. var_6_2.duty)

	for iter_6_0 = self.firestarsTF.childCount, var_6_4.star - 1 do
		cloneTplTo(self.firestarTF, self.firestarsTF)
	end

	for iter_6_1 = 1, self.firestarsTF.childCount do
		setActive(self.firestarsTF:GetChild(iter_6_1 - 1), iter_6_1 <= var_6_4.star)
	end

	self.firelevelTF.text = "Lv." .. var_6_2.level

	onButton(self, self.fireconfirmBtn, function()
		if var_6_2.id == var_6_1.id then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_fire_tip"),
			onYes = function()
				self:emit(GuildMemberMediator.FIRE, var_6_2.id)
				self:Hide()

				return
			end
		})

		return
	end, SFX_CONFIRM)

	return
end

return GuildFirePage
