local var_0_0 = g.core.config.gve_equipment_resource_info
local GveHalidomSelectJobComp = class("GveHalidomSelectJobComp", require("app.fairyGUI.gve.UI_GveHalidomSelectJobComp"))

function GveHalidomSelectJobComp:ctor()
	self.m_selectBtn:addClickListener(handler(self, self._onSelectJobBtnClick))
	self.m_halidomJobList:setVirtual()
	self.m_halidomJobList:setItemRenderer(handler(self, self._onHalidomJobItemItemRenderer))
	self.m_halidomJobList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeHalidomJob))
end

function GveHalidomSelectJobComp:onLoad()
	self.m_expandJobController:setSelectedIndex(0)
end

function GveHalidomSelectJobComp:_onSelectJobBtnClick()
	local var_3_0 = self.m_expandJobController:getSelectedIndex() ~= 1

	self.m_expandJobController:setSelectedIndex(var_3_0 and 1 or 0)

	if var_3_0 then
		local var_3_1 = var_0_0.getLength()

		self.m_halidomJobList:setNumItems(var_3_1)
		self.m_halidomJobList:resizeToFit(var_3_1)
	end
end

function GveHalidomSelectJobComp:_onHalidomJobItemItemRenderer(arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.indexOf(arg_4_1 + 1)

	if var_4_0 then
		arg_4_2:setTitle(var_4_0.name)
		arg_4_2:setCtrlState("isShowLine", {
			index = arg_4_1 + 1 == var_0_0.getLength() and 1 or 0
		})
	end
end

function GveHalidomSelectJobComp:_onChangeHalidomJob(arg_5_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SWITCH)

	local var_5_0 = var_0_0.indexOf(arg_5_1:getDataValue() + 1)

	if var_5_0 then
		self.m_selectBtn:setTitle(var_5_0.name)
		self:dispatchCompEvent("SELECT_HALIDOM_JOB", {
			tag = var_5_0.job
		})
	end

	self:_onSelectJobBtnClick()
end

return GveHalidomSelectJobComp
