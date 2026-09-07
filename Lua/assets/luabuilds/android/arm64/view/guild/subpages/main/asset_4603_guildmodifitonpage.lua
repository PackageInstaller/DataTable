local GuildModiftionPage = class("GuildModiftionPage", import("...base.GuildBasePage"))

function GuildModiftionPage:getTargetUI()
	return "GuildModiftionBluePage", "GuildModiftionRedPage"
end

function GuildModiftionPage:OnLoaded()
	self.nameInput = findTF(self._tf, "frame/name_bg/input"):GetComponent(typeof(InputField))
	self.factionBLHXToggle = findTF(self._tf, "frame/policy_container/faction/blhx")
	self.factionCSZZToggle = findTF(self._tf, "frame/policy_container/faction/cszz")
	self.policyRELAXToggle = findTF(self._tf, "frame/policy_container/policy/relax")
	self.policyPOWERToggle = findTF(self._tf, "frame/policy_container/policy/power")
	self.manifestoInput = findTF(self._tf, "frame/policy_container/input_frame/input"):GetComponent(typeof(InputField))
	self.confirmBtn = findTF(self._tf, "frame/confirm_btn")
	self.cancelBtn = findTF(self._tf, "frame/cancel_btn")
	self.quitBtn = findTF(self._tf, "frame/quit_btn")
	self.dissolveBtn = findTF(self._tf, "frame/dissolve_btn")
	self.factionMask = findTF(self._tf, "frame/policy_container/faction/mask")
	self.costTF = findTF(self._tf, "frame/confirm_btn/print_container/Text"):GetComponent(typeof(Text))

	return
end

function GuildModiftionPage:OnInit()
	self.costTF.text = 0
	self.modifyBackBG = self._tf:Find("bg_decorations")

	setActive(self._tf, false)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.dissolveBtn, function()
		if self.guildVO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_tip_dissolve"),
				onYes = function()
					self:emit(GuildMainMediator.DISSOLVE, self.guildVO.id)

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.quitBtn, function()
		seriesAsync({
			function(arg_8_0)
				self:DealQuit(arg_8_0)

				return
			end
		}, function()
			self:emit(GuildMainMediator.QUIT, self.guildVO.id)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.modifyBackBG, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		local var_11_0 = Clone(self.guildVO)

		if not self.nameInput.text or self.nameInput.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_noname"))

			return
		end

		if not nameValidityCheck(self.nameInput.text, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"err_name_existOtherChar"
		}) then
			return
		end

		if self.nameInput.text ~= self.guildVO:getName() then
			if pg.gameset.modify_guild_cost.key_value > getProxy(PlayerProxy):getData():getTotalGem() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_rmb"))

				return
			end
		end

		if not self.manifestoInput.text or self.manifestoInput.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_nomanifesto"))

			return
		end

		var_11_0:setName(self.nameInput.text)
		var_11_0:setPolicy(self.policy)
		var_11_0:setFaction(self.faction)
		var_11_0:setManifesto(self.manifestoInput.text)

		local function var_11_1()
			if var_11_0:getPolicy() ~= self.guildVO:getPolicy() then
				self:emit(GuildMainMediator.MODIFY, 3, var_11_0:getPolicy(), "")
			end

			if var_11_0:getManifesto() ~= self.guildVO:getManifesto() then
				self:emit(GuildMainMediator.MODIFY, 4, 0, var_11_0:getManifesto())
			end

			if var_11_0:getName() ~= self.guildVO:getName() then
				self:emit(GuildMainMediator.MODIFY, 1, 0, var_11_0:getName())
			end

			self:Hide()

			return
		end

		if var_11_0:getFaction() ~= self.guildVO:getFaction() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_faction_change_tip"),
				onYes = function()
					var_11_1()
					self:emit(GuildMainMediator.MODIFY, 2, var_11_0:getFaction(), "")

					return
				end
			})
		else
			var_11_1()
		end

		return
	end, SFX_CONFIRM)

	local function var_3_0(arg_14_0)
		onInputChanged(self, arg_14_0, function()
			local var_15_0, var_15_1 = wordVer(getInputText(arg_14_0), {
				isReplace = true
			})

			if var_15_0 > 0 then
				setInputText(arg_14_0, var_15_1)
			end

			if getInputText(self.nameInput) ~= self.guildVO:getName() then
				setText(self.costTF, pg.gameset.modify_guild_cost.key_value)
			else
				setText(self.costTF, 0)
			end

			return
		end)

		return
	end

	var_3_0(self.nameInput)
	var_3_0(self.manifestoInput)

	return
end

function GuildModiftionPage:DealQuit(arg_16_1)
	local var_16_0 = self.guildVO:GetActiveEvent()

	if not var_16_0 or var_16_0 and not var_16_0:IsParticipant() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_tip_quit"),
			onYes = arg_16_1
		})
	else
		local var_16_1 = var_16_0:GetMaxJoinCnt()
		local var_16_2 = var_16_1 - var_16_0:GetJoinCnt() + var_16_0:GetExtraJoinCnt()
		local var_16_3

		if var_16_2 <= 0 then
			var_16_3 = COLOR_RED

			local var_16_4

			if not COLOR_RED then
				var_16_3 = COLOR_WHITE
				var_16_4 = {}
			end
		end

		var_16_4.content = i18n("guild_tip_quit_operation", (string.format("<color=%s>%d</color>/%d", var_16_3, var_16_2, var_16_1)))
		var_16_4.onYes = arg_16_1

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_16_4)
	end

	return
end

function GuildModiftionPage:DealBattleReportAward(arg_17_1)
	local var_17_0 = getProxy(GuildProxy):GetCanGetReports()
	local var_17_1

	if #var_17_0 == 0 then
		arg_17_1()

		do return end

		var_17_1 = {
			content = i18n("guild_exist_report_award_when_exit")
		}
	end

	function var_17_1.onYes()
		pg.m02:sendNotification(GAME.SUBMIT_GUILD_REPORT, {
			ids = var_17_0,
			callback = arg_17_1
		})

		return
	end

	function var_17_1.onNo()
		self:emit(GuildMainMediator.QUIT, self.guildVO.id)

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox(var_17_1)

	return
end

function GuildModiftionPage:Show(arg_20_1, arg_20_2)
	self.guildVO = arg_20_1
	self.playerVO = arg_20_2

	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self._tf:SetAsLastSibling()

	self.isShowModify = true
	self.nameInput.text = self.guildVO:getName()
	self.manifestoInput.text = self.guildVO.manifesto

	local var_20_0 = self.guildVO:getDutyByMemberId(self.playerVO.id) == GuildConst.DUTY_COMMANDER

	self.nameInput.interactable = var_20_0
	self.manifestoInput.interactable = var_20_0

	setActive(self.confirmBtn, var_20_0)
	setActive(self.cancelBtn, var_20_0)
	setActive(self.factionMask, self.guildVO:inChangefactionTime())

	if self.guildVO:inChangefactionTime() then
		setText(self.factionMask:Find("timer_container/Text"), (self.guildVO:changeFactionLeftTime()))
	end

	self.faction = self.guildVO:getFaction()

	onToggle(self, self.factionBLHXToggle, function(arg_21_0)
		if arg_21_0 then
			self.faction = GuildConst.FACTION_TYPE_BLHX
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.factionCSZZToggle, function(arg_22_0)
		if arg_22_0 then
			self.faction = GuildConst.FACTION_TYPE_CSZZ
		end

		return
	end, SFX_PANEL)

	self.policy = self.guildVO:getPolicy()

	onToggle(self, self.policyRELAXToggle, function(arg_23_0)
		if arg_23_0 then
			self.policy = GuildConst.POLICY_TYPE_RELAXATION
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.policyPOWERToggle, function(arg_24_0)
		if arg_24_0 then
			self.policy = GuildConst.POLICY_TYPE_POWER
		end

		return
	end, SFX_PANEL)

	if self.faction == GuildConst.FACTION_TYPE_BLHX then
		triggerToggle(self.factionBLHXToggle, true)
	elseif self.faction == GuildConst.FACTION_TYPE_CSZZ then
		triggerToggle(self.factionCSZZToggle, true)
	end

	if self.policy == GuildConst.POLICY_TYPE_RELAXATION then
		triggerToggle(self.policyRELAXToggle, true)
	elseif self.policy == GuildConst.POLICY_TYPE_POWER then
		triggerToggle(self.policyPOWERToggle, true)
	end

	self.policyPOWERToggle:GetComponent(typeof(Toggle)).interactable = var_20_0
	self.policyRELAXToggle:GetComponent(typeof(Toggle)).interactable = var_20_0
	self.factionCSZZToggle:GetComponent(typeof(Toggle)).interactable = var_20_0
	self.factionBLHXToggle:GetComponent(typeof(Toggle)).interactable = var_20_0

	local var_20_1 = self.guildVO:getDutyByMemberId(self.playerVO.id)

	setActive(self.quitBtn, var_20_1 ~= GuildConst.DUTY_COMMANDER)
	setActive(self.dissolveBtn, var_20_1 == GuildConst.DUTY_COMMANDER)

	return
end

function GuildModiftionPage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function GuildModiftionPage:OnDestroy()
	self:Hide()

	return
end

return GuildModiftionPage
