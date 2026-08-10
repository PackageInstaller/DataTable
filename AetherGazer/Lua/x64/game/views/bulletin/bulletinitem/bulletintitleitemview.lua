local var_0_0 = class("BulletinTitleItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:SetViewProp("bulletinID", arg_1_2)
	arg_1_0:SetViewProp("contentIndex", arg_1_3)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()
	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	if arg_2_0.time_ then
		arg_2_0.timt_:Stop()

		arg_2_0.time_ = nil
	end

	arg_2_0:RemoveListeners()
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.titleText_ = arg_3_0:FindCom(typeof(Text), "titleText")
	arg_3_0.timeText_ = arg_3_0:FindCom(typeof(Text), "time/text")
	arg_3_0.blueImg_ = arg_3_0:FindCom(typeof(RectTransform), "blueImg")
	arg_3_0.titleTrs_ = arg_3_0:FindCom(typeof(RectTransform), "titleText")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.RemoveListeners(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.titleText_.text = GetI18NText(arg_6_0:GetContent(arg_6_0:GetViewProp("bulletinID"), arg_6_0:GetViewProp("contentIndex")).text)
	arg_6_0.timeText_.text = TimeMgr.GetInstance():STimeDescS(arg_6_0:GetTimestamp(arg_6_0:GetViewProp("bulletinID")), "!%Y/%m/%d")
	arg_6_0.time_ = Timer.New(function()
		arg_6_0.blueImg_.sizeDelta = Vector2(arg_6_0.titleTrs_.rect.width + 10, arg_6_0.blueImg_.sizeDelta.y)
		arg_6_0.time_ = nil
	end, 0.05, 1)

	arg_6_0.time_:Start()
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.GetTimestamp(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_8_1.id == arg_8_1 then
			local var_8_0 = TimeMgr.GetInstance():GetServerTime()

			return iter_8_1.startTime
		end
	end
end

function var_0_0.GetContent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = SettingData:GetCurrentLanguage()

	for iter_9_0, iter_9_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_9_1.id == arg_9_1 then
			if var_9_0 and iter_9_1.i18n_info_content[var_9_0] then
				return iter_9_1.i18n_info_content[var_9_0][arg_9_2]
			else
				return iter_9_1.content[arg_9_2]
			end
		end
	end
end

return var_0_0
