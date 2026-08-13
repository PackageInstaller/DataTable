class = var_0_10000

local var_0_0 = "ChildishnessSchoolPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChildishnessSchoolPtPage"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.scrollPanel = var_1.Find(var_2_1, "window/panel")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "window/panel/list")
	local var_2_5 = arg_2_0._tf

	arg_2_0.UIlist = var_2_2(var_2_4, var_3.Find(var_2_5, "window/panel/list/item"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.ptTF = var_1.Find(var_2_6, "window/top/pt")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "window/top/pt/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_2_5
	arg_2_0.totalTxt = var_2_9(var_2_8, var_3(var_2_5))

	local var_2_10 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_10, "window/top/btnBack")

	local var_2_11 = arg_2_0._tf

	arg_2_0.getBtn = var_1.Find(var_2_11, "window/btn_get")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.anim

		var_0.Play(var_4_0, "anim_kinder_schoolPT_out")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bg

	local function var_3_5()
		local var_5_0 = arg_3_0.anim

		var_0.Play(var_5_0, "anim_kinder_schoolPT_out")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)
	arg_3_0:Show()

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.GetComponent

	typeof = var_3_4
	Animation = var_3_5
	arg_3_0.anim = var_3_7(var_3_6, var_3_4(var_3_5))

	local var_3_8 = arg_3_0.anim
	local var_3_9 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_3_5
	arg_3_0.animEvent = var_3_9(var_3_8, var_3(var_3_5))

	local var_3_10 = arg_3_0.animEvent

	var_1.SetEndEvent(var_3_10, function()
		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end)

	pg = var_1

	local var_3_11 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_11, arg_3_0._tf)

	return
end

function var_0_1.Show(arg_7_0)
	arg_7_0:UpdatePtData()

	local var_7_0 = arg_7_0.ptData.dropList
	local var_7_1 = arg_7_0.ptData.targets
	local var_7_2 = arg_7_0.ptData.level
	local var_7_3 = arg_7_0.ptData.count

	arg_7_0:updateResIcon(arg_7_0.ptData.resId, arg_7_0.ptData.resIcon, arg_7_0.ptData.type)
	arg_7_0:UpdateList(var_7_0, var_7_1, var_7_2)

	local var_7_4 = arg_7_0.totalTxt

	var_7_4.text = var_7_3
	Canvas = var_7_4

	var_7_4.ForceUpdateCanvases()

	return
end

function var_0_1.UpdateList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	assert = var_1_10004

	var_1_10004(#arg_8_1 == #arg_8_2)

	local var_8_0 = arg_8_0.UIlist

	var_4.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_1[arg_9_1 + 1]
			local var_9_1 = arg_8_2[arg_9_1 + 1]

			setText = var_5

			var_5(arg_9_2:Find("title/Text"), "PHASE " .. arg_9_1 + 1)

			setText = var_5

			var_5(arg_9_2:Find("target/Text"), var_9_1)

			local var_9_2

			if arg_9_2:Find("target/icon") then
				if arg_8_0.resIcon == "" then
					var_9_2 = arg_8_0
					var_9_2.resIcon = nil
				end

				if arg_8_0.resIcon then
					LoadImageSpriteAsync = var_9_2

					var_9_2(arg_8_0.resIcon, arg_9_2:Find("target/icon"), false)
				end

				setActive = var_9_2

				var_9_2(arg_9_2:Find("target/icon"), arg_8_0.resIcon)
			end

			Drop = var_9_2

			local var_9_3 = var_9_2.Create(var_9_0)

			updateDrop = var_6

			var_6(arg_9_2:Find("award/mask"), var_9_3, {
				hideName = true
			})

			local var_9_4 = var_9_3.type

			DROP_TYPE_ITEM = var_7

			if var_9_4 == var_7 then
				local var_9_5 = var_9_3:getSubClass()

				if var_9_4.getConfig(var_9_5, "type") == 9 then
					setActive = var_9_4

					var_9_4(arg_9_2:Find("award/specialFrame"), true)

					goto label_9_0
				end
			end

			setActive = var_9_4

			var_9_4(arg_9_2:Find("award/specialFrame"), false)

			::label_9_0::

			onButton = var_9_4

			local var_9_6 = arg_8_0
			local var_9_7 = arg_9_2:Find("award")

			local function var_9_8()
				local var_10_0 = arg_8_0
				local var_10_1 = var_0.emit

				BaseUI = var_3_10002

				var_10_1(var_10_0, var_3_10002.ON_DROP, var_9_3)

				return
			end

			SFX_PANEL = var_10

			var_9_4(var_9_6, var_9_7, var_9_8, var_10)

			local var_9_9 = arg_8_0.ptData
			local var_9_10 = var_6.GetDroptItemState(var_9_9, arg_9_1 + 1)

			ActivityPtData = var_9_9

			if var_9_10 == var_9_9.STATE_LOCK then
				setActive = var_7

				var_7(arg_9_2:Find("mask_get"), false)

				setActive = var_7

				var_7(arg_9_2:Find("mask_got"), false)
			else
				ActivityPtData = var_7

				if var_9_10 == var_7.STATE_CAN_GET then
					setActive = var_7

					var_7(arg_9_2:Find("mask_get"), true)

					setActive = var_7

					var_7(arg_9_2:Find("mask_got"), false)
				else
					setActive = var_7

					var_7(arg_9_2:Find("mask_get"), false)

					setActive = var_7

					var_7(arg_9_2:Find("mask_got"), true)
				end
			end
		end

		return
	end)

	local var_8_1 = arg_8_0.UIlist

	var_4.align(var_8_1, #arg_8_1)

	local var_8_2 = arg_8_0.scrollPanel
	local var_8_3 = var_4.GetComponent(var_8_2, "ScrollRect")

	scrollTo = var_8_2

	var_8_2(arg_8_0.scrollPanel, 0, 1 - arg_8_3 * 17 / (#arg_8_2 * 17 - 7 - 591))

	local var_8_4 = arg_8_0.ptData

	if var_5.CanGetAward(var_8_4) then
		setActive = var_5

		var_5(arg_8_0.getBtn, true)

		onButton = var_5

		local var_8_5 = arg_8_0
		local var_8_6 = arg_8_0.getBtn

		local function var_8_7()
			local var_11_0 = {}
			local var_11_1 = {}
			local var_11_2 = arg_8_0.ptData
			local var_11_3 = var_2.GetLevel(var_11_2)
			local var_11_4 = arg_8_0.ptData
			local var_11_5 = var_3.GetCurrLevel(var_11_4)

			for iter_11_0 = var_11_3 + 1, var_11_5 do
				var_2_10008 = arg_8_1[iter_11_0]

				local var_11_6 = false

				pairs = var_2_10010

				for iter_11_1, iter_11_2 in var_2_10010(var_11_1) do
					if iter_11_2[1] == var_2_10008[1] and iter_11_2[2] == var_2_10008[2] then
						var_11_6 = true
						iter_11_2[3] = iter_11_2[3] + var_2_10008[3]

						break
					end
				end

				if not var_11_6 then
					table = var_2_10010

					var_2_10010.insert(var_11_1, var_2_10008)
				end
			end

			getProxy = var_4
			PlayerProxy = var_5

			local var_11_7 = var_4(var_5)
			local var_11_8 = var_4.getRawData(var_11_7)

			pg = var_11_7

			local var_11_9 = var_11_7.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = iter_11_0

			if iter_11_0 then
				iter_11_0 = 0
			else
				getProxy = iter_11_0
				BagProxy = var_2_10008
				var_2_10008 = iter_11_0(var_2_10008)
				iter_11_0 = iter_11_0.GetLimitCntById(var_2_10008, var_11_9)
			end

			Task = var_2_10008

			local var_11_10, var_11_11 = var_2_10008.StaticJudgeOverflow(var_11_8.gold, var_11_8.oil, iter_11_0, true, true, var_11_1)

			if var_11_10 then
				table = var_10

				var_10.insert(var_11_0, function(arg_12_0)
					pg = var_3_10001

					local var_12_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_12_1 = var_1.ShowMsgBox
					local var_12_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10004
					var_12_2.type = var_3_10004
					i18n = var_3_10004
					var_12_2.content = var_3_10004("award_max_warning")
					var_12_2.items = var_11_11
					var_12_2.onYes = arg_12_0

					var_12_1(var_12_0, var_12_2)

					return
				end)
			end

			seriesAsync = var_10

			var_10(var_11_0, function()
				local var_13_0 = arg_8_0.ptData
				local var_13_1 = var_0.GetCurrTarget(var_13_0)
				local var_13_2 = arg_8_0
				local var_13_3 = var_1.emit

				ChildishnessSchoolPtMediator = var_3_10003

				local var_13_4 = var_3_10003.EVENT_PT_OPERATION
				local var_13_5 = {
					cmd = 4
				}
				local var_13_6 = arg_8_0.ptData

				var_13_5.activity_id = var_5.GetId(var_13_6)
				var_13_5.arg1 = var_13_1

				var_13_3(var_13_2, var_13_4, var_13_5)

				return
			end)

			return
		end

		SFX_PANEL = var_9

		var_5(var_8_5, var_8_6, var_8_7, var_9)
	else
		setActive = var_5

		var_5(arg_8_0.getBtn, false)

		removeOnButton = var_5

		var_5(arg_8_0.getBtn)
	end

	return
end

function var_0_1.updateResIcon(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 == 2 or arg_14_3 ~= 3 and arg_14_3 ~= 4 and arg_14_3 ~= 5 and arg_14_3 ~= 6 then
		if arg_14_1 then
			Drop = var_1_10004

			local var_14_0 = var_1_10004.New
			local var_14_1 = {}

			DROP_TYPE_RESOURCE = var_1_10006
			var_14_1.type = var_1_10006
			var_14_1.id = arg_14_1

			local var_14_2 = var_14_0(var_14_1)

			arg_14_0.resIcon = var_4.getIcon(var_14_2)
		elseif arg_14_2 then
			arg_14_0.resIcon = arg_14_2
		end
	end

	return
end

function var_0_1.UpdatePtData(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_15_2 = var_15_1(var_15_0, var_1_10003.ALVIT_PT_ACT_ID)

	ActivityPtData = var_15_0
	arg_15_0.ptData = var_15_0.New(var_15_2)

	return
end

function var_0_1.willExit(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf)

	return
end

return var_0_1
