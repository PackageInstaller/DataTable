local BountyMonsterRwdIcon = class("BountyMonsterRwdIcon", require("app.fairyGUI.bounty.UI_BountyMonsterRwdIcon"))

function BountyMonsterRwdIcon:ctor()
	self._data = nil

	self:addClickListener(handler(self, self._onClickIcon))
end

function BountyMonsterRwdIcon:updateIcon(arg_2_1)
	self._data = arg_2_1

	self:setIcon((g.core.common.Path:getIconByTypeValue(arg_2_1.type, arg_2_1.value)))
	self.m_numText:setText(arg_2_1.size)
end

function BountyMonsterRwdIcon:_onClickIcon()
	g.core.common.GlobalFunc.pushInfoPop(self._data)
end

return BountyMonsterRwdIcon
