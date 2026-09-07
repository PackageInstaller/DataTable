local NewGuildMainRedPage = class("NewGuildMainRedPage", import("....base.BaseSubView"))

function NewGuildMainRedPage:getUIName()
	return "NewGuildRedUI"
end

function NewGuildMainRedPage:OnLoaded()
	self.nameInput = findTF(self._tf, "bg/frame/name_bg/input"):GetComponent(typeof(InputField))
	self.manifestoInput = findTF(self._tf, "bg/frame/policy_container/input_frame/input"):GetComponent(typeof(InputField))
	self.relaxToggle = findTF(self._tf, "bg/frame/policy_container/policy/relax")
	self.powerToggle = findTF(self._tf, "bg/frame/policy_container/policy/power")
	self.cancelBtn = findTF(self._tf, "bg/frame/cancel_btn")
	self.confirmBtn = findTF(self._tf, "bg/frame/confirm_btn")
	self.costTF = findTF(self._tf, "bg/frame/confirm_btn/print_container/Text"):GetComponent(typeof(Text))

	return
end

function NewGuildMainRedPage:OnInit()
	local var_3_0 = pg.gameset.create_guild_cost.key_value

	self.costTF.text = pg.gameset.create_guild_cost.key_value

	onInputChanged(self, self.nameInput, function()
		local var_4_0, var_4_1 = wordVer(getInputText(self.nameInput), {
			isReplace = true
		})

		if var_4_0 > 0 then
			setInputText(self.nameInput, var_4_1)
		end

		return
	end)
	onInputChanged(self, self.manifestoInput, function()
		local var_5_0, var_5_1 = wordVer(getInputText(self.manifestoInput), {
			isReplace = true
		})

		if var_5_0 > 0 then
			setInputText(self.manifestoInput, var_5_1)
		end

		return
	end)
	onToggle(self, self.relaxToggle, function(arg_6_0)
		if arg_6_0 then
			self.newGuildVO:setPolicy(GuildConst.POLICY_TYPE_RELAXATION)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.powerToggle, function(arg_7_0)
		if arg_7_0 then
			self.newGuildVO:setPolicy(GuildConst.POLICY_TYPE_POWER)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		self.newGuildVO:setName(self.nameInput.text)

		local var_9_0 = wordVer(self.manifestoInput.text)

		self.newGuildVO:setManifesto(self.manifestoInput.text)

		local var_9_1 = self.newGuildVO:getName()

		if not var_9_1 or var_9_1 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_noname"))

			return
		end

		if not nameValidityCheck(var_9_1, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"err_name_existOtherChar"
		}) then
			return
		end

		if not self.newGuildVO:getFaction() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_nofaction"))

			return
		end

		if not self.newGuildVO:getPolicy() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_nopolicy"))

			return
		end

		local var_9_2 = self.newGuildVO:getManifesto()

		if not var_9_2 or var_9_2 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_nomanifesto"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_create_confirm", var_3_0),
			onYes = function()
				if self.playerVO:getTotalGem() < var_3_0 then
					GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
				else
					self:emit(NewGuildMediator.CREATE, self.newGuildVO)
				end

				return
			end
		})

		return
	end, SFX_CONFIRM)

	return
end

function NewGuildMainRedPage:Show(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self.playerVO = arg_11_2

	NewGuildMainRedPage.super.Show(self)

	self.onCancel = arg_11_4
	self.newGuildVO = arg_11_1

	triggerToggle(self.relaxToggle, true)

	local var_11_0 = GetOrAddComponent(self._tf, "CanvasGroup")

	var_11_0.alpha = 0
	self.isPlaying = true

	LeanTween.value(self._go, 0, 1, 0.6):setOnUpdate(System.Action_float(function(arg_12_0)
		var_11_0.alpha = arg_12_0

		return
	end)):setOnComplete(System.Action(function()
		self.isPlaying = false

		arg_11_3()

		return
	end)):setDelay(0.5)
	self._tf:SetSiblingIndex(1)

	return
end

function NewGuildMainRedPage:IsPlaying()
	return self.isPlaying
end

function NewGuildMainRedPage:OnDestroy()
	return
end

return NewGuildMainRedPage
