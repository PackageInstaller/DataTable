local var_0_0 = class("MetaCharacterTacticsLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaCharacterTacticsUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateRedTag()
	arg_3_0:updateShipImg()
	arg_3_0:updateNamePanel()
	arg_3_0:updateChar()
	arg_3_0:updateSkillListPanel()
	arg_3_0:enablePartialBlur()

	if arg_3_0.contextData.isMainOpen then
		arg_3_0.contextData.isMainOpen = nil

		arg_3_0:moveShipImg(true)
	end

	arg_3_0:moveRightPanel()

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:recycleChar()
	arg_4_0:disablePartialBlur()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	if isActive(arg_5_0.skillUnlockPanel) then
		arg_5_0:closeUnlockSkillPanel()

		return
	else
		arg_5_0:emit(var_0_0.ON_BACK_PRESSED)
	end

	return
end

function var_0_0.initUITextTips(arg_6_0)
	setText(arg_6_0._tf:Find("ExpPanel"):Find("ExpEveryDay"), i18n("meta_exp_per_day"))
	setText(arg_6_0._tf:Find("TaskPanel/StudySkillTip/TipText"), i18n("meta_skill_unlock"))

	return
end

function var_0_0.initData(arg_7_0)
	arg_7_0.metaCharacterProxy = getProxy(MetaCharacterProxy)
	arg_7_0.bayProxy = getProxy(BayProxy)
	arg_7_0.shipPrefab = nil
	arg_7_0.shipModel = nil
	arg_7_0.curMetaShipID = arg_7_0.contextData.shipID
	arg_7_0.curShipVO = nil
	arg_7_0.curMetaCharacterVO = nil

	arg_7_0:updateData()

	arg_7_0.skillBtnList = {}
	arg_7_0.curUnlockSkillID = nil
	arg_7_0.curUnlockMaterialID = nil
	arg_7_0.curUnlockMaterialNeedCount = nil

	return
end

function var_0_0.updateData(arg_8_0)
	arg_8_0.curShipVO = arg_8_0.bayProxy:getShipById(arg_8_0.curMetaShipID)
	arg_8_0.curMetaCharacterVO = arg_8_0.curShipVO:getMetaCharacter()

	return
end

function var_0_0.setTacticsData(arg_9_0, arg_9_1)
	arg_9_0.doubleExpValue = arg_9_1.doubleExp
	arg_9_0.normalExpValue = arg_9_1.normalExp
	arg_9_0.curSkillID = arg_9_1.curSkillID
	arg_9_0.switchCountLeft = arg_9_1.switchCount
	arg_9_0.taskInfoTable = arg_9_1.taskInfoTable
	arg_9_0.skillExpTable = arg_9_1.skillExpTable
	arg_9_1 = nil

	return
end

function var_0_0.switchTacticsSkillData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.curSkillID = arg_10_1
	arg_10_0.switchCountLeft = arg_10_2

	return
end

function var_0_0.levelupTacticsSkillData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.skillExpTable[arg_11_1] = 0
	arg_11_0.switchCountLeft = arg_11_2

	arg_11_0:clearTaskInfo()

	return
end

function var_0_0.updateSkillExp(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.skillExpTable[arg_12_1] = arg_12_2

	return
end

function var_0_0.clearTaskInfo(arg_13_0, arg_13_1)
	arg_13_0.taskInfoTable[arg_13_1] = {}

	return
end

function var_0_0.initUI(arg_14_0)
	arg_14_0.shipImg = arg_14_0._tf:Find("ShipImg")
	arg_14_0.nameTF = arg_14_0._tf:Find("NamePanel")
	arg_14_0.nameScrollText = arg_14_0.nameTF:Find("NameMask/NameText")
	arg_14_0.shipTypeImg = arg_14_0.nameTF:Find("TypeImg")
	arg_14_0.enNameText = arg_14_0.nameTF:Find("NameENText")
	arg_14_0.nameTFStarUIList = UIItemList.New(arg_14_0.nameTF:Find("StarContainer"), (arg_14_0.nameTF:Find("StarTpl")))
	arg_14_0.expPanel = arg_14_0._tf:Find("ExpPanel")
	arg_14_0.expText = arg_14_0.expPanel:Find("ExpText")
	arg_14_0.expDoubleTag = arg_14_0.expText:Find("DoubleTag")
	arg_14_0.taskPanel = arg_14_0._tf:Find("TaskPanel")
	arg_14_0.qCharContainer = arg_14_0.taskPanel:Find("QChar")
	arg_14_0.taskTpl = arg_14_0.taskPanel:Find("TaskTpl")
	arg_14_0.taskScrollTF = arg_14_0.taskPanel:Find("ScrollView")
	arg_14_0.taskTplContainer = arg_14_0.taskPanel:Find("ScrollView/Viewport/Content")
	arg_14_0.taskScrollBar = arg_14_0.taskPanel:Find("ScrollView/Scrollbar Vertical")
	arg_14_0.taskUIItemList = UIItemList.New(arg_14_0.taskTplContainer, arg_14_0.taskTpl)
	arg_14_0.skillInfoPanel = arg_14_0.taskPanel:Find("SkillInfo")
	arg_14_0.curSkillIcon = arg_14_0.skillInfoPanel:Find("Skill/Icon")
	arg_14_0.curSkillNameScrollText = arg_14_0.skillInfoPanel:Find("NameMask/Name")
	arg_14_0.curSkillLevelText = arg_14_0.skillInfoPanel:Find("LevelInfo/CurLevel")
	arg_14_0.nextSkillLevelText = arg_14_0.skillInfoPanel:Find("LevelInfo/NextLevel")
	arg_14_0.curSkillDescText = arg_14_0.skillInfoPanel:Find("DescView/Viewport/SkillDesc")
	arg_14_0.curSkillProgressText = arg_14_0.skillInfoPanel:Find("ExpProgress/Text")
	arg_14_0.curSkillProgressSlider = arg_14_0.skillInfoPanel:Find("ExpSlider")
	arg_14_0.curSkillQuickBtn = arg_14_0.skillInfoPanel:Find("QuickBtn")
	arg_14_0.studySkillTip = arg_14_0.taskPanel:Find("StudySkillTip")
	arg_14_0.startSkillTip = arg_14_0.taskPanel:Find("StartLearn")
	arg_14_0.maxSkillTip = arg_14_0.taskPanel:Find("SkillMax")
	arg_14_0.studySkillBtn = arg_14_0.startSkillTip:Find("StartLearnBtn")
	arg_14_0.skillPanel = arg_14_0._tf:Find("SkillPanel")
	arg_14_0.skillTpl = arg_14_0.skillPanel:Find("SkillTpl")
	arg_14_0.skillContainer = arg_14_0.skillPanel:Find("Skills/Content")
	arg_14_0.skillUIItemList = UIItemList.New(arg_14_0.skillContainer, arg_14_0.skillTpl)
	arg_14_0.skillUnlockPanel = arg_14_0._tf:Find("SkillLearnBox")
	arg_14_0.skillUnlockPanelBG = arg_14_0.skillUnlockPanel:Find("BG")
	arg_14_0.skillUnlockPanelTipText = arg_14_0.skillUnlockPanel:Find("Box/TipText")
	arg_14_0.skillUnlockPanelCancelBtn = arg_14_0.skillUnlockPanel:Find("Box/Btns/CancenBtn")
	arg_14_0.skillUnlockPanelConfirmBtn = arg_14_0.skillUnlockPanel:Find("Box/Btns/ConfirmBtn")
	arg_14_0.materialTpl = arg_14_0.skillUnlockPanel:Find("Box/Material")
	arg_14_0.materialTplContainer = arg_14_0.skillUnlockPanel:Find("Box/MaterialContainer")
	arg_14_0.materialUIItemList = UIItemList.New(arg_14_0.materialTplContainer, arg_14_0.materialTpl)

	return
end

function var_0_0.addListener(arg_15_0)
	onButton(arg_15_0, arg_15_0.skillUnlockPanelBG, function()
		arg_15_0:closeUnlockSkillPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.skillUnlockPanelCancelBtn, function()
		arg_15_0:closeUnlockSkillPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.skillUnlockPanelConfirmBtn, function()
		if not arg_15_0.curUnlockMaterialID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_unlock_skill_select"))

			return
		else
			local var_18_0 = getProxy(BagProxy)

			if var_18_0:getItemCountById(arg_15_0.curUnlockMaterialID) < arg_15_0.curUnlockMaterialNeedCount then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))
			else
				local var_18_1 = 0
				local var_18_2 = 0

				for iter_18_0, iter_18_1 in ipairs(arg_15_0:getMetaSkillTacticsConfigBySkillID(arg_15_0.curUnlockSkillID, 1).skill_unlock) do
					if arg_15_0.curUnlockMaterialID == iter_18_1[2] then
						var_18_1 = iter_18_0
						var_18_2 = iter_18_1[3]

						break
					end
				end

				pg.m02:sendNotification(GAME.TACTICS_META_UNLOCK_SKILL, {
					shipID = arg_15_0.curMetaShipID,
					skillID = arg_15_0.curUnlockSkillID,
					materialIndex = var_18_1,
					materialInfo = {
						id = arg_15_0.curUnlockMaterialID,
						count = var_18_2
					}
				})
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateRedTag(arg_19_0)
	arg_19_0.metaCharacterProxy:updateRedTag(arg_19_0.curMetaCharacterVO.id)

	return
end

function var_0_0.updateShipImg(arg_20_0)
	local var_20_0, var_20_1 = MetaCharacterConst.GetMetaCharacterPaintPath(arg_20_0.curMetaCharacterVO.id, true)

	setImageSprite(arg_20_0.shipImg, LoadSprite(var_20_0, var_20_1), true)
	setLocalPosition(arg_20_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_20_0.curMetaCharacterVO.id][7],
		y = MetaCharacterConst.UIConfig[arg_20_0.curMetaCharacterVO.id][8]
	})
	setLocalScale(arg_20_0.shipImg, {
		x = MetaCharacterConst.UIConfig[arg_20_0.curMetaCharacterVO.id][3],
		y = MetaCharacterConst.UIConfig[arg_20_0.curMetaCharacterVO.id][4]
	})

	return
end

function var_0_0.updateNamePanel(arg_21_0)
	setScrollText(arg_21_0.nameScrollText, (arg_21_0.curShipVO:getName()))
	setImageSprite(arg_21_0.shipTypeImg, LoadSprite("shiptype", (arg_21_0.curShipVO:getShipType())))
	setText(arg_21_0.enNameText, (arg_21_0.curShipVO:getConfig("english_name")))

	local var_21_1 = arg_21_0.curShipVO:getStar()

	arg_21_0.nameTFStarUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = arg_22_2:Find("empty")

			arg_22_1 = arg_22_1 + 1

			setActive(arg_22_2:Find("on"), arg_22_1 <= var_21_1)
		end

		return
	end)
	arg_21_0.nameTFStarUIList:align((arg_21_0.curShipVO:getMaxStar()))

	return
end

function var_0_0.updateChar(arg_23_0)
	return
end

function var_0_0.recycleChar(arg_24_0)
	if arg_24_0.shipPrefab and arg_24_0.shipModel then
		PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.shipPrefab, arg_24_0.shipModel)

		arg_24_0.shipPrefab = nil
		arg_24_0.shipModel = nil
	end

	return
end

function var_0_0.updateSkillListPanel(arg_25_0)
	local var_25_1 = arg_25_0:getSkillIDListForShow(arg_25_0.curShipVO.configId)

	arg_25_0.skillUIItemList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			if var_25_1[arg_26_1 + 1] then
				arg_25_0.skillBtnList[var_25_1[arg_26_1 + 1]] = arg_26_2

				arg_25_0:updateSkillTF(arg_26_2, var_25_1[arg_26_1 + 1])
			end
		end

		return
	end)
	arg_25_0.skillUIItemList:align(#arg_25_0:getSkillIDListForShow(arg_25_0.curShipVO.configId))

	return
end

function var_0_0.updateSkillTF(arg_27_0, arg_27_1, arg_27_2)
	local var_27_1 = arg_27_1:Find("Skill/Level")
	local var_27_2 = arg_27_1:Find("Skill/Arrow")
	local var_27_3 = arg_27_1:Find("Lock")
	local var_27_4 = arg_27_1:Find("Learning")
	local var_27_5 = getSkillConfig(arg_27_2)
	local var_27_6 = arg_27_0.curShipVO:getMetaSkillLevelBySkillID(arg_27_2)

	setImageSprite(arg_27_1:Find("Skill/Icon"), LoadSprite("skillicon/" .. var_27_5.icon))
	setScrollText(arg_27_1:Find("Skill/Mask/Name"), getSkillName(var_27_5.id))

	if var_27_6 > 0 then
		setText(var_27_1, "LEVEL: " .. var_27_6)
		setActive(var_27_3, false)
		onButton(arg_27_0, arg_27_1, function()
			if not isActive(var_27_2) then
				eachChild(arg_27_0.skillContainer, function(arg_29_0)
					setActive(arg_29_0:Find("Skill/Arrow"), false)

					return
				end)
				setActive(var_27_2, true)
				arg_27_0:updateTaskPanel(arg_27_2)
			end

			return
		end, SFX_PANEL)
	else
		setText(var_27_1, "LEVEL: ??")
		setActive(var_27_3, true)
		onButton(arg_27_0, arg_27_1, function()
			arg_27_0:openUnlockSkillPanel(arg_27_2)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateSkillTFLearning(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.skillBtnList) do
		local var_31_0 = arg_31_0.curShipVO:isSkillLevelMax(iter_31_0)

		setActive(iter_31_1:Find("Learning"), iter_31_0 == arg_31_0.curSkillID and not var_31_0)
	end

	return
end

function var_0_0.TryPlayGuide(arg_32_0)
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0025")

	return
end

function var_0_0.updateExpPanel(arg_33_0)
	if arg_33_0:isAllSkillLock() or arg_33_0:isAllSkillMaxLevel() then
		setActive(arg_33_0.expPanel, false)
	elseif arg_33_0.curSkillID > 0 then
		setActive(arg_33_0.expPanel, true)

		local var_33_0 = pg.gameset.meta_skill_exp_double.key_value

		setText(arg_33_0.expText, arg_33_0.normalExpValue .. "/" .. pg.gameset.meta_skill_exp_max.key_value)
		setActive(arg_33_0.expDoubleTag, var_33_0 > arg_33_0.doubleExpValue)
	else
		setActive(arg_33_0.expPanel, false)
	end

	return
end

function var_0_0.updateSkillInfoPanel(arg_34_0, arg_34_1)
	local var_34_0 = getSkillConfig(arg_34_1)

	setImageSprite(arg_34_0.curSkillIcon, LoadSprite("skillicon/" .. var_34_0.icon))
	setScrollText(arg_34_0.curSkillNameScrollText, getSkillName(var_34_0.id))

	local var_34_1 = pg.skill_data_template[arg_34_1].max_level
	local var_34_2 = arg_34_0.curShipVO:getMetaSkillLevelBySkillID(arg_34_1)
	local var_34_3 = pg.skill_data_template[arg_34_1].max_level <= var_34_2

	setText(arg_34_0.curSkillLevelText, var_34_2)
	setText(arg_34_0.nextSkillLevelText, (math.min(var_34_2 + 1, var_34_1)))
	setText(arg_34_0.curSkillDescText, getSkillDesc(arg_34_1, arg_34_0.curShipVO:getMetaSkillLevelBySkillID(arg_34_1)))
	setActive(arg_34_0.curSkillQuickBtn, not var_34_3 and not LOCK_META_SKILL_QUICK)
	onButton(arg_34_0, arg_34_0.curSkillQuickBtn, function()
		arg_34_0:emit(MetaCharacterTacticsMediator.ON_QUICK, arg_34_0.curShipVO.id, arg_34_1)

		return
	end, SFX_PANEL)

	local var_34_4 = arg_34_0.skillExpTable[arg_34_1] or 0

	if not var_34_3 then
		local var_34_5 = arg_34_0:getMetaSkillTacticsConfigBySkillID(arg_34_1, var_34_2).need_exp

		setText(arg_34_0.curSkillProgressText, var_34_4 .. "/" .. var_34_5)
		setSlider(arg_34_0.curSkillProgressSlider, 0, var_34_5, var_34_4)

		if var_34_4 < var_34_5 then
			-- block empty
		end
	else
		setText(arg_34_0.curSkillProgressText, var_34_4 .. "/Max")
		setSlider(arg_34_0.curSkillProgressSlider, 0, 1, 1)
	end

	return
end

function var_0_0.updateTaskListPanel(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:sortTaskConfig(arg_36_1, arg_36_0:getMetaSkillTacticsConfigBySkillID(arg_36_1, (arg_36_0.curShipVO:getMetaSkillLevelBySkillID(arg_36_1))).skill_levelup_task)

	arg_36_0.taskUIItemList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			local var_37_0 = arg_37_2:Find("Desc")
			local var_37_1 = arg_37_2:Find("AddExp")
			local var_37_2 = arg_37_2:Find("Text")

			arg_37_1 = arg_37_1 + 1

			local var_37_3 = var_36_0[arg_37_1]
			local var_37_4 = var_36_0[arg_37_1][1]
			local var_37_5 = arg_36_0:getTaskInfoBySkillAndTaskID(arg_36_1, var_36_0[arg_37_1][1])

			if var_37_5 then
				local var_37_6 = var_37_5.finishCount or 0

				setText(var_37_1, "+" .. var_37_3[3])

				if var_37_3[2] == 0 then
					setText(var_37_2, var_37_6 .. "/∞")
				else
					setText(var_37_2, var_37_6 .. "/" .. var_37_3[2])
				end

				setText(var_37_0, pg.task_meta_data_template[var_37_4].desc)

				return
			end
		end
	end)
	arg_36_0.taskUIItemList:align(#arg_36_0:sortTaskConfig(arg_36_1, arg_36_0:getMetaSkillTacticsConfigBySkillID(arg_36_1, (arg_36_0.curShipVO:getMetaSkillLevelBySkillID(arg_36_1))).skill_levelup_task))

	return
end

function var_0_0.updateTaskPanel(arg_38_0, arg_38_1)
	if arg_38_0.curShipVO:isSkillLevelMax(arg_38_1) == true then
		setActive(arg_38_0.studySkillTip, false)
		setActive(arg_38_0.startSkillTip, false)
		setActive(arg_38_0.maxSkillTip, true)
		setActive(arg_38_0.skillInfoPanel, true)
		setActive(arg_38_0.taskTplContainer, false)
		setActive(arg_38_0.taskScrollBar, false)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
	elseif arg_38_1 ~= arg_38_0.curSkillID then
		setActive(arg_38_0.studySkillTip, false)
		setActive(arg_38_0.startSkillTip, true)
		setActive(arg_38_0.maxSkillTip, false)
		setActive(arg_38_0.skillInfoPanel, true)
		setActive(arg_38_0.taskTplContainer, true)
		setActive(arg_38_0.taskScrollBar, true)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
		arg_38_0:updateTaskListPanel(arg_38_1)
		onButton(arg_38_0, arg_38_0.studySkillBtn, function()
			if arg_38_0.switchCountLeft == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("meta_switch_skill_disable"))
			else
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("meta_switch_skill_box_title", getSkillName(arg_38_1)),
					onYes = function()
						pg.m02:sendNotification(GAME.TACTICS_META_SWITCH_SKILL, {
							shipID = var_0.id,
							skillID = arg_38_1
						})

						return
					end
				})
			end

			return
		end, SFX_PANEL)
	else
		setActive(arg_38_0.studySkillTip, false)
		setActive(arg_38_0.startSkillTip, false)
		setActive(arg_38_0.maxSkillTip, false)
		setActive(arg_38_0.skillInfoPanel, true)
		setActive(arg_38_0.taskTplContainer, true)
		setActive(arg_38_0.taskScrollBar, true)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
		arg_38_0:updateTaskListPanel(arg_38_1)
	end

	return
end

function var_0_0.updateMain(arg_41_0)
	local var_41_0 = arg_41_0:getSkillIDListForShow(arg_41_0.curShipVO.configId)
	local var_41_3, var_41_4 = arg_41_0:isAllSkillLock()

	setActive(arg_41_0.taskScrollTF, not var_41_3)

	if var_41_3 then
		setActive(arg_41_0.expPanel, false)
		setActive(arg_41_0.skillInfoPanel, false)
		setActive(arg_41_0.taskTplContainer, false)
		setActive(arg_41_0.taskScrollBar, false)
		setActive(arg_41_0.studySkillTip, true)
		setActive(arg_41_0.startSkillTip, false)
		setActive(arg_41_0.maxSkillTip, false)
	elseif arg_41_0.curUnlockSkillID then
		triggerButton(arg_41_0.skillBtnList[arg_41_0.curUnlockSkillID])
	elseif arg_41_0.curSkillID > 0 then
		triggerButton(arg_41_0.skillBtnList[arg_41_0.curSkillID])
	else
		triggerButton(arg_41_0.skillBtnList[var_41_4])
	end

	return
end

function var_0_0.tryLearnSkillAfterFirstUnlock(arg_42_0)
	arg_42_0:switchTacticsSkillData(arg_42_0.curUnlockSkillID, 1)
	arg_42_0:updateExpPanel()
	arg_42_0:updateTaskPanel(arg_42_0.curUnlockSkillID)
	arg_42_0:updateSkillTFLearning()
	arg_42_0:TryPlayGuide()

	return
end

function var_0_0.moveShipImg(arg_43_0, arg_43_1)
	local var_43_0 = MetaCharacterConst.UIConfig[arg_43_0.curMetaCharacterVO.id]
	local var_43_1 = arg_43_1 and -2000 or var_43_0[7]

	if arg_43_1 then
		arg_43_0:managedTween(LeanTween.moveX, nil, rtf(arg_43_0.shipImg), var_43_2, 0.2):setFrom(var_43_1)

		return
	end
end

function var_0_0.moveRightPanel(arg_44_0)
	arg_44_0:managedTween(LeanTween.moveX, nil, rtf(arg_44_0.skillPanel), 500, 0.2):setFrom(2000)
	arg_44_0:managedTween(LeanTween.moveX, nil, rtf(arg_44_0.taskPanel), 500, 0.2):setFrom(2000)

	return
end

function var_0_0.openUnlockSkillPanel(arg_45_0, arg_45_1)
	arg_45_0.curUnlockSkillID = arg_45_1

	setText(arg_45_0.skillUnlockPanelTipText, i18n("meta_unlock_skill_tip", ShipGroup.getDefaultShipNameByGroupID(arg_45_0.curMetaCharacterVO.id), (getSkillName(arg_45_1))))

	local var_45_1 = arg_45_0:getMetaSkillTacticsConfigBySkillID(arg_45_1, 1)
	local var_45_3 = {
		var_45_1.skill_unlock[1]
	}

	arg_45_0.materialUIItemList:make(function(arg_46_0, arg_46_1, arg_46_2)
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
			local var_46_5 = var_46_4 < var_46_0[3] and setColorStr(var_46_4, COLOR_RED) or setColorStr(var_46_4, COLOR_GREEN)

			setText(var_46_1, var_46_5 .. "/" .. var_46_0[3])

			arg_45_0.curUnlockMaterialID = var_46_2
			arg_45_0.curUnlockMaterialNeedCount = var_46_3
		end

		return
	end)
	arg_45_0.materialUIItemList:align(#{
		var_45_1.skill_unlock[1]
	})
	setActive(arg_45_0.skillUnlockPanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_45_0.skillUnlockPanel)

	return
end

function var_0_0.closeUnlockSkillPanel(arg_47_0)
	arg_47_0.curUnlockSkillID = nil
	arg_47_0.curUnlockMaterialID = nil
	arg_47_0.curUnlockMaterialNeedCount = nil

	setActive(arg_47_0.skillUnlockPanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_47_0.skillUnlockPanel, arg_47_0._tf)

	return
end

function var_0_0.enablePartialBlur(arg_48_0)
	if arg_48_0._tf then
		table.insert({}, arg_48_0.taskPanel)
		table.insert({}, arg_48_0.skillPanel)
		arg_48_0:OverlayPanel(arg_48_0._tf, {
			groupDelta = -1,
			pbList = {}
		})
	end

	return
end

function var_0_0.disablePartialBlur(arg_49_0)
	if arg_49_0._tf then
		arg_49_0:UnOverlayPanel(arg_49_0._tf)
	end

	return
end

function var_0_0.getMetaSkillTacticsConfigBySkillID(arg_50_0, arg_50_1, arg_50_2)
	return MetaCharacterConst.getMetaSkillTacticsConfig(arg_50_1, arg_50_2)
end

function var_0_0.getTaskInfoBySkillAndTaskID(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0.taskInfoTable[arg_51_1] or {}

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		if iter_51_1.taskID == arg_51_2 then
			return iter_51_1
		end
	end

	return
end

function var_0_0.isAllSkillLock(arg_52_0)
	local var_52_0 = true
	local var_52_1 = 0

	for iter_52_0, iter_52_1 in ipairs((arg_52_0:getSkillIDListForShow(arg_52_0.curShipVO.configId))) do
		if arg_52_0.curShipVO:getMetaSkillLevelBySkillID(iter_52_1) > 0 then
			var_52_0 = false
			var_52_1 = iter_52_1

			break
		end
	end

	return var_52_0, var_52_1
end

function var_0_0.isAllSkillMaxLevel(arg_53_0)
	for iter_53_0, iter_53_1 in ipairs((arg_53_0:getSkillIDListForShow(arg_53_0.curShipVO.configId))) do
		if not arg_53_0.curShipVO:isSkillLevelMax(iter_53_1) then
			return false
		end
	end

	return
end

function var_0_0.updateTacticsRedTag(arg_54_0)
	local var_54_0 = arg_54_0.curShipVO:getMetaCharacter()

	for iter_54_0, iter_54_1 in ipairs((arg_54_0:getSkillIDListForShow(arg_54_0.curShipVO.configId))) do
		local var_54_2 = arg_54_0.curShipVO:getMetaSkillLevelBySkillID(iter_54_1)
		local var_54_3 = arg_54_0.curShipVO:isSkillLevelMax(iter_54_1)

		if var_54_2 > 0 and not var_54_3 then
			local var_54_4 = arg_54_0:getMetaSkillTacticsConfigBySkillID(iter_54_1, var_54_2).need_exp

			if arg_54_0.skillExpTable then
				local var_54_5 = arg_54_0.skillExpTable[iter_54_1] or 0

				if var_54_4 <= var_54_5 then
					break
				end
			end
		end
	end

	return
end

function var_0_0.sortTaskConfig(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = Clone(arg_55_2)

	table.sort(var_55_0, function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_1[1]
		local var_56_1 = arg_56_0[2]
		local var_56_2 = arg_56_1[2]
		local var_56_3 = arg_55_0:getTaskInfoBySkillAndTaskID(arg_55_1, arg_56_0[1])
		local var_56_4 = arg_55_0:getTaskInfoBySkillAndTaskID(arg_55_1, arg_56_1[1])

		if var_56_3 then
			local var_56_5 = var_56_3.finishCount or 0

			if var_56_4 then
				local var_56_6 = var_56_4.finishCount or 0
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
			end
		end
	end)

	return var_55_0
end

function var_0_0.getSkillIDListForShow(arg_57_0, arg_57_1)
	return MetaCharacterConst.getTacticsSkillIDListByShipConfigID(arg_57_1)
end

return var_0_0
