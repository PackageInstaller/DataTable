local SubPageStep = class("SubPageStep", import(".StoryStep"))
local var_0_1 = "MonopolyCar2026SetNamePage"

function SubPageStep:Ctor(arg_1_1)
	SubPageStep.super.Ctor(self, arg_1_1)

	self.page = arg_1_1.name

	if arg_1_1.type == 1 then
		self.page = var_0_1
	end

	return
end

function SubPageStep:GetMode()
	return Story.MODE_SUBPAGE
end

function SubPageStep:GetSubPageCls()
	return _G[self.page]
end

function SubPageStep:ShouldShowSubPage()
	if self.page == var_0_1 then
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

return SubPageStep
