local var_0_0 = class("SubPageStep", import(".StoryStep"))
local var_0_1 = "MonopolyCar2026SetNamePage"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.page = arg_1_1.name

	if arg_1_1.type == 1 then
		arg_1_0.page = var_0_1
	end

	return
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_SUBPAGE
end

function var_0_0.GetSubPageCls(arg_3_0)
	return _G[arg_3_0.page]
end

function var_0_0.ShouldShowSubPage(arg_4_0)
	if arg_4_0.page == var_0_1 then
		local var_4_0 = getProxy(ActivityProxy)
		local var_4_1 = var_4_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

		if not var_4_1 or var_4_1:isEnd() then
			return false
		end

		local var_4_2 = var_4_0:RawGetActivityById(var_4_1:getConfig("config_client").link_act)

		return var_4_2 and not var_4_2:isEnd() and not pg.NewStoryMgr.GetInstance():IsReView()
	else
		return true
	end

	return
end

return var_0_0
