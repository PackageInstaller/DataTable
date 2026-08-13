class = var_0_10000

local var_0_0 = "IdolTrainPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))
local var_0_2 = {
	"dafeng_idol",
	"tashigan_idol",
	"daiduo_idol",
	"daqinghuayu_idol",
	"baerdimo_idol",
	"luoen_idol",
	"guanghui_idol",
	"edu_idol"
}

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.skills = var_1.Find(var_1_0, "skill")
	arg_1_0.skillBtns = {}
	eachChild = var_1

	var_1(arg_1_0.skills, function(arg_2_0)
		table = var_2_10001

		var_2_10001.insert(arg_1_0.skillBtns, arg_2_0)

		return
	end)

	local var_1_1 = arg_1_0.bg

	arg_1_0.getGreyBtn = var_1.Find(var_1_1, "get_grey_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_2, "help_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.idol1 = var_1.Find(var_1_3, "idol1")

	local var_1_4 = arg_1_0.bg

	arg_1_0.idol2 = var_1.Find(var_1_4, "idol2")

	local var_1_5 = arg_1_0._tf

	arg_1_0.buffInfoBox = var_1.Find(var_1_5, "BuffInfoBox")

	local var_1_6 = arg_1_0.buffInfoBox

	arg_1_0.mask = var_1.Find(var_1_6, "mengban")

	local var_1_7 = arg_1_0.buffInfoBox

	arg_1_0.buffWindow = var_1.Find(var_1_7, "panel")

	local var_1_8 = arg_1_0.buffWindow

	arg_1_0.buffName = var_1.Find(var_1_8, "title/name")

	local var_1_9 = arg_1_0.buffWindow

	arg_1_0.titleLv = var_1.Find(var_1_9, "title/lv")

	local var_1_10 = arg_1_0.buffWindow

	arg_1_0.titleIcon = var_1.Find(var_1_10, "title/icon")

	local var_1_11 = arg_1_0.buffWindow

	arg_1_0.buffTip = var_1.Find(var_1_11, "content/tip")

	local var_1_12 = arg_1_0.buffWindow

	arg_1_0.desc = var_1.Find(var_1_12, "content/desc")

	local var_1_13 = arg_1_0.buffWindow

	arg_1_0.buffAwardTF = var_1.Find(var_1_13, "award_bg/award")

	local var_1_14 = arg_1_0._tf

	arg_1_0.trainWindow = var_1.Find(var_1_14, "IdolTrainWindow")

	local var_1_15 = arg_1_0.trainWindow

	arg_1_0.trainTitle = var_1.Find(var_1_15, "panel/title/Text")

	local var_1_16 = arg_1_0.trainWindow

	arg_1_0.trainBtn = var_1.Find(var_1_16, "panel/train_btn")

	local var_1_17 = arg_1_0.trainWindow

	arg_1_0.trainSkills = var_1.Find(var_1_17, "panel/skills")
	arg_1_0.trainSkillBtns = {}
	eachChild = var_1

	var_1(arg_1_0.trainSkills, function(arg_3_0)
		table = var_2_10001

		var_2_10001.insert(arg_1_0.trainSkillBtns, arg_3_0)

		return
	end)

	local var_1_18 = arg_1_0.trainWindow

	arg_1_0.info = var_1.Find(var_1_18, "panel/info")

	local var_1_19 = arg_1_0.info

	arg_1_0.curBuff = var_1.Find(var_1_19, "preview/current")

	local var_1_20 = arg_1_0.info

	arg_1_0.nextBuff = var_1.Find(var_1_20, "preview/next")

	local var_1_21 = arg_1_0._tf

	arg_1_0.msgBox = var_1.Find(var_1_21, "MsgBox")

	local var_1_22 = arg_1_0.msgBox

	arg_1_0.msgIcon = var_1.Find(var_1_22, "panel/title/icon")

	local var_1_23 = arg_1_0.msgBox

	arg_1_0.msgContent = var_1.Find(var_1_23, "panel/content")

	local var_1_24 = arg_1_0.msgBox

	arg_1_0.msgBoxMask = var_1.Find(var_1_24, "mengban")

	local var_1_25 = arg_1_0.msgBox

	arg_1_0.cancelBtn = var_1.Find(var_1_25, "panel/cancel_btn")

	local var_1_26 = arg_1_0.msgBox

	arg_1_0.confirmBtn = var_1.Find(var_1_26, "panel/confirm_btn")

	local var_1_27 = arg_1_0._tf

	arg_1_0.tipPanel = var_1.Find(var_1_27, "Tip")

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	var_0_1.super.OnFirstFlush(arg_4_0)

	removeOnButton = var_1

	var_1(arg_4_0.getBtn)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getBtn

	local function var_4_2()
		local var_5_0 = {}
		local var_5_1 = arg_4_0.ptData
		local var_5_2 = var_1.GetAward(var_5_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_5_3 = var_2_10002(var_2_10004)
		local var_5_4 = var_2.getData(var_5_3)
		local var_5_5 = var_5_2.type

		DROP_TYPE_RESOURCE = var_5_3

		if var_5_5 == var_5_3 then
			var_5_5 = var_5_2.id
			PlayerConst = var_5_3

			if var_5_5 == var_5_3.ResGold and var_5_4:GoldMax(var_5_2.count) then
				table = var_5_5

				var_5_5.insert(var_5_0, function(arg_6_0)
					pg = var_3_10001

					local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_6_1 = var_1.ShowMsgBox
					local var_6_2 = {}

					i18n = var_3_10005

					local var_6_3 = var_3_10005("gold_max_tip_title")

					i18n = var_3_10006
					var_6_2.content = var_6_3 .. var_3_10006("award_max_warning")
					var_6_2.onYes = arg_6_0

					var_6_1(var_6_0, var_6_2)

					return
				end)
			end
		end

		seriesAsync = var_5_5

		var_5_5(var_5_0, function()
			local var_7_0 = arg_4_0.ptData
			local var_7_1, var_7_2 = var_0.GetResProgress(var_7_0)
			local var_7_3 = arg_4_0
			local var_7_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_7_5 = var_3_10005.EVENT_PT_OPERATION
			local var_7_6 = {
				cmd = 1
			}
			local var_7_7 = arg_4_0.ptData

			var_7_6.activity_id = var_7.GetId(var_7_7)
			var_7_6.arg1 = var_7_2

			var_7_4(var_7_3, var_7_5, var_7_6)

			local var_7_8 = arg_4_0.ptData

			if var_2.CanTrain(var_7_8) then
				local var_7_9 = arg_4_0

				var_2.showTrianPanel(var_7_9)
			end

			local var_7_10 = arg_4_0

			var_2.playIdolAni(var_7_10)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	removeOnButton = var_1

	var_1(arg_4_0.battleBtn)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.battleBtn

	local function var_4_5()
		local var_8_0
		local var_8_1
		local var_8_2 = arg_4_0.activity

		if var_2.getConfig(var_8_2, "config_client") ~= "" then
			local var_8_3 = arg_4_0.activity

			if var_3.getConfig(var_8_3, "config_client").linkActID then
				getProxy = var_3
				ActivityProxy = var_8_3

				local var_8_4 = var_3(var_8_3)

				var_8_1 = var_3.getActivityById(var_8_4, var_8_0)
			end
		end

		if not var_8_0 then
			local var_8_5 = arg_4_0
			local var_8_6 = var_3.emit

			ActivityMediator = var_2_10006

			var_8_6(var_8_5, var_2_10006.BATTLE_OPERA)
		elseif var_8_1 and not var_8_1:isEnd() then
			local var_8_7 = arg_4_0
			local var_8_8 = var_3.emit

			ActivityMediator = var_2_10006

			var_8_8(var_8_7, var_2_10006.BATTLE_OPERA)
		else
			local var_8_9 = arg_4_0
			local var_8_10 = var_3.showTip

			i18n = var_2_10006

			var_8_10(var_8_9, var_2_10006("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)
	arg_4_0:hideBuffInfoBox()

	onButton = var_1

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.mask

	local function var_4_8()
		local var_9_0 = arg_4_0

		var_0.hideBuffInfoBox(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_6, var_4_7, var_4_8, var_1_10006)

	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.skillBtns) do
		onButton = var_1_10006

		local var_4_9 = arg_4_0
		local var_4_10 = iter_4_1

		local function var_4_11()
			ipairs = var_2_10000

			local var_10_0 = arg_4_0.ptData

			for iter_10_0, iter_10_1 in var_2_10000(var_2.GetCurBuffInfos(var_10_0)) do
				if iter_4_0 == iter_10_1.group then
					local var_10_1 = arg_4_0

					var_5.showBuffInfoBox(var_10_1, iter_10_1)
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_4_9, var_4_10, var_4_11, var_1_10011)
	end

	local var_4_12 = arg_4_0
	local var_4_13, var_4_14 = arg_4_0.getRandomName(var_4_12)

	pg = var_4_12

	local var_4_15 = var_4_12.UIMgr.GetInstance()

	var_3.LoadingOn(var_4_15)

	PoolMgr = var_3

	local var_4_16 = var_3.GetInstance()

	var_3.GetSpineChar(var_4_16, var_4_13, true, function(arg_11_0)
		pg = var_2_10001

		local var_11_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_11_0)

		arg_4_0.prefab1 = var_4_13

		local var_11_1 = arg_4_0

		var_11_1.model1 = arg_11_0
		tf = var_11_1

		local var_11_2 = var_11_1(arg_11_0)

		Vector3 = var_2
		var_11_2.localScale = var_2(1, 1, 1)

		local var_11_3 = arg_11_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_11_3, "stand2", 0)

		setParent = var_1

		var_1(arg_11_0, arg_4_0.idol1)

		return
	end)

	pg = var_3

	local var_4_17 = var_3.UIMgr.GetInstance()

	var_3.LoadingOn(var_4_17)

	PoolMgr = var_3

	local var_4_18 = var_3.GetInstance()

	var_3.GetSpineChar(var_4_18, var_4_14, true, function(arg_12_0)
		pg = var_2_10001

		local var_12_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_12_0)

		arg_4_0.prefab2 = var_4_14

		local var_12_1 = arg_4_0

		var_12_1.model2 = arg_12_0
		tf = var_12_1

		local var_12_2 = var_12_1(arg_12_0)

		Vector3 = var_2
		var_12_2.localScale = var_2(1, 1, 1)

		local var_12_3 = arg_12_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_12_3, "stand2", 0)

		setParent = var_1

		var_1(arg_12_0, arg_4_0.idol2)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_13_0)
	local var_13_0 = arg_13_0.ptData

	if var_1.CanTrain(var_13_0) and var_1 <= arg_13_0.ptData.level then
		arg_13_0:showTrianPanel()
	end

	local var_13_1 = arg_13_0.ptData
	local var_13_2, var_13_3, var_13_4 = var_2.GetLevelProgress(var_13_1)
	local var_13_5 = arg_13_0.ptData
	local var_13_6, var_13_7, var_13_8 = var_5.GetResProgress(var_13_5)

	setText = var_1_10008

	local var_13_9 = arg_13_0.step

	setColorStr = var_1_10011

	local var_13_10 = "PHASE  " .. var_13_2 .. "/"

	COLOR_WHITE = var_14

	var_1_10008(var_13_9, var_1_10011(var_13_10, var_14) .. var_13_3)

	setText = var_1_10008

	local var_13_11 = arg_13_0.progress

	if 1 <= var_13_8 then
		setColorStr = var_11

		local var_13_12 = var_13_6 .. "/"

		COLOR_WHITE = var_14

		local var_13_13

		if not var_11(var_13_12, var_14) then
			var_13_13 = var_13_6 .. "/"
		end

		var_1_10008(var_13_11, var_13_13 .. var_13_7)

		setSlider = var_1_10008

		var_1_10008(arg_13_0.slider, 0, 1, var_13_8)

		local var_13_14 = arg_13_0.ptData
		local var_13_15 = var_8.CanGetAward(var_13_14)
		local var_13_16 = arg_13_0.ptData
		local var_13_17 = var_9.CanGetNextAward(var_13_16)
		local var_13_18 = arg_13_0.ptData
		local var_13_19 = var_10.CanGetMorePt(var_13_18)
		local var_13_20 = arg_13_0.ptData
		local var_13_21 = var_11.CanTrain(var_13_20)

		setActive = var_13_18

		var_13_18(arg_13_0.battleBtn, var_13_19 and not var_13_15 and var_13_17)

		setActive = var_13_18

		var_13_18(arg_13_0.getBtn, var_13_15)

		setActive = var_13_18

		var_13_18(arg_13_0.getGreyBtn, not var_13_15)

		setActive = var_13_18

		var_13_18(arg_13_0.gotBtn, not var_13_17 and not var_13_21)

		local var_13_22 = arg_13_0.ptData
		local var_13_23 = var_12.GetAward(var_13_22)

		updateDrop = var_13_20

		var_13_20(arg_13_0.awardTF, var_13_23)

		onButton = var_13_20

		local var_13_24 = arg_13_0
		local var_13_25 = arg_13_0.awardTF

		local function var_13_26()
			local var_14_0 = arg_13_0
			local var_14_1 = var_0.emit

			BaseUI = var_2_10003

			var_14_1(var_14_0, var_2_10003.ON_DROP, var_13_23)

			return
		end

		SFX_PANEL = var_1_10018

		var_13_20(var_13_24, var_13_25, var_13_26, var_1_10018)

		ipairs = var_13_20

		local var_13_27 = arg_13_0.ptData

		for iter_13_0, iter_13_1 in var_13_20(var_15.GetCurBuffInfos(var_13_27)) do
			setActive = var_1_10018

			local var_13_28 = arg_13_0.skillBtns[iter_13_1.group]

			var_1_10018(var_20.Find(var_13_28, "lv1"), false)

			setActive = var_1_10018

			local var_13_29 = arg_13_0.skillBtns[iter_13_1.group]

			var_1_10018(var_20.Find(var_13_29, "lv2"), false)

			setActive = var_1_10018

			local var_13_30 = arg_13_0.skillBtns[iter_13_1.group]

			var_1_10018(var_20.Find(var_13_30, "lv3"), false)

			if iter_13_1.next then
				setActive = var_1_10018

				local var_13_31 = arg_13_0.skillBtns[iter_13_1.group]

				var_1_10018(var_20.Find(var_13_31, "lv" .. iter_13_1.lv), true)
			else
				setActive = var_1_10018

				local var_13_32 = arg_13_0.skillBtns[iter_13_1.group]

				var_1_10018(var_20.Find(var_13_32, "lv3"), true)
			end

			pg = var_1_10018
			var_1_10018 = var_1_10018.benefit_buff_template[iter_13_1.id].icon
			setImageSprite = var_19

			local var_13_33 = arg_13_0.skillBtns[iter_13_1.group]
			local var_13_34 = var_21.Find(var_13_33, "icon")

			LoadSprite = var_22

			var_19(var_13_34, var_22(var_1_10018))
		end

		onButton = var_13

		local var_13_35 = arg_13_0
		local var_13_36 = arg_13_0.helpBtn

		local function var_13_37()
			pg = var_2_10000

			local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_15_1 = var_0.ShowMsgBox
			local var_15_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_15_2.type = var_2_10004
			i18n = var_2_10004
			var_15_2.helps = var_2_10004("practise_idol_help")

			var_15_1(var_15_0, var_15_2)

			return
		end

		SFX_PANEL = var_1_10018

		var_13(var_13_35, var_13_36, var_13_37, var_1_10018)

		return
	end
end

function var_0_1.showTrianPanel(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0.trainWindow, true)

	setText = var_1_10001

	local var_16_0 = arg_16_0.trainTitle

	i18n = var_4

	var_1_10001(var_16_0, var_4("upgrade_idol_tip"))

	local var_16_1 = arg_16_0.ptData
	local var_16_2 = var_1.GetCurBuffInfos(var_16_1)

	arg_16_0.selectIndex = nil
	arg_16_0.selectBuffId = nil
	arg_16_0.selectBuffLv = nil
	arg_16_0.selectNewBuffId = nil
	ipairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_0.trainSkillBtns) do
		onButton = var_1_10007

		local var_16_3 = arg_16_0
		local var_16_4 = iter_16_1

		local function var_16_5()
			ipairs = var_2_10000

			for iter_17_0, iter_17_1 in var_2_10000(var_16_2) do
				if iter_16_0 == iter_17_1.group then
					if iter_17_1.next then
						arg_16_0.selectIndex = iter_16_0
						arg_16_0.selectBuffId = iter_17_1.id
						arg_16_0.selectNewBuffId = iter_17_1.next
						arg_16_0.selectBuffLv = iter_17_1.lv
					else
						arg_16_0.selectIndex = nil
						arg_16_0.selectBuffId = nil
						arg_16_0.selectNewBuffId = nil
						arg_16_0.selectBuffLv = nil
					end
				end
			end

			local var_17_0 = arg_16_0

			var_0.flushTrainPanel(var_17_0)

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_16_3, var_16_4, var_16_5, var_1_10012)
	end

	onButton = var_2

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.trainBtn

	local function var_16_8()
		local var_18_0 = arg_16_0

		var_0.showMsgBox(var_18_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_16_6, var_16_7, var_16_8, var_1_10007)
	arg_16_0:flushTrainPanel()

	return
end

function var_0_1.hideTrianPanel(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.trainWindow, false)

	return
end

function var_0_1.flushTrainPanel(arg_20_0)
	local var_20_0 = arg_20_0.ptData

	if var_1.GetCurBuffInfos(var_20_0) then
		ipairs = var_1_10002

		for iter_20_0, iter_20_1 in var_1_10002(var_1) do
			setActive = var_1_10007

			local var_20_1 = arg_20_0.trainSkillBtns[iter_20_1.group]

			var_1_10007(var_9.Find(var_20_1, "lv1"), false)

			setActive = var_1_10007

			local var_20_2 = arg_20_0.trainSkillBtns[iter_20_1.group]

			var_1_10007(var_9.Find(var_20_2, "lv2"), false)

			setActive = var_1_10007

			local var_20_3 = arg_20_0.trainSkillBtns[iter_20_1.group]

			var_1_10007(var_9.Find(var_20_3, "lv3"), false)

			if iter_20_1.next then
				setActive = var_1_10007

				local var_20_4 = arg_20_0.trainSkillBtns[iter_20_1.group]

				var_1_10007(var_9.Find(var_20_4, "lv" .. iter_20_1.lv), true)
			else
				setActive = var_1_10007

				local var_20_5 = arg_20_0.trainSkillBtns[iter_20_1.group]

				var_1_10007(var_9.Find(var_20_5, "lv3"), true)
			end

			pg = var_1_10007
			var_1_10007 = var_1_10007.benefit_buff_template[iter_20_1.id].icon
			setImageSprite = var_8

			local var_20_6 = arg_20_0.trainSkillBtns[iter_20_1.group]
			local var_20_7 = var_10.Find(var_20_6, "icon")

			LoadSprite = var_11

			var_8(var_20_7, var_11(var_1_10007))

			setText = var_8

			local var_20_8 = arg_20_0.trainSkillBtns[iter_20_1.group]
			local var_20_9 = var_10.Find(var_20_8, "name")

			shortenString = var_11
			pg = var_13

			var_8(var_20_9, var_11(var_13.benefit_buff_template[iter_20_1.id].name, 7))
		end
	end

	ipairs = var_1_10002

	for iter_20_2, iter_20_3 in var_1_10002(arg_20_0.trainSkillBtns) do
		if iter_20_2 == arg_20_0.selectIndex then
			setActive = var_1_10007

			var_1_10007(iter_20_3:Find("selected"), true)

			setActive = var_1_10007

			var_1_10007(iter_20_3:Find("name"), true)
		else
			setActive = var_1_10007

			var_1_10007(iter_20_3:Find("selected"), false)

			setActive = var_1_10007

			var_1_10007(iter_20_3:Find("name"), false)
		end
	end

	if arg_20_0.selectIndex then
		setActive = var_2

		var_2(arg_20_0.info, true)

		setActive = var_2

		var_2(arg_20_0.trainBtn, true)

		setText = var_2

		local var_20_10 = arg_20_0.curBuff
		local var_20_11 = "Lv."
		local var_20_12 = arg_20_0.selectBuffLv

		pg = var_1_10007

		var_2(var_20_10, var_20_11 .. var_20_12 .. var_1_10007.benefit_buff_template[arg_20_0.selectBuffId].desc)

		setText = var_2

		local var_20_13 = arg_20_0.nextBuff
		local var_20_14 = "Lv."
		local var_20_15 = arg_20_0.selectBuffLv + 1

		pg = var_7

		var_2(var_20_13, var_20_14 .. var_20_15 .. var_7.benefit_buff_template[arg_20_0.selectNewBuffId].desc)
	else
		setActive = var_2

		var_2(arg_20_0.info, false)

		setActive = var_2

		var_2(arg_20_0.trainBtn, false)
	end

	return
end

function var_0_1.showBuffInfoBox(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0 = var_1_10002.benefit_buff_template[arg_21_1.id].name

	setText = var_3

	var_3(arg_21_0.buffName, var_21_0)

	setText = var_3

	local var_21_1 = arg_21_0.desc

	pg = var_6

	var_3(var_21_1, var_6.benefit_buff_template[arg_21_1.id].desc)

	setText = var_3

	local var_21_2 = arg_21_0.buffTip

	i18n = var_6

	var_3(var_21_2, var_6("upgrade_introduce_tip", var_21_0))

	pg = var_3

	local var_21_3 = var_3.benefit_buff_template[arg_21_1.id].icon

	setImageSprite = var_4

	local var_21_4 = arg_21_0.titleIcon

	LoadSprite = var_7

	var_4(var_21_4, var_7(var_21_3))

	local var_21_5 = arg_21_1.award

	updateDrop = var_21_2

	var_21_2(arg_21_0.buffAwardTF, var_21_5)

	onButton = var_21_2

	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.buffAwardTF

	local function var_21_8()
		local var_22_0 = arg_21_0
		local var_22_1 = var_0.emit

		BaseUI = var_2_10003

		var_22_1(var_22_0, var_2_10003.ON_DROP, var_21_5)

		return
	end

	SFX_PANEL = var_1_10010

	var_21_2(var_21_6, var_21_7, var_21_8, var_1_10010)

	if arg_21_1.next then
		setText = var_5

		var_5(arg_21_0.titleLv, "Lv." .. arg_21_1.lv)

		setActive = var_5

		local var_21_9 = arg_21_0.buffAwardTF

		var_5(var_7.Find(var_21_9, "icon_bg/got_mask"), false)
	else
		setText = var_5

		var_5(arg_21_0.titleLv, "MAX")

		setActive = var_5

		local var_21_10 = arg_21_0.buffAwardTF

		var_5(var_7.Find(var_21_10, "icon_bg/got_mask"), true)

		removeOnButton = var_5

		var_5(arg_21_0.buffAwardTF)
	end

	setActive = var_5

	var_5(arg_21_0.buffInfoBox, true)

	return
end

function var_0_1.hideBuffInfoBox(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.buffInfoBox, false)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	if arg_24_0.prefab1 and arg_24_0.model1 then
		PoolMgr = var_1

		local var_24_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_24_0, arg_24_0.prefab1, arg_24_0.model1)

		arg_24_0.prefab1 = nil
		arg_24_0.model1 = nil
	end

	if arg_24_0.prefab2 and arg_24_0.model2 then
		PoolMgr = var_1

		local var_24_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_24_1, arg_24_0.prefab2, arg_24_0.model2)

		arg_24_0.prefab2 = nil
		arg_24_0.model2 = nil
	end

	return
end

function var_0_1.getRandomName(arg_25_0)
	math = var_1_10001

	local var_25_0 = var_1_10001.random(#var_0_2)
	local var_25_1

	while var_25_1 == var_25_0 or not var_25_1 do
		math = var_3
		var_25_1 = var_3.random(#var_0_2)
	end

	return var_0_2[var_25_0], var_0_2[var_25_1]
end

function var_0_1.playIdolAni(arg_26_0)
	if arg_26_0.model1 then
		local var_26_0 = arg_26_0.model1
		local var_26_1 = var_1.GetComponent(var_26_0, "SpineAnimUI")

		var_1.SetAction(var_26_1, "idol", 0)
	end

	if arg_26_0.model2 then
		local var_26_2 = arg_26_0.model2
		local var_26_3 = var_1.GetComponent(var_26_2, "SpineAnimUI")

		var_1.SetAction(var_26_3, "idol", 0)
	end

	return
end

function var_0_1.showMsgBox(arg_27_0)
	if arg_27_0.selectBuffId then
		setActive = var_1

		var_1(arg_27_0.msgBox, true)

		pg = var_1

		local var_27_0 = var_1.benefit_buff_template[arg_27_0.selectBuffId].icon

		setImageSprite = var_2

		local var_27_1 = arg_27_0.msgIcon

		LoadSprite = var_1_10005

		var_2(var_27_1, var_1_10005(var_27_0))

		pg = var_2

		local var_27_2 = var_2.benefit_buff_template[arg_27_0.selectBuffId].name

		setText = var_3

		local var_27_3 = arg_27_0.msgContent

		i18n = var_1_10006

		var_3(var_27_3, var_1_10006("practise_idol_tip", var_27_2))

		onButton = var_3

		local var_27_4 = arg_27_0
		local var_27_5 = arg_27_0.msgBoxMask

		local function var_27_6()
			local var_28_0 = arg_27_0

			var_0.hideMsgBox(var_28_0)

			return
		end

		SFX_PANEL = var_8

		var_3(var_27_4, var_27_5, var_27_6, var_8)

		onButton = var_3

		local var_27_7 = arg_27_0
		local var_27_8 = arg_27_0.cancelBtn

		local function var_27_9()
			local var_29_0 = arg_27_0

			var_0.hideMsgBox(var_29_0)

			return
		end

		SFX_PANEL = var_8

		var_3(var_27_7, var_27_8, var_27_9, var_8)

		onButton = var_3

		local var_27_10 = arg_27_0
		local var_27_11 = arg_27_0.confirmBtn

		local function var_27_12()
			local var_30_0 = arg_27_0

			var_0.hideMsgBox(var_30_0)

			local var_30_1 = arg_27_0
			local var_30_2 = var_0.emit

			ActivityMediator = var_2_10003

			local var_30_3 = var_2_10003.EVENT_PT_OPERATION
			local var_30_4 = {
				cmd = 3
			}
			local var_30_5 = arg_27_0.ptData

			var_30_4.activity_id = var_5.GetId(var_30_5)

			local var_30_6 = arg_27_0.ptData

			var_30_4.arg1 = var_5.CanTrain(var_30_6)
			var_30_4.arg2 = arg_27_0.selectNewBuffId
			var_30_4.oldBuffId = arg_27_0.selectBuffId

			var_30_2(var_30_1, var_30_3, var_30_4)

			local var_30_7 = arg_27_0

			var_0.hideTrianPanel(var_30_7)

			local var_30_8 = arg_27_0
			local var_30_9 = var_0.showTip

			i18n = var_30_3

			var_30_9(var_30_8, var_30_3("upgrade_complete_tip"))

			return
		end

		SFX_PANEL = var_8

		var_3(var_27_10, var_27_11, var_27_12, var_8)
	end

	return
end

function var_0_1.hideMsgBox(arg_31_0)
	setActive = var_1_10001

	var_1_10001(arg_31_0.msgBox, false)

	return
end

function var_0_1.showTip(arg_32_0, arg_32_1)
	cloneTplTo = var_1_10002

	local var_32_0 = var_1_10002(arg_32_0.tipPanel, arg_32_0._tf)

	setActive = var_1_10003

	var_1_10003(var_32_0, true)

	setText = var_1_10003

	var_1_10003(var_32_0:Find("Text"), arg_32_1)

	local var_32_1 = var_32_0.transform

	Vector3 = var_4
	var_32_1.localScale = var_4(0, 0.1, 1)
	LeanTween = var_32_1

	local var_32_2 = var_32_1.scale
	local var_32_3 = var_32_0

	Vector3 = var_6

	local var_32_4 = var_32_2(var_32_3, var_6(1.8, 0.1, 1), 0.1)

	var_3.setUseEstimatedTime(var_32_4, true)

	LeanTween = var_3

	local var_32_5 = var_3.scale
	local var_32_6 = var_32_0

	Vector3 = var_6

	local var_32_7 = var_32_5(var_32_6, var_6(1.1, 1.1, 1), 0.1)
	local var_32_8 = var_3.setDelay(var_32_7, 0.1)

	var_3.setUseEstimatedTime(var_32_8, true)

	GetOrAddComponent = var_3

	local var_32_9 = var_3(var_32_0, "CanvasGroup")

	Timer = var_4

	local var_32_10 = var_4.New(function()
		IsNil = var_2_10000

		if var_2_10000(var_32_0) then
			return
		end

		LeanTween = var_0

		local var_33_0 = var_0.scale
		local var_33_1 = var_32_0

		Vector3 = var_2_10003

		local var_33_2 = var_33_0(var_33_1, var_2_10003(0.1, 1.5, 1), 0.1)
		local var_33_3 = var_0.setUseEstimatedTime(var_33_2, true)
		local var_33_4 = var_0.setOnComplete

		System = var_3

		var_33_4(var_33_3, var_3.Action(function()
			LeanTween = var_3_10000

			local var_34_0 = var_3_10000.scale
			local var_34_1 = var_32_0

			Vector3 = var_3_10003

			local var_34_2 = var_34_0(var_34_1, var_3_10003.zero, 0.1)
			local var_34_3 = var_0.setUseEstimatedTime(var_34_2, true)
			local var_34_4 = var_0.setOnComplete

			System = var_3

			var_34_4(var_34_3, var_3.Action(function()
				Destroy = var_4_10000

				var_4_10000(var_32_0)

				return
			end))

			return
		end))

		return
	end, 3)

	var_4.Start(var_32_10)

	return
end

return var_0_1
