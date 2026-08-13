class = var_0_10000

local var_0_0 = "MetaSkillDetailBoxLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaSkillDetailBoxUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:updateShipDetail()
	arg_3_0:updateSkillList()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initUITextTips(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "Window/top/bg/infomation/title")
	local var_5_2 = arg_5_0._tf
	local var_5_3 = var_2.Find(var_5_2, "Window/MetaSkillDetailBox/ExpDetail/ExpTipText")
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_3.Find(var_5_4, "Window/MetaSkillDetailBox/TipText")

	setText = var_5_4

	local var_5_6 = var_5_1

	i18n = var_1_10006

	var_5_4(var_5_6, var_1_10006("battle_end_subtitle2"))

	setText = var_5_4

	local var_5_7 = var_5_3

	i18n = var_6

	var_5_4(var_5_7, var_6("meta_skill_dailyexp"))

	setText = var_5_4

	local var_5_8 = var_5_5

	i18n = var_6

	var_5_4(var_5_8, var_6("meta_skill_learn"))

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002
	arg_6_0.metaProxy = var_1_10001(var_1_10002)
	arg_6_0.metaShipID = arg_6_0.contextData.metaShipID

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0.window = var_1.Find(var_7_1, "Window")

	local var_7_2 = arg_7_0.window

	arg_7_0.closeBtn = var_1.Find(var_7_2, "top/btnBack")

	local var_7_3 = arg_7_0.window

	arg_7_0.panel = var_1.Find(var_7_3, "MetaSkillDetailBox")

	local var_7_4 = arg_7_0.panel

	arg_7_0.skillTpl = var_1.Find(var_7_4, "SkillTpl")

	local var_7_5 = arg_7_0.panel

	arg_7_0.expDetailTF = var_1.Find(var_7_5, "ExpDetail")

	local var_7_6 = arg_7_0.expDetailTF

	arg_7_0.shipIcon = var_1.Find(var_7_6, "IconTpl/Icon")

	local var_7_7 = arg_7_0.expDetailTF

	arg_7_0.shipNameText = var_1.Find(var_7_7, "NameMask/Name")

	local var_7_8 = arg_7_0.expDetailTF

	arg_7_0.expProgressText = var_1.Find(var_7_8, "ExpProgressText")

	local var_7_9 = arg_7_0.panel

	arg_7_0.skillContainer = var_1.Find(var_7_9, "ScrollView/Content")
	UIItemList = var_1
	arg_7_0.skillUIItemList = var_1.New(arg_7_0.skillContainer, arg_7_0.skillTpl)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.closeBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	return
end

function var_0_1.updateSkillTF(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("frame")
	local var_11_1 = arg_11_1:Find("check_mark")
	local var_11_2 = var_11_0:Find("skillInfo")
	local var_11_3 = var_11_0:Find("mask")
	local var_11_4 = var_11_0:Find("Slider")
	local var_11_5 = var_11_2:Find("icon")
	local var_11_6 = var_11_2:Find("ExpProgressText")
	local var_11_7 = var_11_2:Find("name_contain/name")
	local var_11_8 = var_11_2:Find("name_contain/level_contain/Text")
	local var_11_9 = var_11_0:Find("Tag/learing")
	local var_11_10 = var_11_0
	local var_11_11 = var_11_0.Find(var_11_10, "Tag/unlockable")

	getProxy = var_11_10
	BayProxy = var_15

	local var_11_12 = var_11_10(var_15)
	local var_11_13 = var_14.getShipById(var_11_12, arg_11_0.metaShipID)
	local var_11_14 = var_14.getMetaSkillLevelBySkillID(var_11_13, arg_11_2)

	getSkillConfig = var_11_13

	local var_11_15 = var_11_13(arg_11_2)

	setImageSprite = var_17

	local var_11_16 = var_11_5

	LoadSprite = var_1_10019

	var_17(var_11_16, var_1_10019("skillicon/" .. var_11_15.icon))

	setText = var_17

	local var_11_17 = var_11_7

	shortenString = var_19
	getSkillName = var_20

	var_17(var_11_17, var_19(var_20(var_11_15.id), 8))

	setText = var_17

	var_17(var_11_8, var_11_14)

	local var_11_18 = arg_11_0.metaProxy
	local var_11_19 = arg_11_2 == var_17.getMetaTacticsInfoByShipID(var_11_18, arg_11_0.metaShipID).curSkillID
	local var_11_20 = var_11_14 > 0
	local var_11_21 = var_14:isSkillLevelMax(arg_11_2)
	local var_11_22 = var_17
	local var_11_23 = var_17.getSkillExp(var_11_22, arg_11_2)

	pg = var_11_22

	if not (var_11_14 >= var_11_22.skill_data_template[arg_11_2].max_level) then
		if var_11_20 then
			MetaCharacterConst = var_1_10024

			local var_11_24 = var_1_10024.getMetaSkillTacticsConfig(arg_11_2, var_11_14).need_exp

			setText = var_26

			var_26(var_11_6, var_11_23 .. "/" .. var_11_24)

			setSlider = var_26

			var_26(var_11_4, 0, var_11_24, var_11_23)

			setActive = var_26

			var_26(var_11_6, true)

			setActive = var_26

			var_26(var_11_4, true)
		else
			setActive = var_1_10024

			var_1_10024(var_11_6, false)

			setActive = var_1_10024

			var_1_10024(var_11_4, false)
		end
	else
		setText = var_1_10024

		var_1_10024(var_11_6, var_11_23 .. "/Max")

		setSlider = var_1_10024

		var_1_10024(var_11_4, 0, 1, 1)

		setActive = var_1_10024

		var_1_10024(var_11_6, true)

		setActive = var_1_10024

		var_1_10024(var_11_4, true)
	end

	setActive = var_1_10024

	var_1_10024(var_11_1, var_11_19 and not var_11_21)

	setActive = var_1_10024

	var_1_10024(var_11_9, var_11_19 and not var_11_21)

	setActive = var_1_10024

	var_1_10024(var_11_11, not var_11_20)

	setActive = var_1_10024

	var_1_10024(var_11_3, not var_11_20)

	onToggle = var_1_10024

	local var_11_25 = arg_11_0
	local var_11_26 = arg_11_1

	local function var_11_27(arg_12_0)
		if arg_12_0 then
			if not var_11_20 then
				pg = var_1

				local var_12_0 = var_1.MsgboxMgr.GetInstance()
				local var_12_1 = var_1.ShowMsgBox

				var_2_10003 = {
					hideYes = true,
					hideNo = true
				}
				MSGBOX_TYPE_META_SKILL_UNLOCK = var_2_10004
				var_2_10003.type = var_2_10004
				var_2_10003.metaShipVO = var_0
				var_2_10003.skillID = arg_11_2

				var_12_1(var_12_0, var_2_10003)
			elseif not var_11_19 and not var_11_21 then
				pg = var_1

				local var_12_2 = var_1.MsgboxMgr.GetInstance()
				local var_12_3 = var_1.ShowMsgBox

				var_2_10003 = {}
				i18n = var_2_10004

				local var_12_4 = "meta_switch_skill_box_title"

				getSkillName = var_2_10006
				var_2_10003.content = var_2_10004(var_12_4, var_2_10006(arg_11_2))

				function var_2_10003.onYes()
					pg = var_3_10000

					local var_13_0 = var_3_10000.m02
					local var_13_1 = var_0.sendNotification

					GAME = var_3_10002

					var_13_1(var_13_0, var_3_10002.TACTICS_META_SWITCH_SKILL, {
						shipID = arg_11_0.metaShipID,
						skillID = arg_11_2
					})

					return
				end

				var_12_3(var_12_2, var_2_10003)
			elseif var_11_21 then
				pg = var_1

				local var_12_5 = var_1.TipsMgr.GetInstance()
				local var_12_6 = var_1.ShowTips

				i18n = var_2_10003

				var_12_6(var_12_5, var_2_10003("meta_skill_maxtip2"))
			end
		end

		return
	end

	SFX_PANEL = var_1_10028

	var_1_10024(var_11_25, var_11_26, var_11_27, var_1_10028)

	return
end

function var_0_1.updateSkillList(arg_14_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1 = var_1.getShipById(var_14_0, arg_14_0.metaShipID)

	MetaCharacterConst = var_14_0

	local var_14_2 = var_14_0.getTacticsSkillIDListByShipConfigID(var_14_1.configId)
	local var_14_3 = arg_14_0.skillUIItemList

	var_3.make(var_14_3, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			arg_15_1 = arg_15_1 + 1

			local var_15_0 = var_14_2[arg_15_1]
			local var_15_1 = arg_14_0

			var_4.updateSkillTF(var_15_1, arg_15_2, var_15_0)
		end

		return
	end)

	local var_14_4 = arg_14_0.skillUIItemList

	var_3.align(var_14_4, #var_14_2)

	return
end

function var_0_1.updateShipDetail(arg_16_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.getShipById(var_16_0, arg_16_0.metaShipID)
	local var_16_2 = var_1.getPainting(var_16_1)
	local var_16_3 = "SquareIcon/" .. var_16_2

	setImageSprite = var_4

	local var_16_4 = arg_16_0.shipIcon

	LoadSprite = var_1_10006

	var_4(var_16_4, var_1_10006(var_16_3, var_16_2))

	setScrollText = var_4

	var_4(arg_16_0.shipNameText, var_1:getName())

	local var_16_5 = arg_16_0.metaProxy
	local var_16_6 = var_4.getMetaTacticsInfoByShipID(var_16_5, arg_16_0.metaShipID).curDayExp

	setColorStr = var_6

	local var_16_7 = var_6(var_16_6, "#FFF152FF")
	local var_16_8 = "/"

	pg = var_8

	local var_16_9 = var_16_7 .. var_16_8 .. var_8.gameset.meta_skill_exp_max.key_value

	setText = var_16_8

	var_16_8(arg_16_0.expProgressText, var_16_9)

	return
end

return var_0_1
