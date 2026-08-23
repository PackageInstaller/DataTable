local var_0_0 = g.core.common.Path
local RoleSkinDevConfig = require("app.view.module.roleSkin.const.RoleSkinDevConfig")
local RoleSkinPartItem = class("RoleSkinPartItem", require("app.fairyGUI.roleSkin.UI_RoleSkinPartItem"))

function RoleSkinPartItem:ctor()
	self._struct = nil
	self._devType = RoleSkinDevConfig.DEV_TYPE.LEVEL
end

function RoleSkinPartItem:updateItem(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._struct = arg_2_1
	self._devType = arg_2_2

	self.m_isOwnController:setSelectedIndex(self._struct:isOwn() and 1 or 0)
	self.m_isWearController:setSelectedIndex(self._struct:isWear() and 1 or 0)
	self.m_iconLoader:setURL(var_0_0:getIconByTypeValue(g.core.common.Goods.TYPE_ROLE_SKIN, self._struct:getSkinInfoId()))
	self.m_level:setText(g.core.lang:get(2052, {
		level = self._struct:getLevel()
	}))
	self.m_stage:setText(g.core.lang:get(200042, {
		stage = self._struct:getStage()
	}))
	self.m_qualityLoader:setURL(var_0_0:getRoleSkinQualityBg(self._struct:getQuality()))
	self.m_iconLoader:setURL(var_0_0:getRoleSkinIcon(self._struct:getIcon()))
	self:_updateRedPoint()
end

function RoleSkinPartItem:_updateRedPoint()
	if self._devType == RoleSkinDevConfig.DEV_TYPE.LEVEL then
		self.m_redPointComp:setShow(self._struct:canLevelUp())
	elseif self._devType == RoleSkinDevConfig.DEV_TYPE.STAGE then
		self.m_redPointComp:setShow(self._struct:canStageUp())
	else
		self.m_redPointComp:setShow(false)
	end
end

return RoleSkinPartItem
