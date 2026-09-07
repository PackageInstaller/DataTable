local CmdLevelFormationPanel = class("CmdLevelFormationPanel", import("..base.BasePanel"))

function CmdLevelFormationPanel:init()
	self.descPanel = self._tf:Find("desc")
	self.descFrameTF = self._tf:Find("desc/frame")
	self.descPos1 = self.descFrameTF:Find("commander1/frame/info")
	self.descPos2 = self.descFrameTF:Find("commander2/frame/info")
	self.skillTFPos1 = self.descFrameTF:Find("commander1/skill_info")
	self.skillTFPos2 = self.descFrameTF:Find("commander2/skill_info")
	self.abilitysTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/abilitys/mask/content"), self.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	self.talentsTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/talents/mask/content"), self.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	self.abilityArr = self._tf:Find("desc/frame/atttr_panel/abilitys/arr")
	self.talentsArr = self._tf:Find("desc/frame/atttr_panel/talents/arr")
	self.animtion = self.descPanel:GetComponent("Animation")
	self.animtionEvent = self._tf:Find("desc"):GetComponent(typeof(DftAniEvent))

	return
end

function CmdLevelFormationPanel:update(arg_2_1, arg_2_2)
	self.callback = arg_2_2

	assert(arg_2_1)

	self.fleet = arg_2_1

	self:updateDesc()

	return
end

function CmdLevelFormationPanel:attach(arg_3_1)
	CmdLevelFormationPanel.super.attach(self, arg_3_1)
	setActive(self._go, false)
	onButton(self, self._tf, function()
		self:close()

		return
	end, SFX_PANEL)

	return
end

function CmdLevelFormationPanel:playAnim(arg_5_1)
	self.animtion:Play(arg_5_1)

	return
end

function CmdLevelFormationPanel:open()
	self:playAnim("cmdopen")
	setActive(self._go, true)
	setParent(self._go, pg.UIMgr.GetInstance().OverlayMain)
	self._tf:SetAsLastSibling()

	return
end

function CmdLevelFormationPanel:close()
	self:playAnim("cmdclose")
	setActive(self._go, false)

	return
end

function CmdLevelFormationPanel:updateDesc()
	local var_8_0 = self.fleet:getCommanders()

	for iter_8_0 = 1, CommanderConst.MAX_FORMATION_POS do
		self:updateCommander(self["descPos" .. iter_8_0], iter_8_0, var_8_0[iter_8_0])
		self:updateSkillTF(var_8_0[iter_8_0], self["skillTFPos" .. iter_8_0])
	end

	self:updateAdditions()

	return
end

function CmdLevelFormationPanel:updateAdditions()
	local var_9_0 = _.values(self.fleet:getCommandersTalentDesc())
	local var_9_1, var_9_2 = self.fleet:getCommandersAddition()

	self.abilitysTF:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			setText(arg_10_2:Find("name"), AttributeType.Type2Name(var_9_1[arg_10_1 + 1].attrName))
			setText(arg_10_2:Find("Text"), string.format("%0.3f", var_9_1[arg_10_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_9_1[arg_10_1 + 1].attrName, arg_10_2:Find("icon"), false)
			setActive(arg_10_2:Find("bg"), arg_10_1 % 2 ~= 0)
		end

		return
	end)
	self.abilitysTF:align(#var_9_1)
	setActive(self.abilityArr, #var_9_1 > 4)
	self.talentsTF:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_9_0[arg_11_1 + 1]

			setScrollText(findTF(arg_11_2, "name_mask/name"), var_9_0[arg_11_1 + 1].name)
			setText(arg_11_2:Find("Text"), var_11_0.value .. (var_11_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setActive(arg_11_2:Find("bg"), arg_11_1 % 2 ~= 0)
		end

		return
	end)
	self.talentsTF:align(#var_9_0)
	setActive(self.talentsArr, #var_9_0 > 4)

	return
end

function CmdLevelFormationPanel:updateSkillTF(arg_12_1, arg_12_2)
	setActive(arg_12_2, arg_12_1)

	if arg_12_1 then
		local var_12_0 = arg_12_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_12_0:getConfig("icon"), "", arg_12_2:Find("icon"))
		setText(arg_12_2:Find("level"), "Lv." .. var_12_0:getLevel())
	end

	return
end

function CmdLevelFormationPanel:updateCommander(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:Find("add")
	local var_13_1 = arg_13_1:Find("info")

	if arg_13_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_13_3:getPainting(), "", (arg_13_1:Find("info/mask/icon")))

		local var_13_2 = arg_13_1:Find("info/name")

		if var_13_2 then
			setText(var_13_2, arg_13_3:getName())
		end

		setImageSprite(arg_13_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_13_3:getRarity())))
	end

	onButton(self, var_13_1, function()
		if self.callback then
			self.callback(arg_13_2)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_13_0, function()
		if self.callback then
			self.callback(arg_13_2)
		end

		return
	end, SFX_PANEL)
	setActive(var_13_0, not arg_13_3)
	setActive(var_13_1, arg_13_3)

	return
end

function CmdLevelFormationPanel:enable(arg_16_1)
	setActive(self._go, arg_16_1)

	return
end

function CmdLevelFormationPanel:clear()
	setActive(self._go, false)
	setParent(self._go, self.parent.topPanel)

	return
end

return CmdLevelFormationPanel
