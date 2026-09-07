local GuildAppiontPage = class("GuildAppiontPage", import(".GuildMemberBasePage"))

function GuildAppiontPage:getUIName()
	return "GuildAppiontPage"
end

local var_0_1 = {
	"commander",
	"deputyCommander",
	"picked",
	"normal"
}

function GuildAppiontPage:OnLoaded()
	GuildAppiontPage.super.OnLoaded(self)

	self.dutyContainer = self._tf:Find("frame/duty")
	self.print = self._tf:Find("frame/prints/print"):GetComponent(typeof(Image))
	self.confirmBtn = self._tf:Find("frame/confirm_btn")
	self.nameTF = self._tf:Find("frame/info/name/Text"):GetComponent(typeof(Text))
	self.iconTF = self._tf:Find("frame/info/shipicon/icon"):GetComponent(typeof(Image))
	self.starsTF = self._tf:Find("frame/info/shipicon/stars")
	self.starTF = self._tf:Find("frame/info/shipicon/stars/star")
	self.levelTF = self._tf:Find("frame/info/level/Text"):GetComponent(typeof(Text))
	self.circle = self._tf:Find("frame/info/shipicon/frame")
	self.toggles = self._tf:Find("frame/duty"):GetComponent(typeof(ToggleGroup))

	return
end

function GuildAppiontPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function GuildAppiontPage:ShouldShow()
	return self.memberVO.id ~= self.playerVO.id
end

function GuildAppiontPage:OnShow()
	local var_6_0 = self.memberVO
	local var_6_1 = self.guildVO
	local var_6_2 = self.guildVO:getDutyByMemberId(self.playerVO.id)
	local var_6_3 = self.guildVO:getEnableDuty(var_6_2, self.memberVO.duty)
	local var_6_4 = self.guildVO:getAssistantMaxCount()
	local var_6_5 = self.guildVO:getAssistantCount()
	local var_6_6

	for iter_6_0, iter_6_1 in ipairs(var_0_1) do
		local var_6_7 = self.dutyContainer:Find(iter_6_1)
		local var_6_8 = var_6_7:Find("Text")
		local var_6_9 = false

		if var_6_0.duty == iter_6_0 then
			setText(var_6_8, i18n("guild_duty_tip_1"))

			var_6_9 = true
		elseif not table.contains(var_6_3, iter_6_0) then
			if var_6_4 <= var_6_5 and iter_6_0 == 2 then
				setText(var_6_8, i18n("guild_deputy_commander_cnt_is_full"))
			else
				setText(var_6_8, i18n("guild_duty_tip_2"))
			end

			var_6_9 = true
		end

		setActive(var_6_8, not table.contains(var_6_3, iter_6_0))

		if var_6_2 == GuildConst.DUTY_COMMANDER and iter_6_0 == 2 and not var_6_9 then
			if var_6_4 <= var_6_5 then
				setText(var_6_8, i18n("guild_deputy_commander_cnt_is_full"))
			else
				setText(var_6_8, i18n("guild_deputy_commander_cnt", var_6_5, var_6_4))
			end

			setActive(var_6_8, true)
		end

		setToggleEnabled(var_6_7, table.contains(var_6_3, iter_6_0))
		onToggle(self, var_6_7, function(arg_7_0)
			if arg_7_0 then
				var_6_6 = iter_6_0
				self.selectedToggle = var_6_7
			end

			return
		end, SFX_PANEL)
	end

	local var_6_10 = self.dutyContainer:Find("commander/Image2")

	if var_6_2 == GuildConst.DUTY_COMMANDER and var_6_0.duty > GuildConst.DUTY_DEPUTY_COMMANDER then
		onButton(self, var_6_10, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_duty_shoule_be_deputy_commander"))

			return
		end, SFX_PANEL)
	else
		local var_6_11 = var_6_10:GetComponent(typeof(Button))

		if not IsNil(var_6_11) then
			Object.Destroy(var_6_11)
		end
	end

	local var_6_12 = var_6_1:getFaction()

	if var_6_12 == GuildConst.FACTION_TYPE_BLHX then
		self.print.color = Color.New(0.4235294117647059, 0.6313725490196078, 0.9568627450980393)
	elseif var_6_12 == GuildConst.FACTION_TYPE_CSZZ then
		self.print.color = Color.New(0.9568627450980393, 0.44313725490196076, 0.42745098039215684)
	end

	self.nameTF.text = var_6_0.name

	local var_6_13 = AttireFrame.attireFrameRes(var_6_0, var_6_0.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, var_6_0.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_13, var_6_13, true, function(arg_9_0)
		if IsNil(self._tf) then
			return
		end

		if self.circle then
			arg_9_0.name = var_6_13
			findTF(arg_9_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_9_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_13, var_6_13, arg_9_0)
		end

		return
	end)

	local var_6_14 = pg.ship_data_statistics[var_6_0.icon]

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_6_0.icon,
		skin_id = var_6_0.skinId
	}):getPainting(), function(arg_10_0)
		if not IsNil(self.iconTF) then
			self.iconTF.sprite = arg_10_0
		end

		return
	end)

	for iter_6_2 = self.starsTF.childCount, var_6_14.star - 1 do
		cloneTplTo(self.starTF, self.starsTF)
	end

	for iter_6_3 = 1, self.starsTF.childCount do
		setActive(self.starsTF:GetChild(iter_6_3 - 1), iter_6_3 <= var_6_14.star)
	end

	self.levelTF.text = "Lv." .. var_6_0.level

	onButton(self, self.confirmBtn, function()
		local function var_11_0()
			self:emit(GuildMemberMediator.SET_DUTY, var_6_0.id, var_6_6)
			self:Hide()

			return
		end

		if var_6_2 == GuildConst.DUTY_COMMANDER and var_6_6 == GuildConst.DUTY_COMMANDER then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_transfer_president_confirm", var_6_0.name),
				onYes = var_11_0
			})
		else
			var_11_0()
		end

		return
	end, SFX_CONFIRM)

	return
end

function GuildAppiontPage:Hide()
	self.toggles:SetAllTogglesOff()
	GuildAppiontPage.super.Hide(self)

	return
end

return GuildAppiontPage
