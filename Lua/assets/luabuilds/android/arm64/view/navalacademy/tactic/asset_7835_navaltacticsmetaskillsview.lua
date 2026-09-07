local NavalTacticsMetaSkillsView = class("NavalTacticsMetaSkillsView", import("...base.BaseSubView"))

function NavalTacticsMetaSkillsView:getUIName()
	return "NavalTacticsMetaSkillsPanel"
end

function NavalTacticsMetaSkillsView:OnInit()
	self:initUITip()
	self:initUI()
	self:addListener()
	self:updateSkillList()
	triggerToggle(self.skillToggleList[1], true)
	self:Show()

	return
end

function NavalTacticsMetaSkillsView:Show()
	NavalTacticsMetaSkillsView.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function NavalTacticsMetaSkillsView:Hide()
	NavalTacticsMetaSkillsView.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

function NavalTacticsMetaSkillsView:OnDestroy()
	self:Hide()

	return
end

function NavalTacticsMetaSkillsView:setData(arg_6_1, arg_6_2)
	self.metaShipID = arg_6_1 or self.metaShipID
	self.metaShipVO = getProxy(BayProxy):getShipById(self.metaShipID)
	self.closeCB = arg_6_2 or self.closeCB
	self.metaProxy = getProxy(MetaCharacterProxy)
	self.metaTacticsInfo = self.metaProxy:getMetaTacticsInfoByShipID(self.metaShipVO.id)
	self.selectSkillID = self.selectSkillID or nil

	return
end

function NavalTacticsMetaSkillsView:initUITip()
	local var_7_0 = self._tf:Find("frame/bg/title_bg/title")

	setText(self._tf:Find("frame/buttons/detail_btn/Image"), i18n("meta_tactics_detail"))
	setText(self._tf:Find("frame/buttons/unlock_btn/Image"), i18n("meta_tactics_unlock"))
	setText(self._tf:Find("frame/buttons/switch_btn/Image"), i18n("meta_tactics_switch"))

	return
end

function NavalTacticsMetaSkillsView:initUI()
	self.bg = self._tf:Find("print")

	local var_8_0 = self._tf:Find("frame")

	self.skillTpl = var_8_0:Find("skilltpl")
	self.skillContainer = var_8_0:Find("skill_contain/content")

	local var_8_1 = var_8_0:Find("buttons")

	self.detailBtn = var_8_1:Find("detail_btn")
	self.unlockBtn = var_8_1:Find("unlock_btn")
	self.switchBtn = var_8_1:Find("switch_btn")
	self.skillUIItemList = UIItemList.New(self.skillContainer, self.skillTpl)

	return
end

function NavalTacticsMetaSkillsView:addListener()
	onButton(self, self.bg, function()
		self:Hide()

		if self.closeCB then
			self.closeCB()
		else
			self:Destroy()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.detailBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenTactics = true,
			autoOpenShipConfigID = self.metaShipVO.configId
		})

		return
	end, SFX_PANEL)
	onButton(self, self.unlockBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			hideNo = true,
			type = MSGBOX_TYPE_META_SKILL_UNLOCK,
			metaShipVO = self.metaShipVO,
			skillID = self.selectSkillID
		})

		return
	end, SFX_PANEL)
	onButton(self, self.switchBtn, function()
		pg.m02:sendNotification(GAME.TACTICS_META_SWITCH_SKILL, {
			shipID = self.metaShipVO.id,
			skillID = self.selectSkillID
		})

		return
	end, SFX_PANEL)

	return
end

function NavalTacticsMetaSkillsView:updateSkillTF(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("frame")
	local var_14_1 = var_14_0:Find("skillInfo")
	local var_14_2 = var_14_0:Find("empty")
	local var_14_3 = var_14_0:Find("mask")
	local var_14_4 = var_14_1:Find("descView/Viewport/desc")
	local var_14_5 = var_14_1:Find("next_contain/label")
	local var_14_6 = var_14_1:Find("next_contain/Text")
	local var_14_7 = var_14_1:Find("name_contain/name")
	local var_14_8 = var_14_1:Find("name_contain/level_contain/Text")
	local var_14_9 = var_14_0:Find("Tag/learing")
	local var_14_10 = var_14_0:Find("Tag/unlockable")
	local var_14_11 = self.metaShipVO:getMetaSkillLevelBySkillID(arg_14_2)
	local var_14_12 = getSkillConfig(arg_14_2)
	local var_14_13 = arg_14_2 == self.metaTacticsInfo.curSkillID
	local var_14_14 = var_14_11 > 0

	setImageSprite(var_14_1:Find("icon"), LoadSprite("skillicon/" .. var_14_12.icon))
	setText(var_14_4, getSkillDesc(arg_14_2, var_14_14 and var_14_11 or 1))
	setText(var_14_7, getSkillName(var_14_12.id))
	setText(var_14_8, var_14_11)

	local var_14_15 = var_14_11 >= pg.skill_data_template[arg_14_2].max_level

	if var_14_11 < pg.skill_data_template[arg_14_2].max_level then
		if var_14_14 then
			setText(var_14_6, setColorStr(self.metaTacticsInfo:getSkillExp(arg_14_2), COLOR_GREEN) .. "/" .. MetaCharacterConst.getMetaSkillTacticsConfig(arg_14_2, var_14_11).need_exp)
			setActive(var_14_5, true)
			setActive(var_14_6, true)
		else
			setActive(var_14_5, false)
			setActive(var_14_6, false)
		end
	else
		setText(var_14_6, "Max")
	end

	setActive(var_14_9, var_14_13 and not var_14_15)
	setActive(var_14_10, not var_14_14)
	setActive(var_14_3, not var_14_14)
	onToggle(self, arg_14_1, function(arg_15_0)
		if arg_15_0 then
			self.selectSkillID = arg_14_2

			self:updateButtons(self.selectSkillID)
		end

		return
	end, SFX_PANEL)

	return
end

function NavalTacticsMetaSkillsView:updateSkillList()
	local var_16_0 = MetaCharacterConst.getTacticsSkillIDListByShipConfigID(self.metaShipVO.configId)

	self.skillUIItemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			arg_17_1 = arg_17_1 + 1
			self.skillToggleList = self.skillToggleList or {}
			self.skillToggleList[arg_17_1] = arg_17_2

			self:updateSkillTF(arg_17_2, var_16_0[arg_17_1])
		end

		return
	end)
	self.skillUIItemList:align(#var_16_0)

	return
end

function NavalTacticsMetaSkillsView:updateButtons(arg_18_1)
	local var_18_0 = (arg_18_1 or self.selectSkillID) == self.metaTacticsInfo.curSkillID
	local var_18_1 = self.metaShipVO:getMetaSkillLevelBySkillID(arg_18_1 or self.selectSkillID) > 0

	if (arg_18_1 or self.selectSkillID) == self.metaTacticsInfo.curSkillID or self.metaShipVO:isSkillLevelMax(arg_18_1 or self.selectSkillID) then
		setActive(self.detailBtn, true)
		setActive(self.unlockBtn, false)
		setActive(self.switchBtn, false)
	elseif not var_18_1 then
		setActive(self.detailBtn, true)
		setActive(self.unlockBtn, true)
		setActive(self.switchBtn, false)
	elseif var_18_1 and not var_18_0 then
		setActive(self.detailBtn, true)
		setActive(self.unlockBtn, false)
		setActive(self.switchBtn, true)
	end

	return
end

function NavalTacticsMetaSkillsView:reUpdate(arg_19_1, arg_19_2)
	self:setData(arg_19_1, arg_19_2)
	self:updateSkillList()
	self:updateButtons()

	return
end

return NavalTacticsMetaSkillsView
