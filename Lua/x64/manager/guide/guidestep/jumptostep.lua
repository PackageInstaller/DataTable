local var_0_0 = class("JumpToStep", BaseStep)

function var_0_0.Init(arg_1_0, arg_1_1)
	local var_1_0 = GuideStepCfg[arg_1_0._stepId]

	arg_1_0._isNoHome = arg_1_0._guide.is_no_home
	arg_1_0._linkData = var_1_0.params
end

function var_0_0.Play(arg_2_0)
	if arg_2_0._linkData[1] == 101 or arg_2_0._isNoHome then
		gameContext:ClearHistory()
	end

	local var_2_0, var_2_1 = JumpTools.GetLinkAndParams(arg_2_0._linkData)

	JumpTools.OpenPageUntilLoaded(var_2_0, var_2_1)
	arg_2_0:OnStepEnd()
end

function var_0_0.Check(arg_3_0)
	if (whereami == "home" or manager.windowBar:GetWhereTag() == "qworld") and not LuaExchangeHelper.GetSceneIsHanding() then
		return true
	else
		return false
	end
end

return var_0_0
