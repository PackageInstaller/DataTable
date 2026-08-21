local var_0_0 = class("MedalDetailPanel")

var_0_0.setColorstateText = "#73757f"
var_0_0.setColorstate = "#ed4646"

function var_0_0.SetIconScale(arg_1_0, arg_1_1)
	arg_1_0._iconScale = Vector2.New(arg_1_1, arg_1_1)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform
	arg_2_0._parent = arg_2_2

	pg.DelegateInfo.New(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0._mask = findTF(arg_3_0._tf, "mask")
	arg_3_0._medalIcon = findTF(arg_3_0._tf, "icon")
	arg_3_0._medalLock = findTF(arg_3_0._tf, "lock")
	arg_3_0._nameText = findTF(arg_3_0._tf, "name")
	arg_3_0._descText = findTF(arg_3_0._tf, "desc")
	arg_3_0._progressBG = findTF(arg_3_0._tf, "progress")
	arg_3_0._progressText = findTF(arg_3_0._tf, "progress/label")
	arg_3_0._conditionText = findTF(arg_3_0._tf, "condition")
	arg_3_0._stateText = findTF(arg_3_0._tf, "state")
	arg_3_0._prevBtn = findTF(arg_3_0._tf, "prevBtn")
	arg_3_0._nextBtn = findTF(arg_3_0._tf, "nextBtn")
	arg_3_0._closeBtn = findTF(arg_3_0._tf, "backbtn")

	onButton(arg_3_0, arg_3_0._mask, function()
		if arg_3_0._parent.DETAIL_CLOSE_ANIM and arg_3_0._parent.DETAIL_CLOSE_ANIM_Time then
			quickPlayAnimation(arg_3_0._go, arg_3_0._parent.DETAIL_CLOSE_ANIM)
			onDelayTick(function()
				arg_3_0:SetActive(false)

				return
			end, arg_3_0._parent.DETAIL_CLOSE_ANIM_Time)
		else
			arg_3_0:SetActive(false)
		end

		return
	end, SFX_CANCEL)

	if arg_3_0._closeBtn then
		onButton(arg_3_0, arg_3_0._closeBtn, function()
			if arg_3_0._parent.DETAIL_CLOSE_ANIM and arg_3_0._parent.DETAIL_CLOSE_ANIM_Time then
				quickPlayAnimation(arg_3_0._go, arg_3_0._parent.DETAIL_CLOSE_ANIM)
				onDelayTick(function()
					arg_3_0:SetActive(false)

					return
				end, arg_3_0._parent.DETAIL_CLOSE_ANIM_Time)
			else
				arg_3_0:SetActive(false)
			end

			return
		end, SFX_CANCEL)
	end

	onButton(arg_3_0, arg_3_0._prevBtn, function()
		arg_3_0._currentIndex = math.max(arg_3_0._currentIndex - 1, 1)

		arg_3_0:UpdateMedal()

		return
	end)
	onButton(arg_3_0, arg_3_0._nextBtn, function()
		arg_3_0._currentIndex = math.min(arg_3_0._currentIndex + 1, #arg_3_0._medalGroup:GetMedalIds())

		arg_3_0:UpdateMedal()

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
	local var_12_0 = arg_12_0._medalGroup:GetMedalIds()[arg_12_0._currentIndex]

	arg_12_0._medal = arg_12_0._medalGroup:GetMedalList()[var_12_0]

	local var_12_1 = pg.activity_medal_template[var_12_0]

	setText(arg_12_0._nameText, pg.activity_medal_template[var_12_0].activity_medal_name)
	setText(arg_12_0._descText, var_12_1.activity_medal_desc)

	if arg_12_0._medal.timeStamp then
		LoadImageSpriteAsync("activitymedal/" .. var_12_0, arg_12_0._medalIcon, true)
	else
		LoadImageSpriteAsync("activitymedal/" .. var_12_0 .. "_l", arg_12_0._medalIcon, true)
	end

	arg_12_0._medalIcon.transform.localScale = arg_12_0._iconScale

	SetActive(arg_12_0._medalLock, not arg_12_0._medal.timeStamp)

	if arg_12_0._medal.timeStamp then
		setText(arg_12_0._conditionText, i18n("word_gain_date") .. pg.TimeMgr.GetInstance():CTimeDescC(arg_12_0._medal.timeStamp, "%Y/%m/%d"))
		setText(arg_12_0._progressText, i18n("word_unlock"))
	else
		setText(arg_12_0._conditionText, pg.task_data_template[var_12_1.task_id].desc)
		setText(arg_12_0._progressText, i18n("word_lock"))
	end

	local var_12_2 = findTF(arg_12_0._tf, "progress/lock")

	if var_12_2 then
		SetActive(var_12_2, not arg_12_0._medal.timeStamp)
	end

	local var_12_3 = arg_12_0._medalGroup:GetMedalGroupState()

	if var_12_3 == ActivityMedalGroup.STATE_EXPIRE then
		setText(arg_12_0._stateText, setColorStr(i18n("word_cant_gain_anymore"), var_12_4))
	elseif var_12_3 == ActivityMedalGroup.STATE_CLOSE then
		setText(arg_12_0._stateText, setColorStr(i18n("word_activity_not_open"), var_12_5))
	end

	SetActive(arg_12_0._stateText, var_12_3 ~= ActivityMedalGroup.STATE_ACTIVE)
	SetActive(arg_12_0._prevBtn, arg_12_0._currentIndex ~= 1)
	SetActive(arg_12_0._nextBtn, arg_12_0._currentIndex ~= #arg_12_0._medalGroup:GetMedalIds())

	return
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	SetActive(arg_13_0._go, arg_13_1)

	arg_13_0._active = arg_13_1

	if arg_13_1 then
		pg.UIMgr.GetInstance():BlurPanel(arg_13_0._go)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._go, arg_13_0._parent._tf)
	end

	return
end

function var_0_0.IsActive(arg_14_0)
	return arg_14_0._active
end

function var_0_0.Dispose(arg_15_0)
	pg.DelegateInfo.Dispose(arg_15_0)

	return
end

return var_0_0
