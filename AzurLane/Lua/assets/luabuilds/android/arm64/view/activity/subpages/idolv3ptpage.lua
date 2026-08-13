class = var_0_10000

local var_0_0 = "IdolV3PtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))
local var_0_2 = {
	"kewei_idol",
	"ougen_idol",
	"nengdai_idol",
	"jingang_idol",
	"lumang_idol",
	"boyixi_idol"
}

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.trainEntranceBtn = var_1.Find(var_1_0, "train_btn")

	local var_1_1 = arg_1_0.bg

	arg_1_0.skills = var_1.Find(var_1_1, "skill")
	arg_1_0.skillBtns = {}

	for iter_1_0 = 0, arg_1_0.skills.childCount - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_1_2 = arg_1_0.skillBtns
		local var_1_3 = arg_1_0.skills

		var_1_10005(var_1_2, var_8.GetChild(var_1_3, iter_1_0))
	end

	local var_1_4 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_4, "help_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.idol1 = var_1.Find(var_1_5, "idol1")

	local var_1_6 = arg_1_0._tf

	arg_1_0.buffInfoBox = var_1.Find(var_1_6, "BuffInfoBox")

	local var_1_7 = arg_1_0.buffInfoBox

	arg_1_0.mask = var_1.Find(var_1_7, "mengban")

	local var_1_8 = arg_1_0.buffInfoBox

	arg_1_0.buffWindow = var_1.Find(var_1_8, "panel")

	local var_1_9 = arg_1_0.buffWindow

	arg_1_0.buffName = var_1.Find(var_1_9, "title/name")

	local var_1_10 = arg_1_0.buffWindow

	arg_1_0.titleLv = var_1.Find(var_1_10, "title/lv")

	local var_1_11 = arg_1_0.buffWindow

	arg_1_0.titleIcon = var_1.Find(var_1_11, "title/icon")

	local var_1_12 = arg_1_0.buffWindow

	arg_1_0.buffTip = var_1.Find(var_1_12, "content/tip")

	local var_1_13 = arg_1_0.buffWindow

	arg_1_0.desc = var_1.Find(var_1_13, "content/desc")

	local var_1_14 = arg_1_0.buffWindow

	arg_1_0.buffAwardTF = var_1.Find(var_1_14, "award_bg/award")

	local var_1_15 = arg_1_0._tf

	arg_1_0.trainWindow = var_1.Find(var_1_15, "IdolTrainWindow")

	local var_1_16 = arg_1_0.trainWindow

	arg_1_0.trainTitle = var_1.Find(var_1_16, "panel/title/Text")

	local var_1_17 = arg_1_0.trainWindow

	arg_1_0.trainBtn = var_1.Find(var_1_17, "panel/train_btn")

	local var_1_18 = arg_1_0.trainWindow

	arg_1_0.trainSkills = var_1.Find(var_1_18, "panel/skills")
	arg_1_0.trainSkillBtns = {}

	for iter_1_1 = 0, arg_1_0.trainSkills.childCount - 1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_1_19 = arg_1_0.trainSkillBtns
		local var_1_20 = arg_1_0.trainSkills

		var_1_10005(var_1_19, var_8.GetChild(var_1_20, iter_1_1))
	end

	local var_1_21 = arg_1_0.trainWindow

	arg_1_0.info = var_1.Find(var_1_21, "panel/info")

	local var_1_22 = arg_1_0.info

	arg_1_0.curBuff = var_1.Find(var_1_22, "preview/current")

	local var_1_23 = arg_1_0.info

	arg_1_0.nextBuff = var_1.Find(var_1_23, "preview/next")

	local var_1_24 = arg_1_0._tf

	arg_1_0.msgBox = var_1.Find(var_1_24, "MsgBox")

	local var_1_25 = arg_1_0.msgBox

	arg_1_0.msgIcon = var_1.Find(var_1_25, "panel/title/icon")
	setText = var_1

	local var_1_26 = arg_1_0.msgBox
	local var_1_27 = var_3.Find(var_1_26, "panel/title/Text")

	i18n = var_4

	var_1(var_1_27, var_4("title_info"))

	local var_1_28 = arg_1_0.msgBox

	arg_1_0.msgContent = var_1.Find(var_1_28, "panel/content")

	local var_1_29 = arg_1_0.msgBox

	arg_1_0.msgBoxMask = var_1.Find(var_1_29, "mengban")

	local var_1_30 = arg_1_0.msgBox

	arg_1_0.cancelBtn = var_1.Find(var_1_30, "panel/cancel_btn")

	local var_1_31 = arg_1_0.msgBox

	arg_1_0.confirmBtn = var_1.Find(var_1_31, "panel/confirm_btn")

	local var_1_32 = arg_1_0._tf

	arg_1_0.tipPanel = var_1.Find(var_1_32, "Tip")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	removeOnButton = var_1

	var_1(arg_2_0.getBtn)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getBtn

	local function var_2_2()
		local var_3_0 = {}
		local var_3_1 = arg_2_0.ptData
		local var_3_2 = var_1.GetAward(var_3_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_3_3 = var_2_10002(var_2_10004)
		local var_3_4 = var_2.getData(var_3_3)
		local var_3_5 = var_3_2.type

		DROP_TYPE_RESOURCE = var_3_3

		if var_3_5 == var_3_3 then
			var_3_5 = var_3_2.id
			PlayerConst = var_3_3

			if var_3_5 == var_3_3.ResGold and var_3_4:GoldMax(var_3_2.count) then
				table = var_3_5

				var_3_5.insert(var_3_0, function(arg_4_0)
					pg = var_3_10001

					local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_4_1 = var_1.ShowMsgBox
					local var_4_2 = {}

					i18n = var_3_10005

					local var_4_3 = var_3_10005("gold_max_tip_title")

					i18n = var_3_10006
					var_4_2.content = var_4_3 .. var_3_10006("award_max_warning")
					var_4_2.onYes = arg_4_0

					var_4_1(var_4_0, var_4_2)

					return
				end)
			end
		end

		seriesAsync = var_3_5

		var_3_5(var_3_0, function()
			local var_5_0 = arg_2_0.ptData
			local var_5_1, var_5_2 = var_0.GetResProgress(var_5_0)
			local var_5_3 = arg_2_0
			local var_5_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_5_5 = var_3_10005.EVENT_PT_OPERATION
			local var_5_6 = {
				cmd = 1
			}
			local var_5_7 = arg_2_0.ptData

			var_5_6.activity_id = var_7.GetId(var_5_7)
			var_5_6.arg1 = var_5_2

			var_5_4(var_5_3, var_5_5, var_5_6)

			local var_5_8 = arg_2_0

			var_2.playIdolAni(var_5_8)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	removeOnButton = var_1

	var_1(arg_2_0.battleBtn)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.battleBtn

	local function var_2_5()
		local var_6_0
		local var_6_1
		local var_6_2 = arg_2_0.activity

		if var_2.getConfig(var_6_2, "config_client") ~= "" then
			local var_6_3 = arg_2_0.activity

			if var_3.getConfig(var_6_3, "config_client").linkActID then
				getProxy = var_3
				ActivityProxy = var_6_3

				local var_6_4 = var_3(var_6_3)

				var_6_1 = var_3.getActivityById(var_6_4, var_6_0)
			end
		end

		if not var_6_0 then
			local var_6_5 = arg_2_0
			local var_6_6 = var_3.emit

			ActivityMediator = var_2_10006

			var_6_6(var_6_5, var_2_10006.BATTLE_OPERA)
		elseif var_6_1 and not var_6_1:isEnd() then
			local var_6_7 = arg_2_0
			local var_6_8 = var_3.emit

			ActivityMediator = var_2_10006

			var_6_8(var_6_7, var_2_10006.BATTLE_OPERA)
		else
			local var_6_9 = arg_2_0
			local var_6_10 = var_3.showTip

			i18n = var_2_10006

			var_6_10(var_6_9, var_2_10006("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.trainEntranceBtn

	local function var_2_8()
		local var_7_0 = arg_2_0

		var_0.showTrianPanel(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.helpBtn

	local function var_2_11()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		i18n = var_2_10004
		var_8_2.helps = var_2_10004("idol3rd_practice")

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_9, var_2_10, var_2_11, var_1_10006)
	arg_2_0:hideBuffInfoBox()

	onButton = var_1

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.mask

	local function var_2_14()
		local var_9_0 = arg_2_0

		var_0.hideBuffInfoBox(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_12, var_2_13, var_2_14, var_1_10006)

	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.skillBtns) do
		onButton = var_1_10006

		local var_2_15 = arg_2_0
		local var_2_16 = iter_2_1

		local function var_2_17()
			ipairs = var_2_10000

			local var_10_0 = arg_2_0.ptData

			for iter_10_0, iter_10_1 in var_2_10000(var_2.GetCurBuffInfos(var_10_0)) do
				if iter_2_0 == iter_10_1.group then
					local var_10_1 = arg_2_0

					var_5.showBuffInfoBox(var_10_1, iter_10_1)
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_2_15, var_2_16, var_2_17, var_1_10011)
	end

	local var_2_18 = var_0_2

	math = var_2

	local var_2_19 = var_2_18[var_2.random(#var_0_2)]

	pg = var_2

	local var_2_20 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_2_20)

	PoolMgr = var_2

	local var_2_21 = var_2.GetInstance()

	var_2.GetSpineChar(var_2_21, var_2_19, true, function(arg_11_0)
		pg = var_2_10001

		local var_11_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_11_0)

		arg_2_0.prefab1 = var_2_19

		local var_11_1 = arg_2_0

		var_11_1.model1 = arg_11_0
		tf = var_11_1

		local var_11_2 = var_11_1(arg_11_0)

		Vector3 = var_2
		var_11_2.localScale = var_2(1, 1, 1)

		local var_11_3 = arg_11_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_11_3, "stand2", 0)

		setParent = var_1

		var_1(arg_11_0, arg_2_0.idol1)

		return
	end)

	setActive = var_2

	local var_2_22 = arg_2_0.skills
	local var_2_23 = arg_2_0.ptData

	var_2(var_2_22, var_5.isInBuffTime(var_2_23))

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	local var_12_0 = false
	local var_12_1 = arg_12_0.ptData

	if var_2.CanTrain(var_12_1) and var_2 <= arg_12_0.ptData.level then
		var_12_0 = true
	end

	local var_12_2 = arg_12_0.ptData
	local var_12_3, var_12_4, var_12_5 = var_3.GetLevelProgress(var_12_2)
	local var_12_6 = arg_12_0.ptData
	local var_12_7, var_12_8, var_12_9 = var_6.GetResProgress(var_12_6)

	setText = var_1_10009

	var_1_10009(arg_12_0.step, var_12_3 .. "/" .. var_12_4)

	setText = var_1_10009

	var_1_10009(arg_12_0.progress, var_12_7 .. "/" .. var_12_8)

	setSlider = var_1_10009

	var_1_10009(arg_12_0.slider, 0, 1, var_12_9)

	local var_12_10 = arg_12_0.ptData
	local var_12_11 = var_9.CanGetAward(var_12_10)
	local var_12_12 = arg_12_0.ptData
	local var_12_13 = var_10.CanGetNextAward(var_12_12)
	local var_12_14 = arg_12_0.ptData
	local var_12_15 = var_11.CanGetMorePt(var_12_14)
	local var_12_16 = arg_12_0.ptData
	local var_12_17 = var_12.CanTrain(var_12_16)

	setActive = var_12_14

	var_12_14(arg_12_0.battleBtn, true)

	setActive = var_12_14

	var_12_14(arg_12_0.getBtn, var_12_11 and not var_12_0)

	setActive = var_12_14

	var_12_14(arg_12_0.trainEntranceBtn, var_12_0)

	setActive = var_12_14

	var_12_14(arg_12_0.gotBtn, not var_12_13 and not var_12_17)

	local var_12_18 = arg_12_0.ptData
	local var_12_19 = var_13.GetAward(var_12_18)

	updateDrop = var_12_16

	var_12_16(arg_12_0.awardTF, var_12_19)

	onButton = var_12_16

	local var_12_20 = arg_12_0
	local var_12_21 = arg_12_0.awardTF

	local function var_12_22()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_19)

		return
	end

	SFX_PANEL = var_1_10019

	var_12_16(var_12_20, var_12_21, var_12_22, var_1_10019)

	ipairs = var_12_16

	local var_12_23 = arg_12_0.ptData

	for iter_12_0, iter_12_1 in var_12_16(var_16.GetCurBuffInfos(var_12_23)) do
		setActive = var_1_10019

		local var_12_24 = arg_12_0.skillBtns[iter_12_1.group]

		var_1_10019(var_21.Find(var_12_24, "lv1"), false)

		setActive = var_1_10019

		local var_12_25 = arg_12_0.skillBtns[iter_12_1.group]

		var_1_10019(var_21.Find(var_12_25, "lv2"), false)

		setActive = var_1_10019

		local var_12_26 = arg_12_0.skillBtns[iter_12_1.group]

		var_1_10019(var_21.Find(var_12_26, "lv3"), false)

		if iter_12_1.next then
			setActive = var_1_10019

			local var_12_27 = arg_12_0.skillBtns[iter_12_1.group]

			var_1_10019(var_21.Find(var_12_27, "lv" .. iter_12_1.lv), true)
		else
			setActive = var_1_10019

			local var_12_28 = arg_12_0.skillBtns[iter_12_1.group]

			var_1_10019(var_21.Find(var_12_28, "lv3"), true)
		end

		pg = var_1_10019
		var_1_10019 = var_1_10019.benefit_buff_template[iter_12_1.id].icon
		setImageSprite = var_20

		local var_12_29 = arg_12_0.skillBtns[iter_12_1.group]
		local var_12_30 = var_22.Find(var_12_29, "icon")

		LoadSprite = var_23

		var_20(var_12_30, var_23(var_1_10019))
	end

	return
end

function var_0_1.showTrianPanel(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.trainWindow, true)

	setText = var_1_10001

	local var_14_0 = arg_14_0.trainTitle

	i18n = var_4

	var_1_10001(var_14_0, var_4("upgrade_idol_tip"))

	local var_14_1 = arg_14_0.ptData
	local var_14_2 = var_1.GetCurBuffInfos(var_14_1)

	arg_14_0.selectIndex = nil
	arg_14_0.selectBuffId = nil
	arg_14_0.selectBuffLv = nil
	arg_14_0.selectNewBuffId = nil
	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_0.trainSkillBtns) do
		onButton = var_1_10007

		local var_14_3 = arg_14_0
		local var_14_4 = iter_14_1

		local function var_14_5()
			ipairs = var_2_10000

			for iter_15_0, iter_15_1 in var_2_10000(var_14_2) do
				if iter_14_0 == iter_15_1.group and iter_15_1.next then
					arg_14_0.selectIndex = iter_14_0
					arg_14_0.selectBuffId = iter_15_1.id
					arg_14_0.selectNewBuffId = iter_15_1.next
					arg_14_0.selectBuffLv = iter_15_1.lv
				end
			end

			local var_15_0 = arg_14_0

			var_0.flushTrainPanel(var_15_0)

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_14_3, var_14_4, var_14_5, var_1_10012)
	end

	onButton = var_2

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.trainBtn

	local function var_14_8()
		local var_16_0 = arg_14_0

		var_0.showMsgBox(var_16_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_14_6, var_14_7, var_14_8, var_1_10007)

	underscore = var_2

	if var_2.detect(var_14_2, function(arg_17_0)
		return arg_17_0.next
	end) then
		triggerButton = var_3

		var_3(arg_14_0.trainSkillBtns[var_2.group])
	end

	return
end

function var_0_1.hideTrianPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.trainWindow, false)

	return
end

function var_0_1.flushTrainPanel(arg_19_0)
	local var_19_0 = arg_19_0.ptData

	if var_1.GetCurBuffInfos(var_19_0) then
		ipairs = var_1_10002

		for iter_19_0, iter_19_1 in var_1_10002(var_1) do
			setActive = var_1_10007

			local var_19_1 = arg_19_0.trainSkillBtns[iter_19_1.group]

			var_1_10007(var_9.Find(var_19_1, "lv1"), false)

			setActive = var_1_10007

			local var_19_2 = arg_19_0.trainSkillBtns[iter_19_1.group]

			var_1_10007(var_9.Find(var_19_2, "lv2"), false)

			setActive = var_1_10007

			local var_19_3 = arg_19_0.trainSkillBtns[iter_19_1.group]

			var_1_10007(var_9.Find(var_19_3, "lv3"), false)

			if iter_19_1.next then
				setActive = var_1_10007

				local var_19_4 = arg_19_0.trainSkillBtns[iter_19_1.group]

				var_1_10007(var_9.Find(var_19_4, "lv" .. iter_19_1.lv), true)
			else
				setActive = var_1_10007

				local var_19_5 = arg_19_0.trainSkillBtns[iter_19_1.group]

				var_1_10007(var_9.Find(var_19_5, "lv3"), true)
			end

			pg = var_1_10007
			var_1_10007 = var_1_10007.benefit_buff_template[iter_19_1.id].icon
			setImageSprite = var_8

			local var_19_6 = arg_19_0.trainSkillBtns[iter_19_1.group]
			local var_19_7 = var_10.Find(var_19_6, "icon")

			LoadSprite = var_11

			var_8(var_19_7, var_11(var_1_10007))

			setText = var_8

			local var_19_8 = arg_19_0.trainSkillBtns[iter_19_1.group]
			local var_19_9 = var_10.Find(var_19_8, "name")

			shortenString = var_11
			pg = var_13

			var_8(var_19_9, var_11(var_13.benefit_buff_template[iter_19_1.id].name, 7))
		end
	end

	ipairs = var_1_10002

	for iter_19_2, iter_19_3 in var_1_10002(arg_19_0.trainSkillBtns) do
		if iter_19_2 == arg_19_0.selectIndex then
			setActive = var_1_10007

			var_1_10007(iter_19_3:Find("selected"), true)

			setActive = var_1_10007

			var_1_10007(iter_19_3:Find("name"), true)
		else
			setActive = var_1_10007

			var_1_10007(iter_19_3:Find("selected"), false)

			setActive = var_1_10007

			var_1_10007(iter_19_3:Find("name"), false)
		end
	end

	if arg_19_0.selectIndex then
		setActive = var_2

		var_2(arg_19_0.info, true)

		setActive = var_2

		var_2(arg_19_0.trainBtn, true)

		setText = var_2

		local var_19_10 = arg_19_0.curBuff
		local var_19_11 = "Lv."
		local var_19_12 = arg_19_0.selectBuffLv

		pg = var_1_10007

		var_2(var_19_10, var_19_11 .. var_19_12 .. var_1_10007.benefit_buff_template[arg_19_0.selectBuffId].desc)

		setText = var_2

		local var_19_13 = arg_19_0.nextBuff
		local var_19_14 = "Lv."
		local var_19_15 = arg_19_0.selectBuffLv + 1

		pg = var_7

		var_2(var_19_13, var_19_14 .. var_19_15 .. var_7.benefit_buff_template[arg_19_0.selectNewBuffId].desc)
	else
		setActive = var_2

		var_2(arg_19_0.info, false)

		setActive = var_2

		var_2(arg_19_0.trainBtn, false)
	end

	return
end

function var_0_1.showBuffInfoBox(arg_20_0, arg_20_1)
	pg = var_1_10002

	local var_20_0 = var_1_10002.benefit_buff_template[arg_20_1.id].name

	setText = var_3

	var_3(arg_20_0.buffName, var_20_0)

	setText = var_3

	local var_20_1 = arg_20_0.desc

	pg = var_6

	var_3(var_20_1, var_6.benefit_buff_template[arg_20_1.id].desc)

	setText = var_3

	local var_20_2 = arg_20_0.buffTip

	i18n = var_6

	var_3(var_20_2, var_6("upgrade_introduce_tip", var_20_0))

	pg = var_3

	local var_20_3 = var_3.benefit_buff_template[arg_20_1.id].icon

	setImageSprite = var_4

	local var_20_4 = arg_20_0.titleIcon

	LoadSprite = var_7

	var_4(var_20_4, var_7(var_20_3))

	local var_20_5 = arg_20_1.award

	updateDrop = var_20_2

	var_20_2(arg_20_0.buffAwardTF, var_20_5)

	onButton = var_20_2

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.buffAwardTF

	local function var_20_8()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		BaseUI = var_2_10003

		var_21_1(var_21_0, var_2_10003.ON_DROP, var_20_5)

		return
	end

	SFX_PANEL = var_1_10010

	var_20_2(var_20_6, var_20_7, var_20_8, var_1_10010)

	if arg_20_1.next then
		setText = var_5

		var_5(arg_20_0.titleLv, "Lv." .. arg_20_1.lv)

		setActive = var_5

		local var_20_9 = arg_20_0.buffAwardTF

		var_5(var_7.Find(var_20_9, "icon_bg/got_mask"), false)
	else
		setText = var_5

		var_5(arg_20_0.titleLv, "MAX")

		setActive = var_5

		local var_20_10 = arg_20_0.buffAwardTF

		var_5(var_7.Find(var_20_10, "icon_bg/got_mask"), true)

		removeOnButton = var_5

		var_5(arg_20_0.buffAwardTF)
	end

	setActive = var_5

	var_5(arg_20_0.buffInfoBox, true)

	return
end

function var_0_1.hideBuffInfoBox(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.buffInfoBox, false)

	return
end

function var_0_1.OnDestroy(arg_23_0)
	if arg_23_0.prefab1 and arg_23_0.model1 then
		PoolMgr = var_1

		local var_23_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_23_0, arg_23_0.prefab1, arg_23_0.model1)

		arg_23_0.prefab1 = nil
		arg_23_0.model1 = nil
	end

	return
end

function var_0_1.playIdolAni(arg_24_0)
	if arg_24_0.model1 then
		local var_24_0 = arg_24_0.model1
		local var_24_1 = var_1.GetComponent(var_24_0, "SpineAnimUI")

		var_1.SetAction(var_24_1, "idol", 0)
	end

	return
end

function var_0_1.showMsgBox(arg_25_0)
	if arg_25_0.selectBuffId then
		setActive = var_1

		var_1(arg_25_0.msgBox, true)

		pg = var_1

		local var_25_0 = var_1.benefit_buff_template[arg_25_0.selectBuffId].icon

		setImageSprite = var_2

		local var_25_1 = arg_25_0.msgIcon

		LoadSprite = var_1_10005

		var_2(var_25_1, var_1_10005(var_25_0))

		pg = var_2

		local var_25_2 = var_2.benefit_buff_template[arg_25_0.selectBuffId].name

		setText = var_3

		local var_25_3 = arg_25_0.msgContent

		i18n = var_1_10006

		var_3(var_25_3, var_1_10006("practise_idol_tip", var_25_2))

		onButton = var_3

		local var_25_4 = arg_25_0
		local var_25_5 = arg_25_0.msgBoxMask

		local function var_25_6()
			local var_26_0 = arg_25_0

			var_0.hideMsgBox(var_26_0)

			return
		end

		SFX_PANEL = var_8

		var_3(var_25_4, var_25_5, var_25_6, var_8)

		onButton = var_3

		local var_25_7 = arg_25_0
		local var_25_8 = arg_25_0.cancelBtn

		local function var_25_9()
			local var_27_0 = arg_25_0

			var_0.hideMsgBox(var_27_0)

			return
		end

		SFX_PANEL = var_8

		var_3(var_25_7, var_25_8, var_25_9, var_8)

		onButton = var_3

		local var_25_10 = arg_25_0
		local var_25_11 = arg_25_0.confirmBtn

		local function var_25_12()
			local var_28_0 = arg_25_0

			var_0.hideMsgBox(var_28_0)

			local var_28_1 = arg_25_0
			local var_28_2 = var_0.emit

			ActivityMediator = var_2_10003

			local var_28_3 = var_2_10003.EVENT_PT_OPERATION
			local var_28_4 = {
				cmd = 3
			}
			local var_28_5 = arg_25_0.ptData

			var_28_4.activity_id = var_5.GetId(var_28_5)

			local var_28_6 = arg_25_0.ptData

			var_28_4.arg1 = var_5.CanTrain(var_28_6)
			var_28_4.arg2 = arg_25_0.selectNewBuffId
			var_28_4.oldBuffId = arg_25_0.selectBuffId

			function var_28_4.callback()
				local var_29_0 = arg_25_0

				var_0.hideTrianPanel(var_29_0)

				local var_29_1 = arg_25_0
				local var_29_2 = var_0.showTip

				i18n = var_3_10003

				var_29_2(var_29_1, var_3_10003("upgrade_complete_tip"))

				return
			end

			var_28_2(var_28_1, var_28_3, var_28_4)

			return
		end

		SFX_PANEL = var_8

		var_3(var_25_10, var_25_11, var_25_12, var_8)
	end

	return
end

function var_0_1.hideMsgBox(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.msgBox, false)

	return
end

function var_0_1.showTip(arg_31_0, arg_31_1)
	cloneTplTo = var_1_10002

	local var_31_0 = var_1_10002(arg_31_0.tipPanel, arg_31_0._tf)

	setActive = var_1_10003

	var_1_10003(var_31_0, true)

	setText = var_1_10003

	var_1_10003(var_31_0:Find("Text"), arg_31_1)

	local var_31_1 = var_31_0.transform

	Vector3 = var_4
	var_31_1.localScale = var_4(0, 0.1, 1)
	LeanTween = var_31_1

	local var_31_2 = var_31_1.scale
	local var_31_3 = var_31_0

	Vector3 = var_6

	local var_31_4 = var_31_2(var_31_3, var_6(1.8, 0.1, 1), 0.1)

	var_3.setUseEstimatedTime(var_31_4, true)

	LeanTween = var_3

	local var_31_5 = var_3.scale
	local var_31_6 = var_31_0

	Vector3 = var_6

	local var_31_7 = var_31_5(var_31_6, var_6(1.1, 1.1, 1), 0.1)
	local var_31_8 = var_3.setDelay(var_31_7, 0.1)

	var_3.setUseEstimatedTime(var_31_8, true)

	GetOrAddComponent = var_3

	local var_31_9 = var_3(var_31_0, "CanvasGroup")

	Timer = var_4

	local var_31_10 = var_4.New(function()
		IsNil = var_2_10000

		if var_2_10000(var_31_0) then
			return
		end

		LeanTween = var_0

		local var_32_0 = var_0.scale
		local var_32_1 = var_31_0

		Vector3 = var_2_10003

		local var_32_2 = var_32_0(var_32_1, var_2_10003(0.1, 1.5, 1), 0.1)
		local var_32_3 = var_0.setUseEstimatedTime(var_32_2, true)
		local var_32_4 = var_0.setOnComplete

		System = var_3

		var_32_4(var_32_3, var_3.Action(function()
			LeanTween = var_3_10000

			local var_33_0 = var_3_10000.scale
			local var_33_1 = var_31_0

			Vector3 = var_3_10003

			local var_33_2 = var_33_0(var_33_1, var_3_10003.zero, 0.1)
			local var_33_3 = var_0.setUseEstimatedTime(var_33_2, true)
			local var_33_4 = var_0.setOnComplete

			System = var_3

			var_33_4(var_33_3, var_3.Action(function()
				Destroy = var_4_10000

				var_4_10000(var_31_0)

				return
			end))

			return
		end))

		return
	end, 3)

	var_4.Start(var_31_10)

	return
end

return var_0_1
