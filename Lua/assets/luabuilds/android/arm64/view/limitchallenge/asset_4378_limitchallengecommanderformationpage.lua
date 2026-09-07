local LimitChallengeCommanderFormationPage = class("LimitChallengeCommanderFormationPage", import("view.base.BaseSubView"))

function LimitChallengeCommanderFormationPage:getUIName()
	return "CommanderFormationUI"
end

function LimitChallengeCommanderFormationPage:OnInit()
	setActive(self.samllTF, true)

	self.pos1 = self.samllTF:Find("commander1")
	self.pos2 = self.samllTF:Find("commander2")

	setActive(self.descPanel, false)

	self.descFrameTF = self.descPanel:Find("frame")
	self.descPos1 = self.descFrameTF:Find("commander1/frame/info")
	self.descPos2 = self.descFrameTF:Find("commander2/frame/info")
	self.skillTFPos1 = self.descFrameTF:Find("commander1/skill_info")
	self.skillTFPos2 = self.descFrameTF:Find("commander2/skill_info")
	self.abilitysTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/abilitys/mask/content"), self.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	self.talentsTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/talents/mask/content"), self.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	self.abilityArr = self.descPanel:Find("frame/atttr_panel/abilitys/arr")
	self.talentsArr = self.descPanel:Find("frame/atttr_panel/talents/arr")
	self.restAllBtn = self.descFrameTF:Find("rest_all")

	setActive(self.restAllBtn, false)

	self.quickBtn = self.descFrameTF:Find("quick_btn")

	setActive(self.quickBtn, false)
	onButton(self, self.samllTF, function()
		self:openDescPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.descPanel, function()
		self:closeDescPanel()

		return
	end, SFX_PANEL)

	return
end

function LimitChallengeCommanderFormationPage:Update(arg_5_1, arg_5_2)
	self.fleet = arg_5_1
	self.prefabFleets = arg_5_2

	local var_5_0 = self.fleet:getCommanders()

	for iter_5_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(self["pos" .. iter_5_0], "pos tf can not nil")
		self:updateCommander(self["pos" .. iter_5_0], iter_5_0, var_5_0[iter_5_0])
	end

	self:updateDesc()

	return
end

function LimitChallengeCommanderFormationPage:openDescPanel(arg_6_1)
	local var_6_0 = arg_6_1 or 0.2

	if LeanTween.isTweening(go(self.samllTF)) or LeanTween.isTweening(go(self.descFrameTF)) then
		return
	end

	setAnchoredPosition(self.samllTF, {
		x = 0
	})
	LeanTween.moveX(self.samllTF, 800, var_6_0):setOnComplete(System.Action(function()
		setActive(self.descPanel, true)
		self:OverlayPanel(self._tf)
		setAnchoredPosition(self.descFrameTF, {
			x = 800
		})
		LeanTween.moveX(self.descFrameTF, 0, var_6_0)

		return
	end))

	self.contextData.inDescPage = true

	self._tf:SetAsLastSibling()

	return
end

function LimitChallengeCommanderFormationPage:closeDescPanel(arg_8_1)
	local var_8_0 = arg_8_1 or 0.2

	if LeanTween.isTweening(go(self.samllTF)) or LeanTween.isTweening(go(self.descFrameTF)) then
		return
	end

	setAnchoredPosition(self.descFrameTF, {
		x = 0
	})
	LeanTween.moveX(self.descFrameTF, 800, var_8_0):setOnComplete(System.Action(function()
		setActive(self.descPanel, false)
		self:UnOverlayPanel(self._tf, self._parentTf)
		setAnchoredPosition(self.samllTF, {
			x = 800
		})
		LeanTween.moveX(self.samllTF, 0, var_8_0)

		return
	end))

	self.contextData.inDescPage = false

	return
end

function LimitChallengeCommanderFormationPage:updateDesc()
	local var_10_0 = self.fleet:getCommanders()

	for iter_10_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(self["pos" .. iter_10_0], "pos tf can not nil")
		self:updateCommander(self["descPos" .. iter_10_0], iter_10_0, var_10_0[iter_10_0], true)
		self:updateSkillTF(var_10_0[iter_10_0], self["skillTFPos" .. iter_10_0])
	end

	self:updateAdditions()

	return
end

function LimitChallengeCommanderFormationPage:updateAdditions()
	local var_11_0 = _.values(self.fleet:getCommandersTalentDesc())
	local var_11_1, var_11_2 = self.fleet:getCommandersAddition()

	self.abilitysTF:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setText(arg_12_2:Find("name"), AttributeType.Type2Name(var_11_1[arg_12_1 + 1].attrName))
			setText(arg_12_2:Find("Text"), ("+" .. math.floor(var_11_1[arg_12_1 + 1].value * 1000) / 1000) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_11_1[arg_12_1 + 1].attrName, arg_12_2:Find("icon"), false)
			setImageAlpha(arg_12_2:Find("bg"), arg_12_1 % 2)
		end

		return
	end)
	self.abilitysTF:align(#var_11_1)
	setActive(self.abilityArr, #var_11_1 > 4)
	self.talentsTF:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_11_0[arg_13_1 + 1]

			setScrollText(findTF(arg_13_2, "name_mask/name"), var_11_0[arg_13_1 + 1].name)
			setText(arg_13_2:Find("Text"), (var_13_0.value > 0 and "+" or "") .. var_13_0.value .. (var_13_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_13_2:Find("bg"), arg_13_1 % 2)
		end

		return
	end)
	self.talentsTF:align(#var_11_0)
	setActive(self.talentsArr, #var_11_0 > 4)

	return
end

function LimitChallengeCommanderFormationPage:updateSkillTF(arg_14_1, arg_14_2)
	setActive(arg_14_2, arg_14_1)

	if arg_14_1 then
		local var_14_0 = arg_14_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_14_0:getConfig("icon"), "", arg_14_2:Find("icon"))
		setText(arg_14_2:Find("level"), "Lv." .. var_14_0:getLevel())
		onButton(self, arg_14_2, function()
			self:emit(LimitChallengePreCombatMediator.ON_CMD_SKILL, var_14_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_14_2)
	end

	return
end

function LimitChallengeCommanderFormationPage:updateCommander(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1:Find("add")
	local var_16_1 = arg_16_1:Find("info")

	if arg_16_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_16_3:getPainting(), "", (arg_16_1:Find("info/mask/icon")))

		local var_16_2 = arg_16_1:Find("info/name")

		if var_16_2 then
			setText(var_16_2, arg_16_3:getName())
		end

		setImageSprite(arg_16_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_16_3:getRarity())))
	end

	if arg_16_4 then
		onButton(self, var_16_1, function()
			self:emit(LimitChallengePreCombatMediator.ON_SELECT_COMMANDER, arg_16_2, self.fleet.id)

			return
		end, SFX_PANEL)
		onButton(self, var_16_0, function()
			self:emit(LimitChallengePreCombatMediator.ON_SELECT_COMMANDER, arg_16_2, self.fleet.id)

			return
		end, SFX_PANEL)
	end

	setActive(var_16_0, not arg_16_3)
	setActive(var_16_1, arg_16_3)

	return
end

function LimitChallengeCommanderFormationPage:OnDestroy()
	if self:isShowing() then
		LeanTween.cancel(go(self.samllTF))
		LeanTween.cancel(go(self.descFrameTF))

		if isActive(self.descPanel) then
			self:UnOverlayPanel(self._tf, self._parentTf)
		end
	end

	return
end

return LimitChallengeCommanderFormationPage
