local OutPostCoreActivityUI = class("OutPostCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function OutPostCoreActivityUI:getUIName()
	return "OutPostCoreActivityUI"
end

function OutPostCoreActivityUI:ActiveScenarioLayer(arg_2_1)
	self.contextData.activeScenario = arg_2_1

	return
end

return OutPostCoreActivityUI
