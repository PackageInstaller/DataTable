local GuildApplyRedPage = class("GuildApplyRedPage", import("....base.BaseSubView"))

function GuildApplyRedPage:getUIName()
	return "GuildApplyRedUI"
end

function GuildApplyRedPage:OnLoaded()
	self.iconTF = findTF(self._tf, "panel/frame/policy_container/input_frame/shipicon/icon"):GetComponent(typeof(Image))
	self.circle = findTF(self._tf, "panel/frame/policy_container/input_frame/shipicon/frame")
	self.manifesto = findTF(self._tf, "panel/frame/policy_container/input_frame/Text"):GetComponent(typeof(Text))
	self.starsTF = findTF(self._tf, "panel/frame/policy_container/input_frame/shipicon/stars")
	self.starTF = findTF(self._tf, "panel/frame/policy_container/input_frame/shipicon/stars/star")
	self.applyBtn = findTF(self._tf, "panel/frame/confirm_btn")
	self.cancelBtn = findTF(self._tf, "panel/frame/cancel_btn")
	self.nameTF = findTF(self._tf, "panel/frame/name"):GetComponent(typeof(Text))
	self.levelTF = findTF(self._tf, "panel/frame/info/level/Text"):GetComponent(typeof(Text))
	self.countTF = findTF(self._tf, "panel/frame/info/count/Text"):GetComponent(typeof(Text))
	self.flagName = findTF(self._tf, "panel/frame/policy_container/name/Text"):GetComponent(typeof(Text))
	self.policyTF = findTF(self._tf, "panel/frame/policy_container/policy/Text"):GetComponent(typeof(Text))

	return
end

function GuildApplyRedPage:OnInit()
	onButton(self, self.applyBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			yesText = "text_confirm",
			limit = 20,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("guild_request_msg_placeholder"),
			title = i18n("guild_request_msg_title"),
			onYes = function(arg_5_0)
				self:emit(JoinGuildMediator.APPLY, self.guildVO.id, arg_5_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function GuildApplyRedPage:Show(arg_7_1)
	self.guildVO = arg_7_1

	self:UpdateApplyPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	GuildApplyRedPage.super.Show(self)

	return
end

function GuildApplyRedPage:UpdateApplyPanel()
	local var_8_0 = Ship.New({
		configId = self.guildVO:getCommader().icon
	})

	LoadSpriteAsync("QIcon/" .. var_8_0:getPainting(), function(arg_9_0)
		self.iconTF.sprite = arg_9_0

		return
	end)

	local var_8_1 = pg.ship_data_statistics[var_8_0.configId]

	self.manifesto.text = self.guildVO.manifesto

	for iter_8_0 = self.starsTF.childCount, var_8_1.star - 1 do
		cloneTplTo(self.starTF, self.starsTF)
	end

	for iter_8_1 = 1, self.starsTF.childCount do
		setActive(self.starsTF:GetChild(iter_8_1 - 1), iter_8_1 <= var_8_1.star)
	end

	self.nameTF.text = self.guildVO.name

	if self.guildVO.level < 9 then
		self.levelTF.text = "0" .. self.guildVO.level or self.guildVO.level
	end

	self.countTF.text = self.guildVO.memberCount .. "/" .. self.guildVO:getMaxMember()
	self.flagName.text = self.guildVO:getCommader().name
	self.policyTF.text = self.guildVO:getPolicyName()

	local var_8_2 = self.guildVO:getCommader()
	local var_8_3 = AttireFrame.attireFrameRes(var_8_2, var_8_2.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, var_8_2.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_8_3, var_8_3, true, function(arg_10_0)
		if IsNil(self._tf) then
			return
		end

		if self.circle then
			arg_10_0.name = var_8_3
			findTF(arg_10_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_10_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_8_3, var_8_3, arg_10_0)
		end

		return
	end)

	return
end

function GuildApplyRedPage:Hide()
	GuildApplyRedPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	if self.circle.childCount > 0 then
		local var_11_0 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_0.name, var_11_0.name, var_11_0)
	end

	return
end

function GuildApplyRedPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return GuildApplyRedPage
