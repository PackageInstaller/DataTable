class = var_0_10000

local var_0_0 = "MetaCharacterTacticsLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaCharacterTacticsUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
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

function var_0_1.willExit(arg_4_0)
	arg_4_0:moveShipImg(false)
	arg_4_0:recycleChar()
	arg_4_0:disablePartialBlur()

	return
end

function var_0_1.onBackPressed(arg_5_0)
	isActive = var_1_10001

	if var_1_10001(arg_5_0.skillUnlockPanel) then
		arg_5_0:closeUnlockSkillPanel()

		return
	else
		arg_5_0:emit(var_0_1.ON_BACK_PRESSED)
	end

	return
end

function var_0_1.initUITextTips(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "ExpPanel")
	local var_6_2

	var_6_2, setText = var_1.Find(var_6_1, "ExpEveryDay"), var_6_1
	i18n = var_1_10005

	var_6_1(var_6_2, var_1_10005("meta_exp_per_day"))

	local var_6_3 = arg_6_0._tf
	local var_6_4

	var_6_4, setText = var_3.Find(var_6_3, "TaskPanel/StudySkillTip/TipText"), var_6_3
	i18n = var_6

	var_6_3(var_6_4, var_6("meta_skill_unlock"))

	return
end

function var_0_1.initData(arg_7_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002
	arg_7_0.metaCharacterProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	BayProxy = var_1_10002
	arg_7_0.bayProxy = var_1(var_1_10002)
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

function var_0_1.updateData(arg_8_0)
	local var_8_0 = arg_8_0.bayProxy

	arg_8_0.curShipVO = var_1.getShipById(var_8_0, arg_8_0.curMetaShipID)

	local var_8_1 = arg_8_0.curShipVO

	arg_8_0.curMetaCharacterVO = var_1.getMetaCharacter(var_8_1)

	return
end

function var_0_1.setTacticsData(arg_9_0, arg_9_1)
	arg_9_0.doubleExpValue = arg_9_1.doubleExp
	arg_9_0.normalExpValue = arg_9_1.normalExp
	arg_9_0.curSkillID = arg_9_1.curSkillID
	arg_9_0.switchCountLeft = arg_9_1.switchCount
	arg_9_0.taskInfoTable = arg_9_1.taskInfoTable
	arg_9_0.skillExpTable = arg_9_1.skillExpTable
	arg_9_1 = nil

	return
end

function var_0_1.switchTacticsSkillData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.curSkillID = arg_10_1
	arg_10_0.switchCountLeft = arg_10_2

	return
end

function var_0_1.levelupTacticsSkillData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.skillExpTable[arg_11_1] = 0
	arg_11_0.switchCountLeft = arg_11_2

	arg_11_0:clearTaskInfo()

	return
end

function var_0_1.updateSkillExp(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.skillExpTable[arg_12_1] = arg_12_2

	return
end

function var_0_1.clearTaskInfo(arg_13_0, arg_13_1)
	arg_13_0.taskInfoTable[arg_13_1] = {}

	return
end

function var_0_1.initUI(arg_14_0)
	local var_14_0 = arg_14_0._tf

	arg_14_0.shipImg = var_1.Find(var_14_0, "ShipImg")

	local var_14_1 = arg_14_0._tf

	arg_14_0.nameTF = var_1.Find(var_14_1, "NamePanel")

	local var_14_2 = arg_14_0.nameTF

	arg_14_0.nameScrollText = var_1.Find(var_14_2, "NameMask/NameText")

	local var_14_3 = arg_14_0.nameTF

	arg_14_0.shipTypeImg = var_1.Find(var_14_3, "TypeImg")

	local var_14_4 = arg_14_0.nameTF

	arg_14_0.enNameText = var_1.Find(var_14_4, "NameENText")

	local var_14_5 = arg_14_0.nameTF
	local var_14_6 = var_1.Find(var_14_5, "StarTpl")
	local var_14_7 = arg_14_0.nameTF
	local var_14_8 = var_2.Find(var_14_7, "StarContainer")

	UIItemList = var_14_7
	arg_14_0.nameTFStarUIList = var_14_7.New(var_14_8, var_14_6)

	local var_14_9 = arg_14_0._tf

	arg_14_0.expPanel = var_3.Find(var_14_9, "ExpPanel")

	local var_14_10 = arg_14_0.expPanel

	arg_14_0.expText = var_3.Find(var_14_10, "ExpText")

	local var_14_11 = arg_14_0.expText

	arg_14_0.expDoubleTag = var_3.Find(var_14_11, "DoubleTag")

	local var_14_12 = arg_14_0._tf

	arg_14_0.taskPanel = var_3.Find(var_14_12, "TaskPanel")

	local var_14_13 = arg_14_0.taskPanel

	arg_14_0.qCharContainer = var_3.Find(var_14_13, "QChar")

	local var_14_14 = arg_14_0.taskPanel

	arg_14_0.taskTpl = var_3.Find(var_14_14, "TaskTpl")

	local var_14_15 = arg_14_0.taskPanel

	arg_14_0.taskScrollTF = var_3.Find(var_14_15, "ScrollView")

	local var_14_16 = arg_14_0.taskPanel

	arg_14_0.taskTplContainer = var_3.Find(var_14_16, "ScrollView/Viewport/Content")

	local var_14_17 = arg_14_0.taskPanel

	arg_14_0.taskScrollBar = var_3.Find(var_14_17, "ScrollView/Scrollbar Vertical")
	UIItemList = var_3
	arg_14_0.taskUIItemList = var_3.New(arg_14_0.taskTplContainer, arg_14_0.taskTpl)

	local var_14_18 = arg_14_0.taskPanel

	arg_14_0.skillInfoPanel = var_3.Find(var_14_18, "SkillInfo")

	local var_14_19 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillIcon = var_3.Find(var_14_19, "Skill/Icon")

	local var_14_20 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillNameScrollText = var_3.Find(var_14_20, "NameMask/Name")

	local var_14_21 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillLevelText = var_3.Find(var_14_21, "LevelInfo/CurLevel")

	local var_14_22 = arg_14_0.skillInfoPanel

	arg_14_0.nextSkillLevelText = var_3.Find(var_14_22, "LevelInfo/NextLevel")

	local var_14_23 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillDescText = var_3.Find(var_14_23, "DescView/Viewport/SkillDesc")

	local var_14_24 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillProgressText = var_3.Find(var_14_24, "ExpProgress/Text")

	local var_14_25 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillProgressSlider = var_3.Find(var_14_25, "ExpSlider")

	local var_14_26 = arg_14_0.skillInfoPanel

	arg_14_0.curSkillQuickBtn = var_3.Find(var_14_26, "QuickBtn")

	local var_14_27 = arg_14_0.taskPanel

	arg_14_0.studySkillTip = var_3.Find(var_14_27, "StudySkillTip")

	local var_14_28 = arg_14_0.taskPanel

	arg_14_0.startSkillTip = var_3.Find(var_14_28, "StartLearn")

	local var_14_29 = arg_14_0.taskPanel

	arg_14_0.maxSkillTip = var_3.Find(var_14_29, "SkillMax")

	local var_14_30 = arg_14_0.startSkillTip

	arg_14_0.studySkillBtn = var_3.Find(var_14_30, "StartLearnBtn")

	local var_14_31 = arg_14_0._tf

	arg_14_0.skillPanel = var_3.Find(var_14_31, "SkillPanel")

	local var_14_32 = arg_14_0.skillPanel

	arg_14_0.skillTpl = var_3.Find(var_14_32, "SkillTpl")

	local var_14_33 = arg_14_0.skillPanel

	arg_14_0.skillContainer = var_3.Find(var_14_33, "Skills/Content")
	UIItemList = var_3
	arg_14_0.skillUIItemList = var_3.New(arg_14_0.skillContainer, arg_14_0.skillTpl)

	local var_14_34 = arg_14_0._tf

	arg_14_0.skillUnlockPanel = var_3.Find(var_14_34, "SkillLearnBox")

	local var_14_35 = arg_14_0.skillUnlockPanel

	arg_14_0.skillUnlockPanelBG = var_3.Find(var_14_35, "BG")

	local var_14_36 = arg_14_0.skillUnlockPanel

	arg_14_0.skillUnlockPanelTipText = var_3.Find(var_14_36, "Box/TipText")

	local var_14_37 = arg_14_0.skillUnlockPanel

	arg_14_0.skillUnlockPanelCancelBtn = var_3.Find(var_14_37, "Box/Btns/CancenBtn")

	local var_14_38 = arg_14_0.skillUnlockPanel

	arg_14_0.skillUnlockPanelConfirmBtn = var_3.Find(var_14_38, "Box/Btns/ConfirmBtn")

	local var_14_39 = arg_14_0.skillUnlockPanel

	arg_14_0.materialTpl = var_3.Find(var_14_39, "Box/Material")

	local var_14_40 = arg_14_0.skillUnlockPanel

	arg_14_0.materialTplContainer = var_3.Find(var_14_40, "Box/MaterialContainer")
	UIItemList = var_3
	arg_14_0.materialUIItemList = var_3.New(arg_14_0.materialTplContainer, arg_14_0.materialTpl)

	return
end

function var_0_1.addListener(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.skillUnlockPanelBG

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.closeUnlockSkillPanel(var_16_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10005)

	onButton = var_1_10001

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.skillUnlockPanelCancelBtn

	local function var_15_5()
		local var_17_0 = arg_15_0

		var_0.closeUnlockSkillPanel(var_17_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_3, var_15_4, var_15_5, var_1_10005)

	onButton = var_1_10001

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.skillUnlockPanelConfirmBtn

	local function var_15_8()
		local var_18_0

		if not arg_15_0.curUnlockMaterialID then
			pg = var_18_0
			var_2_10001 = var_18_0.TipsMgr.GetInstance()
			var_18_0 = var_18_0.ShowTips
			i18n = var_2_10002

			var_18_0(var_2_10001, var_2_10002("meta_unlock_skill_select"))

			return
		else
			getProxy = var_18_0
			BagProxy = var_2_10001

			local var_18_1 = var_18_0(var_2_10001)

			if var_0.getItemCountById(var_18_1, arg_15_0.curUnlockMaterialID) < arg_15_0.curUnlockMaterialNeedCount then
				pg = var_1

				local var_18_2 = var_1.TipsMgr.GetInstance()
				local var_18_3 = var_1.ShowTips

				i18n = var_2_10003

				var_18_3(var_18_2, var_2_10003("word_materal_no_enough"))
			else
				local var_18_4 = 0
				local var_18_5 = 0
				local var_18_6 = arg_15_0
				local var_18_7 = var_3.getMetaSkillTacticsConfigBySkillID(var_18_6, arg_15_0.curUnlockSkillID, 1).skill_unlock

				ipairs = var_5

				for iter_18_0, iter_18_1 in var_5(var_18_7) do
					if arg_15_0.curUnlockMaterialID == iter_18_1[2] then
						var_18_4 = iter_18_0
						var_18_5 = iter_18_1[3]

						break
					end
				end

				pg = var_5

				local var_18_8 = var_5.m02
				local var_18_9 = var_5.sendNotification

				GAME = var_7

				var_18_9(var_18_8, var_7.TACTICS_META_UNLOCK_SKILL, {
					shipID = arg_15_0.curMetaShipID,
					skillID = arg_15_0.curUnlockSkillID,
					materialIndex = var_18_4,
					materialInfo = {
						id = arg_15_0.curUnlockMaterialID,
						count = var_18_5
					}
				})
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_6, var_15_7, var_15_8, var_1_10005)

	return
end

function var_0_1.updateRedTag(arg_19_0)
	local var_19_0 = arg_19_0.metaCharacterProxy

	var_1.updateRedTag(var_19_0, arg_19_0.curMetaCharacterVO.id)

	return
end

function var_0_1.updateShipImg(arg_20_0)
	MetaCharacterConst = var_1_10001

	local var_20_0, var_20_1 = var_1_10001.GetMetaCharacterPaintPath(arg_20_0.curMetaCharacterVO.id, true)

	setImageSprite = var_3

	local var_20_2 = arg_20_0.shipImg

	LoadSprite = var_1_10005

	var_3(var_20_2, var_1_10005(var_20_0, var_20_1), true)

	local var_20_3 = arg_20_0.curMetaCharacterVO.id

	MetaCharacterConst = var_20_2

	local var_20_4 = var_20_2.UIConfig[var_20_3]

	setLocalPosition = var_5

	var_5(arg_20_0.shipImg, {
		x = var_20_4[7],
		y = var_20_4[8]
	})

	setLocalScale = var_5

	var_5(arg_20_0.shipImg, {
		x = var_20_4[3],
		y = var_20_4[4]
	})

	return
end

function var_0_1.updateNamePanel(arg_21_0)
	local var_21_0 = arg_21_0.curShipVO
	local var_21_1 = arg_21_0.curMetaCharacterVO
	local var_21_2 = var_21_0
	local var_21_3 = var_21_0.getName(var_21_2)

	setScrollText = var_21_2

	var_21_2(arg_21_0.nameScrollText, var_21_3)

	local var_21_4 = var_21_0
	local var_21_5 = var_21_0.getShipType(var_21_4)

	setImageSprite = var_21_4

	local var_21_6 = arg_21_0.shipTypeImg

	LoadSprite = var_1_10007

	var_21_4(var_21_6, var_1_10007("shiptype", var_21_5))

	local var_21_7 = var_21_0
	local var_21_8 = var_21_0.getConfig(var_21_7, "english_name")

	setText = var_21_7

	var_21_7(arg_21_0.enNameText, var_21_8)

	local var_21_9 = var_21_0:getMaxStar()
	local var_21_10 = var_21_0:getStar()
	local var_21_11 = arg_21_0.nameTFStarUIList

	var_8.make(var_21_11, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = arg_22_2:Find("empty")
			local var_22_1 = arg_22_2
			local var_22_2 = arg_22_2.Find(var_22_1, "on")

			arg_22_1 = arg_22_1 + 1
			setActive = var_22_1

			var_22_1(var_22_2, arg_22_1 <= var_21_10)
		end

		return
	end)

	local var_21_12 = arg_21_0.nameTFStarUIList

	var_8.align(var_21_12, var_21_9)

	return
end

function var_0_1.updateChar(arg_23_0)
	return
end

function var_0_1.recycleChar(arg_24_0)
	if arg_24_0.shipPrefab and arg_24_0.shipModel then
		PoolMgr = var_1

		local var_24_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_24_0, arg_24_0.shipPrefab, arg_24_0.shipModel)

		arg_24_0.shipPrefab = nil
		arg_24_0.shipModel = nil
	end

	return
end

function var_0_1.updateSkillListPanel(arg_25_0)
	local var_25_0 = arg_25_0.curShipVO
	local var_25_1 = arg_25_0.curMetaCharacterVO
	local var_25_2 = arg_25_0:getSkillIDListForShow(var_25_0.configId)
	local var_25_3 = arg_25_0.skillUIItemList

	var_4.make(var_25_3, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate and var_25_2[arg_26_1 + 1] then
			arg_25_0.skillBtnList[var_3] = arg_26_2

			local var_26_0 = arg_25_0

			var_4.updateSkillTF(var_26_0, arg_26_2, var_3)
		end

		return
	end)

	local var_25_4 = arg_25_0.skillUIItemList

	var_4.align(var_25_4, #var_25_2)

	return
end

function var_0_1.updateSkillTF(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.curShipVO
	local var_27_1 = arg_27_0.curMetaCharacterVO
	local var_27_2 = arg_27_1:Find("Skill/Icon")
	local var_27_3 = arg_27_1:Find("Skill/Level")
	local var_27_4 = arg_27_1:Find("Skill/Mask/Name")
	local var_27_5 = arg_27_1:Find("Skill/Arrow")
	local var_27_6 = arg_27_1:Find("Lock")
	local var_27_7 = arg_27_1
	local var_27_8 = arg_27_1.Find(var_27_7, "Learning")

	getSkillConfig = var_27_7

	local var_27_9 = var_27_7(arg_27_2)
	local var_27_10 = var_27_0
	local var_27_11 = var_27_0.getMetaSkillLevelBySkillID(var_27_10, arg_27_2)

	setImageSprite = var_27_10

	local var_27_12 = var_27_2

	LoadSprite = var_1_10015

	var_27_10(var_27_12, var_1_10015("skillicon/" .. var_27_9.icon))

	setScrollText = var_27_10

	local var_27_13 = var_27_4

	getSkillName = var_15

	var_27_10(var_27_13, var_15(var_27_9.id))

	if 0 < var_27_11 then
		setText = var_13

		var_13(var_27_3, "LEVEL: " .. var_27_11)

		setActive = var_13

		var_13(var_27_6, false)

		onButton = var_13

		local var_27_14 = arg_27_0
		local var_27_15 = arg_27_1

		local function var_27_16()
			isActive = var_2_10000

			if not var_2_10000(var_27_5) then
				eachChild = var_0

				var_0(arg_27_0.skillContainer, function(arg_29_0)
					local var_29_0 = arg_29_0
					local var_29_1 = arg_29_0.Find(var_29_0, "Skill/Arrow")

					setActive = var_29_0

					var_29_0(var_29_1, false)

					return
				end)

				setActive = var_0

				var_0(var_27_5, true)

				local var_28_0 = arg_27_0

				var_0.updateTaskPanel(var_28_0, arg_27_2)
			end

			return
		end

		SFX_PANEL = var_17

		var_13(var_27_14, var_27_15, var_27_16, var_17)
	else
		setText = var_13

		var_13(var_27_3, "LEVEL: ??")

		setActive = var_13

		var_13(var_27_6, true)

		onButton = var_13

		local var_27_17 = arg_27_0
		local var_27_18 = arg_27_1

		local function var_27_19()
			local var_30_0 = arg_27_0

			var_0.openUnlockSkillPanel(var_30_0, arg_27_2)

			return
		end

		SFX_PANEL = var_17

		var_13(var_27_17, var_27_18, var_27_19, var_17)
	end

	return
end

function var_0_1.updateSkillTFLearning(arg_31_0)
	local var_31_0 = arg_31_0.curShipVO

	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.skillBtnList) do
		local var_31_1 = iter_31_1:Find("Learning")
		local var_31_2 = var_31_0:isSkillLevelMax(iter_31_0)
		local var_31_3 = iter_31_0 == arg_31_0.curSkillID

		setActive = var_10

		var_10(var_31_1, var_31_3 and not var_31_2)
	end

	return
end

function var_0_1.TryPlayGuide(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayByGuideId(var_32_0, "NG0025")

	return
end

function var_0_1.updateExpPanel(arg_33_0)
	local var_33_0 = arg_33_0:isAllSkillLock()
	local var_33_1 = arg_33_0
	local var_33_2 = arg_33_0.isAllSkillMaxLevel(var_33_1)

	if var_33_0 or var_33_2 then
		setActive = var_33_1

		var_33_1(arg_33_0.expPanel, false)
	else
		local var_33_3

		if arg_33_0.curSkillID > 0 then
			setActive = var_33_3

			var_33_3(arg_33_0.expPanel, true)

			pg = var_33_3
			var_33_3 = var_33_3.gameset.meta_skill_exp_double.key_value
			pg = var_4

			local var_33_4 = var_4.gameset.meta_skill_exp_max.key_value

			setText = var_5

			var_5(arg_33_0.expText, arg_33_0.normalExpValue .. "/" .. var_33_4)

			setActive = var_5

			var_5(arg_33_0.expDoubleTag, var_33_3 > arg_33_0.doubleExpValue)
		else
			setActive = var_33_3

			var_33_3(arg_33_0.expPanel, false)
		end
	end

	return
end

function var_0_1.updateSkillInfoPanel(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.curShipVO

	getSkillConfig = var_1_10003

	local var_34_1 = var_1_10003(arg_34_1)

	setImageSprite = var_4

	local var_34_2 = arg_34_0.curSkillIcon

	LoadSprite = var_1_10006

	var_4(var_34_2, var_1_10006("skillicon/" .. var_34_1.icon))

	setScrollText = var_4

	local var_34_3 = arg_34_0.curSkillNameScrollText

	getSkillName = var_6

	var_4(var_34_3, var_6(var_34_1.id))

	pg = var_4

	local var_34_4 = var_4.skill_data_template[arg_34_1].max_level <= var_34_0:getMetaSkillLevelBySkillID(arg_34_1)

	setText = var_7

	var_7(arg_34_0.curSkillLevelText, var_5)

	math = var_7

	local var_34_5 = var_7.min(var_5 + 1, var_4)

	setText = var_8

	var_8(arg_34_0.nextSkillLevelText, var_34_5)

	setText = var_8

	local var_34_6 = arg_34_0.curSkillDescText

	getSkillDesc = var_10

	var_8(var_34_6, var_10(arg_34_1, var_34_0:getMetaSkillLevelBySkillID(arg_34_1)))

	setActive = var_8

	local var_34_7 = arg_34_0.curSkillQuickBtn
	local var_34_8

	if not var_34_4 then
		LOCK_META_SKILL_QUICK = var_10
		var_34_8 = not var_10
	else
		var_34_8 = false
	end

	if false then
		var_34_8 = true
	end

	var_8(var_34_7, var_34_8)

	onButton = var_8

	local var_34_9 = arg_34_0
	local var_34_10 = arg_34_0.curSkillQuickBtn

	local function var_34_11()
		local var_35_0 = arg_34_0
		local var_35_1 = var_0.emit

		MetaCharacterTacticsMediator = var_2_10002

		var_35_1(var_35_0, var_2_10002.ON_QUICK, arg_34_0.curShipVO.id, arg_34_1)

		return
	end

	SFX_PANEL = var_12

	var_8(var_34_9, var_34_10, var_34_11, var_12)

	local var_34_12

	if not arg_34_0.skillExpTable[arg_34_1] then
		var_34_12 = 0
	end

	if not var_34_4 then
		local var_34_13 = arg_34_0:getMetaSkillTacticsConfigBySkillID(arg_34_1, var_5).need_exp

		setText = var_11

		var_11(arg_34_0.curSkillProgressText, var_34_12 .. "/" .. var_34_13)

		setSlider = var_11

		var_11(arg_34_0.curSkillProgressSlider, 0, var_34_13, var_34_12)

		if var_34_12 < var_34_13 then
			-- block empty
		end
	else
		setText = var_34_9

		var_34_9(arg_34_0.curSkillProgressText, var_34_12 .. "/Max")

		setSlider = var_34_9

		var_34_9(arg_34_0.curSkillProgressSlider, 0, 1, 1)
	end

	return
end

function var_0_1.updateTaskListPanel(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.curShipVO
	local var_36_1 = var_2.getMetaSkillLevelBySkillID(var_36_0, arg_36_1)
	local var_36_2 = arg_36_0:getMetaSkillTacticsConfigBySkillID(arg_36_1, var_36_1).skill_levelup_task
	local var_36_3 = arg_36_0:sortTaskConfig(arg_36_1, var_36_2)
	local var_36_4 = arg_36_0.taskUIItemList

	var_6.make(var_36_4, function(arg_37_0, arg_37_1, arg_37_2)
		UIItemList = var_2_10003

		if arg_37_0 == var_2_10003.EventUpdate then
			local var_37_0 = arg_37_2:Find("Desc")
			local var_37_1 = arg_37_2:Find("AddExp")
			local var_37_2 = arg_37_2:Find("Text")

			arg_37_1 = arg_37_1 + 1

			local var_37_3 = var_36_3[arg_37_1][1]
			local var_37_4 = arg_36_0
			local var_37_5

			if not var_8.getTaskInfoBySkillAndTaskID(var_37_4, arg_36_1, var_37_3) or not var_8.finishCount then
				var_37_5 = 0
			end

			local var_37_6 = var_6[3]

			setText = var_11

			var_11(var_37_1, "+" .. var_37_6)

			if var_6[2] == 0 then
				setText = var_12

				var_12(var_37_2, var_37_5 .. "/∞")
			else
				setText = var_12

				var_12(var_37_2, var_37_5 .. "/" .. var_11)
			end

			setText = var_12

			local var_37_7 = var_37_0

			pg = var_14

			var_12(var_37_7, var_14.task_meta_data_template[var_37_3].desc)
		end

		return
	end)

	local var_36_5 = arg_36_0.taskUIItemList

	var_6.align(var_36_5, #var_36_3)

	return
end

function var_0_1.updateTaskPanel(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.curShipVO
	local var_38_1 = arg_38_0.curMetaCharacterVO
	local var_38_2 = var_38_0

	if var_38_0.isSkillLevelMax(var_38_2, arg_38_1) == true then
		setActive = var_38_2

		var_38_2(arg_38_0.studySkillTip, false)

		setActive = var_38_2

		var_38_2(arg_38_0.startSkillTip, false)

		setActive = var_38_2

		var_38_2(arg_38_0.maxSkillTip, true)

		setActive = var_38_2

		var_38_2(arg_38_0.skillInfoPanel, true)

		setActive = var_38_2

		var_38_2(arg_38_0.taskTplContainer, false)

		setActive = var_38_2

		var_38_2(arg_38_0.taskScrollBar, false)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
	elseif arg_38_1 ~= arg_38_0.curSkillID then
		setActive = var_5

		var_5(arg_38_0.studySkillTip, false)

		setActive = var_5

		var_5(arg_38_0.startSkillTip, true)

		setActive = var_5

		var_5(arg_38_0.maxSkillTip, false)

		setActive = var_5

		var_5(arg_38_0.skillInfoPanel, true)

		setActive = var_5

		var_5(arg_38_0.taskTplContainer, true)

		setActive = var_5

		var_5(arg_38_0.taskScrollBar, true)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
		arg_38_0:updateTaskListPanel(arg_38_1)

		onButton = var_5

		local var_38_3 = arg_38_0
		local var_38_4 = arg_38_0.studySkillBtn

		local function var_38_5()
			local var_39_1

			if arg_38_0.switchCountLeft == 0 then
				pg = var_39_1

				local var_39_0 = var_39_1.TipsMgr.GetInstance()

				var_39_1 = var_39_1.ShowTips
				i18n = var_2_10002

				var_39_1(var_39_0, var_2_10002("meta_switch_skill_disable"))
			else
				pg = var_39_1

				local var_39_2 = var_39_1.MsgboxMgr.GetInstance()
				local var_39_3 = var_0.ShowMsgBox
				local var_39_4 = {}

				i18n = var_2_10003

				local var_39_5 = "meta_switch_skill_box_title"

				getSkillName = var_2_10005
				var_39_4.content = var_2_10003(var_39_5, var_2_10005(arg_38_1))

				function var_39_4.onYes()
					pg = var_3_10000

					local var_40_0 = var_3_10000.m02
					local var_40_1 = var_0.sendNotification

					GAME = var_3_10002

					var_40_1(var_40_0, var_3_10002.TACTICS_META_SWITCH_SKILL, {
						shipID = var_38_0.id,
						skillID = arg_38_1
					})

					return
				end

				var_39_3(var_39_2, var_39_4)
			end

			return
		end

		SFX_PANEL = var_1_10009

		var_5(var_38_3, var_38_4, var_38_5, var_1_10009)
	else
		setActive = var_5

		var_5(arg_38_0.studySkillTip, false)

		setActive = var_5

		var_5(arg_38_0.startSkillTip, false)

		setActive = var_5

		var_5(arg_38_0.maxSkillTip, false)

		setActive = var_5

		var_5(arg_38_0.skillInfoPanel, true)

		setActive = var_5

		var_5(arg_38_0.taskTplContainer, true)

		setActive = var_5

		var_5(arg_38_0.taskScrollBar, true)
		arg_38_0:updateSkillInfoPanel(arg_38_1)
		arg_38_0:updateTaskListPanel(arg_38_1)
	end

	return
end

function var_0_1.updateMain(arg_41_0)
	local var_41_0 = arg_41_0.curShipVO
	local var_41_1 = arg_41_0:getSkillIDListForShow(var_41_0.configId)
	local var_41_2 = true
	local var_41_3 = 0
	local var_41_4, var_41_5 = arg_41_0:isAllSkillLock()
	local var_41_6 = var_41_5
	local var_41_7 = var_41_4

	setActive = var_41_4

	var_41_4(arg_41_0.taskScrollTF, not var_41_7)

	if var_41_7 then
		setActive = var_41_4

		var_41_4(arg_41_0.expPanel, false)

		setActive = var_41_4

		var_41_4(arg_41_0.skillInfoPanel, false)

		setActive = var_41_4

		var_41_4(arg_41_0.taskTplContainer, false)

		setActive = var_41_4

		var_41_4(arg_41_0.taskScrollBar, false)

		setActive = var_41_4

		var_41_4(arg_41_0.studySkillTip, true)

		setActive = var_41_4

		var_41_4(arg_41_0.startSkillTip, false)

		setActive = var_41_4

		var_41_4(arg_41_0.maxSkillTip, false)
	elseif arg_41_0.curUnlockSkillID then
		triggerButton = var_5

		var_5(arg_41_0.skillBtnList[arg_41_0.curUnlockSkillID])
	elseif arg_41_0.curSkillID > 0 then
		triggerButton = var_5

		var_5(arg_41_0.skillBtnList[arg_41_0.curSkillID])
	else
		triggerButton = var_5

		var_5(arg_41_0.skillBtnList[var_41_6])
	end

	return
end

function var_0_1.tryLearnSkillAfterFirstUnlock(arg_42_0)
	local var_42_0 = arg_42_0.curUnlockSkillID
	local var_42_1 = 1

	arg_42_0:switchTacticsSkillData(var_42_0, var_42_1)
	arg_42_0:updateExpPanel()
	arg_42_0:updateTaskPanel(var_42_0)
	arg_42_0:updateSkillTFLearning()
	arg_42_0:TryPlayGuide()

	return
end

function var_0_1.moveShipImg(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.curMetaCharacterVO.id

	MetaCharacterConst = var_1_10003

	local var_43_1 = var_1_10003.UIConfig[var_43_0]
	local var_43_2 = arg_43_1 and -2000 or var_43_1[7]
	local var_43_3

	if not arg_43_1 or not var_43_1[7] then
		var_43_3 = -2000
	end

	local var_43_4 = arg_43_0
	local var_43_5 = arg_43_0.managedTween

	LeanTween = var_1_10008

	local var_43_6 = var_1_10008.moveX
	local var_43_7

	rtf = var_1_10010

	local var_43_8 = var_43_5(var_43_4, var_43_6, var_43_7, var_1_10010(arg_43_0.shipImg), var_43_3, 0.2)

	var_6.setFrom(var_43_8, var_43_2)

	return
end

function var_0_1.moveRightPanel(arg_44_0)
	local var_44_0 = 2000
	local var_44_1 = 500
	local var_44_2 = arg_44_0
	local var_44_3 = arg_44_0.managedTween

	LeanTween = var_1_10005

	local var_44_4 = var_1_10005.moveX
	local var_44_5

	rtf = var_1_10007

	local var_44_6 = var_44_3(var_44_2, var_44_4, var_44_5, var_1_10007(arg_44_0.skillPanel), var_44_1, 0.2)

	var_3.setFrom(var_44_6, var_44_0)

	local var_44_7 = arg_44_0
	local var_44_8 = arg_44_0.managedTween

	LeanTween = var_5

	local var_44_9 = var_5.moveX
	local var_44_10

	rtf = var_7

	local var_44_11 = var_44_8(var_44_7, var_44_9, var_44_10, var_7(arg_44_0.taskPanel), var_44_1, 0.2)

	var_3.setFrom(var_44_11, var_44_0)

	return
end

function var_0_1.openUnlockSkillPanel(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.curShipVO
	local var_45_1 = arg_45_0.curMetaCharacterVO

	arg_45_0.curUnlockSkillID = arg_45_1
	ShipGroup = var_1_10004

	local var_45_2 = var_1_10004.getDefaultShipNameByGroupID(var_45_1.id)

	getSkillName = var_5

	local var_45_3 = var_5(arg_45_1)

	setText = var_6

	local var_45_4 = arg_45_0.skillUnlockPanelTipText

	i18n = var_1_10008

	var_6(var_45_4, var_1_10008("meta_unlock_skill_tip", var_45_2, var_45_3))

	local var_45_5 = arg_45_0:getMetaSkillTacticsConfigBySkillID(arg_45_1, 1).skill_unlock
	local var_45_6 = {
		var_6.skill_unlock[1]
	}
	local var_45_7 = arg_45_0.materialUIItemList

	var_8.make(var_45_7, function(arg_46_0, arg_46_1, arg_46_2)
		UIItemList = var_2_10003

		if arg_46_0 == var_2_10003.EventUpdate then
			arg_46_1 = arg_46_1 + 1

			local var_46_0 = var_45_6[arg_46_1]
			local var_46_1 = arg_46_2:Find("Item")
			local var_46_2 = arg_46_2:Find("SelectedTag")
			local var_46_3 = arg_46_2:Find("Count/Text")
			local var_46_4 = {}

			DROP_TYPE_ITEM = var_8
			var_46_4.type = var_8
			var_46_4.id = var_46_0[2]
			var_46_4.count = var_46_0[3]
			updateDrop = var_8

			var_8(var_46_1, var_46_4)

			setActive = var_8

			var_8(var_46_2, false)

			local var_46_5 = var_46_0[2]
			local var_46_6 = var_46_0[3]

			getProxy = var_10
			BagProxy = var_2_10011

			local var_46_7 = var_10(var_2_10011)

			if var_10.getItemCountById(var_46_7, var_46_5) < var_46_6 then
				setColorStr = var_46_7

				local var_46_8 = var_10

				COLOR_RED = var_2_10013

				if not var_46_7(var_46_8, var_2_10013) then
					setColorStr = var_46_7
					var_46_8 = var_10
					COLOR_GREEN = var_2_10013
					var_46_7 = var_46_7(var_46_8, var_2_10013)
				end

				setText = var_46_8

				var_46_8(var_46_3, var_46_7 .. "/" .. var_46_6)

				arg_45_0.curUnlockMaterialID = var_46_5
				arg_45_0.curUnlockMaterialNeedCount = var_46_6

				return
			end
		end
	end)

	local var_45_8 = arg_45_0.materialUIItemList

	var_8.align(var_45_8, #var_45_6)

	setActive = var_8

	var_8(arg_45_0.skillUnlockPanel, true)

	pg = var_8

	local var_45_9 = var_8.UIMgr.GetInstance()

	var_8.BlurPanel(var_45_9, arg_45_0.skillUnlockPanel)

	return
end

function var_0_1.closeUnlockSkillPanel(arg_47_0)
	arg_47_0.curUnlockSkillID = nil
	arg_47_0.curUnlockMaterialID = nil
	arg_47_0.curUnlockMaterialNeedCount = nil
	setActive = var_1

	var_1(arg_47_0.skillUnlockPanel, false)

	pg = var_1

	local var_47_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_47_0, arg_47_0.skillUnlockPanel, arg_47_0._tf)

	return
end

function var_0_1.enablePartialBlur(arg_48_0)
	if arg_48_0._tf then
		local var_48_0 = {}

		table = var_1_10002

		var_1_10002.insert(var_48_0, arg_48_0.taskPanel)

		table = var_2

		var_2.insert(var_48_0, arg_48_0.skillPanel)
		arg_48_0:OverlayPanel(arg_48_0._tf, {
			groupDelta = -1,
			pbList = var_48_0
		})
	end

	return
end

function var_0_1.disablePartialBlur(arg_49_0)
	if arg_49_0._tf then
		arg_49_0:UnOverlayPanel(arg_49_0._tf)
	end

	return
end

function var_0_1.getMetaSkillTacticsConfigBySkillID(arg_50_0, arg_50_1, arg_50_2)
	MetaCharacterConst = var_1_10003

	return var_1_10003.getMetaSkillTacticsConfig(arg_50_1, arg_50_2)
end

function var_0_1.getTaskInfoBySkillAndTaskID(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0

	if not arg_51_0.taskInfoTable[arg_51_1] then
		var_51_0 = {}
	end

	ipairs = var_1_10004

	for iter_51_0, iter_51_1 in var_1_10004(var_51_0) do
		if iter_51_1.taskID == arg_51_2 then
			return iter_51_1
		end
	end

	return
end

function var_0_1.isAllSkillLock(arg_52_0)
	local var_52_0 = arg_52_0.curShipVO
	local var_52_1 = arg_52_0:getSkillIDListForShow(var_52_0.configId)
	local var_52_2 = true
	local var_52_3 = 0

	ipairs = var_1_10005

	for iter_52_0, iter_52_1 in var_1_10005(var_52_1) do
		if var_52_0:getMetaSkillLevelBySkillID(iter_52_1) > 0 then
			var_52_2 = false
			var_52_3 = iter_52_1

			break
		end
	end

	return var_52_2, var_52_3
end

function var_0_1.isAllSkillMaxLevel(arg_53_0)
	local var_53_0 = arg_53_0.curShipVO
	local var_53_1 = arg_53_0:getSkillIDListForShow(var_53_0.configId)
	local var_53_2 = true

	ipairs = var_4

	for iter_53_0, iter_53_1 in var_4(var_53_1) do
		if not var_53_0:isSkillLevelMax(iter_53_1) then
			return false
		end
	end

	return
end

function var_0_1.updateTacticsRedTag(arg_54_0)
	local var_54_0 = arg_54_0.curShipVO
	local var_54_1 = var_1.getMetaCharacter(var_54_0)
	local var_54_2 = arg_54_0:getSkillIDListForShow(var_1.configId)
	local var_54_3 = false

	ipairs = var_5

	for iter_54_0, iter_54_1 in var_5(var_54_2) do
		local var_54_4 = var_1:getMetaSkillLevelBySkillID(iter_54_1)
		local var_54_5 = var_1:isSkillLevelMax(iter_54_1)

		if var_54_4 > 0 and not var_54_5 then
			local var_54_6 = arg_54_0:getMetaSkillTacticsConfigBySkillID(iter_54_1, var_54_4).need_exp
			local var_54_7

			if not arg_54_0.skillExpTable or not arg_54_0.skillExpTable[iter_54_1] then
				var_54_7 = 0
			end

			if var_54_6 <= var_54_7 then
				local var_54_8 = true

				break
			end
		end
	end

	return
end

function var_0_1.sortTaskConfig(arg_55_0, arg_55_1, arg_55_2)
	Clone = var_1_10003

	local var_55_0 = var_1_10003(arg_55_2)

	table = var_4

	var_4.sort(var_55_0, function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_0[1]
		local var_56_1 = arg_56_1[1]
		local var_56_2 = arg_56_0[2]
		local var_56_3 = arg_56_1[2]
		local var_56_4 = arg_55_0
		local var_56_5 = var_6.getTaskInfoBySkillAndTaskID(var_56_4, arg_55_1, var_56_0)
		local var_56_6 = arg_55_0
		local var_56_7 = var_7.getTaskInfoBySkillAndTaskID(var_56_6, arg_55_1, var_56_1)
		local var_56_8

		if not var_56_5 or not var_56_5.finishCount then
			var_56_8 = 0
		end

		local var_56_9

		if not var_56_7 or not var_56_7.finishCount then
			var_56_9 = 0
		end

		local var_56_10 = var_56_2 > 0 and var_56_8 <= var_56_2
		local var_56_11 = var_56_3 > 0 and var_56_9 <= var_56_3

		if var_56_2 == 0 and var_56_3 == 0 then
			return var_56_0 < var_56_1
		elseif var_56_2 == 0 then
			return true
		elseif var_56_3 == 0 then
			return false
		elseif var_56_10 == true and var_56_11 == true then
			return var_56_0 < var_56_1
		elseif var_56_10 == true then
			return false
		elseif var_56_11 == true then
			return true
		else
			return var_56_0 < var_56_1
		end

		return
	end)

	return var_55_0
end

function var_0_1.getSkillIDListForShow(arg_57_0, arg_57_1)
	MetaCharacterConst = var_1_10002

	return var_1_10002.getTacticsSkillIDListByShipConfigID(arg_57_1)
end

return var_0_1
