class = var_0_10000

local var_0_0 = "SubPageStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryStep"))
local var_0_2 = "MonopolyCar2026SetNamePage"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.page = arg_1_1.name

	if arg_1_1.type == 1 then
		arg_1_0.page = var_0_2
	end

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_SUBPAGE
end

function var_0_1.GetSubPageCls(arg_3_0)
	_G = var_1_10001

	return var_1_10001[arg_3_0.page]
end

function var_0_1.ShouldShowSubPage(arg_4_0)
	if arg_4_0.page == var_0_2 then
		getProxy = var_1
		ActivityProxy = var_1_10003

		local var_4_0 = var_1(var_1_10003)
		local var_4_1 = var_1.getActivityByType

		ActivityConst = var_1_10005

		if not var_4_1(var_4_0, var_1_10005.ACTIVITY_TYPE_MONOPOLY) or var_2:isEnd() then
			return false
		end

		local var_4_2 = var_2
		local var_4_3 = var_2.getConfig(var_4_2, "config_client").link_act
		local var_4_4 = var_1:RawGetActivityById(var_4_3)

		pg = var_4_2

		local var_4_5 = var_4_2.NewStoryMgr.GetInstance()
		local var_4_6 = var_5.IsReView(var_4_5)

		return var_4_4 and not var_4_4:isEnd() and not var_4_6
	else
		return true
	end

	return
end

return var_0_1
