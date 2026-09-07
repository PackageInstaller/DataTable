local LevelCMDFormationView = class("LevelCMDFormationView", import("view.base.BaseUI"))

function LevelCMDFormationView:getUIName()
	return "LevelCommanderView"
end

function LevelCMDFormationView:init()
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
		self:onBackPressed()

		return
	end, SFX_PANEL)

	return
end

function LevelCMDFormationView:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function LevelCMDFormationView:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function LevelCMDFormationView:setCallback(arg_9_1)
	self.callback = arg_9_1

	return
end

function LevelCMDFormationView:updateFleet(arg_10_1)
	self.fleet = arg_10_1

	self:updateDesc()
	self:updateRecordFleet()

	return
end

function LevelCMDFormationView:setCommanderPrefabs(arg_11_1)
	self.prefabFleets = arg_11_1

	self:updateRecordPanel()

	return
end

function LevelCMDFormationView:updateRecordFleet()
	local var_12_0 = self.fleet:getCommanders()

	for iter_12_0, iter_12_1 in ipairs(self.recordCommanders) do
		self:updateCommander(iter_12_1, iter_12_0, var_12_0[iter_12_0])
		self:updateSkillTF(var_12_0[iter_12_0], self.reocrdSkills[iter_12_0])
	end

	return
end

function LevelCMDFormationView:updateRecordPanel()
	local var_13_0 = self.fleet:getCommanders()

	self.recordList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			self:UpdatePrefabFleet(self.prefabFleets[arg_14_1 + 1], arg_14_2, var_13_0)
		end

		return
	end)
	self.recordList:align(#self.prefabFleets)

	return
end

function LevelCMDFormationView:UpdatePrefabFleet(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2:Find("fleet_name")
	local var_15_1 = arg_15_1:getName()

	onInputEndEdit(self, var_15_0, function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_RENAME,
			id = arg_15_1.id,
			str = getInputText(var_15_0),
			onFailed = function()
				setInputText(var_15_0, var_15_1)

				return
			end
		})

		return
	end)
	setInputText(var_15_0, var_15_1)
	onButton(self, arg_15_2:Find("use_btn"), function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
			id = arg_15_1.id
		})
		self:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(self, arg_15_2:Find("record_btn"), function()
		self.callback({
			type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
			id = arg_15_1.id
		})

		return
	end, SFX_PANEL)

	local var_15_2 = {
		arg_15_2:Find("commander1/skill_info"),
		arg_15_2:Find("commander2/skill_info")
	}

	for iter_15_0, iter_15_1 in ipairs({
		arg_15_2:Find("commander1/frame/info"),
		arg_15_2:Find("commander2/frame/info")
	}) do
		local var_15_3 = arg_15_1:getCommanderByPos(iter_15_0)

		self:updateCommander(iter_15_1, iter_15_0, var_15_3)
		self:updateSkillTF(var_15_3, var_15_2[iter_15_0])
	end

	return
end

function LevelCMDFormationView:updateDesc()
	local var_20_0 = self.fleet:getCommanders()

	for iter_20_0 = 1, CommanderConst.MAX_FORMATION_POS do
		self:updateCommander(self["descPos" .. iter_20_0], iter_20_0, var_20_0[iter_20_0], true)
		self:updateSkillTF(var_20_0[iter_20_0], self["skillTFPos" .. iter_20_0])
	end

	self:updateAdditions()

	return
end

function LevelCMDFormationView:updateAdditions()
	local var_21_0 = _.values(self.fleet:getCommandersTalentDesc())
	local var_21_1, var_21_2 = self.fleet:getCommandersAddition()

	self.abilitysTF:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			setText(arg_22_2:Find("name"), AttributeType.Type2Name(var_21_1[arg_22_1 + 1].attrName))
			setText(arg_22_2:Find("Text"), string.format("%0.3f", var_21_1[arg_22_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_21_1[arg_22_1 + 1].attrName, arg_22_2:Find("icon"), false)
			setImageAlpha(arg_22_2:Find("bg"), arg_22_1 % 2)
		end

		return
	end)
	self.abilitysTF:align(#var_21_1)
	setActive(self.abilityArr, #var_21_1 > 4)
	self.talentsTF:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = var_21_0[arg_23_1 + 1]

			setScrollText(findTF(arg_23_2, "name_mask/name"), var_21_0[arg_23_1 + 1].name)
			setText(arg_23_2:Find("Text"), var_23_0.value .. (var_23_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_23_2:Find("bg"), arg_23_1 % 2)
		end

		return
	end)
	self.talentsTF:align(#var_21_0)
	setActive(self.talentsArr, #var_21_0 > 4)

	return
end

function LevelCMDFormationView:updateSkillTF(arg_24_1, arg_24_2)
	setActive(arg_24_2, arg_24_1)

	if arg_24_1 then
		local var_24_0 = arg_24_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_24_0:getConfig("icon"), "", arg_24_2:Find("icon"))
		setText(arg_24_2:Find("level"), "Lv." .. var_24_0:getLevel())
		onButton(self, arg_24_2, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_SHOW_SKILL,
				skill = var_24_0
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_24_2)
	end

	return
end

function LevelCMDFormationView:updateCommander(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_1:Find("add")
	local var_26_1 = arg_26_1:Find("info")

	if arg_26_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_26_3:getPainting(), "", (arg_26_1:Find("info/mask/icon")))

		local var_26_2 = arg_26_1:Find("info/name")

		if var_26_2 then
			setText(var_26_2, arg_26_3:getName())
		end

		setImageSprite(arg_26_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_26_3:getRarity())))
	end

	if arg_26_4 then
		onButton(self, var_26_1, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_26_2
			})

			return
		end, SFX_PANEL)
		onButton(self, var_26_0, function()
			self.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_26_2
			})

			return
		end, SFX_PANEL)
	end

	setActive(var_26_0, not arg_26_3)
	setActive(var_26_1, arg_26_3)

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
