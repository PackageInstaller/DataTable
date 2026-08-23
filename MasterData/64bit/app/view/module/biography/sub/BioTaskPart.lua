local BioTaskPart = class("BioTaskPart", require("app.fairyGUI.biography.UI_BioTaskPart"))

function BioTaskPart:ctor()
	self._ownerStage = nil
	self._refMissionArr = nil

	self:_initDefaultData()
	self:_initRegisterUI()
end

function BioTaskPart:onLoad()
	return
end

function BioTaskPart:onUnload()
	self._ownerStage = nil
	self._refMissionArr = nil
end

function BioTaskPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function BioTaskPart:refreshTask(arg_5_1)
	local var_5_0 = g.core.model.User.bioData:getChain(arg_5_1.chains[1])

	self._refMissionArr = var_5_0.missions

	self.m_taskList:setNumItems(#self._refMissionArr)
	self.m_taskList:scrollToView((math.max(var_5_0.current - 2, 0)))
end

function BioTaskPart:_initDefaultData()
	return
end

function BioTaskPart:_initRegisterUI()
	self.m_taskList:setIniter()
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
end

function BioTaskPart:_onRenderTaskList(arg_8_1, arg_8_2)
	arg_8_2:updateData(self._refMissionArr[arg_8_1 + 1])
end

return BioTaskPart
