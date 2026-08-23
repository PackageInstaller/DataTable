local var_0_0 = g.core.model.User.themeData
local ThemeBioTaskPart = class("ThemeBioTaskPart", require("app.fairyGUI.themeBio.UI_ThemeBioTaskPart"))

function ThemeBioTaskPart:ctor()
	self._ownerStage = nil
	self._refMissionArr = nil

	self:_initRegisterUI()
end

function ThemeBioTaskPart:onLoad()
	return
end

function ThemeBioTaskPart:onUnload()
	self._ownerStage = nil
	self._refMissionArr = nil
end

function ThemeBioTaskPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function ThemeBioTaskPart:refreshTask(arg_5_1, arg_5_2)
	self._activeThemeValue = arg_5_2 or 1
	self._themeBioData = var_0_0:getThemeData(self._activeThemeValue):getThemeBioData()

	local var_5_0 = self._themeBioData:getChain(arg_5_1.chains[1])

	self._refMissionArr = var_5_0.missions

	self.m_taskList:setNumItems(#self._refMissionArr)
	self.m_taskList:scrollToView((math.max(var_5_0.current - 2, 0)))
end

function ThemeBioTaskPart:_initRegisterUI()
	self.m_taskList:setIniter()
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
end

function ThemeBioTaskPart:_onRenderTaskList(arg_7_1, arg_7_2)
	arg_7_2:updateData(self._refMissionArr[arg_7_1 + 1], self._activeThemeValue)
end

return ThemeBioTaskPart
