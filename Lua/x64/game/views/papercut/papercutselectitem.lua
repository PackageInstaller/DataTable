local var_0_0 = class("PaperCutSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_4_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_4_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutData:SetSelectActivityID(arg_4_0.activityID_)

		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.activityID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.activityID_ == nil then
		local var_6_0 = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, arg_6_2)

		manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_0)
	elseif arg_6_0.activityID_ ~= arg_6_2 then
		local var_6_1 = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, arg_6_0.activityID_)

		manager.redPoint:unbindUIandKey(arg_6_0.transform_, var_6_1)

		local var_6_2 = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, arg_6_2)

		manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_2)
	end

	arg_6_0.activityID_ = arg_6_2
	arg_6_0.mainActivityID_ = arg_6_1
	arg_6_0.startTime_ = ActivityData:GetActivityData(arg_6_0.activityID_).startTime
	arg_6_0.stopTime_ = ActivityData:GetActivityData(arg_6_0.activityID_).stopTime

	arg_6_0:RefreshUI()
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.clickHandler_ = nil

	arg_8_0:UnRegisterRedPoint()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RefreshLock(arg_9_0)
	if arg_9_0.isLock_ == false then
		return
	end

	arg_9_0.isLock_ = manager.time:GetServerTime() < arg_9_0.startTime_

	if arg_9_0.isLock_ == true then
		arg_9_0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_9_0.startTime_))
	else
		arg_9_0.statusController_:SetSelectedState("uncomplete")
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.isLock_ = manager.time:GetServerTime() < arg_10_0.startTime_

	if arg_10_0.isLock_ == true then
		arg_10_0.statusController_:SetSelectedState("lock")

		arg_10_0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_10_0.startTime_))
	elseif PaperCutData:GetPlayedList(arg_10_0.activityID_) == true then
		arg_10_0.statusController_:SetSelectedState("completed")

		arg_10_0.icon_.color = Color(1, 0.8117647058823529, 0.5294117647058824, 1)

		local var_10_0 = PaperCutData:GetScore(arg_10_0.activityID_) or 0

		arg_10_0.scoreText_.text = var_10_0
	else
		arg_10_0.statusController_:SetSelectedState("uncomplete")

		arg_10_0.icon_.color = Color(0.7019607843137254, 0.5215686274509804, 0.4588235294117647, 1)
	end

	arg_10_0:RefreshImage()
	arg_10_0:RefreshTitle()
end

function var_0_0.RefreshImage(arg_11_0)
	arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. PaperCutCfg[arg_11_0.activityID_].picture)
end

function var_0_0.RefreshTitle(arg_12_0)
	arg_12_0.titleText_.text = GetI18NText(PaperCutCfg[arg_12_0.activityID_].name)
end

function var_0_0.UnRegisterRedPoint(arg_13_0)
	local var_13_0 = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_13_0.mainActivityID_, arg_13_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_13_0.transform_, var_13_0)
end

return var_0_0
