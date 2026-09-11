local JumpToStep = class("JumpToStep", BaseStep)

function JumpToStep:Init(arg_1_1)
	self._isNoHome = self._guide.is_no_home
	self._linkData = GuideStepCfg[self._stepId].params
end

function JumpToStep:Play()
	if self._linkData[1] == 101 or self._isNoHome then
		gameContext:ClearHistory()
	end

	local var_2_0, var_2_1 = JumpTools.GetLinkAndParams(self._linkData)

	JumpTools.OpenPageUntilLoaded(var_2_0, var_2_1)
	self:OnStepEnd()
end

function JumpToStep:Check()
	if (whereami == "home" or manager.windowBar:GetWhereTag() == "qworld") and not LuaExchangeHelper.GetSceneIsHanding() then
		return true
	else
		return false
	end
end

return JumpToStep
