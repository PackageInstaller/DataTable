local BioTaskCell = class("BioTaskCell", require("app.fairyGUI.biography.UI_BioTaskCell"))

function BioTaskCell:ctor()
	self._tmpAwardArr = nil

	self:_initRegisterUI()
end

function BioTaskCell:_initRegisterUI()
	self.m_awardList:setIniter()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_goBtn:addClickListener(handler(self, self._onTaskGotoClick))
end

function BioTaskCell:_onRenderAwardList(arg_3_1, arg_3_2)
	self._tmpAwardArr[arg_3_1 + 1].scaleIndex = 3
	self._tmpAwardArr[arg_3_1 + 1].hideNum = false

	arg_3_2:updateIcon(self._tmpAwardArr[arg_3_1 + 1])
end

function BioTaskCell:_onTaskGotoClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
		type = 1
	})
	g.core.module.ModuleManager:popComponent()
end

function BioTaskCell:updateData(arg_5_1)
	local var_5_0 = g.core.model.User.bioData:getMission(arg_5_1)

	if var_5_0.finish then
		self.m_stateController:setSelectedIndex(2)
	elseif var_5_0.unlock then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_nameTxt:setText(var_5_0.name)
	self.m_descTxt:setText(var_5_0.description)

	self._tmpAwardArr = var_5_0.reward_first > 0 and g.core.common.Drops:getGoodsArray(var_5_0.reward_first) or {}

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

return BioTaskCell
