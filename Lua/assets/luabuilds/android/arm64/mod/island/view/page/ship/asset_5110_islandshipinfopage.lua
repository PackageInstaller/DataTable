local IslandShipInfoPage = class("IslandShipInfoPage", import("...base.IslandBasePage"))

function IslandShipInfoPage:getUIName()
	return "IslandShipInfoUI"
end

function IslandShipInfoPage:OnLoaded()
	self.energyTipTr = self._tf:Find("adapt/name_panel/tip")
	self.energyTipTxt = self._tf:Find("adapt/name_panel/tip/Text"):GetComponent(typeof(Text))
	self.energyTr = self._tf:Find("adapt/name_panel/energy")
	self.energyTxt = self._tf:Find("adapt/name_panel/energy"):GetComponent(typeof(Text))
	self.energyLabel = self._tf:Find("adapt/name_panel/energy/label")
	self.nameTxt = self._tf:Find("adapt/name_panel/name"):GetComponent(typeof(Text))
	self.nameEnTxt = self._tf:Find("adapt/name_panel/en"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("adapt/main_panel/level/level"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("adapt/main_panel/level/exp"):GetComponent(typeof(Text))
	self.expProgress = self._tf:Find("adapt/main_panel/level/progress")
	self.upgradeBtn = self._tf:Find("adapt/main_panel/level/add")
	self.breakoutBtn = self._tf:Find("adapt/main_panel/level/breakout")
	self.uiAttrList = UIItemList.New(self._tf:Find("adapt/main_panel/attr/list"), self._tf:Find("adapt/main_panel/attr/list/tpl"))
	self.attrUpgradeBtn = self._tf:Find("adapt/main_panel/attr/upgrade")
	self.skillTr = self._tf:Find("adapt/main_panel/skill")
	self.skillIconImg = self._tf:Find("adapt/main_panel/skill/icon")
	self.skillName = self._tf:Find("adapt/main_panel/skill/info/name"):GetComponent(typeof(Text))
	self.skillLevel = self._tf:Find("adapt/main_panel/skill/info/level"):GetComponent(typeof(Text))
	self.skillDesc = self._tf:Find("adapt/main_panel/skill/info/desc/Text"):GetComponent(typeof(Text))
	self.skillMask = self._tf:Find("adapt/main_panel/skill_mask")
	self.skillMaskLabel = self._tf:Find("adapt/main_panel/skill_mask/content/Text")
	self.skillUpgradeBtn = self._tf:Find("adapt/main_panel/skill/upgrade")
	self.skillInfoBtn = self._tf:Find("adapt/main_panel/skill/click")
	self.breakOutList = UIItemList.New(self._tf:Find("adapt/main_panel/level/starts"), self._tf:Find("adapt/main_panel/level/starts/tpl"))
	self.statusPanel = IslandShipStatusPanel.New(self._tf:Find("adapt/main_panel/status"), self._tf:Find("adapt/main_panel/status_empty"))
	self.followerBtn = self._tf:Find("adapt/follower")
	self.followerBtnInvite = self._tf:Find("adapt/follower/1")
	self.followerBtnCancel = self._tf:Find("adapt/follower/2")
	self.followerBtnDisable = self._tf:Find("adapt/follower/3")

	setText(self.energyLabel, i18n("island_ship_energy"))
	setText(self.followerBtnInvite:Find("Text"), i18n("island_follow_btn_State_usable"))
	setText(self.followerBtnCancel:Find("Text"), i18n("island_follow_btn_State_cancel"))
	setText(self.followerBtnDisable:Find("Text"), i18n("island_follow_btn_State_disable"))
	setActive(self.followerBtnInvite:Find("Text"), false)
	setActive(self.followerBtnInvite:Find("Text"), true)

	return
end

function IslandShipInfoPage:OnInit()
	onButton(self, self.energyTr, function()
		self:DisplayEnergyTip()

		return
	end, SFX_PANEL)
	onButton(self, self.skillUpgradeBtn, function()
		if self.ship:GetSkill():IsMaxLevel() then
			return
		end

		self:OpenPage(IslandShipSkillUpgradePage, self.ship)

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		if self.ship:IsMaxLevel() then
			if self.ship:IsMaxBreakLevel() then
				return
			end

			self:OpenPage(IslandShipBreakoutPage, self.ship)
		else
			self:OpenPage(IslandShipUpgradePage, self.ship)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.breakoutBtn, function()
		triggerButton(self.upgradeBtn)

		return
	end, SFX_PANEL)
	onButton(self, self.attrUpgradeBtn, function()
		self:OpenPage(IslandShipAttrUpgradePage, self.ship)

		return
	end, SFX_PANEL)
	onButton(self, self.followerBtn, function()
		if getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(self.ship.id) then
			self:ShowMsgBox({
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					self:emitCore(ISLAND_EVT.WILL_DEL_FOLLOWER, self.ship.id)

					return
				end
			})
		else
			self:emit(IslandMediator.ADD_FOLLOWER, self.ship.id)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.skillInfoBtn, function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_SHIP_SKILL,
			skill = self.ship:GetSkill()
		})

		return
	end, SFX_PANEL)

	return
end

function IslandShipInfoPage:OnShow(arg_12_1)
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_12_1)

	if var_12_0 == nil then
		return
	end

	self:UpdateMainView(var_12_0)
	self:UpdateFollowBtn(var_12_0)

	self.ship = var_12_0

	return
end

function IslandShipInfoPage:UpdateFollowBtn(arg_13_1)
	local var_13_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(arg_13_1.id)
	local var_13_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():CanFollowPlayer(arg_13_1.id)

	setActive(self.followerBtnInvite, not var_13_0 and var_13_1)
	setActive(self.followerBtnCancel, var_13_0)

	local var_13_2 = not var_13_1 and not var_13_0

	setActive(self.followerBtnDisable, not var_13_1 and not var_13_0)
	setButtonEnabled(self.followerBtn, not var_13_2)

	return
end

function IslandShipInfoPage:AddListeners()
	self:AddListener(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE, self.OnUseExpBook)
	self:AddListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, self.OnBreakOut)
	self:AddListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, self.OnAttrUpgrade)
	self:AddListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, self.OnSkillUpgrade)
	self:AddListener(GAME.ISLAND_FOLLOWER_OP_DONE, self.OnFollowOpDone)

	return
end

function IslandShipInfoPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE, self.OnUseExpBook)
	self:RemoveListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, self.OnBreakOut)
	self:RemoveListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, self.OnAttrUpgrade)
	self:RemoveListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, self.OnSkillUpgrade)
	self:RemoveListener(GAME.ISLAND_FOLLOWER_OP_DONE, self.OnFollowOpDone)

	return
end

function IslandShipInfoPage:OnFollowOpDone()
	self:UpdateFollowBtn(self.ship)

	return
end

function IslandShipInfoPage:OnAttrUpgrade()
	self:UpdateAttrs(self.ship)

	return
end

function IslandShipInfoPage:OnUseExpBook()
	self:UpdateLevelAndExp(self.ship)
	self:UpdateAttrs(self.ship)

	return
end

function IslandShipInfoPage:OnBreakOut()
	self:UpdateEnergy(self.ship)
	self:UpdateLevelAndExp(self.ship)
	self:UpdateAttrs(self.ship)
	self:UpdateSkill(self.ship)
	self:UpdateBreakOutLevel(self.ship)

	return
end

function IslandShipInfoPage:OnSkillUpgrade()
	self:UpdateSkill(self.ship)

	return
end

function IslandShipInfoPage:UpdateMainView(arg_21_1)
	self:UpdateEnergy(arg_21_1)
	self:UpdateLevelAndExp(arg_21_1)
	self:UpdateAttrs(arg_21_1)
	self:UpdateSkill(arg_21_1)
	self:UpdateBreakOutLevel(arg_21_1)
	self:UpdateStatus(arg_21_1)

	self.ship = arg_21_1

	return
end

function IslandShipInfoPage:DisplayEnergyTip()
	self:RemoveCloseEnergyTipTimer()
	setActive(self.energyTipTr, true)

	self.energyTipTxt.text = i18n("island_ship_energy_full")

	self:AddCloseEnergyTipTimer()

	return
end

function IslandShipInfoPage:AddCloseEnergyTipTimer()
	self.timer = Timer.New(function()
		self:RemoveCloseEnergyTipTimer()

		return
	end, 3)

	self.timer:Start()

	return
end

function IslandShipInfoPage:RemoveCloseEnergyTipTimer()
	setActive(self.energyTipTr, false)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandShipInfoPage:UpdateBreakOutLevel(arg_26_1)
	local var_26_0 = arg_26_1:GetBreakLevel()

	self.breakOutList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			setActive(arg_27_2:Find("Image"), arg_27_1 + 1 <= var_26_0)
		end

		return
	end)
	self.breakOutList:align(arg_26_1:GetBreakMaxLevel())

	return
end

function IslandShipInfoPage:UpdateEnergy(arg_28_1)
	local var_28_0 = arg_28_1:GetCurrentEnergy()

	self.energyTxt.text = "[" .. ((var_28_0 <= 20 or nil) and ("<color=#ab4734>" .. var_28_0 .. "</color>" or var_28_0)) .. "/" .. arg_28_1:GetMaxEnergy() .. "]"

	return
end

function IslandShipInfoPage:UpdateLevelAndExp(arg_29_1)
	self.nameTxt.text = arg_29_1:GetName()
	self.nameEnTxt.text = arg_29_1:GetEnName()
	self.levelTxt.text = "Level:" .. arg_29_1:GetLevel()

	if not arg_29_1:IsMaxLevel() then
		local var_29_0 = arg_29_1:GetExp()
		local var_29_1 = arg_29_1:GetTargetExp()

		self.expTxt.text = var_29_0 .. "/" .. var_29_1

		setSlider(self.expProgress, 0, 1, var_29_0 / var_29_1)
	else
		self.expTxt.text = "[MAX]"

		setSlider(self.expProgress, 0, 1, 1)
	end

	setActive(self.upgradeBtn, not arg_29_1:IsMaxLevel())
	setActive(self.breakoutBtn, arg_29_1:IsMaxLevel() and not arg_29_1:IsMaxBreakLevel())

	return
end

function IslandShipInfoPage:RemoveAttrTimer()
	if self.attrTimer then
		self.attrTimer:Stop()

		self.attrTimer = nil
	end

	return
end

function IslandShipInfoPage:UpdateAttrs(arg_31_1)
	local var_31_0 = IslandShipAttr.ATTRS

	self.uiAttrList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			self:UpdateAttr(arg_32_2, var_31_0, arg_32_1 + 1, arg_31_1)
		end

		return
	end)
	self.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function IslandShipInfoPage:UpdateAttr(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_4:GetAttr(arg_33_2[arg_33_3])

	setText(arg_33_1:Find("name"), IslandShipAttr.ToChinese(arg_33_2[arg_33_3]))

	local var_33_1 = IslandProductTimeHelper.GetAttributeAddPercentByAttribute(arg_33_4.id, arg_33_3)

	setTextColor(arg_33_1:Find("value"), Color.NewHex(var_33_1 > 0 and "#00B91E" or var_33_1 < 0 and "#FF6767" or "#393A3C"))

	local var_33_3 = var_33_1 ~= 0 and math.floor(var_33_0 * (1 + 0.01 * var_33_1)) or var_33_0

	setText(arg_33_1:Find("value"), var_33_3)

	if var_33_1 ~= 0 then
		local var_33_4 = _.select(arg_33_4:GetDisplayStatus(), function(arg_34_0)
			return arg_34_0:GetBuffType() == IslandBuffType.SHIP_ATTR
		end)

		onButton(self, arg_33_1, function()
			self:ShowMsgBox({
				hideNo = true,
				type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
				title = i18n("island_word_ship_buff_desc"),
				statusList = var_33_4
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_33_1)
	end

	local var_33_5 = IslandShipAttr.Grade2Img((arg_33_4:GetAttrGradeByValue(var_33_3)))

	GetImageSpriteFromAtlasAsync("ui/IslandShipUI_atlas", var_33_5[1], arg_33_1:Find("grade"))
	GetImageSpriteFromAtlasAsync("ui/IslandShipUI_atlas", var_33_5[2], arg_33_1:Find("grade_bg"))

	return
end

function IslandShipInfoPage:UpdateSkill(arg_36_1)
	local var_36_0 = arg_36_1:GetSkill()

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. var_36_0:GetIcon(), "", self.skillIconImg)

	self.skillName.text = var_36_0:GetName()
	self.skillLevel.text = "[Lv." .. var_36_0:GetLevel() .. "]"
	self.skillDesc.text = var_36_0:GetEffectDesc()

	local var_36_1 = var_36_0:IsUnlock()

	setActive(self.skillTr, var_36_1)
	setActive(self.skillMask, not var_36_1)
	setText(self.skillMaskLabel, i18n("island_need_star", arg_36_1:GetSkillUnlockLevel()))
	setActive(self.skillUpgradeBtn, not var_36_0:IsMaxLevel())

	return
end

function IslandShipInfoPage:UpdateStatus(arg_37_1)
	self.statusPanel:Flush(arg_37_1)

	local var_37_0 = arg_37_1:GetDisplayStatus()

	onButton(self, self.statusPanel.viewBtn, function()
		self:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
			title = i18n("island_word_ship_buff_desc"),
			statusList = var_37_0
		})

		return
	end, SFX_PANEL)

	return
end

function IslandShipInfoPage:OnHide()
	self:RemoveCloseEnergyTipTimer()

	return
end

function IslandShipInfoPage:OnDestroy()
	self.statusPanel:Dispose()

	self.statusPanel = nil

	self:RemoveCloseEnergyTipTimer()

	return
end

return IslandShipInfoPage
