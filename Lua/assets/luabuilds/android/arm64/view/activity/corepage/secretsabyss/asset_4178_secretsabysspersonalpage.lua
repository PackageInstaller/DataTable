local SecretsAbyssPersonalPage = class("SecretsAbyssPersonalPage", import("view.activity.BackHills.OtherWorld.TerminalPersonalPage"))

SecretsAbyssPersonalPage.BIND_EVENT_ACT_ID = 50094
SecretsAbyssPersonalPage.config = pg.roll_attr
SecretsAbyssPersonalPage.NAME_ID = 1001
SecretsAbyssPersonalPage.LV_ID = 1002
SecretsAbyssPersonalPage.JOB_ID = 1003
SecretsAbyssPersonalPage.GUARDIAN_ID = 1004

local function var_0_2(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = arg_1_0[1], arg_1_0[2] do
		if SecretsAbyssPersonalPage.config[iter_1_0] then
			table.insert(var_1_0, iter_1_0)
		end
	end

	return var_1_0
end

SecretsAbyssPersonalPage.PROPERTY_IDS = var_0_2({
	2001,
	2006
})
SecretsAbyssPersonalPage.ABILITY_IDS = var_0_2({
	3000,
	3193
})
SecretsAbyssPersonalPage.RANDOM_ABILITY_CNT = 8
SecretsAbyssPersonalPage.personalRandomData = nil

function SecretsAbyssPersonalPage:getUIName()
	return "SecretsAbyssPersonalPage"
end

function SecretsAbyssPersonalPage:OnLoaded()
	self.infoTF = self._tf:Find("frame/info")
	self.nameTitle = self.infoTF:Find("infos/name/title")
	self.nameInput = self.infoTF:Find("infos/name/box/InputField")
	self.jobTitle = self.infoTF:Find("infos/job/title")
	self.jobValue = self.infoTF:Find("infos/job/value")
	self.guardianTitle = self.infoTF:Find("infos/guardian/title")
	self.guardianValue = self.infoTF:Find("infos/guardian/value")
	self.lvTitle = self.infoTF:Find("level/lv/title")
	self.lvValue = self.infoTF:Find("level/lv/value")
	self.lvSlider = self.infoTF:Find("level/slider/slider")
	self.lvSliderImage = self.lvSlider:GetComponent(typeof(Image))
	self.lvUpgradeTF = self.infoTF:Find("level/slider/upgrade")

	setActive(self.lvUpgradeTF, false)

	self.propertyTF = self._tf:Find("frame/property")
	self.propertyContent = self.propertyTF:Find("content")
	self.propertyTpl = self.propertyTF:Find("tpl")

	setActive(self.propertyTpl, false)
	setActive(self.propertyTpl:Find("upgrade"), false)

	if PLATFORM_CODE == PLATFORM_CH or PLATFORM_CODE == PLATFORM_CHT then
		self.abilityTF = self._tf:Find("frame/ability")

		setActive(self._tf:Find("frame/ability_2"), false)
	else
		self.abilityTF = self._tf:Find("frame/ability_2")

		setActive(self._tf:Find("frame/ability"), false)
	end

	setActive(self.abilityTF, true)

	self.abilityContent = self.abilityTF:Find("content")
	self.abilityTpl = self.abilityTF:Find("tpl")

	setActive(self.abilityTpl, false)

	self.randomBtn = self._tf:Find("frame/random_btn")
	self.helpBtn = self._tf:Find("frame/help_tips")
	self.effectTF = self._tf:Find("effect")

	setActive(self.effectTF, false)

	self.quitBtn = self._tf:Find("frame/close_btn")
	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.showName = getProxy(PlayerProxy):getRawData().name

	return
end

function SecretsAbyssPersonalPage:OnInit()
	self.activity = getProxy(ActivityProxy):getActivityById(SecretsAbyssPersonalPage.BIND_EVENT_ACT_ID)

	assert(self.activity, "not exist bind event act, id" .. SecretsAbyssPersonalPage.BIND_EVENT_ACT_ID)
	self.nameInput:GetComponent(typeof(InputField)).onValueChanged:AddListener(function()
		if not self.unlockRandom or not nameValidityCheck(getInputText(self.nameInput), 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			self:SetDefaultName()
		else
			self.showName = getInputText(self.nameInput)

			setInputText(self.nameInput, self.showName)
			self:SetLocalName(self.showName)
		end

		return
	end)
	onButton(self, self.randomBtn, function()
		setActive(self.effectTF, false)
		setActive(self.effectTF, true)
		setActive(self.randomBtn, false)
		self:managedTween(LeanTween.delayedCall, function()
			SecretsAbyssPersonalPage.personalRandomData = {}

			self:UpdateView(true)
			setActive(self.effectTF, false)
			setActive(self.randomBtn, self.unlockRandom)

			return
		end, SecretsAbyssPersonalPage.RANDOM_CHANGE_TIME, nil)

		if self.randomCallback then
			self:randomCallback()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("personal_random_tip"))

		return
	end, SFX_PANEL)
	setActive(self.randomBtn, self.unlockRandom)
	setActive(self.helpBtn, not self.unlockRandom)
	setActive(self.infoTF:Find("infos/name/box/edit"), self.unlockRandom)

	if self.unlockRandom and self:GetLocalName() ~= "" then
		self.showName = self:GetLocalName()
	end

	self.nameInput:GetComponent(typeof(InputField)).interactable = self.unlockRandom

	onButton(self, self.quitBtn, function()
		self:Hide()

		return
	end)
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end)
	self:UpdateView()

	return
end

function SecretsAbyssPersonalPage:UnlockRandom()
	self.unlockRandom = true

	return
end

function SecretsAbyssPersonalPage:SetUpgrade()
	self.upgradeFlag = true

	return
end

function SecretsAbyssPersonalPage:SetBossRushNode(arg_13_1, arg_13_2)
	self.currentBossRushNode = arg_13_1
	self.lastBossRushNode = arg_13_2

	return
end

function SecretsAbyssPersonalPage:GetActivitySingleEventOption(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(pg.activity_single_event.all) do
		if pg.activity_single_event[iter_14_1].story == arg_14_1:getConfig("story") then
			return pg.activity_single_event[iter_14_1].options
		end
	end

	return
end

function SecretsAbyssPersonalPage:GetCurrentEvent()
	return self.currentBossRushNode
end

function SecretsAbyssPersonalPage:RegisterRandomCallback(arg_16_1)
	self.randomCallback = arg_16_1

	return
end

function SecretsAbyssPersonalPage:UpdateView(arg_17_1)
	self.showCfg = {}

	for iter_17_0, iter_17_1 in ipairs((self.upgradeFlag or #self:GetActivitySingleEventOption(self.currentBossRushNode) == 0) and self:GetActivitySingleEventOption(self.lastBossRushNode) or self:GetActivitySingleEventOption(self.currentBossRushNode)) do
		self.showCfg[iter_17_1[1]] = iter_17_1[2]
	end

	self:UpdateInfo(arg_17_1)
	self:UpdateProperty(arg_17_1)
	self:UpdateAbility(arg_17_1)

	if self.upgradeFlag then
		self.upgradeCfg = {}

		for iter_17_2, iter_17_3 in ipairs(self:GetActivitySingleEventOption(self.currentBossRushNode)) do
			self.upgradeCfg[iter_17_3[1]] = iter_17_3[2]
		end

		self:PlayUpgradeAnims()
	end

	return
end

function SecretsAbyssPersonalPage:UpdateInfo(arg_18_1)
	self:SetDefaultName()
	setText(self.nameTitle, self:GetRollAttrInfoById(SecretsAbyssPersonalPage.NAME_ID, arg_18_1) .. "：")

	local var_18_0, var_18_1 = self:GetRollAttrInfoById(SecretsAbyssPersonalPage.JOB_ID, arg_18_1)

	setText(self.jobTitle, var_18_0 .. "：")
	setText(self.jobValue, var_18_1)

	local var_18_2, var_18_3 = self:GetRollAttrInfoById(SecretsAbyssPersonalPage.GUARDIAN_ID, arg_18_1)

	setText(self.guardianTitle, var_18_2 .. "：")
	setText(self.guardianValue, var_18_3)

	local var_18_4, var_18_5 = self:GetRollAttrInfoById(SecretsAbyssPersonalPage.LV_ID, arg_18_1)

	setText(self.lvTitle, var_18_4 .. "：")
	setText(self.lvValue, var_18_5)

	self.lvSliderImage.fillAmount = tonumber(var_18_5) / SecretsAbyssPersonalPage.config[SecretsAbyssPersonalPage.LV_ID].random_value[2]

	if arg_18_1 then
		SecretsAbyssPersonalPage.personalRandomData[SecretsAbyssPersonalPage.JOB_ID] = var_18_1
		SecretsAbyssPersonalPage.personalRandomData[SecretsAbyssPersonalPage.GUARDIAN_ID] = var_18_3
		SecretsAbyssPersonalPage.personalRandomData[SecretsAbyssPersonalPage.LV_ID] = var_18_5
	end

	return
end

function SecretsAbyssPersonalPage:UpdateProperty(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(SecretsAbyssPersonalPage.PROPERTY_IDS) do
		var_19_0 = var_19_0 + 1

		local var_19_1

		if var_19_0 > self.propertyContent.childCount then
			var_19_1 = cloneTplTo(self.propertyTpl, self.propertyContent) or self.propertyContent:GetChild(var_19_0 - 1)
		end

		var_19_1.name = iter_19_1

		local var_19_2, var_19_3 = self:GetRollAttrInfoById(iter_19_1, arg_19_1)

		setText(var_19_1:Find("name"), var_19_2)
		setText(var_19_1:Find("value/Text"), var_19_3)

		if arg_19_1 then
			SecretsAbyssPersonalPage.personalRandomData[iter_19_1] = var_19_3
		end
	end

	for iter_19_2 = 1, self.propertyContent.childCount - 1 do
		if var_19_0 < iter_19_2 then
			setActive(self.propertyContent:GetChild(iter_19_2 - 1), false)
		end
	end

	return
end

function SecretsAbyssPersonalPage:UpdateAbility(arg_20_1)
	local var_20_0 = {}

	if arg_20_1 then
		var_20_0 = self:GetRandomAbilityIds()
	elseif SecretsAbyssPersonalPage.personalRandomData then
		for iter_20_0, iter_20_1 in pairs(SecretsAbyssPersonalPage.personalRandomData) do
			if table.contains(SecretsAbyssPersonalPage.ABILITY_IDS, iter_20_0) then
				table.insert(var_20_0, iter_20_0)
			end
		end
	else
		for iter_20_2, iter_20_3 in pairs(self.showCfg) do
			if table.contains(SecretsAbyssPersonalPage.ABILITY_IDS, iter_20_2) then
				table.insert(var_20_0, iter_20_2)
			end
		end
	end

	table.sort(var_20_0)

	for iter_20_4, iter_20_5 in ipairs(var_20_0) do
		local var_20_1

		if iter_20_4 > self.abilityContent.childCount then
			var_20_1 = cloneTplTo(self.abilityTpl, self.abilityContent) or self.abilityContent:GetChild(iter_20_4 - 1)
		end

		var_20_1.name = iter_20_4

		local var_20_2, var_20_3 = self:GetRollAttrInfoById(iter_20_5, arg_20_1)

		setScrollText(var_20_1:Find("name_mask/name"), var_20_2)
		setText(var_20_1:Find("value/Text"), var_20_3)

		if arg_20_1 then
			SecretsAbyssPersonalPage.personalRandomData[iter_20_5] = var_20_3
		end
	end

	for iter_20_6 = 1, self.abilityContent.childCount do
		if iter_20_6 > #var_20_0 then
			setActive(self.abilityContent:GetChild(iter_20_6 - 1), false)
		end
	end

	return
end

function SecretsAbyssPersonalPage:GetRollAttrInfoById(arg_21_1, arg_21_2)
	local var_21_0 = ""

	if arg_21_2 then
		var_21_0 = (table.contains(SecretsAbyssPersonalPage.PROPERTY_IDS, arg_21_1) or arg_21_1 == SecretsAbyssPersonalPage.LV_ID) and math.random(SecretsAbyssPersonalPage.config[arg_21_1].random_value[1], SecretsAbyssPersonalPage.config[arg_21_1].random_value[2]) or SecretsAbyssPersonalPage.config[arg_21_1].random_value[math.random(#SecretsAbyssPersonalPage.config[arg_21_1].random_value)]
	else
		var_21_0 = self.showCfg[arg_21_1] or SecretsAbyssPersonalPage.config[arg_21_1].default_value

		if SecretsAbyssPersonalPage.personalRandomData then
			var_21_0 = SecretsAbyssPersonalPage.personalRandomData[arg_21_1]
		end
	end

	local var_21_2 = tostring(var_21_0)
end

function SecretsAbyssPersonalPage:GetRandomAbilityIds()
	local var_22_0 = {}

	for iter_22_0 = 1, #SecretsAbyssPersonalPage.ABILITY_IDS do
		table.insert(var_22_0, iter_22_0)
	end

	shuffle(var_22_0)

	local var_22_1 = {}

	for iter_22_1 = 1, SecretsAbyssPersonalPage.RANDOM_ABILITY_CNT do
		table.insert(var_22_1, SecretsAbyssPersonalPage.ABILITY_IDS[var_22_0[iter_22_1]])
	end

	return var_22_1
end

SecretsAbyssPersonalPage.UPGRADE_TAG_SHOW_TIME = 2
SecretsAbyssPersonalPage.LV_ANIM_TIME = 0.5
SecretsAbyssPersonalPage.PROPERTY_TPL_ANIM_TIME = 0.5
SecretsAbyssPersonalPage.ABILITY_TPL_ANIM_TIME = 0.5
SecretsAbyssPersonalPage.RANDOM_CHANGE_TIME = 0.8

function SecretsAbyssPersonalPage:PlayUpgradeAnims()
	seriesAsync({
		function(arg_24_0)
			self:PlayLevelAnim(arg_24_0)

			return
		end,
		function(arg_25_0)
			self:PlayPropertyAnim(arg_25_0)

			return
		end,
		function(arg_26_0)
			self:PlayAbilityAnim(arg_26_0)

			return
		end
	}, function()
		self.upgradeFlag = nil

		return
	end)

	return
end

function SecretsAbyssPersonalPage:PlayLevelAnim(arg_28_1)
	local var_28_0, var_28_1, var_28_2 = self:GetStaticInfo(SecretsAbyssPersonalPage.LV_ID)

	setActive(self.lvUpgradeTF, var_28_2)

	if var_28_2 then
		self:managedTween(LeanTween.delayedCall, function()
			setActive(self.lvUpgradeTF, false)

			return
		end, SecretsAbyssPersonalPage.UPGRADE_TAG_SHOW_TIME, nil)
		self:managedTween(LeanTween.value, nil, go(self.lvValue), var_28_0, var_28_1, SecretsAbyssPersonalPage.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_30_0)
			setText(self.lvValue, math.floor(arg_30_0))

			return
		end)):setOnComplete(System.Action(function()
			arg_28_1()

			return
		end))
		self:managedTween(LeanTween.value, nil, go(self.lvSlider), var_28_0 / SecretsAbyssPersonalPage.config[SecretsAbyssPersonalPage.LV_ID].random_value[2], var_28_1 / SecretsAbyssPersonalPage.config[SecretsAbyssPersonalPage.LV_ID].random_value[2], SecretsAbyssPersonalPage.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_32_0)
			self.lvSliderImage.fillAmount = arg_32_0

			return
		end))
	else
		arg_28_1()
	end

	return
end

function SecretsAbyssPersonalPage:PlayAbilityAnim(arg_33_1)
	local var_33_0, var_33_1, var_33_2 = self:GetDynamicInfo()

	if var_33_2 then
		local var_33_3 = {}

		for iter_33_0 = 1, #var_33_1 do
			local var_33_4 = iter_33_0 > #var_33_0
			local var_33_5 = var_33_1[iter_33_0]
			local var_33_6

			if iter_33_0 > #var_33_0 then
				var_33_6 = cloneTplTo(self.abilityTpl, self.abilityContent) or self.abilityContent:GetChild(iter_33_0 - 1)
			end

			GetOrAddComponent(var_33_6, typeof(CanvasGroup)).alpha = var_33_4 and 0 or 1

			if var_33_0[iter_33_0] ~= var_33_5 then
				if not var_33_4 then
					table.insert(var_33_3, function(arg_34_0)
						self:managedTween(LeanTween.value, nil, go(var_33_6), 1, 0, SecretsAbyssPersonalPage.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeInBack):setOnUpdate(System.Action_float(function(arg_35_0)
							GetOrAddComponent(var_33_6, typeof(CanvasGroup)).alpha = arg_35_0

							return
						end)):setOnComplete(System.Action(function()
							setText(var_33_6:Find("name"), SecretsAbyssPersonalPage.config[var_33_5].name)
							setText(var_33_6:Find("value/Text"), self.upgradeCfg[var_33_5])
							arg_34_0()

							return
						end))

						return
					end)
				end

				table.insert(var_33_3, function(arg_37_0)
					if var_33_4 then
						setText(var_33_6:Find("name"), SecretsAbyssPersonalPage.config[var_33_5].name)
						setText(var_33_6:Find("value/Text"), self.upgradeCfg[var_33_5])
					end

					self:managedTween(LeanTween.value, nil, go(var_33_6), 0, 1, SecretsAbyssPersonalPage.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_38_0)
						GetOrAddComponent(var_33_6, typeof(CanvasGroup)).alpha = arg_38_0

						return
					end)):setOnComplete(System.Action(function()
						arg_37_0()

						return
					end))

					return
				end)
			end
		end

		seriesAsync(var_33_3, function()
			arg_33_1()

			return
		end)
	else
		arg_33_1()
	end

	return
end

function SecretsAbyssPersonalPage:Show()
	SecretsAbyssPersonalPage.super.Show(self)

	self.isActive = true

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SecretsAbyssPersonalPage:Hide()
	SecretsAbyssPersonalPage.super.Hide(self)

	self.isActive = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function SecretsAbyssPersonalPage:IsActive()
	return self.isActive
end

function SecretsAbyssPersonalPage:OnDestroy()
	self:cleanManagedTween()

	return
end

return SecretsAbyssPersonalPage
