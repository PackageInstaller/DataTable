class = var_0_10000

local var_0_0 = "NavalTacticsMetaSkillsView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NavalTacticsMetaSkillsPanel"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initUITip()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateSkillList()

	triggerToggle = var_1

	var_1(arg_2_0.skillToggleList[1], true)
	arg_2_0:Show()

	return
end

function var_0_1.Show(arg_3_0)
	var_0_1.super.Show(arg_3_0)

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.Hide(arg_4_0)
	var_0_1.super.Hide(arg_4_0)

	pg = var_1

	local var_4_0 = var_1.UIMgr.GetInstance()
	local var_4_1 = var_1.UnOverlayPanel
	local var_4_2 = arg_4_0._tf

	pg = var_1_10005

	var_4_1(var_4_0, var_4_2, var_1_10005.UIMgr.GetInstance().UIMain)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	arg_5_0:Hide()

	return
end

function var_0_1.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.metaShipID = arg_6_1 or arg_6_0.metaShipID
	getProxy = var_3
	BayProxy = var_1_10005

	local var_6_0 = var_3(var_1_10005)

	arg_6_0.metaShipVO = var_3.getShipById(var_6_0, arg_6_0.metaShipID)
	arg_6_0.closeCB = arg_6_2 or arg_6_0.closeCB
	getProxy = var_3
	MetaCharacterProxy = var_6_0
	arg_6_0.metaProxy = var_3(var_6_0)

	local var_6_1 = arg_6_0.metaProxy

	arg_6_0.metaTacticsInfo = var_3.getMetaTacticsInfoByShipID(var_6_1, arg_6_0.metaShipVO.id)

	local var_6_2

	if not arg_6_0.selectSkillID then
		var_6_2 = nil
	end

	arg_6_0.selectSkillID = var_6_2

	return
end

function var_0_1.initUITip(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_1.Find(var_7_0, "frame/bg/title_bg/title")
	local var_7_2 = arg_7_0._tf
	local var_7_3 = var_2.Find(var_7_2, "frame/buttons/detail_btn/Image")
	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_3.Find(var_7_4, "frame/buttons/unlock_btn/Image")
	local var_7_6 = arg_7_0._tf
	local var_7_7 = var_4.Find(var_7_6, "frame/buttons/switch_btn/Image")

	setText = var_7_4

	local var_7_8 = var_7_3

	i18n = var_1_10008

	var_7_4(var_7_8, var_1_10008("meta_tactics_detail"))

	setText = var_7_4

	local var_7_9 = var_7_5

	i18n = var_8

	var_7_4(var_7_9, var_8("meta_tactics_unlock"))

	setText = var_7_4

	local var_7_10 = var_7_7

	i18n = var_8

	var_7_4(var_7_10, var_8("meta_tactics_switch"))

	return
end

function var_0_1.initUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.bg = var_1.Find(var_8_0, "print")

	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_1.Find(var_8_1, "frame")

	arg_8_0.skillTpl = var_1.Find(var_8_2, "skilltpl")
	arg_8_0.skillContainer = var_1:Find("skill_contain/content")

	local var_8_3 = var_1:Find("buttons")

	arg_8_0.detailBtn = var_2.Find(var_8_3, "detail_btn")
	arg_8_0.unlockBtn = var_2:Find("unlock_btn")
	arg_8_0.switchBtn = var_2:Find("switch_btn")
	UIItemList = var_3
	arg_8_0.skillUIItemList = var_3.New(arg_8_0.skillContainer, arg_8_0.skillTpl)

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.bg

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.Hide(var_10_0)

		if arg_9_0.closeCB then
			arg_9_0.closeCB()
		else
			local var_10_1 = arg_9_0

			var_0.Destroy(var_10_1)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10006)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.detailBtn

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.m02
		local var_11_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_11_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_11_1(var_11_0, var_11_2, var_2_10004.METACHARACTER, {
			autoOpenTactics = true,
			autoOpenShipConfigID = arg_9_0.metaShipVO.configId
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10006)

	onButton = var_1_10001

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.unlockBtn

	local function var_9_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {
			hideYes = true,
			hideNo = true
		}

		MSGBOX_TYPE_META_SKILL_UNLOCK = var_2_10004
		var_12_2.type = var_2_10004
		var_12_2.metaShipVO = arg_9_0.metaShipVO
		var_12_2.skillID = arg_9_0.selectSkillID

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_6, var_9_7, var_9_8, var_1_10006)

	onButton = var_1_10001

	local var_9_9 = arg_9_0
	local var_9_10 = arg_9_0.switchBtn

	local function var_9_11()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10003

		var_13_1(var_13_0, var_2_10003.TACTICS_META_SWITCH_SKILL, {
			shipID = arg_9_0.metaShipVO.id,
			skillID = arg_9_0.selectSkillID
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_9_9, var_9_10, var_9_11, var_1_10006)

	return
end

function var_0_1.updateSkillTF(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("frame")
	local var_14_1 = var_3.Find(var_14_0, "skillInfo")
	local var_14_2 = var_3:Find("empty")
	local var_14_3 = var_3:Find("mask")
	local var_14_4 = var_14_1:Find("icon")
	local var_14_5 = var_14_1:Find("descView/Viewport/desc")
	local var_14_6 = var_14_1:Find("next_contain/label")
	local var_14_7 = var_14_1:Find("next_contain/Text")
	local var_14_8 = var_14_1:Find("name_contain/name")
	local var_14_9 = var_14_1:Find("name_contain/level_contain/Text")
	local var_14_10 = var_3:Find("Tag/learing")
	local var_14_11 = var_3
	local var_14_12 = var_3.Find(var_14_11, "Tag/unlockable")
	local var_14_13 = arg_14_0.metaShipVO
	local var_14_14 = var_15.getMetaSkillLevelBySkillID(var_14_13, arg_14_2)

	getSkillConfig = var_14_11

	local var_14_15 = var_14_11(arg_14_2)
	local var_14_16 = arg_14_2 == arg_14_0.metaTacticsInfo.curSkillID
	local var_14_17 = var_14_14 > 0

	setImageSprite = var_1_10019

	local var_14_18 = var_14_4

	LoadSprite = var_1_10022

	var_1_10019(var_14_18, var_1_10022("skillicon/" .. var_14_15.icon))

	setText = var_1_10019

	local var_14_19 = var_14_5

	getSkillDesc = var_22

	var_1_10019(var_14_19, var_22(arg_14_2, var_14_17 and var_14_14 or 1))

	setText = var_1_10019

	local var_14_20 = var_14_8

	getSkillName = var_22

	var_1_10019(var_14_20, var_22(var_14_15.id))

	setText = var_1_10019

	var_1_10019(var_14_9, var_14_14)

	local var_14_21 = arg_14_0.metaTacticsInfo
	local var_14_22 = var_19.getSkillExp(var_14_21, arg_14_2)

	pg = var_1_10020

	if not (var_14_14 >= var_1_10020.skill_data_template[arg_14_2].max_level) then
		if var_14_17 then
			MetaCharacterConst = var_22

			local var_14_23 = var_22.getMetaSkillTacticsConfig(arg_14_2, var_14_14).need_exp

			setText = var_24

			local var_14_24 = var_14_7

			setColorStr = var_1_10027

			local var_14_25 = var_14_22

			COLOR_GREEN = var_1_10030

			var_24(var_14_24, var_1_10027(var_14_25, var_1_10030) .. "/" .. var_14_23)

			setActive = var_24

			var_24(var_14_6, true)

			setActive = var_24

			var_24(var_14_7, true)
		else
			setActive = var_22

			var_22(var_14_6, false)

			setActive = var_22

			var_22(var_14_7, false)
		end
	else
		setText = var_22

		var_22(var_14_7, "Max")
	end

	setActive = var_22

	var_22(var_14_10, var_14_16 and not var_21)

	setActive = var_22

	var_22(var_14_12, not var_14_17)

	setActive = var_22

	var_22(var_14_3, not var_14_17)

	onToggle = var_22

	local var_14_26 = arg_14_0
	local var_14_27 = arg_14_1

	local function var_14_28(arg_15_0)
		if arg_15_0 then
			arg_14_0.selectSkillID = arg_14_2

			local var_15_0 = arg_14_0

			var_1.updateButtons(var_15_0, arg_14_0.selectSkillID)
		end

		return
	end

	SFX_PANEL = var_1_10027

	var_22(var_14_26, var_14_27, var_14_28, var_1_10027)

	return
end

function var_0_1.updateSkillList(arg_16_0)
	MetaCharacterConst = var_1_10001

	local var_16_0 = var_1_10001.getTacticsSkillIDListByShipConfigID(arg_16_0.metaShipVO.configId)
	local var_16_1 = arg_16_0.skillUIItemList

	var_2.make(var_16_1, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			arg_17_1 = arg_17_1 + 1

			local var_17_0 = arg_16_0
			local var_17_1

			if not arg_16_0.skillToggleList then
				var_17_1 = {}
			end

			var_17_0.skillToggleList = var_17_1
			arg_16_0.skillToggleList[arg_17_1] = arg_17_2

			local var_17_2 = var_16_0[arg_17_1]
			local var_17_3 = arg_16_0

			var_4.updateSkillTF(var_17_3, arg_17_2, var_17_2)
		end

		return
	end)

	local var_16_2 = arg_16_0.skillUIItemList

	var_2.align(var_16_2, #var_16_0)

	return
end

function var_0_1.updateButtons(arg_18_0, arg_18_1)
	local var_18_0 = (arg_18_1 or arg_18_0.selectSkillID) == arg_18_0.metaTacticsInfo.curSkillID
	local var_18_1 = arg_18_0.metaShipVO
	local var_18_2 = var_4.getMetaSkillLevelBySkillID(var_18_1, var_2) > 0
	local var_18_3 = arg_18_0.metaShipVO
	local var_18_4 = var_5.isSkillLevelMax(var_18_3, var_2)

	if var_18_0 or var_18_4 then
		setActive = var_18_1

		var_18_1(arg_18_0.detailBtn, true)

		setActive = var_18_1

		var_18_1(arg_18_0.unlockBtn, false)

		setActive = var_18_1

		var_18_1(arg_18_0.switchBtn, false)
	elseif not var_18_2 then
		setActive = var_18_1

		var_18_1(arg_18_0.detailBtn, true)

		setActive = var_18_1

		var_18_1(arg_18_0.unlockBtn, true)

		setActive = var_18_1

		var_18_1(arg_18_0.switchBtn, false)
	elseif var_18_2 and not var_18_0 then
		setActive = var_18_1

		var_18_1(arg_18_0.detailBtn, true)

		setActive = var_18_1

		var_18_1(arg_18_0.unlockBtn, false)

		setActive = var_18_1

		var_18_1(arg_18_0.switchBtn, true)
	end

	return
end

function var_0_1.reUpdate(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:setData(arg_19_1, arg_19_2)
	arg_19_0:updateSkillList()
	arg_19_0:updateButtons()

	return
end

return var_0_1
