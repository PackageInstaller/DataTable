local Transition = class("Transition", import("..base.BaseUI"))

function Transition:getUIName()
	local var_1_0 = self.UIName

	if not self.UIName then
		var_1_0 = self.contextData.loadUI
		self.UIName = self.contextData.loadUI
	end

	return var_1_0
end

function Transition:init()
	return
end

function Transition:didEnter()
	return
end

function Transition:onBackPressed()
	return
end

return Transition
