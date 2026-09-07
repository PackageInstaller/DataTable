local GuildCommanderFormationPage = class("GuildCommanderFormationPage", import("....base.BaseSubView"))

function GuildCommanderFormationPage:getUIName()
	return "GuildCommanderFormationUI"
end

function GuildCommanderFormationPage:OnInit()
	self.samllTF = self._tf:Find("small")

	setActive(self.samllTF, true)

	self.pos1 = self._tf:Find("small/commander1")
	self.pos2 = self._tf:Find("small/commander2")
	self.descPanel = self._tf:Find("desc")

	setActive(self.descPanel, false)

	self.descFrameTF = self._tf:Find("desc/frame")
	self.descPos1 = self.descFrameTF:Find("commander1/frame/info")
	self.descPos2 = self.descFrameTF:Find("commander2/frame/info")
	self.skillTFPos1 = self.descFrameTF:Find("commander1/skill_info")
	self.skillTFPos2 = self.descFrameTF:Find("commander2/skill_info")
	self.abilitysTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/abilitys/mask/content"), self.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	self.talentsTF = UIItemList.New(self.descFrameTF:Find("atttr_panel/talents/mask/content"), self.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	self.abilityArr = self._tf:Find("desc/frame/atttr_panel/abilitys/arr")
	self.talentsArr = self._tf:Find("desc/frame/atttr_panel/talents/arr")
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

	onButton(self, self.samllTF, function()
		self:openDescPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.descPanel, function()
		self:closeDescPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.restAllBtn, function()
		if not self.fleet:ExistAnyCommander() then
			return
		end

		self:emit(GuildEventMediator.COMMANDER_FORMATION_OP, {
			data = {
				fleet = self.fleet,
				type = LevelUIConst.COMMANDER_OP_REST_ALL
			},
			fleetId = self.fleet.id
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
	self:Show()

	return
end

function GuildCommanderFormationPage:Update(arg_8_1, arg_8_2)
	self.fleet = arg_8_1
	self.prefabFleets = arg_8_2

	local var_8_0 = self.fleet:getCommanders()

	for iter_8_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(self["pos" .. iter_8_0], "pos tf can not nil")
		self:updateCommander(self["pos" .. iter_8_0], iter_8_0, var_8_0[iter_8_0])
	end

	self:updateDesc()
	self:updateRecordPanel()

	return
end

function GuildCommanderFormationPage:openDescPanel(arg_9_1)
	local var_9_0 = arg_9_1 or 0.2

	if LeanTween.isTweening(go(self.samllTF)) or LeanTween.isTweening(go(self.descFrameTF)) then
		return
	end

	setAnchoredPosition(self.samllTF, {
		x = -108
	})
	LeanTween.moveX(self.samllTF, 1500, var_9_0):setOnComplete(System.Action(function()
		setActive(self.descPanel, true)
		setAnchoredPosition(self.descFrameTF, {
			x = 1500
		})
		LeanTween.moveX(self.descFrameTF, -108, var_9_0)

		return
	end))

	self.contextData.inDescPage = true

	self._tf:SetAsLastSibling()

	return
end

function GuildCommanderFormationPage:closeDescPanel(arg_11_1)
	local var_11_0 = arg_11_1 or 0.2

	if LeanTween.isTweening(go(self.samllTF)) or LeanTween.isTweening(go(self.descFrameTF)) then
		return
	end

	setAnchoredPosition(self.descFrameTF, {
		x = -108
	})
	LeanTween.moveX(self.descFrameTF, 1500, var_11_0):setOnComplete(System.Action(function()
		setActive(self.descPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		setAnchoredPosition(self.samllTF, {
			x = 1500
		})
		LeanTween.moveX(self.samllTF, -108, var_11_0)

		return
	end))

	self.contextData.inDescPage = false

	return
end

function GuildCommanderFormationPage:updateDesc()
	local var_13_0 = self.fleet:getCommanders()

	for iter_13_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(self["pos" .. iter_13_0], "pos tf can not nil")
		self:updateCommander(self["descPos" .. iter_13_0], iter_13_0, var_13_0[iter_13_0], true)
		self:updateSkillTF(var_13_0[iter_13_0], self["skillTFPos" .. iter_13_0])
	end

	self:updateAdditions()

	return
end

function GuildCommanderFormationPage:updateAdditions()
	local var_14_0 = _.values(self.fleet:getCommandersTalentDesc())
	local var_14_1, var_14_2 = self.fleet:getCommandersAddition()

	self.abilitysTF:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setText(arg_15_2:Find("name"), AttributeType.Type2Name(var_14_1[arg_15_1 + 1].attrName))
			setText(arg_15_2:Find("Text"), ("+" .. math.floor(var_14_1[arg_15_1 + 1].value * 1000) / 1000) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_14_1[arg_15_1 + 1].attrName, arg_15_2:Find("icon"), false)
			setImageAlpha(arg_15_2:Find("bg"), arg_15_1 % 2)
		end

		return
	end)
	self.abilitysTF:align(#var_14_1)
	setActive(self.abilityArr, #var_14_1 > 4)
	self.talentsTF:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = var_14_0[arg_16_1 + 1]

			setScrollText(findTF(arg_16_2, "name_mask/name"), var_14_0[arg_16_1 + 1].name)
			setText(arg_16_2:Find("Text"), (var_16_0.value > 0 and "+" or "") .. var_16_0.value .. (var_16_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_16_2:Find("bg"), arg_16_1 % 2)
		end

		return
	end)
	self.talentsTF:align(#var_14_0)
	setActive(self.talentsArr, #var_14_0 > 4)
	Canvas.ForceUpdateCanvases()

	return
end

function GuildCommanderFormationPage:updateSkillTF(arg_17_1, arg_17_2)
	setActive(arg_17_2, arg_17_1)

	if arg_17_1 then
		local var_17_0 = arg_17_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_17_0:getConfig("icon"), "", arg_17_2:Find("icon"))
		setText(arg_17_2:Find("level"), "Lv." .. var_17_0:getLevel())
		onButton(self, arg_17_2, function()
			self:emit(GuildEventMediator.ON_CMD_SKILL, var_17_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_17_2)
	end

	return
end

function GuildCommanderFormationPage:updateCommander(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_1:Find("add")
	local var_19_1 = arg_19_1:Find("info")

	if arg_19_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_19_3:getPainting(), "", (arg_19_1:Find("info/mask/icon")))

		local var_19_2 = arg_19_1:Find("info/name")

		if var_19_2 then
			setText(var_19_2, arg_19_3:getName())
		end

		setImageSprite(arg_19_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_19_3:getRarity())))
	end

	if arg_19_4 then
		onButton(self, var_19_1, function()
			self:emit(GuildEventMediator.ON_SELECT_COMMANDER, self.fleet.id, arg_19_2, arg_19_3)

			return
		end, SFX_PANEL)
		onButton(self, var_19_0, function()
			self:emit(GuildEventMediator.ON_SELECT_COMMANDER, self.fleet.id, arg_19_2, arg_19_3)

			return
		end, SFX_PANEL)
	end

	setActive(var_19_0, not arg_19_3)
	setActive(var_19_1, arg_19_3)

	return
end

function GuildCommanderFormationPage:OpenRecordPanel()
	setActive(self.descFrameTF, false)
	setActive(self.recordPanel, true)

	return
end

function GuildCommanderFormationPage:updateRecordPanel()
	local var_23_0 = self.fleet:getCommanders()

	for iter_23_0, iter_23_1 in ipairs(self.recordCommanders) do
		self:updateCommander(iter_23_1, iter_23_0, var_23_0[iter_23_0])
		self:updateSkillTF(var_23_0[iter_23_0], self.reocrdSkills[iter_23_0])
	end

	self.recordList:make(function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			self:UpdatePrefabFleet(self.prefabFleets[arg_24_1 + 1], arg_24_2, var_23_0)
		end

		return
	end)
	self.recordList:align(#self.prefabFleets)

	return
end

function GuildCommanderFormationPage:UpdatePrefabFleet(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_2:Find("fleet_name")
	local var_25_1 = arg_25_1:getName()

	onInputEndEdit(self, var_25_0, function()
		self:emit(GuildEventMediator.COMMANDER_FORMATION_OP, {
			data = {
				fleet = self.fleet,
				type = LevelUIConst.COMMANDER_OP_RENAME,
				id = arg_25_1.id,
				str = getInputText(var_25_0),
				onFailed = function()
					setInputText(var_25_0, var_25_1)

					return
				end
			},
			fleetId = self.fleet.id
		})

		return
	end)
	setInputText(var_25_0, var_25_1)
	onButton(self, arg_25_2:Find("use_btn"), function()
		self:emit(GuildEventMediator.COMMANDER_FORMATION_OP, {
			data = {
				fleet = self.fleet,
				type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
				id = arg_25_1.id
			},
			fleetId = self.fleet.id
		})
		self:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(self, arg_25_2:Find("record_btn"), function()
		self:emit(GuildEventMediator.COMMANDER_FORMATION_OP, {
			data = {
				fleet = self.fleet,
				type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
				id = arg_25_1.id
			},
			fleetId = self.fleet.id
		})

		return
	end, SFX_PANEL)

	local var_25_2 = {
		arg_25_2:Find("commander1/skill_info"),
		arg_25_2:Find("commander2/skill_info")
	}

	for iter_25_0, iter_25_1 in ipairs({
		arg_25_2:Find("commander1/frame/info"),
		arg_25_2:Find("commander2/frame/info")
	}) do
		local var_25_3 = arg_25_1:getCommanderByPos(iter_25_0)

		self:updateCommander(iter_25_1, iter_25_0, var_25_3)
		self:updateSkillTF(var_25_3, var_25_2[iter_25_0])
	end

	return
end

function GuildCommanderFormationPage:CloseRecordPanel()
	setActive(self.descFrameTF, true)
	setActive(self.recordPanel, false)

	return
end

function GuildCommanderFormationPage:OnDestroy()
	if self:isShowing() then
		LeanTween.cancel(go(self.samllTF))
		LeanTween.cancel(go(self.descFrameTF))
	end

	return
end

return GuildCommanderFormationPage
