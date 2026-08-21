local var_0_0 = class("GMActivityItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:Show(true)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if arg_2_0.activityID_ ~= arg_2_1 then
		arg_2_0.toggle_.isOn = false
	end

	arg_2_0.activityID_ = arg_2_1

	local var_2_0 = ActivityData:GetActivityData(arg_2_1)
	local var_2_1 = var_2_0.startTime
	local var_2_2 = var_2_0.stopTime
	local var_2_3
	local var_2_4

	if var_2_1 == 0 then
		var_2_4 = ""
	else
		local var_2_5 = string.format("<size=25>%s-%s</size>", manager.time:STimeDescS(var_2_1, "!%m/%d %H:%M"), manager.time:STimeDescS(var_2_2, "!%m/%d %H:%M"))
		local var_2_6
		local var_2_7 = var_2_2 < manager.time:GetServerTime() and "#000000" or var_2_1 < manager.time:GetServerTime() and "blue" or "red"

		var_2_4 = string.format("(<color=%s>%s</color>)", var_2_7, var_2_5)
	end

	if #ActivityCfg[arg_2_1].sub_activity_list <= 0 then
		arg_2_0.text_.text = string.format("<b>Φ</b>%s-%s%s", arg_2_1, GetI18NText(ActivityCfg[arg_2_1].remark), var_2_4)
	else
		arg_2_0.text_.text = string.format("%s-%s%s", arg_2_1, GetI18NText(ActivityCfg[arg_2_1].remark), var_2_4)
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddToggleListener(arg_4_0.toggle_, function(arg_5_0)
		GMData:EnabledActivity(arg_4_0.activityID_, arg_5_0)
	end)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.gameObject_:SetActive(arg_6_1)
end

function var_0_0.SelectItem(arg_7_0, arg_7_1)
	arg_7_0.toggle_.isOn = arg_7_1
end

return var_0_0
