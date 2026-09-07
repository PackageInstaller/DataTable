local LevelCMDFormationView = class("LevelCMDFormationView", import("..base.BaseSubView"))

function LevelCMDFormationView:getUIName()
	return "LevelCommanderView"
end

function LevelCMDFormationView:OnInit()
	self:InitUI()

	return
end

function LevelCMDFormationView:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	self.callback = nil

	return
end

function LevelCMDFormationView:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function LevelCMDFormationView:Hide()
	setActive(self._go, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function LevelCMDFormationView:InitUI()
	self.descFrameTF = self._tf:Find("frame")
	self.descPos1 = self.descFrameTF:Find("commander1/frame/info")
	self.descPos2 = self.descFrameTF:Find("commander2/frame/info")
	self.skillTFPos1 = self.descFrameTF:Find("commander1/skill_info")
	self.skillTFPos2 = self.descFrameTF:Find("commander2/skill_info")
	self.abilitysTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/abilitys/mask/content"), self.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	self.talentsTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/talents/mask/content"), self.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	self.abilityArr = self._tf:Find("frame/atttr_panel/abilitys/arr")
	self.talentsArr = self._tf:Find("frame/atttr_panel/talents/arr")
	self.restAllBtn = self.descFrameTF:Find("rest_all")
	self.quickBtn = self.descFrameTF:Find("quick_btn")
	self.recordPanel = self._tf:Find("record_panel")
	self.recordCommanders = {
		self.recordPanel:Find("current/commanders/commander1/frame/info"),
		self.recordPanel:Find("current/commanders/commander2/frame/info")
	}
	self.reocrdSkills = {
		self.recordPanel:Find("current/commanders/commander1/skill_info"),
		self.recordPanel:Find("current/commanders/commander2/skill_info")
	}
	self.recordList = UIItemList.New(self.recordPanel:Find("record/content"), self.recordPanel:Find("record/content/commanders"))

	onButton(self, self.restAllBtn, function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_REST_ALL
		})

		return
	end, SFX_PANEL)
	onButton(self, self.quickBtn, function()
		self:OpenRecordPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.recordPanel:Find("back"), function()
		self:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function LevelCMDFormationView:setCallback(arg_11_1)
	self.callback = arg_11_1

	return
end

function LevelCMDFormationView:update(arg_12_1, arg_12_2)
	self:updateFleet(arg_12_1)
	self:updatePrefabs(arg_12_2)

	return
end

function LevelCMDFormationView:updateFleet(arg_13_1)
	self.fleet = arg_13_1

	self:updateDesc()
	self:updateRecordFleet()

	return
end

function LevelCMDFormationView:updatePrefabs(arg_14_1)
	self.prefabFleets = arg_14_1

	self:updateRecordPanel()

	return
end

function LevelCMDFormationView:updateRecordFleet()
	local var_15_0 = self.fleet:getCommanders()

	for iter_15_0, iter_15_1 in ipairs(self.recordCommanders) do
		self:updateCommander(iter_15_1, iter_15_0, var_15_0[iter_15_0])
		self:updateSkillTF(var_15_0[iter_15_0], self.reocrdSkills[iter_15_0])
	end

	return
end

function LevelCMDFormationView:updateRecordPanel()
	local var_16_0 = self.fleet:getCommanders()

	self.recordList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			self:UpdatePrefabFleet(self.prefabFleets[arg_17_1 + 1], arg_17_2, var_16_0)
		end

		return
	end)
	self.recordList:align(#self.prefabFleets)

	return
end

function LevelCMDFormationView:UpdatePrefabFleet(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2:Find("fleet_name")
	local var_18_1 = arg_18_1:getName()

	onInputEndEdit(self, var_18_0, function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_RENAME,
			id = arg_18_1.id,
			str = getInputText(var_18_0),
			onFailed = function()
				setInputText(var_18_0, var_18_1)

				return
			end
		})

		return
	end)
	setInputText(var_18_0, var_18_1)
	onButton(self, arg_18_2:Find("use_btn"), function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
			id = arg_18_1.id
		})
		self:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(self, arg_18_2:Find("record_btn"), function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
			id = arg_18_1.id
		})

		return
	end, SFX_PANEL)

	local var_18_2 = {
		arg_18_2:Find("commander1/skill_info"),
		arg_18_2:Find("commander2/skill_info")
	}

	for iter_18_0, iter_18_1 in ipairs({
		arg_18_2:Find("commander1/frame/info"),
		arg_18_2:Find("commander2/frame/info")
	}) do
		local var_18_3 = arg_18_1:getCommanderByPos(iter_18_0)

		self:updateCommander(iter_18_1, iter_18_0, var_18_3)
		self:updateSkillTF(var_18_3, var_18_2[iter_18_0])
	end

	return
end

function LevelCMDFormationView:updateDesc()
	local var_23_0 = self.fleet:getCommanders()

	for iter_23_0 = 1, CommanderConst.MAX_FORMATION_POS do
		self:updateCommander(self["descPos" .. iter_23_0], iter_23_0, var_23_0[iter_23_0], true)
		self:updateSkillTF(var_23_0[iter_23_0], self["skillTFPos" .. iter_23_0])
	end

	self:updateAdditions()

	return
end

function LevelCMDFormationView:updateAdditions()
	local var_24_0 = _.values(self.fleet:getCommandersTalentDesc())
	local var_24_1, var_24_2 = self.fleet:getCommandersAddition()

	self.abilitysTF:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			setText(arg_25_2:Find("name"), AttributeType.Type2Name(var_24_1[arg_25_1 + 1].attrName))
			setText(arg_25_2:Find("Text"), string.format("%0.3f", var_24_1[arg_25_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_24_1[arg_25_1 + 1].attrName, arg_25_2:Find("icon"), false)
			setImageAlpha(arg_25_2:Find("bg"), arg_25_1 % 2)
		end

		return
	end)
	self.abilitysTF:align(#var_24_1)
	setActive(self.abilityArr, #var_24_1 > 4)
	self.talentsTF:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = var_24_0[arg_26_1 + 1]

			setScrollText(findTF(arg_26_2, "name_mask/name"), var_24_0[arg_26_1 + 1].name)
			setText(arg_26_2:Find("Text"), var_26_0.value .. (var_26_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_26_2:Find("bg"), arg_26_1 % 2)
		end

		return
	end)
	self.talentsTF:align(#var_24_0)
	setActive(self.talentsArr, #var_24_0 > 4)

	return
end

function LevelCMDFormationView:updateSkillTF(arg_27_1, arg_27_2)
	setActive(arg_27_2, arg_27_1)

	if arg_27_1 then
		local var_27_0 = arg_27_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_27_0:getConfig("icon"), "", arg_27_2:Find("icon"))
		setText(arg_27_2:Find("level"), "Lv." .. var_27_0:getLevel())
		onButton(self, arg_27_2, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_SHOW_SKILL,
				skill = var_27_0
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_27_2)
	end

	return
end

function LevelCMDFormationView:updateCommander(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_1:Find("add")
	local var_29_1 = arg_29_1:Find("info")

	if arg_29_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_29_3:getPainting(), "", (arg_29_1:Find("info/mask/icon")))

		local var_29_2 = arg_29_1:Find("info/name")

		if var_29_2 then
			setText(var_29_2, arg_29_3:getName())
		end

		setImageSprite(arg_29_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_29_3:getRarity())))
	end

	if arg_29_4 then
		onButton(self, var_29_1, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_29_2
			})

			return
		end, SFX_PANEL)
		onButton(self, var_29_0, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_29_2
			})

			return
		end, SFX_PANEL)
	end

	setActive(var_29_0, not arg_29_3)
	setActive(var_29_1, arg_29_3)

	return
end

function LevelCMDFormationView:OpenRecordPanel()
	setActive(self.descFrameTF, false)
	setActive(self.recordPanel, true)

	return
end

function LevelCMDFormationView:CloseRecordPanel()
	setActive(self.descFrameTF, true)
	setActive(self.recordPanel, false)

	return
end

return LevelCMDFormationView
