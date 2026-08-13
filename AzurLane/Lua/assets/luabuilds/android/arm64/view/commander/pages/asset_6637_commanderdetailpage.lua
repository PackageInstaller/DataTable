class = var_0_10000

local var_0_0 = "CommanderDetailPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderDetailUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:Load()

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	CommanderCatScene = var_1_10004

	var_3_1(var_3_0, var_1_10004.EVENT_CLOSE_DESC, function(arg_4_0)
		triggerToggle = var_2_10001

		var_2_10001(arg_3_0.skillBtn, false)

		triggerToggle = var_2_10001

		var_2_10001(arg_3_0.additionBtn, false)

		triggerToggle = var_2_10001

		var_2_10001(arg_3_0.otherBtn, false)

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	CommanderCatScene = var_4

	var_3_3(var_3_2, var_4.EVENT_FOLD, function(arg_5_0, arg_5_1)
		triggerToggle = var_2_10002

		var_2_10002(arg_3_0.skillBtn, false)

		triggerToggle = var_2_10002

		var_2_10002(arg_3_0.additionBtn, false)

		triggerToggle = var_2_10002

		var_2_10002(arg_3_0.otherBtn, false)

		if arg_5_1 then
			LeanTween = var_2_10002
			var_2_10002 = var_2_10002.moveY
			rtf = var_4

			var_2_10002(var_4(arg_3_0.commanderInfo), -400, 0.5)
		else
			LeanTween = var_2_10002

			local var_5_0 = var_2_10002.moveY

			rtf = var_4

			var_5_0(var_4(arg_3_0.commanderInfo), 71, 0.5)
		end

		return
	end)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bind

	CommanderCatScene = var_4

	var_3_5(var_3_4, var_4.EVENT_PREVIEW, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0

		var_2.UpdatePreView(var_6_0, arg_6_1)

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	CommanderCatScene = var_4

	var_3_7(var_3_6, var_4.EVENT_PREVIEW_REVERSE, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_3_0

		var_3.UpdateReversePreView(var_7_0, arg_7_1, arg_7_2)

		return
	end)

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.bind

	CommanderCatScene = var_4

	var_3_9(var_3_8, var_4.EVENT_PREVIEW_PLAY, function(arg_8_0, arg_8_1, arg_8_2)
		triggerToggle = var_2_10003

		var_2_10003(arg_3_0.skillBtn, true)

		local var_8_0 = not arg_8_1 or #arg_8_1 <= 0 or arg_8_2

		triggerToggle = var_2_10004

		var_2_10004(arg_3_0.otherBtn, not var_8_0)

		triggerToggle = var_2_10004

		var_2_10004(arg_3_0.additionBtn, false)

		setToggleEnabled = var_2_10004

		var_2_10004(arg_3_0.additionBtn, false)

		local var_8_1 = arg_3_0

		var_4.UpdatePreViewWithOther(var_8_1, arg_8_1)

		return
	end)

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.bind

	CommanderCatScene = var_4

	var_3_11(var_3_10, var_4.EVENT_PREVIEW_ADDITION, function(arg_9_0, arg_9_1)
		triggerToggle = var_2_10002

		var_2_10002(arg_3_0.skillBtn, true)

		triggerToggle = var_2_10002

		var_2_10002(arg_3_0.additionBtn, true)

		local var_9_0 = arg_3_0

		var_2.UpdatePreviewAddition(var_9_0, arg_9_1)

		return
	end)

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.bind

	CommanderCatDockPage = var_4

	var_3_13(var_3_12, var_4.ON_SORT, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_3_0

		var_2.OnSort(var_10_0, arg_10_1)

		return
	end)

	return
end

function var_0_1.OnLoaded(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.statement = var_1.Find(var_11_0, "detail/statement")

	local var_11_1 = arg_11_0.statement

	Vector3 = var_1_10002
	var_11_1.localScale = var_1_10002(1, 0, 1)

	local var_11_2 = arg_11_0._tf

	arg_11_0.talentSkill = var_1.Find(var_11_2, "detail/talent_skill")

	local var_11_3 = arg_11_0.talentSkill
	local var_11_4 = var_1.Find(var_11_3, "talent/content")

	UIItemList = var_2
	arg_11_0.talentList = var_2.New(var_11_4, var_11_4:GetChild(0))

	local var_11_5 = arg_11_0.statement

	arg_11_0.abilityAdditionTF = var_2.Find(var_11_5, "atttrs/content")

	local var_11_6 = arg_11_0.statement

	arg_11_0.talentAdditionTF = var_2.Find(var_11_6, "talents/scroll/content")
	UIItemList = var_2

	local var_11_7 = var_2.New
	local var_11_8 = arg_11_0.talentAdditionTF
	local var_11_9 = arg_11_0.talentAdditionTF

	arg_11_0.talentAdditionList = var_11_7(var_11_8, var_5.GetChild(var_11_9, 0))

	local var_11_10 = arg_11_0.talentSkill

	arg_11_0.skillIcon = var_2.Find(var_11_10, "skill/icon/Image")

	local var_11_11 = arg_11_0._tf

	arg_11_0.lockTF = var_2.Find(var_11_11, "info/lock")

	local var_11_12 = arg_11_0._tf

	arg_11_0.commanderInfo = var_2.Find(var_11_12, "info")

	local var_11_13 = arg_11_0.commanderInfo

	arg_11_0.expPanel = var_2.Find(var_11_13, "exp")

	local var_11_14 = arg_11_0.commanderInfo
	local var_11_15 = var_2.Find(var_11_14, "exp/level")
	local var_11_16 = var_2.GetComponent

	typeof = var_5
	Text = var_11_9
	arg_11_0.commanderLevelTxt = var_11_16(var_11_15, var_5(var_11_9))

	local var_11_17 = arg_11_0.commanderInfo
	local var_11_18 = var_2.Find(var_11_17, "exp/Image")
	local var_11_19 = var_2.GetComponent

	typeof = var_5
	Image = var_11_9
	arg_11_0.commanderExpImg = var_11_19(var_11_18, var_5(var_11_9))

	local var_11_20 = arg_11_0.commanderInfo
	local var_11_21 = var_2.Find(var_11_20, "name_bg/mask/Text")

	arg_11_0.commanderNameTxt = var_2.GetComponent(var_11_21, "ScrollText")

	local var_11_22 = arg_11_0.commanderInfo

	arg_11_0.modifyNameBtn = var_2.Find(var_11_22, "name_bg/modify")
	pg = var_2

	local var_11_23 = var_2.gameset.commander_rename_open.key_value == 1

	setActive = var_11_3

	var_11_3(arg_11_0.modifyNameBtn, var_11_23)

	local var_11_24 = arg_11_0.commanderInfo

	arg_11_0.line = var_3.Find(var_11_24, "line")

	local var_11_25 = arg_11_0.commanderInfo

	arg_11_0.fleetnums = var_3.Find(var_11_25, "line/numbers")

	local var_11_26 = arg_11_0.commanderInfo

	arg_11_0.fleetTF = var_3.Find(var_11_26, "line/fleet")

	local var_11_27 = arg_11_0.commanderInfo

	arg_11_0.subTF = var_3.Find(var_11_27, "line/sub_fleet")

	local var_11_28 = arg_11_0.commanderInfo

	arg_11_0.leisureTF = var_3.Find(var_11_28, "line/leisure")

	local var_11_29 = arg_11_0.commanderInfo

	arg_11_0.labelInBattleTF = var_3.Find(var_11_29, "line/inbattle")

	local var_11_30 = arg_11_0.commanderInfo
	local var_11_31 = var_3.Find(var_11_30, "rarity")
	local var_11_32 = var_3.GetComponent

	typeof = var_6
	Image = var_8
	arg_11_0.rarityImg = var_11_32(var_11_31, var_6(var_8))

	local var_11_33 = arg_11_0.commanderInfo

	arg_11_0.abilityTF = var_3.Find(var_11_33, "ablitys")

	local var_11_34 = arg_11_0.commanderInfo

	arg_11_0.skillBtn = var_3.Find(var_11_34, "skill_btn")

	local var_11_35 = arg_11_0.commanderInfo

	arg_11_0.additionBtn = var_3.Find(var_11_35, "addition_btn")

	local var_11_36 = arg_11_0.commanderInfo

	arg_11_0.otherBtn = var_3.Find(var_11_36, "other_btn")

	local var_11_37 = arg_11_0._tf
	local var_11_38 = var_3.Find(var_11_37, "detail/other/name/Text")
	local var_11_39 = var_3.GetComponent

	typeof = var_6
	Text = var_8
	arg_11_0.otherCommanderNameTxt = var_11_39(var_11_38, var_6(var_8))

	local var_11_40 = arg_11_0._tf

	arg_11_0.otherCommanderSkillImg = var_3.Find(var_11_40, "detail/other/skill/Image")
	UIItemList = var_3

	local var_11_41 = var_3.New
	local var_11_42 = arg_11_0._tf
	local var_11_43 = var_5.Find(var_11_42, "detail/other/talent")
	local var_11_44 = arg_11_0._tf

	arg_11_0.otherCommanderTalentList = var_11_41(var_11_43, var_6.Find(var_11_44, "detail/other/talent/tpl"))

	local var_11_45 = arg_11_0._tf
	local var_11_46 = var_3.Find(var_11_45, "detail/other/desc/mask/Text")
	local var_11_47 = var_3.GetComponent

	typeof = var_6
	ScrollText = var_11_44
	arg_11_0.otherCommanderDescTxt = var_11_47(var_11_46, var_6(var_11_44))
	arg_11_0.blurPanel = arg_11_0._parentTf.parent
	arg_11_0.blurPanelParent = arg_11_0.blurPanel.parent
	CommanderRenamePage = var_3

	local var_11_48 = var_3.New

	pg = var_11_46
	arg_11_0.renamePanel = var_11_48(var_11_46.UIMgr.GetInstance().OverlayMain, arg_11_0.event)
	setText = var_3

	local var_11_49 = arg_11_0._tf
	local var_11_50 = var_5.Find(var_11_49, "detail/statement/atttrs/title/Text")

	i18n = var_6

	var_3(var_11_50, var_6("commander_subtile_ablity"))

	setText = var_3

	local var_11_51 = arg_11_0._tf
	local var_11_52 = var_5.Find(var_11_51, "detail/statement/talents/title/Text")

	i18n = var_6

	var_3(var_11_52, var_6("commander_subtile_talent"))

	return
end

function var_0_1.OnInit(arg_12_0)
	arg_12_0:RegisterEvent()

	arg_12_0.isOnAddition = false
	arg_12_0.isOnSkill = false
	onToggle = var_1

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.skillBtn

	local function var_12_2(arg_13_0)
		arg_12_0.isOnSkill = arg_13_0

		local var_13_0 = arg_12_0

		var_1.Blur(var_13_0)

		if arg_13_0 then
			local var_13_1 = arg_12_0
			local var_13_2 = var_1.emit

			CommanderCatScene = var_2_10004

			var_13_2(var_13_1, var_2_10004.EVENT_OPEN_DESC)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_12_0, var_12_1, var_12_2, var_1_10006)

	onToggle = var_1

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.additionBtn

	local function var_12_5(arg_14_0)
		arg_12_0.isOnAddition = arg_14_0

		local var_14_0 = arg_12_0.statement

		if arg_14_0 then
			Vector3 = var_2_10002

			if not var_2_10002(1, 1, 1) then
				Vector3 = var_2_10002
				var_2_10002 = var_2_10002(1, 0, 1)
			end

			var_14_0.localScale = var_2_10002

			local var_14_1 = arg_12_0

			var_1.Blur(var_14_1)

			if arg_14_0 then
				local var_14_2 = arg_12_0
				local var_14_3 = var_1.emit

				CommanderCatScene = var_2_10004

				var_14_3(var_14_2, var_2_10004.EVENT_OPEN_DESC)
			end

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_1(var_12_3, var_12_4, var_12_5, var_1_10006)

	onToggle = var_1

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.otherBtn

	local function var_12_8(arg_15_0)
		arg_12_0.isOnOther = arg_15_0

		local var_15_0 = arg_12_0

		var_1.Blur(var_15_0)

		if arg_15_0 then
			local var_15_1 = arg_12_0
			local var_15_2 = var_1.emit

			CommanderCatScene = var_2_10004

			var_15_2(var_15_1, var_2_10004.EVENT_OPEN_DESC)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_12_6, var_12_7, var_12_8, var_1_10006)

	onButton = var_1

	local var_12_9 = arg_12_0
	local var_12_10 = arg_12_0.modifyNameBtn

	local function var_12_11()
		local var_16_0 = arg_12_0.commanderVO

		if not var_0.canModifyName(var_16_0) then
			local var_16_1 = var_0:getRenameTimeDesc()
			local var_16_2 = arg_12_0.contextData.msgBox
			local var_16_3 = var_2.ExecuteAction
			local var_16_4 = "Show"
			local var_16_5 = {}

			i18n = var_2_10007
			var_16_5.content = var_2_10007("commander_rename_coldtime_tip", var_16_1)

			var_16_3(var_16_2, var_16_4, var_16_5)
		else
			local var_16_6 = arg_12_0.renamePanel

			var_1.ExecuteAction(var_16_6, "Show", var_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_12_9, var_12_10, var_12_11, var_1_10006)

	return
end

function var_0_1.Update(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.commanderVO = arg_17_1

	arg_17_0:UpdateInfo()
	arg_17_0:UpdateTalents()
	arg_17_0:UpdateSkills()
	arg_17_0:UpdateAbilityAddition()
	arg_17_0:UpdateTalentAddition()
	arg_17_0:UpdateAbilitys()
	arg_17_0:UpdateLockState()
	arg_17_0:UpdateLevel()
	arg_17_0:UpdateStyle(arg_17_2)

	local var_17_0 = arg_17_0._tf

	var_3.SetAsFirstSibling(var_17_0)
	arg_17_0:Show()

	return
end

function var_0_1.UpdateLockState(arg_18_0)
	local var_18_0 = arg_18_0.commanderVO
	local var_18_1 = var_1.getLock(var_18_0)

	setActive = var_1_10002

	local var_18_2 = arg_18_0.lockTF

	var_1_10002(var_4.Find(var_18_2, "image"), var_18_1 == 0)

	onButton = var_1_10002

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.lockTF

	local function var_18_5()
		local var_19_0 = 1 - var_18_1
		local var_19_1 = arg_18_0
		local var_19_2 = var_1.emit

		CommanderCatMediator = var_2_10004

		var_19_2(var_19_1, var_2_10004.LOCK, arg_18_0.commanderVO.id, var_19_0)

		return
	end

	SFX_PANEL = var_7

	var_1_10002(var_18_3, var_18_4, var_18_5, var_7)

	return
end

function var_0_1.UpdateStyle(arg_20_0, arg_20_1)
	if arg_20_1 then
		triggerToggle = var_1_10002

		var_1_10002(arg_20_0.skillBtn, true)

		triggerToggle = var_1_10002

		var_1_10002(arg_20_0.additionBtn, true)

		setActive = var_1_10002

		var_1_10002(arg_20_0.lockTF, false)
	end

	setButtonEnabled = var_1_10002

	var_1_10002(arg_20_0.modifyNameBtn, not arg_20_1)

	return
end

function var_0_1.UpdateInfo(arg_21_0)
	local var_21_0 = arg_21_0.commanderVO

	Commander = var_1_10002

	local var_21_1 = var_1_10002.rarity2Print(var_21_0:getRarity())

	if arg_21_0.rarityPrint ~= var_21_1 then
		LoadImageSpriteAsync = var_3

		var_3("CommanderRarity/" .. var_21_1, arg_21_0.rarityImg, true)

		arg_21_0.rarityPrint = var_21_1
	end

	eachChild = var_3

	var_3(arg_21_0.fleetnums, function(arg_22_0)
		setActive = var_2_10001

		local var_22_0 = arg_22_0

		go = var_2_10004

		local var_22_1 = var_2_10004(arg_22_0).name

		tostring = var_2_10005

		local var_22_2

		if not var_21_0.fleetId then
			var_22_2 = ""
		end

		var_2_10001(var_22_0, var_22_1 == var_2_10005(var_22_2))

		return
	end)

	local var_21_2

	if var_21_0.fleetId then
		var_21_2 = not var_21_0.inBattle and var_21_0.sub
	end

	local var_21_3 = var_21_2 and 260 or 200
	local var_21_4 = arg_21_0.line

	Vector2 = var_6
	var_21_4.sizeDelta = var_6(var_21_3, arg_21_0.line.sizeDelta.y)
	setActive = var_21_4

	var_21_4(arg_21_0.subTF, var_21_2)

	setActive = var_21_4

	local var_21_5 = arg_21_0.fleetTF
	local var_21_6

	if var_21_0.fleetId then
		var_21_6 = not var_21_0.inBattle and not var_21_0.sub
	end

	var_21_4(var_21_5, var_21_6)

	setActive = var_21_4

	var_21_4(arg_21_0.leisureTF, not var_21_0.inFleet and not var_21_0.inBattle)

	setActive = var_21_4

	var_21_4(arg_21_0.labelInBattleTF, var_21_0.inBattle)

	local var_21_7 = arg_21_0.commanderVO

	defaultValue = var_6

	local var_21_8 = var_6(arg_21_0.forceDefaultName, false)
	local var_21_9 = arg_21_0.commanderNameTxt

	var_7.SetText(var_21_9, var_21_7:getName(var_21_8))

	return
end

function var_0_1.OnSort(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.commanderVO

	arg_23_0.forceDefaultName = not arg_23_1

	local var_23_1 = arg_23_0.commanderNameTxt

	var_4.SetText(var_23_1, var_23_0:getName(var_3))

	return
end

function var_0_1.UpdatePreView(arg_24_0, arg_24_1)
	arg_24_0:UpdateAbilitys(arg_24_1)
	arg_24_0:UpdatePreviewAddition(arg_24_1)
	arg_24_0:UpdateLevel(arg_24_1)

	return
end

function var_0_1.UpdateReversePreView(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_UpdateAbilitys(arg_25_2, arg_25_1)
	arg_25_0:_UpdateAbilityAddition(arg_25_2, arg_25_1)
	arg_25_0:_UpdateTalentAddition(arg_25_2)
	arg_25_0:UpdateLevel(arg_25_2)

	return
end

function var_0_1.UpdatePreViewWithOther(arg_26_0, arg_26_1)
	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	Clone = var_1_10002

	local var_26_0 = var_1_10002(arg_26_0.commanderVO)

	CommanderCatUtil = var_1_10003

	local var_26_1 = var_1_10003.GetSkillExpAndCommanderExp(var_26_0, arg_26_1)

	var_26_0:addExp(var_26_1)

	local var_26_2 = arg_26_1[#arg_26_1]

	getProxy = var_5
	CommanderProxy = var_7

	local var_26_3 = var_5(var_7)
	local var_26_4 = var_5.getCommanderById(var_26_3, var_26_2)

	arg_26_0:UpdateOtherCommander(var_26_4)
	arg_26_0:UpdateLevel(var_26_0)
	arg_26_0:UpdateAbilitys(var_26_0)

	return
end

function var_0_1.UpdatePreviewAddition(arg_27_0, arg_27_1)
	arg_27_0:UpdateAbilityAddition(arg_27_1)
	arg_27_0:UpdateTalentAddition()

	return
end

function var_0_1.UpdateOtherCommander(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.otherCommanderNameTxt
	local var_28_1 = arg_28_1

	var_28_0.text = arg_28_1.getName(var_28_1)

	local var_28_2 = arg_28_1:getSkills()[1]
	local var_28_3 = arg_28_1:GetDisplayTalents()

	GetImageSpriteFromAtlasAsync = var_28_1

	var_28_1("commanderskillicon/" .. var_28_2:getConfig("icon"), "", arg_28_0.otherCommanderSkillImg)

	local var_28_4 = arg_28_0.otherCommanderTalentList

	var_5.make(var_28_4, function(arg_29_0, arg_29_1, arg_29_2)
		UIItemList = var_2_10003

		if arg_29_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_29_2:Find("Text"), "")

			if var_28_3[arg_29_1 + 1] then
				local var_29_0 = arg_28_0

				var_4.UpdateTalent(var_29_0, arg_28_1, var_3, arg_29_2)

				onToggle = var_4

				local var_29_1 = arg_28_0
				local var_29_2 = arg_29_2

				local function var_29_3(arg_30_0)
					if arg_30_0 then
						local var_30_0 = arg_28_0.otherCommanderDescTxt
						local var_30_1 = var_1.SetText
						local var_30_2 = var_0

						var_30_1(var_30_0, var_4.getConfig(var_30_2, "desc"))
					end

					return
				end

				SFX_PANEL = var_9

				var_4(var_29_1, var_29_2, var_29_3, var_9)

				if arg_29_1 == 0 then
					triggerToggle = var_4

					var_4(arg_29_2, true)
				end
			end

			setActive = var_4

			var_4(arg_29_2:Find("empty"), var_3 == nil)

			local var_29_4 = arg_29_2
			local var_29_5 = arg_29_2.GetComponent

			typeof = var_7
			Image = var_9

			local var_29_6 = var_29_5(var_29_4, var_7(var_9))

			var_29_6.enabled = var_3 ~= nil
			setActive = var_29_6

			local var_29_7 = arg_29_2:Find("lock")
			local var_29_9

			if var_3 then
				::label_29_0::

				local var_29_8 = arg_28_1

				var_29_9 = not var_7.IsLearnedTalent(var_29_8, var_3.id)
			end

			var_29_6(var_29_7, var_29_9)
		end

		return
	end)

	local var_28_5 = arg_28_0.otherCommanderTalentList

	var_5.align(var_28_5, 5)

	return
end

function var_0_1.UpdateLevel(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1 or arg_31_0.commanderVO

	if arg_31_1 then
		var_1_10003 = arg_31_1.level

		if arg_31_0.commanderVO.level < var_1_10003 then
			COLOR_GREEN = var_1_10003

			if not var_1_10003 then
				COLOR_WHITE = var_1_10003
			end

			setColorStr = var_1_10004

			local var_31_1 = var_1_10004("LV." .. var_31_0.level, var_1_10003)

			arg_31_0.commanderLevelTxt.text = var_31_1

			if var_31_0:isMaxLevel() then
				arg_31_0.commanderExpImg.fillAmount = 1
			else
				arg_31_0.commanderExpImg.fillAmount = var_31_0.exp / var_31_0:getNextLevelExp()
			end

			return
		end
	end
end

function var_0_1.UpdateAbilitys(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.commanderVO

	arg_32_0:_UpdateAbilitys(var_32_0, arg_32_1)

	return
end

function var_0_1._UpdateAbilitys(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1
	local var_33_1 = arg_33_1.getAbilitys(var_33_0)
	local var_33_2

	if arg_33_2 then
		var_33_2 = arg_33_2:getAbilitys()
	end

	pairs = var_33_0

	for iter_33_0, iter_33_1 in var_33_0(var_33_1) do
		local var_33_3 = arg_33_0.abilityTF
		local var_33_4 = var_10.Find(var_33_3, iter_33_0)
		local var_33_5

		if var_33_2 and var_33_2[iter_33_0].value - iter_33_1.value <= 0 then
			var_33_5 = nil
		end

		if var_33_5 then
			setColorStr = var_33_3
			var_1_10014 = "+" .. var_33_5
			COLOR_GREEN = var_15

			local var_33_6

			if not var_33_3(var_1_10014, var_15) then
				var_33_6 = " "
			end

			local var_33_7 = var_33_4
			local var_33_8 = var_33_4.Find(var_33_7, "add/base")

			setText = var_1_10014

			var_1_10014(var_33_8, iter_33_1.value)

			var_1_10014 = var_33_4:Find("add")
			setText = var_33_7

			var_33_7(var_1_10014, var_33_6)
		end
	end

	return
end

function var_0_1.UpdateAbilityAddition(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.commanderVO

	arg_34_0:_UpdateAbilityAddition(var_34_0, arg_34_1)

	return
end

function var_0_1._UpdateAbilityAddition(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1:getAbilitysAddition()
	local var_35_1

	if arg_35_2 then
		var_35_1 = arg_35_2:getAbilitysAddition()
	end

	local var_35_2 = 0

	pairs = var_1_10006

	for iter_35_0, iter_35_1 in var_1_10006(var_35_0) do
		if iter_35_1 > 0 then
			local var_35_3 = arg_35_0.abilityAdditionTF
			local var_35_4 = var_11.GetChild(var_35_3, var_35_2)

			GetImageSpriteFromAtlasAsync = var_1_10012

			var_1_10012("attricon", iter_35_0, var_35_4:Find("bg/icon"), false)

			setText = var_1_10012

			local var_35_5 = var_35_4:Find("bg/name")

			AttributeType = var_15

			var_1_10012(var_35_5, var_15.Type2Name(iter_35_0))

			string = var_1_10012
			var_1_10012 = var_1_10012.format("%0.3f", iter_35_1)
			setText = var_35_3

			local var_35_6 = var_35_4
			local var_35_7 = var_35_4.Find(var_35_6, "bg/value")
			local var_35_8 = "+"

			math = var_35_6

			var_35_3(var_35_7, (var_35_8 .. var_35_6.floor(iter_35_1 * 1000) / 1000) .. "%")

			local var_35_9

			if not var_35_1 or not var_35_1[iter_35_0] then
				var_35_9 = iter_35_1
			end

			setActive = var_14

			var_14(var_35_4:Find("up"), var_35_9 < iter_35_1)

			setActive = var_14

			var_14(var_35_4:Find("down"), iter_35_1 < var_35_9)

			var_35_2 = var_35_2 + 1
		end
	end

	return
end

function var_0_1.UpdateTalents(arg_36_0)
	local var_36_0 = arg_36_0.commanderVO
	local var_36_1 = var_1.GetDisplayTalents(var_36_0)
	local var_36_2 = arg_36_0.talentList

	var_3.make(var_36_2, function(arg_37_0, arg_37_1, arg_37_2)
		UIItemList = var_2_10003

		if arg_37_0 == var_2_10003.EventUpdate then
			local var_37_0 = var_36_1[arg_37_1 + 1]
			local var_37_1 = arg_36_0

			var_4.UpdateTalent(var_37_1, var_0, var_37_0, arg_37_2)
		end

		return
	end)

	local var_36_3 = arg_36_0.talentList

	var_3.align(var_36_3, #var_36_1)

	return
end

function var_0_1.UpdateTalent(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	setText = var_1_10004

	var_1_10004(arg_38_3:Find("Text"), arg_38_2:getConfig("name"))

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_38_0 = "CommanderTalentIcon/"
	local var_38_1 = arg_38_2

	var_1_10004(var_38_0 .. arg_38_2.getConfig(var_38_1, "icon"), "", arg_38_3)

	local var_38_2 = arg_38_3
	local var_38_3 = arg_38_3.GetComponent

	typeof = var_7
	Button = var_38_1

	if var_38_3(var_38_2, var_7(var_38_1)) then
		onButton = var_4

		local var_38_4 = arg_38_0
		local var_38_5 = arg_38_3

		local function var_38_6()
			local var_39_0 = arg_38_0.contextData.treePanel

			var_0.ExecuteAction(var_39_0, "Show", arg_38_2)

			return
		end

		SFX_PANEL = var_38_1

		var_4(var_38_4, var_38_5, var_38_6, var_38_1)
	end

	setActive = var_4

	var_4(arg_38_3:Find("lock"), not arg_38_1:IsLearnedTalent(arg_38_2.id))

	return
end

function var_0_1.UpdateTalentAddition(arg_40_0)
	local var_40_0 = arg_40_0.commanderVO

	arg_40_0:_UpdateTalentAddition(var_40_0)

	return
end

function var_0_1._UpdateTalentAddition(arg_41_0, arg_41_1)
	local var_41_0

	_ = var_1_10003

	local var_41_1 = var_1_10003.values(arg_41_1:getTalentsDesc())
	local var_41_2 = arg_41_0.talentAdditionList

	var_4.make(var_41_2, function(arg_42_0, arg_42_1, arg_42_2)
		UIItemList = var_2_10003

		if arg_42_0 == var_2_10003.EventUpdate then
			local var_42_0 = var_41_1[arg_42_1 + 1]

			setScrollText = var_4
			findTF = var_2_10006

			var_4(var_2_10006(arg_42_2, "bg/name_mask/name"), var_42_0.name)

			local var_42_1 = var_42_0.type

			CommanderConst = var_2_10005

			local var_42_2 = var_42_1 == var_2_10005.TALENT_ADDITION_RATIO and "%" or ""

			setText = var_5

			var_5(arg_42_2:Find("bg/value"), (var_42_0.value > 0 and "+" or "") .. var_42_0.value .. var_42_2)

			setActive = var_5

			var_5(arg_42_2:Find("up"), false)

			setActive = var_5

			var_5(arg_42_2:Find("down"), false)

			local var_42_3 = arg_42_2:Find("bg")
			local var_42_4 = var_5.GetComponent

			typeof = var_8
			Image = var_10
			var_42_4(var_42_3, var_8(var_10)).enabled = arg_42_1 % 2 ~= 0
		end

		return
	end)

	local var_41_3 = arg_41_0.talentAdditionList

	var_4.align(var_41_3, #var_41_1)

	return
end

function var_0_1.UpdateSkills(arg_43_0)
	local var_43_0 = arg_43_0.commanderVO
	local var_43_1 = var_1.getSkills(var_43_0)[1]

	GetImageSpriteFromAtlasAsync = var_43_0

	local var_43_2 = "commanderskillicon/"
	local var_43_3 = var_43_1

	var_43_0(var_43_2 .. var_43_1.getConfig(var_43_3, "icon"), "", arg_43_0.skillIcon)

	onButton = var_43_0

	local var_43_4 = arg_43_0
	local var_43_5 = arg_43_0.skillIcon

	local function var_43_6()
		local var_44_0 = arg_43_0
		local var_44_1 = var_0.emit

		CommanderCatMediator = var_2_10003

		var_44_1(var_44_0, var_2_10003.SKILL_INFO, var_43_1)

		return
	end

	SFX_PANEL = var_43_3

	var_43_0(var_43_4, var_43_5, var_43_6, var_43_3)

	return
end

function var_0_1.CanBack(arg_45_0)
	if arg_45_0.renamePanel then
		local var_45_0 = arg_45_0.renamePanel

		if var_1.GetLoaded(var_45_0) then
			local var_45_1 = arg_45_0.renamePanel

			if var_1.isShowing(var_45_1) then
				local var_45_2 = arg_45_0.renamePanel

				var_1.Hide(var_45_2)

				return false
			end
		end
	end

	return true
end

function var_0_1.OnDestroy(arg_46_0)
	if arg_46_0.isBlur then
		pg = var_1

		local var_46_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_46_0, arg_46_0.blurPanel, arg_46_0.blurPanelParent)
	end

	if arg_46_0.renamePanel then
		local var_46_1 = arg_46_0.renamePanel

		var_1.Destroy(var_46_1)

		arg_46_0.renamePanel = nil
	end

	return
end

function var_0_1.Blur(arg_47_0)
	if arg_47_0.isOnAddition or arg_47_0.isOnSkill or arg_47_0.isOnOther then
		arg_47_0.isBlur = true
		pg = var_1

		local var_47_0 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_47_0, arg_47_0.blurPanel)
	else
		arg_47_0.isBlur = false
		pg = var_1

		local var_47_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_47_1, arg_47_0.blurPanel, arg_47_0.blurPanelParent)
	end

	return
end

return var_0_1
