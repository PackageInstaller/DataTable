local MetaCharacterTacticsLayer = class("MetaCharacterTacticsLayer", import("...base.BaseUI"))

function MetaCharacterTacticsLayer:getUIName()
	return "MetaCharacterTacticsUI"
end

function MetaCharacterTacticsLayer:init()
	self:initUITextTips()
	self:initData()
	self:initUI()
	self:addListener()

	return
end

function MetaCharacterTacticsLayer:didEnter()
	self:updateRedTag()
	self:updateShipImg()
	self:updateNamePanel()
	self:updateChar()
	self:updateSkillListPanel()
	self:enablePartialBlur()

	if self.contextData.isMainOpen then
		self.contextData.isMainOpen = nil

		self:moveShipImg(true)
	end

	self:moveRightPanel()

	return
end

function MetaCharacterTacticsLayer:willExit()
	self:moveShipImg(false)
	self:recycleChar()
	self:disablePartialBlur()

	return
end

function MetaCharacterTacticsLayer:onBackPressed()
	if isActive(self.skillUnlockPanel) then
		self:closeUnlockSkillPanel()

		return
	else
		self:emit(MetaCharacterTacticsLayer.ON_BACK_PRESSED)
	end

	return
end

function MetaCharacterTacticsLayer:initUITextTips()
	setText(self._tf:Find("ExpPanel"):Find("ExpEveryDay"), i18n("meta_exp_per_day"))
	setText(self._tf:Find("TaskPanel/StudySkillTip/TipText"), i18n("meta_skill_unlock"))

	return
end

function MetaCharacterTacticsLayer:initData()
	self.metaCharacterProxy = getProxy(MetaCharacterProxy)
	self.bayProxy = getProxy(BayProxy)
	self.shipPrefab = nil
	self.shipModel = nil
	self.curMetaShipID = self.contextData.shipID
	self.curShipVO = nil
	self.curMetaCharacterVO = nil

	self:updateData()

	self.skillBtnList = {}
	self.curUnlockSkillID = nil
	self.curUnlockMaterialID = nil
	self.curUnlockMaterialNeedCount = nil

	return
end

function MetaCharacterTacticsLayer:updateData()
	self.curShipVO = self.bayProxy:getShipById(self.curMetaShipID)
	self.curMetaCharacterVO = self.curShipVO:getMetaCharacter()

	return
end

function MetaCharacterTacticsLayer:setTacticsData(arg_9_1)
	self.doubleExpValue = arg_9_1.doubleExp
	self.normalExpValue = arg_9_1.normalExp
	self.curSkillID = arg_9_1.curSkillID
	self.switchCountLeft = arg_9_1.switchCount
	self.taskInfoTable = arg_9_1.taskInfoTable
	self.skillExpTable = arg_9_1.skillExpTable
	arg_9_1 = nil

	return
end

function MetaCharacterTacticsLayer:switchTacticsSkillData(arg_10_1, arg_10_2)
	self.curSkillID = arg_10_1
	self.switchCountLeft = arg_10_2

	return
end

function MetaCharacterTacticsLayer:levelupTacticsSkillData(arg_11_1, arg_11_2)
	self.skillExpTable[arg_11_1] = 0
	self.switchCountLeft = arg_11_2

	self:clearTaskInfo()

	return
end

function MetaCharacterTacticsLayer:updateSkillExp(arg_12_1, arg_12_2)
	self.skillExpTable[arg_12_1] = arg_12_2

	return
end

function MetaCharacterTacticsLayer:clearTaskInfo(arg_13_1)
	self.taskInfoTable[arg_13_1] = {}

	return
end

function MetaCharacterTacticsLayer:initUI()
	self.shipImg = self._tf:Find("ShipImg")
	self.nameTF = self._tf:Find("NamePanel")
	self.nameScrollText = self.nameTF:Find("NameMask/NameText")
	self.shipTypeImg = self.nameTF:Find("TypeImg")
	self.enNameText = self.nameTF:Find("NameENText")
	self.nameTFStarUIList = UIItemList.New(self.nameTF:Find("StarContainer"), (self.nameTF:Find("StarTpl")))
	self.expPanel = self._tf:Find("ExpPanel")
	self.expText = self.expPanel:Find("ExpText")
	self.expDoubleTag = self.expText:Find("DoubleTag")
	self.taskPanel = self._tf:Find("TaskPanel")
	self.qCharContainer = self.taskPanel:Find("QChar")
	self.taskTpl = self.taskPanel:Find("TaskTpl")
	self.taskScrollTF = self.taskPanel:Find("ScrollView")
	self.taskTplContainer = self.taskPanel:Find("ScrollView/Viewport/Content")
	self.taskScrollBar = self.taskPanel:Find("ScrollView/Scrollbar Vertical")
	self.taskUIItemList = UIItemList.New(self.taskTplContainer, self.taskTpl)
	self.skillInfoPanel = self.taskPanel:Find("SkillInfo")
	self.curSkillIcon = self.skillInfoPanel:Find("Skill/Icon")
	self.curSkillNameScrollText = self.skillInfoPanel:Find("NameMask/Name")
	self.curSkillLevelText = self.skillInfoPanel:Find("LevelInfo/CurLevel")
	self.nextSkillLevelText = self.skillInfoPanel:Find("LevelInfo/NextLevel")
	self.curSkillDescText = self.skillInfoPanel:Find("DescView/Viewport/SkillDesc")
	self.curSkillProgressText = self.skillInfoPanel:Find("ExpProgress/Text")
	self.curSkillProgressSlider = self.skillInfoPanel:Find("ExpSlider")
	self.curSkillQuickBtn = self.skillInfoPanel:Find("QuickBtn")
	self.studySkillTip = self.taskPanel:Find("StudySkillTip")
	self.startSkillTip = self.taskPanel:Find("StartLearn")
	self.maxSkillTip = self.taskPanel:Find("SkillMax")
	self.studySkillBtn = self.startSkillTip:Find("StartLearnBtn")
	self.skillPanel = self._tf:Find("SkillPanel")
	self.skillTpl = self.skillPanel:Find("SkillTpl")
	self.skillContainer = self.skillPanel:Find("Skills/Content")
	self.skillUIItemList = UIItemList.New(self.skillContainer, self.skillTpl)
	self.skillUnlockPanel = self._tf:Find("SkillLearnBox")
	self.skillUnlockPanelBG = self.skillUnlockPanel:Find("BG")
	self.skillUnlockPanelTipText = self.skillUnlockPanel:Find("Box/TipText")
	self.skillUnlockPanelCancelBtn = self.skillUnlockPanel:Find("Box/Btns/CancenBtn")
	self.skillUnlockPanelConfirmBtn = self.skillUnlockPanel:Find("Box/Btns/ConfirmBtn")
	self.materialTpl = self.skillUnlockPanel:Find("Box/Material")
	self.materialTplContainer = self.skillUnlockPanel:Find("Box/MaterialContainer")
	self.materialUIItemList = UIItemList.New(self.materialTplContainer, self.materialTpl)

	return
end

function MetaCharacterTacticsLayer:addListener()
	onButton(self, self.skillUnlockPanelBG, function()
		self:closeUnlockSkillPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.skillUnlockPanelCancelBtn, function()
		self:closeUnlockSkillPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.skillUnlockPanelConfirmBtn, function()
		if not self.curUnlockMaterialID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_unlock_skill_select"))

			return
		elseif getProxy(BagProxy):getItemCountById(self.curUnlockMaterialID) < self.curUnlockMaterialNeedCount then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))
		else
			local var_18_0 = 0
			local var_18_1 = 0

			for iter_18_0, iter_18_1 in ipairs(self:getMetaSkillTacticsConfigBySkillID(self.curUnlockSkillID, 1).skill_unlock) do
				if self.curUnlockMaterialID == iter_18_1[2] then
					var_18_0 = iter_18_0
					var_18_1 = iter_18_1[3]

					break
				end
			end

			pg.m02:sendNotification(GAME.TACTICS_META_UNLOCK_SKILL, {
				shipID = self.curMetaShipID,
				skillID = self.curUnlockSkillID,
				materialIndex = var_18_0,
				materialInfo = {
					id = self.curUnlockMaterialID,
					count = var_18_1
				}
			})
		end

		return
	end, SFX_PANEL)

	return
end

function MetaCharacterTacticsLayer:updateRedTag()
	self.metaCharacterProxy:updateRedTag(self.curMetaCharacterVO.id)

	return
end

function MetaCharacterTacticsLayer:updateShipImg()
	local var_20_0, var_20_1 = MetaCharacterConst.GetMetaCharacterPaintPath(self.curMetaCharacterVO.id, true)

	setImageSprite(self.shipImg, LoadSprite(var_20_0, var_20_1), true)
	setLocalPosition(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][7],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][8]
	})
	setLocalScale(self.shipImg, {
		x = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id][4]
	})

	return
end

function MetaCharacterTacticsLayer:updateNamePanel()
	setScrollText(self.nameScrollText, (self.curShipVO:getName()))
	setImageSprite(self.shipTypeImg, LoadSprite("shiptype", (self.curShipVO:getShipType())))
	setText(self.enNameText, (self.curShipVO:getConfig("english_name")))

	local var_21_1 = self.curShipVO:getStar()

	self.nameTFStarUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = arg_22_2:Find("empty")

			arg_22_1 = arg_22_1 + 1

			setActive(arg_22_2:Find("on"), arg_22_1 <= var_21_1)
		end

		return
	end)
	self.nameTFStarUIList:align((self.curShipVO:getMaxStar()))

	return
end

function MetaCharacterTacticsLayer:updateChar()
	return
end

function MetaCharacterTacticsLayer:recycleChar()
	if self.shipPrefab and self.shipModel then
		PoolMgr.GetInstance():ReturnSpineChar(self.shipPrefab, self.shipModel)

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function MetaCharacterTacticsLayer:updateSkillListPanel()
	local var_25_1 = self:getSkillIDListForShow(self.curShipVO.configId)

	self.skillUIItemList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			if var_25_1[arg_26_1 + 1] then
				self.skillBtnList[var_25_1[arg_26_1 + 1]] = arg_26_2

				self:updateSkillTF(arg_26_2, var_25_1[arg_26_1 + 1])
			end
		end

		return
	end)
	self.skillUIItemList:align(#var_25_1)

	return
end

function MetaCharacterTacticsLayer:updateSkillTF(arg_27_1, arg_27_2)
	local var_27_1 = arg_27_1:Find("Skill/Level")
	local var_27_2 = arg_27_1:Find("Skill/Arrow")
	local var_27_3 = arg_27_1:Find("Lock")
	local var_27_4 = arg_27_1:Find("Learning")
	local var_27_5 = getSkillConfig(arg_27_2)
	local var_27_6 = self.curShipVO:getMetaSkillLevelBySkillID(arg_27_2)

	setImageSprite(arg_27_1:Find("Skill/Icon"), LoadSprite("skillicon/" .. var_27_5.icon))
	setScrollText(arg_27_1:Find("Skill/Mask/Name"), getSkillName(var_27_5.id))

	if var_27_6 > 0 then
		setText(var_27_1, "LEVEL: " .. var_27_6)
		setActive(var_27_3, false)
		onButton(self, arg_27_1, function()
			if not isActive(var_27_2) then
				eachChild(self.skillContainer, function(arg_29_0)
					setActive(arg_29_0:Find("Skill/Arrow"), false)

					return
				end)
				setActive(var_27_2, true)
				self:updateTaskPanel(arg_27_2)
			end

			return
		end, SFX_PANEL)
	else
		setText(var_27_1, "LEVEL: ??")
		setActive(var_27_3, true)
		onButton(self, arg_27_1, function()
			self:openUnlockSkillPanel(arg_27_2)

			return
		end, SFX_PANEL)
	end

	return
end

function MetaCharacterTacticsLayer:updateSkillTFLearning()
	for iter_31_0, iter_31_1 in pairs(self.skillBtnList) do
		setActive(iter_31_1:Find("Learning"), iter_31_0 == self.curSkillID and not self.curShipVO:isSkillLevelMax(iter_31_0))
	end

	return
end

function MetaCharacterTacticsLayer:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0025")

	return
end

function MetaCharacterTacticsLayer:updateExpPanel()
	if self:isAllSkillLock() or self:isAllSkillMaxLevel() then
		setActive(self.expPanel, false)
	elseif self.curSkillID > 0 then
		setActive(self.expPanel, true)

		local var_33_0 = pg.gameset.meta_skill_exp_double.key_value

		setText(self.expText, self.normalExpValue .. "/" .. pg.gameset.meta_skill_exp_max.key_value)
		setActive(self.expDoubleTag, var_33_0 > self.doubleExpValue)
	else
		setActive(self.expPanel, false)
	end

	return
end

function MetaCharacterTacticsLayer:updateSkillInfoPanel(arg_34_1)
	local var_34_0 = getSkillConfig(arg_34_1)

	setImageSprite(self.curSkillIcon, LoadSprite("skillicon/" .. var_34_0.icon))
	setScrollText(self.curSkillNameScrollText, getSkillName(var_34_0.id))

	local var_34_1 = pg.skill_data_template[arg_34_1].max_level
	local var_34_2 = self.curShipVO:getMetaSkillLevelBySkillID(arg_34_1)
	local var_34_3 = pg.skill_data_template[arg_34_1].max_level <= var_34_2

	setText(self.curSkillLevelText, var_34_2)
	setText(self.nextSkillLevelText, (math.min(var_34_2 + 1, var_34_1)))
	setText(self.curSkillDescText, getSkillDesc(arg_34_1, self.curShipVO:getMetaSkillLevelBySkillID(arg_34_1)))
	setActive(self.curSkillQuickBtn, not var_34_3 and not LOCK_META_SKILL_QUICK)
	onButton(self, self.curSkillQuickBtn, function()
		self:emit(MetaCharacterTacticsMediator.ON_QUICK, self.curShipVO.id, arg_34_1)

		return
	end, SFX_PANEL)

	local var_34_4 = self.skillExpTable[arg_34_1] or 0

	if not var_34_3 then
		local var_34_5 = self:getMetaSkillTacticsConfigBySkillID(arg_34_1, var_34_2).need_exp

		setText(self.curSkillProgressText, var_34_4 .. "/" .. var_34_5)
		setSlider(self.curSkillProgressSlider, 0, var_34_5, var_34_4)

		if var_34_4 < var_34_5 then
			-- block empty
		end
	else
		setText(self.curSkillProgressText, var_34_4 .. "/Max")
		setSlider(self.curSkillProgressSlider, 0, 1, 1)
	end

	return
end

function MetaCharacterTacticsLayer:updateTaskListPanel(arg_36_1)
	local var_36_0 = self:sortTaskConfig(arg_36_1, self:getMetaSkillTacticsConfigBySkillID(arg_36_1, (self.curShipVO:getMetaSkillLevelBySkillID(arg_36_1))).skill_levelup_task)

	self.taskUIItemList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			local var_37_0 = arg_37_2:Find("Desc")
			local var_37_1 = arg_37_2:Find("AddExp")
			local var_37_2 = arg_37_2:Find("Text")

			arg_37_1 = arg_37_1 + 1

			local var_37_3 = var_36_0[arg_37_1]
			local var_37_4 = var_36_0[arg_37_1][1]
			local var_37_5 = self:getTaskInfoBySkillAndTaskID(arg_36_1, var_36_0[arg_37_1][1])
			local var_37_6

			if var_37_5 then
				var_37_6 = var_37_5.finishCount or 0
			end

			setText(var_37_1, "+" .. var_37_3[3])

			if var_37_3[2] == 0 then
				setText(var_37_2, var_37_6 .. "/∞")
			else
				setText(var_37_2, var_37_6 .. "/" .. var_37_3[2])
			end

			setText(var_37_0, pg.task_meta_data_template[var_37_4].desc)
		end

		return
	end)
	self.taskUIItemList:align(#var_36_0)

	return
end

function MetaCharacterTacticsLayer:updateTaskPanel(arg_38_1)
	local var_38_0 = self.curShipVO

	if self.curShipVO:isSkillLevelMax(arg_38_1) == true then
		setActive(self.studySkillTip, false)
		setActive(self.startSkillTip, false)
		setActive(self.maxSkillTip, true)
		setActive(self.skillInfoPanel, true)
		setActive(self.taskTplContainer, false)
		setActive(self.taskScrollBar, false)
		self:updateSkillInfoPanel(arg_38_1)
	elseif arg_38_1 ~= self.curSkillID then
		setActive(self.studySkillTip, false)
		setActive(self.startSkillTip, true)
		setActive(self.maxSkillTip, false)
		setActive(self.skillInfoPanel, true)
		setActive(self.taskTplContainer, true)
		setActive(self.taskScrollBar, true)
		self:updateSkillInfoPanel(arg_38_1)
		self:updateTaskListPanel(arg_38_1)
		onButton(self, self.studySkillBtn, function()
			if self.switchCountLeft == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("meta_switch_skill_disable"))
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("meta_switch_skill_box_title", getSkillName(arg_38_1)),
					onYes = function()
						pg.m02:sendNotification(GAME.TACTICS_META_SWITCH_SKILL, {
							shipID = var_38_0.id,
							skillID = arg_38_1
						})

						return
					end
				})
			end

			return
		end, SFX_PANEL)
	else
		setActive(self.studySkillTip, false)
		setActive(self.startSkillTip, false)
		setActive(self.maxSkillTip, false)
		setActive(self.skillInfoPanel, true)
		setActive(self.taskTplContainer, true)
		setActive(self.taskScrollBar, true)
		self:updateSkillInfoPanel(arg_38_1)
		self:updateTaskListPanel(arg_38_1)
	end

	return
end

function MetaCharacterTacticsLayer:updateMain()
	local var_41_0 = self:getSkillIDListForShow(self.curShipVO.configId)
	local var_41_3, var_41_4 = self:isAllSkillLock()

	setActive(self.taskScrollTF, not var_41_3)

	if var_41_3 then
		setActive(self.expPanel, false)
		setActive(self.skillInfoPanel, false)
		setActive(self.taskTplContainer, false)
		setActive(self.taskScrollBar, false)
		setActive(self.studySkillTip, true)
		setActive(self.startSkillTip, false)
		setActive(self.maxSkillTip, false)
	elseif self.curUnlockSkillID then
		triggerButton(self.skillBtnList[self.curUnlockSkillID])
	elseif self.curSkillID > 0 then
		triggerButton(self.skillBtnList[self.curSkillID])
	else
		triggerButton(self.skillBtnList[var_41_4])
	end

	return
end

function MetaCharacterTacticsLayer:tryLearnSkillAfterFirstUnlock()
	self:switchTacticsSkillData(self.curUnlockSkillID, 1)
	self:updateExpPanel()
	self:updateTaskPanel(self.curUnlockSkillID)
	self:updateSkillTFLearning()
	self:TryPlayGuide()

	return
end

function MetaCharacterTacticsLayer:moveShipImg(arg_43_1)
	local var_43_0 = MetaCharacterConst.UIConfig[self.curMetaCharacterVO.id]

	self:managedTween(LeanTween.moveX, nil, rtf(self.shipImg), (arg_43_1 or nil) and (var_43_0[7] or -2000), 0.2):setFrom(arg_43_1 and -2000 or var_43_0[7])

	return
end

function MetaCharacterTacticsLayer:moveRightPanel()
	self:managedTween(LeanTween.moveX, nil, rtf(self.skillPanel), 500, 0.2):setFrom(2000)
	self:managedTween(LeanTween.moveX, nil, rtf(self.taskPanel), 500, 0.2):setFrom(2000)

	return
end

function MetaCharacterTacticsLayer:openUnlockSkillPanel(arg_45_1)
	self.curUnlockSkillID = arg_45_1

	setText(self.skillUnlockPanelTipText, i18n("meta_unlock_skill_tip", ShipGroup.getDefaultShipNameByGroupID(self.curMetaCharacterVO.id), (getSkillName(arg_45_1))))

	local var_45_1 = self:getMetaSkillTacticsConfigBySkillID(arg_45_1, 1)
	local var_45_3 = {
		var_45_1.skill_unlock[1]
	}

	self.materialUIItemList:make(function(arg_46_0, arg_46_1, arg_46_2)
		if arg_46_0 == UIItemList.EventUpdate then
			arg_46_1 = arg_46_1 + 1

			local var_46_0 = var_45_3[arg_46_1]
			local var_46_1 = arg_46_2:Find("Count/Text")

			updateDrop(arg_46_2:Find("Item"), {
				type = DROP_TYPE_ITEM,
				id = var_45_3[arg_46_1][2],
				count = var_45_3[arg_46_1][3]
			})
			setActive(arg_46_2:Find("SelectedTag"), false)

			local var_46_2 = var_46_0[2]
			local var_46_3 = var_46_0[3]
			local var_46_4 = getProxy(BagProxy):getItemCountById(var_46_0[2])

			setText(var_46_1, (var_46_4 < var_46_0[3] and setColorStr(var_46_4, COLOR_RED) or setColorStr(var_46_4, COLOR_GREEN)) .. "/" .. var_46_0[3])

			self.curUnlockMaterialID = var_46_2
			self.curUnlockMaterialNeedCount = var_46_3
		end

		return
	end)
	self.materialUIItemList:align(#var_45_3)
	setActive(self.skillUnlockPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(self.skillUnlockPanel)

	return
end

function MetaCharacterTacticsLayer:closeUnlockSkillPanel()
	self.curUnlockSkillID = nil
	self.curUnlockMaterialID = nil
	self.curUnlockMaterialNeedCount = nil

	setActive(self.skillUnlockPanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.skillUnlockPanel, self._tf)

	return
end

function MetaCharacterTacticsLayer:enablePartialBlur()
	if self._tf then
		local var_48_0 = {}

		table.insert(var_48_0, self.taskPanel)
		table.insert(var_48_0, self.skillPanel)
		self:OverlayPanel(self._tf, {
			groupDelta = -1,
			pbList = var_48_0
		})
	end

	return
end

function MetaCharacterTacticsLayer:disablePartialBlur()
	if self._tf then
		self:UnOverlayPanel(self._tf)
	end

	return
end

function MetaCharacterTacticsLayer:getMetaSkillTacticsConfigBySkillID(arg_50_1, arg_50_2)
	return MetaCharacterConst.getMetaSkillTacticsConfig(arg_50_1, arg_50_2)
end

function MetaCharacterTacticsLayer:getTaskInfoBySkillAndTaskID(arg_51_1, arg_51_2)
	for iter_51_0, iter_51_1 in ipairs(self.taskInfoTable[arg_51_1] or {}) do
		if iter_51_1.taskID == arg_51_2 then
			return iter_51_1
		end
	end

	return
end

function MetaCharacterTacticsLayer:isAllSkillLock()
	local var_52_0 = true
	local var_52_1 = 0

	for iter_52_0, iter_52_1 in ipairs((self:getSkillIDListForShow(self.curShipVO.configId))) do
		if self.curShipVO:getMetaSkillLevelBySkillID(iter_52_1) > 0 then
			var_52_0 = false
			var_52_1 = iter_52_1

			break
		end
	end

	return var_52_0, var_52_1
end

function MetaCharacterTacticsLayer:isAllSkillMaxLevel()
	for iter_53_0, iter_53_1 in ipairs((self:getSkillIDListForShow(self.curShipVO.configId))) do
		if not self.curShipVO:isSkillLevelMax(iter_53_1) then
			return false
		end
	end

	return
end

function MetaCharacterTacticsLayer:updateTacticsRedTag()
	local var_54_0 = self.curShipVO:getMetaCharacter()

	for iter_54_0, iter_54_1 in ipairs((self:getSkillIDListForShow(self.curShipVO.configId))) do
		local var_54_2 = self.curShipVO:getMetaSkillLevelBySkillID(iter_54_1)

		if var_54_2 > 0 and not self.curShipVO:isSkillLevelMax(iter_54_1) then
			if self.skillExpTable then
				if self:getMetaSkillTacticsConfigBySkillID(iter_54_1, var_54_2).need_exp <= (self.skillExpTable[iter_54_1] or 0) then
					break
				end
			end
		end
	end

	return
end

function MetaCharacterTacticsLayer:sortTaskConfig(arg_55_1, arg_55_2)
	local var_55_0 = Clone(arg_55_2)

	table.sort(var_55_0, function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_1[1]
		local var_56_1 = arg_56_0[2]
		local var_56_2 = arg_56_1[2]
		local var_56_3 = self:getTaskInfoBySkillAndTaskID(arg_55_1, arg_56_0[1])
		local var_56_4 = self:getTaskInfoBySkillAndTaskID(arg_55_1, arg_56_1[1])
		local var_56_5

		if var_56_3 then
			var_56_5 = var_56_3.finishCount or 0

			local var_56_6

			if var_56_4 then
				var_56_6 = var_56_4.finishCount or 0
			end
		end

		local var_56_7 = var_56_1 > 0 and var_56_5 <= var_56_1
		local var_56_8 = var_56_2 > 0 and var_56_6 <= var_56_2

		if var_56_1 == 0 and var_56_2 == 0 then
			return arg_56_0[1] < var_56_0
		elseif var_56_1 == 0 then
			return true
		elseif var_56_2 == 0 then
			return false
		elseif var_56_7 == true and var_56_8 == true then
			return arg_56_0[1] < var_56_0
		elseif var_56_7 == true then
			return false
		elseif var_56_8 == true then
			return true
		else
			return arg_56_0[1] < var_56_0
		end

		return
	end)

	return var_55_0
end

function MetaCharacterTacticsLayer:getSkillIDListForShow(arg_57_1)
	return MetaCharacterConst.getTacticsSkillIDListByShipConfigID(arg_57_1)
end

return MetaCharacterTacticsLayer
