local OutpostKnightStateComp = class("OutpostKnightStateComp", require("app.fairyGUI.outpost.UI_OutpostKnightStateComp"))

function OutpostKnightStateComp:ctor()
	self._status = nil
	self._knight = nil

	self:addClickListener(handler(self, self.onSelfClick))
end

function OutpostKnightStateComp:updateStatues(arg_2_1, arg_2_2)
	self._status = arg_2_2
	self._knight = arg_2_1
end

function OutpostKnightStateComp:onSelfClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostStatusPop").new({
		type = self._status,
		struct = self._knight
	})))
end

return OutpostKnightStateComp
