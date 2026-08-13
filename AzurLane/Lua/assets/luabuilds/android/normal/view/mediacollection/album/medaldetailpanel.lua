class = var_0_10000

local var_0_0 = var_0_10000("MedalDetailPanel")

var_0_0.setColorstateText = "#73757f"
var_0_0.setColorstate = "#ed4646"

function var_0_0.SetIconScale(arg_1_0, arg_1_1)
	Vector2 = var_1_10002
	arg_1_0._iconScale = var_1_10002.New(arg_1_1, arg_1_1)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform
	arg_2_0._parent = arg_2_2
	pg = var_3

	var_3.DelegateInfo.New(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_0.InitUI(arg_3_0)
	findTF = var_1_10001
	arg_3_0._mask = var_1_10001(arg_3_0._tf, "mask")
	findTF = var_1
	arg_3_0._medalIcon = var_1(arg_3_0._tf, "icon")
	findTF = var_1
	arg_3_0._medalLock = var_1(arg_3_0._tf, "lock")
	findTF = var_1
	arg_3_0._nameText = var_1(arg_3_0._tf, "name")
	findTF = var_1
	arg_3_0._descText = var_1(arg_3_0._tf, "desc")
	findTF = var_1
	arg_3_0._progressBG = var_1(arg_3_0._tf, "progress")
	findTF = var_1
	arg_3_0._progressText = var_1(arg_3_0._tf, "progress/label")
	findTF = var_1
	arg_3_0._conditionText = var_1(arg_3_0._tf, "condition")
	findTF = var_1
	arg_3_0._stateText = var_1(arg_3_0._tf, "state")
	findTF = var_1
	arg_3_0._prevBtn = var_1(arg_3_0._tf, "prevBtn")
	findTF = var_1
	arg_3_0._nextBtn = var_1(arg_3_0._tf, "nextBtn")
	findTF = var_1
	arg_3_0._closeBtn = var_1(arg_3_0._tf, "backbtn")
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._mask

	local function var_3_2()
		if arg_3_0._parent.DETAIL_CLOSE_ANIM and arg_3_0._parent.DETAIL_CLOSE_ANIM_Time then
			quickPlayAnimation = var_0

			var_0(arg_3_0._go, arg_3_0._parent.DETAIL_CLOSE_ANIM)

			onDelayTick = var_0

			var_0(function()
				local var_5_0 = arg_3_0

				var_0.SetActive(var_5_0, false)

				return
			end, arg_3_0._parent.DETAIL_CLOSE_ANIM_Time)
		else
			local var_4_0 = arg_3_0

			var_0.SetActive(var_4_0, false)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	if arg_3_0._closeBtn then
		onButton = var_1

		local var_3_3 = arg_3_0
		local var_3_4 = arg_3_0._closeBtn

		local function var_3_5()
			if arg_3_0._parent.DETAIL_CLOSE_ANIM and arg_3_0._parent.DETAIL_CLOSE_ANIM_Time then
				quickPlayAnimation = var_0

				var_0(arg_3_0._go, arg_3_0._parent.DETAIL_CLOSE_ANIM)

				onDelayTick = var_0

				var_0(function()
					local var_7_0 = arg_3_0

					var_0.SetActive(var_7_0, false)

					return
				end, arg_3_0._parent.DETAIL_CLOSE_ANIM_Time)
			else
				local var_6_0 = arg_3_0

				var_0.SetActive(var_6_0, false)
			end

			return
		end

		SFX_CANCEL = var_1_10005

		var_1(var_3_3, var_3_4, var_3_5, var_1_10005)
	end

	onButton = var_1

	var_1(arg_3_0, arg_3_0._prevBtn, function()
		local var_8_0 = arg_3_0

		math = var_2_10001
		var_8_0._currentIndex = var_2_10001.max(arg_3_0._currentIndex - 1, 1)

		local var_8_1 = arg_3_0

		var_0.UpdateMedal(var_8_1)

		return
	end)

	onButton = var_1

	var_1(arg_3_0, arg_3_0._nextBtn, function()
		local var_9_0 = arg_3_0

		math = var_2_10001

		local var_9_1 = var_2_10001.min
		local var_9_2 = arg_3_0._currentIndex + 1
		local var_9_3 = arg_3_0._medalGroup

		var_9_0._currentIndex = var_9_1(var_9_2, #var_3.GetMedalIds(var_9_3))

		local var_9_4 = arg_3_0

		var_0.UpdateMedal(var_9_4)

		return
	end)

	return
end

function var_0_0.SetMedalGroup(arg_10_0, arg_10_1)
	arg_10_0._medalGroup = arg_10_1

	return
end

function var_0_0.SetCurrentIndex(arg_11_0, arg_11_1)
	arg_11_0._currentIndex = arg_11_1

	return
end

function var_0_0.UpdateMedal(arg_12_0)
	local var_12_0 = arg_12_0._medalGroup
	local var_12_1 = var_1.GetMedalIds(var_12_0)[arg_12_0._currentIndex]
	local var_12_2 = arg_12_0._medalGroup

	arg_12_0._medal = var_2.GetMedalList(var_12_2)[var_12_1]
	pg = var_2

	local var_12_3 = var_2.activity_medal_template[var_12_1]

	setText = var_12_2

	var_12_2(arg_12_0._nameText, var_12_3.activity_medal_name)

	setText = var_12_2

	var_12_2(arg_12_0._descText, var_12_3.activity_medal_desc)

	if arg_12_0._medal.timeStamp then
		LoadImageSpriteAsync = var_3

		var_3("activitymedal/" .. var_12_1, arg_12_0._medalIcon, true)
	else
		LoadImageSpriteAsync = var_3

		var_3("activitymedal/" .. var_12_1 .. "_l", arg_12_0._medalIcon, true)
	end

	local var_12_4 = arg_12_0._medalIcon.transform

	var_12_4.localScale = arg_12_0._iconScale
	SetActive = var_12_4

	var_12_4(arg_12_0._medalLock, not arg_12_0._medal.timeStamp)

	local var_12_6

	if arg_12_0._medal.timeStamp then
		setText = var_3

		local var_12_5 = arg_12_0._conditionText

		i18n = var_12_6
		var_12_6 = var_12_6("word_gain_date")
		pg = var_6
		var_1_10007 = var_6.TimeMgr.GetInstance()

		var_3(var_12_5, var_12_6 .. var_6.CTimeDescC(var_1_10007, arg_12_0._medal.timeStamp, "%Y/%m/%d"))

		setText = var_3

		local var_12_7 = arg_12_0._progressText

		i18n = var_12_6

		var_3(var_12_7, var_12_6("word_unlock"))
	else
		setText = var_3

		local var_12_8 = arg_12_0._conditionText

		pg = var_12_6

		var_3(var_12_8, var_12_6.task_data_template[var_12_3.task_id].desc)

		setText = var_3

		local var_12_9 = arg_12_0._progressText

		i18n = var_5

		var_3(var_12_9, var_5("word_lock"))
	end

	findTF = var_3

	if var_3(arg_12_0._tf, "progress/lock") then
		SetActive = var_4

		var_4(var_3, not arg_12_0._medal.timeStamp)
	end

	local var_12_10 = arg_12_0._medalGroup
	local var_12_11 = var_4.GetMedalGroupState(var_12_10)

	ActivityMedalGroup = var_12_10

	if var_12_11 == var_12_10.STATE_EXPIRE then
		setText = var_5

		local var_12_12 = arg_12_0._stateText

		setColorStr = var_1_10007
		i18n = var_1_10008
		var_1_10008 = var_1_10008("word_cant_gain_anymore")

		local var_12_13

		if not arg_12_0._parent.setColorstateText then
			var_12_13 = arg_12_0.setColorstateText
		end

		var_5(var_12_12, var_1_10007(var_1_10008, var_12_13))
	else
		ActivityMedalGroup = var_5

		if var_12_11 == var_5.STATE_CLOSE then
			setText = var_5

			local var_12_14 = arg_12_0._stateText

			setColorStr = var_1_10007
			i18n = var_1_10008

			local var_12_15 = var_1_10008("word_activity_not_open")
			local var_12_16

			if not arg_12_0._parent.setColorstate then
				var_12_16 = arg_12_0.setColorstate
			end

			var_5(var_12_14, var_1_10007(var_12_15, var_12_16))
		end
	end

	SetActive = var_5

	local var_12_17 = arg_12_0._stateText

	ActivityMedalGroup = var_1_10007

	var_5(var_12_17, var_12_11 ~= var_1_10007.STATE_ACTIVE)

	SetActive = var_5

	var_5(arg_12_0._prevBtn, arg_12_0._currentIndex ~= 1)

	SetActive = var_5

	local var_12_18 = arg_12_0._nextBtn
	local var_12_19 = arg_12_0._currentIndex
	local var_12_20 = arg_12_0._medalGroup

	var_5(var_12_18, var_12_19 ~= #var_8.GetMedalIds(var_12_20))

	return
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	SetActive = var_1_10002

	var_1_10002(arg_13_0._go, arg_13_1)

	arg_13_0._active = arg_13_1

	if arg_13_1 then
		pg = var_1_10002

		local var_13_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_13_0, arg_13_0._go)
	else
		pg = var_1_10002

		local var_13_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_13_1, arg_13_0._go, arg_13_0._parent._tf)
	end

	return
end

function var_0_0.IsActive(arg_14_0)
	return arg_14_0._active
end

function var_0_0.Dispose(arg_15_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
