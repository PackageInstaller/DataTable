class = var_0_10000

local var_0_0 = "EducateBottomPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateBottomPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.contentTF = var_1.Find(var_2_0, "content")

	local var_2_1 = arg_2_0.contentTF

	arg_2_0.planBtn = var_1.Find(var_2_1, "btns/schedule")

	local var_2_2 = arg_2_0.contentTF

	arg_2_0.mapBtn = var_1.Find(var_2_2, "btns/map")
	setText = var_1

	local var_2_3 = arg_2_0.mapBtn
	local var_2_4 = var_2.Find(var_2_3, "tips/limit/Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("child_option_limit"))

	local var_2_5 = arg_2_0.contentTF

	arg_2_0.schoolBtn = var_1.Find(var_2_5, "btns/enter_school")

	local var_2_6 = arg_2_0.contentTF

	arg_2_0.upgradeBtn = var_1.Find(var_2_6, "btns/system_upgrade")

	local var_2_7 = arg_2_0.contentTF

	arg_2_0.targetSetBtn = var_1.Find(var_2_7, "btns/target_set")

	local var_2_8 = arg_2_0.contentTF

	arg_2_0.endingBtn = var_1.Find(var_2_8, "btns/ending")

	local var_2_9 = arg_2_0.contentTF

	arg_2_0.resetBtn = var_1.Find(var_2_9, "btns/reset")

	local var_2_10 = arg_2_0

	arg_2_0.addListener(var_2_10)

	getProxy = var_1
	EducateProxy = var_2_10

	local var_2_11 = var_1(var_2_10)
	local var_2_12 = var_1.GetTaskProxy(var_2_11)

	arg_2_0.targetSetDays = var_1.GetTargetSetDays(var_2_12)

	arg_2_0:Flush()

	return
end

function var_0_1.addListener(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.planBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_4_2 = var_2_10002.EDUCATE_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.EDUCATE_SCHEDULE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.mapBtn

	local function var_3_5()
		isActive = var_2_10000

		local var_5_0 = arg_3_0.mapBtn

		if var_2_10000(var_1.Find(var_5_0, "lock")) then
			return
		end

		local var_5_1 = arg_3_0
		local var_5_2 = var_0.emit

		EducateBaseUI = var_5_0

		local var_5_3 = var_5_0.EDUCATE_GO_SCENE

		SCENE = var_3

		var_5_2(var_5_1, var_5_3, var_3.EDUCATE_MAP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.schoolBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_6_2 = var_2_10002.EDUCATE_ON_MSG_TIP
		local var_6_3 = {}

		i18n = var_2_10004
		var_6_3.content = var_2_10004("child_school_sure_tip")

		function var_6_3.onYes()
			setActive = var_3_10000

			var_3_10000(arg_3_0.schoolBtn, false)

			local var_7_0 = arg_3_0

			var_0.updateTargetSetBtn(var_7_0)

			EducateConst = var_0

			local var_7_1

			if var_0.ENTER_NEW_STAGE_PERFORMS[2] then
				pg = var_7_0
				var_7_1 = var_7_0.PerformMgr.GetInstance()

				var_7_0.PlayOne(var_7_1, var_0, function()
					local var_8_0 = arg_3_0

					var_0.playGuide(var_8_0, "tb_9_1")

					local var_8_1 = arg_3_0

					var_0.onEnterVirtualStage(var_8_1)

					return
				end)
			else
				var_7_1 = arg_3_0

				var_7_0.playGuide(var_7_1, "tb_9_1")

				var_7_1 = arg_3_0

				var_7_0.onEnterVirtualStage(var_7_1)
			end

			getProxy = var_7_0
			EducateProxy = var_7_1

			local var_7_2 = var_7_0(var_7_1)
			local var_7_3 = var_1.GetPlanProxy(var_7_2)

			var_1.ClearLocalPlansData(var_7_3)

			return
		end

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.upgradeBtn

	local function var_3_11()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_9_2 = var_2_10002.EDUCATE_ON_MSG_TIP
		local var_9_3 = {}

		i18n = var_2_10004
		var_9_3.content = var_2_10004("child_upgrade_sure_tip")

		function var_9_3.onYes()
			setActive = var_3_10000

			var_3_10000(arg_3_0.upgradeBtn, false)

			local var_10_0 = arg_3_0

			var_0.updateTargetSetBtn(var_10_0)

			getProxy = var_0
			EducateProxy = var_10_0

			local var_10_1 = var_0(var_10_0)
			local var_10_2 = var_0.GetCharData(var_10_1)
			local var_10_3 = var_0.GetStage(var_10_2)

			EducateConst = var_10_2

			if var_10_2.ENTER_NEW_STAGE_PERFORMS[var_10_3 + 1] then
				pg = var_2
				var_3_10003 = var_2.PerformMgr.GetInstance()

				var_2.PlayOne(var_3_10003, var_1, function()
					local var_11_0 = arg_3_0

					var_0.onEnterVirtualStage(var_11_0)

					return
				end)
			else
				var_3_10003 = arg_3_0

				var_2.onEnterVirtualStage(var_3_10003)
			end

			getProxy = var_2
			EducateProxy = var_3_10003

			local var_10_4 = var_2(var_3_10003)
			local var_10_5 = var_2.GetPlanProxy(var_10_4)

			var_2.ClearLocalPlansData(var_10_5)

			return
		end

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.targetSetBtn

	local function var_3_14()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_12_2 = var_2_10002.EDUCATE_GO_SUBLAYER

		Context = var_2_10003

		local var_12_3 = var_2_10003.New
		local var_12_4 = {}

		EducateTargetSetMediator = var_2_10005
		var_12_4.mediator = var_2_10005
		EducateTargetSetLayer = var_2_10005
		var_12_4.viewComponent = var_2_10005

		var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.endingBtn

	local function var_3_17()
		local var_13_0 = arg_3_0
		local var_13_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_13_2 = var_2_10002.EDUCATE_ON_MSG_TIP
		local var_13_3 = {}

		i18n = var_2_10004
		var_13_3.content = var_2_10004("child_end_sure_tip")

		function var_13_3.onYes()
			pg = var_3_10000

			local var_14_0 = var_3_10000.PerformMgr.GetInstance()
			local var_14_1 = var_0.PlayOne

			EducateConst = var_3_10002

			var_14_1(var_14_0, var_3_10002.FIRST_ENTER_END_PERFORM, function()
				local var_15_0 = arg_3_0
				local var_15_1 = var_0.emit

				EducateMediator = var_4_10002

				var_15_1(var_15_0, var_4_10002.ON_ENDING_TRIGGER)

				return
			end)

			return
		end

		var_13_1(var_13_0, var_13_2, var_13_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10005)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.resetBtn

	local function var_3_20()
		local var_16_0 = arg_3_0
		local var_16_1 = var_0.emit

		EducateBaseUI = var_2_10002

		local var_16_2 = var_2_10002.EDUCATE_ON_MSG_TIP
		local var_16_3 = {}

		i18n = var_2_10004
		var_16_3.content = var_2_10004("child_reset_sure_tip")

		function var_16_3.onYes()
			local var_17_0 = arg_3_0
			local var_17_1 = var_0.emit

			EducateMediator = var_3_10002

			var_17_1(var_17_0, var_3_10002.ON_GAME_RESET)

			return
		end

		var_16_1(var_16_0, var_16_2, var_16_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10005)

	local var_3_21 = "anim_educate_bottom_show"

	if arg_3_0.contextData and arg_3_0.contextData.isMainEnter then
		var_3_21 = "anim_educate_bottom_in"
	end

	local var_3_22 = arg_3_0._tf
	local var_3_23 = var_2.GetComponent

	typeof = var_3_20
	Animation = var_1_10005

	local var_3_24 = var_3_23(var_3_22, var_3_20(var_1_10005))

	var_2.Play(var_3_24, var_3_21)

	return
end

function var_0_1.playGuide(arg_18_0, arg_18_1)
	pg = var_1_10002

	local var_18_0 = var_1_10002.NewStoryMgr.GetInstance()

	if not var_2.IsPlayed(var_18_0, arg_18_1) then
		pg = var_2

		local var_18_1 = var_2.NewGuideMgr.GetInstance()

		var_2.Play(var_18_1, arg_18_1)

		pg = var_2

		local var_18_2 = var_2.m02
		local var_18_3 = var_2.sendNotification

		GAME = var_4

		var_18_3(var_18_2, var_4.STORY_UPDATE, {
			storyId = arg_18_1
		})
	end

	return
end

function var_0_1.onEnterVirtualStage(arg_19_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)

	var_1.SetVirtualStage(var_19_0, true)

	local var_19_1 = arg_19_0
	local var_19_2 = arg_19_0.emit

	EducateMediator = var_3

	var_19_2(var_19_1, var_3.ENTER_VIRTUAL_STAGE)

	return
end

function var_0_1.Flush(arg_20_0)
	local var_20_0 = arg_20_0

	if not arg_20_0.GetLoaded(var_20_0) then
		return
	end

	getProxy = var_1
	EducateProxy = var_20_0

	local var_20_1 = var_1(var_20_0)

	arg_20_0.curTime = var_1.GetCurTime(var_20_1)
	getProxy = var_1
	EducateProxy = var_20_1

	local var_20_2 = var_1(var_20_1)

	arg_20_0.status = var_1.GetGameStatus(var_20_2)
	EducateHelper = var_1

	local var_20_3 = var_1.IsSystemUnlock

	EducateConst = var_20_2

	local var_20_4 = var_20_3(var_20_2.SYSTEM_GO_OUT)

	getProxy = var_2
	EducateProxy = var_1_10003

	local var_20_5 = var_2(var_1_10003)
	local var_20_6 = var_2.InVirtualStage(var_20_5)

	setActive = var_20_5

	local var_20_7 = arg_20_0.mapBtn

	var_20_5(var_4.Find(var_20_7, "lock"), not var_20_4 or var_20_6)

	setActive = var_20_5

	local var_20_8 = arg_20_0.planBtn
	local var_20_9 = arg_20_0.status

	EducateConst = var_6

	if var_20_9 ~= var_6.STATUES_ENDING then
		local var_20_10 = arg_20_0.status

		EducateConst = var_6

		local var_20_11

		if var_20_10 == var_6.STATUES_RESET then
			var_20_11 = false
		else
			var_20_11 = true
		end

		var_20_5(var_20_8, var_20_11)

		setActive = var_20_5

		local var_20_12 = arg_20_0.mapBtn
		local var_20_13 = arg_20_0.status

		EducateConst = var_6

		if var_20_13 ~= var_6.STATUES_ENDING then
			local var_20_14 = arg_20_0.status

			EducateConst = var_6

			local var_20_15

			if var_20_14 == var_6.STATUES_RESET then
				var_20_15 = false
			else
				var_20_15 = true
			end

			var_20_5(var_20_12, var_20_15)
			arg_20_0:updateMapBtnTips()

			setActive = var_3

			local var_20_16 = arg_20_0.schoolBtn
			local var_20_17

			if arg_20_0:isSchoolBtnShow() then
				var_20_17 = not var_20_6
			end

			var_3(var_20_16, var_20_17)

			setActive = var_3

			local var_20_18 = arg_20_0.upgradeBtn
			local var_20_19 = arg_20_0
			local var_20_20

			if arg_20_0.isUpgradeBtnShow(var_20_19) then
				var_20_20 = not var_20_6
			end

			var_3(var_20_18, var_20_20)
			arg_20_0:updateTargetSetBtn()

			setActive = var_3

			local var_20_21 = arg_20_0.endingBtn
			local var_20_22 = arg_20_0.status

			EducateConst = var_20_19

			var_3(var_20_21, var_20_22 == var_20_19.STATUES_ENDING)

			setActive = var_3

			local var_20_23 = arg_20_0.resetBtn
			local var_20_24 = arg_20_0.status

			EducateConst = var_6

			var_3(var_20_23, var_20_24 == var_6.STATUES_RESET)

			isActive = var_3

			if not var_3(arg_20_0.schoolBtn) then
				isActive = var_3

				if not var_3(arg_20_0.upgradeBtn) then
					isActive = var_3

					if var_3(arg_20_0.targetSetBtn) then
						setActive = var_3

						var_3(arg_20_0.planBtn, false)
					end

					return
				end
			end
		end
	end
end

function var_0_1.isSchoolBtnShow(arg_21_0)
	local var_21_0 = arg_21_0.status

	EducateConst = var_1_10002

	local var_21_1

	if var_21_0 == var_1_10002.STATUES_PREPARE then
		EducateHelper = var_21_0
		var_21_1 = var_21_0.IsSameDay(arg_21_0.curTime, arg_21_0.targetSetDays[2])
	else
		var_21_1 = false
	end

	if false then
		var_21_1 = true
	end

	return var_21_1
end

function var_0_1.isUpgradeBtnShow(arg_22_0)
	local var_22_0 = arg_22_0.status

	EducateConst = var_1_10002

	if var_22_0 == var_1_10002.STATUES_PREPARE then
		EducateHelper = var_22_0

		if not var_22_0.IsSameDay(arg_22_0.curTime, arg_22_0.targetSetDays[3]) then
			EducateHelper = var_22_0
			var_22_0 = var_22_0.IsSameDay(arg_22_0.curTime, arg_22_0.targetSetDays[4])
		end
	else
		var_22_0 = false
	end

	if false then
		var_22_0 = true
	end

	return var_22_0
end

function var_0_1.isTargetSetBtnShow(arg_23_0)
	local var_23_0 = arg_23_0.status

	EducateConst = var_1_10002

	local var_23_1

	if var_23_0 == var_1_10002.STATUES_PREPARE then
		isActive = var_23_0

		if not var_23_0(arg_23_0.schoolBtn) then
			isActive = var_1
			var_23_1 = not var_1(arg_23_0.upgradeBtn)

			goto label_23_0
		end
	end

	var_23_1 = false

	if false then
		var_23_1 = true
	end

	::label_23_0::

	return var_23_1
end

function var_0_1.updateTargetSetBtn(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.isTargetSetBtnShow(var_24_0)

	setActive = var_24_0

	var_24_0(arg_24_0.targetSetBtn, var_24_1)

	if var_24_1 then
		setActive = var_24_0

		local var_24_2 = arg_24_0.mapBtn

		var_24_0(var_3.Find(var_24_2, "lock"), true)
	end

	return
end

function var_0_1.updateMapBtnTips(arg_25_0)
	EducateTipHelper = var_1_10001

	var_1_10001.GetSiteUnlockTipIds()

	getProxy = var_1
	EducateProxy = var_1_10002

	local var_25_0 = var_1(var_1_10002)
	local var_25_1 = var_1.GetShowSiteIds(var_25_0)

	underscore = var_25_0

	local var_25_2 = var_25_0.any(var_25_1, function(arg_26_0)
		EducateTipHelper = var_2_10001

		local var_26_0 = var_2_10001.IsShowNewTip

		EducateTipHelper = var_2_10002

		return var_26_0(var_2_10002.NEW_SITE, arg_26_0)
	end)

	underscore = var_3

	local var_25_3 = var_3.any(var_25_1, function(arg_27_0)
		getProxy = var_2_10001
		EducateProxy = var_2_10002

		local var_27_0 = var_2_10001(var_2_10002)
		local var_27_1 = var_1.GetOptionsBySiteId(var_27_0, arg_27_0)

		underscore = var_27_0

		return var_27_0.any(var_27_1, function(arg_28_0)
			return arg_28_0:IsShowLimit()
		end)
	end)

	setActive = var_4

	local var_25_4 = arg_25_0.mapBtn

	var_4(var_5.Find(var_25_4, "tips/new"), var_25_2)

	setActive = var_4

	local var_25_5 = arg_25_0.mapBtn

	var_4(var_5.Find(var_25_5, "tips/limit"), var_25_3)

	return
end

function var_0_1.OnDestroy(arg_29_0)
	return
end

return var_0_1
