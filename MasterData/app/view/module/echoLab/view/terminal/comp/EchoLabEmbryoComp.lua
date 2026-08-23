local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local EchoLabEmbryoComp = class("EchoLabEmbryoComp", require("app.fairyGUI.echoLab.UI_EchoLabLeftEmbryoComp"))

function EchoLabEmbryoComp:ctor()
	self._ctrlType = 0
	self._cardType = 0

	self:addClickListener(handler(self, self._onClick))
	self.m_slotList:setIniter()
	self.m_slotList:setItemRenderer(handler(self, self._onRendererslotList))
end

function EchoLabEmbryoComp:onLoad()
	self:_updateEchoLabComp()
end

function EchoLabEmbryoComp:_updateEchoLabComp()
	self._ctrlType = self.m_typeController:getSelectedIndex() + 1
	self._cardType = var_0_0.EchoLabNameArray[self._ctrlType].cardType

	local var_3_0 = var_0_1:getLineUpAttr(self._cardType)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_1, var_3_2 = g.core.lang:getAttr(iter_3_0, iter_3_1, false)

		self.m_descTxt:setText(var_3_1 .. g.core.lang:get(408515, {
			num = iter_3_1 / 10
		}))
	end

	if table.nums(var_3_0) == 0 then
		self.m_descTxt:setText(var_0_0.EchoLabNameArray[self._ctrlType].defaultAttr)
	end

	self.m_slotList:setNumItems(var_0_0.ECHOLAB_SLOT_COUNT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			ctrlType = self._ctrlType,
			cardType = self._cardType
		}
	})
end

function EchoLabEmbryoComp:_onRendererslotList(arg_4_1, arg_4_2)
	arg_4_2:updateSlotCell(arg_4_1 + 1, self._ctrlType, self._cardType)
end

function EchoLabEmbryoComp:_onClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ECHOLAB_DEPLOY, {
		type = self._ctrlType,
		cardType = self._cardType
	})
end

return EchoLabEmbryoComp
