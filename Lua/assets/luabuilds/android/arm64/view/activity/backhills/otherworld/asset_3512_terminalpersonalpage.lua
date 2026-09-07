local TerminalPersonalPage = class("TerminalPersonalPage", import("view.base.BaseSubView"))
local var_0_1 = "otherworld_personal_name"

TerminalPersonalPage.BIND_EVENT_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_EVENT_ID
TerminalPersonalPage.config = pg.roll_attr
TerminalPersonalPage.NAME_ID = 1001
TerminalPersonalPage.LV_ID = 1002
TerminalPersonalPage.JOB_ID = 1003
TerminalPersonalPage.GUARDIAN_ID = 1004

local function var_0_2(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = arg_1_0[1], arg_1_0[2] do
		if TerminalPersonalPage.config[iter_1_0] then
			table.insert(var_1_0, iter_1_0)
		end
	end

	return var_1_0
end

TerminalPersonalPage.PROPERTY_IDS = var_0_2({
	2001,
	2006
})
TerminalPersonalPage.ABILITY_IDS = var_0_2({
	3000,
	3193
})
TerminalPersonalPage.RANDOM_ABILITY_CNT = 8

function TerminalPersonalPage:getUIName()
	return "TerminalPersonalPage"
end

function TerminalPersonalPage:OnLoaded()
	self._tf.name = tostring(OtherworldTerminalLayer.PAGE_PERSONAL)
	self.infoTF = self._tf:Find("frame/info")

	setText(self.infoTF:Find("title/content/Text"), i18n("personal_info_title"))

	self.nameTitle = self.infoTF:Find("infos/name/title")
	self.nameInput = self.infoTF:Find("infos/name/box/InputField")
	self.jobTitle = self.infoTF:Find("infos/job/title")
	self.jobValue = self.infoTF:Find("infos/job/value")
	self.guardianTitle = self.infoTF:Find("infos/guardian/title")
	self.guardianValue = self.infoTF:Find("infos/guardian/value")
	self.lvTitle = self.infoTF:Find("level/lv/title")
	self.lvValue = self.infoTF:Find("level/lv/value")
	self.lvSlider = self.infoTF:Find("level/slider")
	self.lvUpgradeTF = self.infoTF:Find("level/slider/upgrade")

	setActive(self.lvUpgradeTF, false)

	self.propertyTF = self._tf:Find("frame/property")

	setText(self.propertyTF:Find("title/content/Text"), i18n("personal_property_title"))

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
	setText(self.abilityTF:Find("title/content/Text"), i18n("personal_ability_title"))

	self.abilityContent = self.abilityTF:Find("content")
	self.abilityTpl = self.abilityTF:Find("tpl")

	setActive(self.abilityTpl, false)

	self.randomBtn = self._tf:Find("frame/random_btn")

	setText(self.randomBtn:Find("Text"), i18n("personal_random"))

	self.randomGreyBtn = self._tf:Find("frame/random_btn_grey")

	setText(self.randomGreyBtn:Find("Text"), i18n("personal_random"))

	self.effectTF = self._tf:Find("effect")

	setActive(self.effectTF, false)

	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.showName = getProxy(PlayerProxy):getRawData().name

	return
end

function TerminalPersonalPage:OnInit()
	self.activity = getProxy(ActivityProxy):getActivityById(TerminalPersonalPage.BIND_EVENT_ACT_ID)

	assert(self.activity, "not exist bind event act, id" .. TerminalPersonalPage.BIND_EVENT_ACT_ID)
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
		setActive(self.randomGreyBtn, false)
		self:managedTween(LeanTween.delayedCall, function()
			OtherworldMapScene.personalRandomData = {}

			self:UpdateView(true)
			setActive(self.effectTF, false)
			setActive(self.randomBtn, self.unlockRandom)
			setActive(self.randomGreyBtn, not self.unlockRandom)

			return
		end, TerminalPersonalPage.RANDOM_CHANGE_TIME, nil)

		return
	end, SFX_PANEL)
	onButton(self, self.randomGreyBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("personal_random_tip"))

		return
	end, SFX_PANEL)

	self.unlockRandom = self.activity:IsFinishAllMain()

	setActive(self.randomBtn, self.unlockRandom)
	setActive(self.randomGreyBtn, not self.unlockRandom)
	setActive(self.infoTF:Find("infos/name/box/edit"), self.unlockRandom)

	if self.unlockRandom and self:GetLocalName() ~= "" then
		self.showName = self:GetLocalName()
	end

	self.nameInput:GetComponent(typeof(InputField)).interactable = self.unlockRandom

	self:UpdateView()

	return
end

function TerminalPersonalPage:UpdateView(arg_9_1)
	local var_9_0

	if self.contextData.upgrade then
		var_9_0 = self.activity:GetLastShowConfig() or self.activity:GetShowConfig()
	end

	self.showCfg = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		self.showCfg[iter_9_1[1]] = iter_9_1[2]
	end

	self:UpdateInfo(arg_9_1)
	self:UpdateProperty(arg_9_1)
	self:UpdateAbility(arg_9_1)

	if self.contextData.upgrade then
		self.upgradeCfg = {}

		for iter_9_2, iter_9_3 in ipairs(self.activity:GetShowConfig()) do
			self.upgradeCfg[iter_9_3[1]] = iter_9_3[2]
		end

		self:PlayUpgradeAnims()
	end

	return
end

function TerminalPersonalPage:SetDefaultName()
	setInputText(self.nameInput, self.showName)

	return
end

function TerminalPersonalPage:UpdateInfo(arg_11_1)
	self:SetDefaultName()
	setText(self.nameTitle, self:GetRollAttrInfoById(TerminalPersonalPage.NAME_ID, arg_11_1) .. "：")

	local var_11_0, var_11_1 = self:GetRollAttrInfoById(TerminalPersonalPage.JOB_ID, arg_11_1)

	setText(self.jobTitle, var_11_0 .. "：")
	setText(self.jobValue, var_11_1)

	local var_11_2, var_11_3 = self:GetRollAttrInfoById(TerminalPersonalPage.GUARDIAN_ID, arg_11_1)

	setText(self.guardianTitle, var_11_2 .. "：")
	setText(self.guardianValue, var_11_3)

	local var_11_4, var_11_5 = self:GetRollAttrInfoById(TerminalPersonalPage.LV_ID, arg_11_1)

	setText(self.lvTitle, var_11_4 .. "：")
	setText(self.lvValue, var_11_5)
	setSlider(self.lvSlider, 0, 1, tonumber(var_11_5) / TerminalPersonalPage.config[TerminalPersonalPage.LV_ID].random_value[2])

	if arg_11_1 then
		OtherworldMapScene.personalRandomData[TerminalPersonalPage.JOB_ID] = var_11_1
		OtherworldMapScene.personalRandomData[TerminalPersonalPage.GUARDIAN_ID] = var_11_3
		OtherworldMapScene.personalRandomData[TerminalPersonalPage.LV_ID] = var_11_5
	end

	return
end

function TerminalPersonalPage:UpdateProperty(arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(TerminalPersonalPage.PROPERTY_IDS) do
		var_12_0 = var_12_0 + 1

		local var_12_1

		if var_12_0 > self.propertyContent.childCount then
			var_12_1 = cloneTplTo(self.propertyTpl, self.propertyContent) or self.propertyContent:GetChild(var_12_0 - 1)
		end

		var_12_1.name = iter_12_1

		local var_12_2, var_12_3 = self:GetRollAttrInfoById(iter_12_1, arg_12_1)

		setText(var_12_1:Find("name"), var_12_2)
		setText(var_12_1:Find("value/Text"), var_12_3)

		if arg_12_1 then
			OtherworldMapScene.personalRandomData[iter_12_1] = var_12_3
		end
	end

	for iter_12_2 = 1, self.propertyContent.childCount - 1 do
		if var_12_0 < iter_12_2 then
			setActive(self.propertyContent:GetChild(iter_12_2 - 1), false)
		end
	end

	return
end

function TerminalPersonalPage:UpdateAbility(arg_13_1)
	local var_13_0 = {}

	if arg_13_1 then
		var_13_0 = self:GetRandomAbilityIds()
	elseif OtherworldMapScene.personalRandomData then
		for iter_13_0, iter_13_1 in pairs(OtherworldMapScene.personalRandomData) do
			if table.contains(TerminalPersonalPage.ABILITY_IDS, iter_13_0) then
				table.insert(var_13_0, iter_13_0)
			end
		end
	else
		for iter_13_2, iter_13_3 in pairs(self.showCfg) do
			if table.contains(TerminalPersonalPage.ABILITY_IDS, iter_13_2) then
				table.insert(var_13_0, iter_13_2)
			end
		end
	end

	table.sort(var_13_0)

	for iter_13_4, iter_13_5 in ipairs(var_13_0) do
		local var_13_1

		if iter_13_4 > self.abilityContent.childCount then
			var_13_1 = cloneTplTo(self.abilityTpl, self.abilityContent) or self.abilityContent:GetChild(iter_13_4 - 1)
		end

		var_13_1.name = iter_13_4

		local var_13_2, var_13_3 = self:GetRollAttrInfoById(iter_13_5, arg_13_1)

		setText(var_13_1:Find("name"), var_13_2)
		setText(var_13_1:Find("value/Text"), var_13_3)

		if arg_13_1 then
			OtherworldMapScene.personalRandomData[iter_13_5] = var_13_3
		end
	end

	for iter_13_6 = 1, self.abilityContent.childCount do
		if iter_13_6 > #var_13_0 then
			setActive(self.abilityContent:GetChild(iter_13_6 - 1), false)
		end
	end

	return
end

function TerminalPersonalPage:GetRollAttrInfoById(arg_14_1, arg_14_2)
	local var_14_0 = ""

	if arg_14_2 then
		var_14_0 = (table.contains(TerminalPersonalPage.PROPERTY_IDS, arg_14_1) or arg_14_1 == TerminalPersonalPage.LV_ID) and math.random(TerminalPersonalPage.config[arg_14_1].random_value[1], TerminalPersonalPage.config[arg_14_1].random_value[2]) or TerminalPersonalPage.config[arg_14_1].random_value[math.random(#TerminalPersonalPage.config[arg_14_1].random_value)]
	else
		var_14_0 = self.showCfg[arg_14_1] or TerminalPersonalPage.config[arg_14_1].default_value

		if OtherworldMapScene.personalRandomData then
			var_14_0 = OtherworldMapScene.personalRandomData[arg_14_1]
		end
	end

	local var_14_2 = tostring(var_14_0)
end

function TerminalPersonalPage:GetRandomAbilityIds()
	local var_15_0 = {}

	for iter_15_0 = 1, #TerminalPersonalPage.ABILITY_IDS do
		table.insert(var_15_0, iter_15_0)
	end

	shuffle(var_15_0)

	local var_15_1 = {}

	for iter_15_1 = 1, TerminalPersonalPage.RANDOM_ABILITY_CNT do
		table.insert(var_15_1, TerminalPersonalPage.ABILITY_IDS[var_15_0[iter_15_1]])
	end

	return var_15_1
end

TerminalPersonalPage.UPGRADE_TAG_SHOW_TIME = 2
TerminalPersonalPage.LV_ANIM_TIME = 0.5
TerminalPersonalPage.PROPERTY_TPL_ANIM_TIME = 0.5
TerminalPersonalPage.ABILITY_TPL_ANIM_TIME = 0.5
TerminalPersonalPage.RANDOM_CHANGE_TIME = 0.8

function TerminalPersonalPage:PlayUpgradeAnims()
	seriesAsync({
		function(arg_17_0)
			self:PlayLevelAnim(arg_17_0)

			return
		end,
		function(arg_18_0)
			self:PlayPropertyAnim(arg_18_0)

			return
		end,
		function(arg_19_0)
			self:PlayAbilityAnim(arg_19_0)

			return
		end
	}, function()
		self.contextData.upgrade = nil

		return
	end)

	return
end

function TerminalPersonalPage:GetStaticInfo(arg_21_1)
	local var_21_1 = tonumber(self.showCfg[arg_21_1] or TerminalPersonalPage.config[arg_21_1].default_value)
	local var_21_2 = tonumber(self.upgradeCfg[arg_21_1] or var_21_1)

	return var_21_1, var_21_2, var_21_2 - var_21_1 ~= 0
end

function TerminalPersonalPage:PlayLevelAnim(arg_22_1)
	local var_22_0, var_22_1, var_22_2 = self:GetStaticInfo(TerminalPersonalPage.LV_ID)

	setActive(self.lvUpgradeTF, var_22_2)

	if var_22_2 then
		self:managedTween(LeanTween.delayedCall, function()
			setActive(self.lvUpgradeTF, false)

			return
		end, TerminalPersonalPage.UPGRADE_TAG_SHOW_TIME, nil)
		self:managedTween(LeanTween.value, nil, go(self.lvValue), var_22_0, var_22_1, TerminalPersonalPage.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_24_0)
			setText(self.lvValue, math.floor(arg_24_0))

			return
		end)):setOnComplete(System.Action(function()
			arg_22_1()

			return
		end))
		self:managedTween(LeanTween.value, nil, go(self.lvSlider), var_22_0 / TerminalPersonalPage.config[TerminalPersonalPage.LV_ID].random_value[2], var_22_1 / TerminalPersonalPage.config[TerminalPersonalPage.LV_ID].random_value[2], TerminalPersonalPage.LV_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_26_0)
			setSlider(self.lvSlider, 0, 1, arg_26_0)

			return
		end))
	else
		arg_22_1()
	end

	return
end

function TerminalPersonalPage:PlayPropertyAnim(arg_27_1)
	local var_27_0 = {}

	for iter_27_0 = 1, #TerminalPersonalPage.PROPERTY_IDS do
		local var_27_1 = iter_27_0 > self.propertyContent.childCount
		local var_27_2

		if iter_27_0 > self.propertyContent.childCount then
			var_27_2 = cloneTplTo(self.propertyTpl, self.propertyContent) or self.propertyContent:GetChild(iter_27_0 - 1)
		end

		local var_27_3 = TerminalPersonalPage.PROPERTY_IDS[iter_27_0]
		local var_27_4, var_27_5, var_27_6 = self:GetStaticInfo(TerminalPersonalPage.PROPERTY_IDS[iter_27_0])

		if var_27_1 then
			setText(var_27_2:Find("name"), TerminalPersonalPage.config[var_27_3].name)
			setText(var_27_2:Find("value/Text"), var_27_4)
		end

		if var_27_6 then
			table.insert(var_27_0, function(arg_28_0)
				setActive(var_27_2:Find("upgrade"), var_27_6)
				self:managedTween(LeanTween.delayedCall, function()
					setActive(var_27_2:Find("upgrade"), false)

					return
				end, TerminalPersonalPage.UPGRADE_TAG_SHOW_TIME, nil)
				self:managedTween(LeanTween.value, nil, go(var_27_2), var_27_4, var_27_5, TerminalPersonalPage.PROPERTY_TPL_ANIM_TIME):setOnUpdate(System.Action_float(function(arg_30_0)
					setText(var_27_2:Find("value/Text"), math.floor(arg_30_0))

					return
				end)):setOnComplete(System.Action(function()
					arg_28_0()

					return
				end))

				return
			end)
		end
	end

	seriesAsync(var_27_0, function()
		arg_27_1()

		return
	end)

	return
end

function TerminalPersonalPage:GetDynamicInfo(arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}

	for iter_33_0, iter_33_1 in pairs(self.showCfg) do
		if table.contains(TerminalPersonalPage.ABILITY_IDS, iter_33_0) then
			table.insert(var_33_0, iter_33_0)
		end
	end

	table.sort(var_33_0)

	for iter_33_2, iter_33_3 in pairs(self.upgradeCfg) do
		if table.contains(TerminalPersonalPage.ABILITY_IDS, iter_33_2) then
			table.insert(var_33_1, iter_33_2)
		end
	end

	table.sort(var_33_1)

	return var_33_0, var_33_1, #var_33_0 ~= #var_33_1 or underscore.any(var_33_1, function(arg_34_0)
		return not table.contains(var_33_0, arg_34_0)
	end)
end

function TerminalPersonalPage:PlayAbilityAnim(arg_35_1)
	local var_35_0, var_35_1, var_35_2 = self:GetDynamicInfo()

	if var_35_2 then
		local var_35_3 = {}

		for iter_35_0 = 1, #var_35_1 do
			local var_35_4 = iter_35_0 > #var_35_0
			local var_35_5 = var_35_1[iter_35_0]
			local var_35_6

			if iter_35_0 > #var_35_0 then
				var_35_6 = cloneTplTo(self.abilityTpl, self.abilityContent) or self.abilityContent:GetChild(iter_35_0 - 1)
			end

			GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = var_35_4 and 0 or 1

			if var_35_0[iter_35_0] ~= var_35_5 then
				if not var_35_4 then
					table.insert(var_35_3, function(arg_36_0)
						self:managedTween(LeanTween.value, nil, go(var_35_6), 1, 0, TerminalPersonalPage.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeInBack):setOnUpdate(System.Action_float(function(arg_37_0)
							GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = arg_37_0

							return
						end)):setOnComplete(System.Action(function()
							setText(var_35_6:Find("name"), TerminalPersonalPage.config[var_35_5].name)
							setText(var_35_6:Find("value/Text"), self.upgradeCfg[var_35_5])
							arg_36_0()

							return
						end))

						return
					end)
				end

				table.insert(var_35_3, function(arg_39_0)
					if var_35_4 then
						setText(var_35_6:Find("name"), TerminalPersonalPage.config[var_35_5].name)
						setText(var_35_6:Find("value/Text"), self.upgradeCfg[var_35_5])
					end

					self:managedTween(LeanTween.value, nil, go(var_35_6), 0, 1, TerminalPersonalPage.ABILITY_TPL_ANIM_TIME):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_40_0)
						GetOrAddComponent(var_35_6, typeof(CanvasGroup)).alpha = arg_40_0

						return
					end)):setOnComplete(System.Action(function()
						arg_39_0()

						return
					end))

					return
				end)
			end
		end

		seriesAsync(var_35_3, function()
			arg_35_1()

			return
		end)
	else
		arg_35_1()
	end

	return
end

function TerminalPersonalPage:GetLocalName()
	if not self.unlockRandom then
		return ""
	end

	return PlayerPrefs.GetString(var_0_1 .. self.playerId)
end

function TerminalPersonalPage:SetLocalName(arg_44_1)
	if not self.unlockRandom then
		return
	end

	PlayerPrefs.SetString(var_0_1 .. self.playerId, arg_44_1)
	PlayerPrefs.Save()

	return
end

function TerminalPersonalPage:OnDestroy()
	self:cleanManagedTween()

	return
end

return TerminalPersonalPage
