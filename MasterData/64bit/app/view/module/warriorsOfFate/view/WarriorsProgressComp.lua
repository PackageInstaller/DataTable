local WarriorsProgressComp = class("WarriorsProgressComp", require("app.fairyGUI.warriorsOfFate.UI_WarriorsProgressComp"))

function WarriorsProgressComp:ctor()
	self._type = nil

	self:addClickListener(handler(self, self._onClickExamine))
end

function WarriorsProgressComp:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._type = arg_2_1

	self.m_progressComp:getChild("title"):setText(tostring(arg_2_3) .. "/" .. tostring(arg_2_4))
	self.m_progressComp:setValue(arg_2_3)
	self.m_progressComp:setMax(arg_2_4)

	if arg_2_2 == 0 then
		self.m_typeController:setSelectedIndex(0)
		self.m_describeRichtext:setText("[color=" .. g.core.common.Color.ui[23] .. "]" .. g.core.lang:get(105008) .. "[/color]")
	else
		self.m_typeController:setSelectedIndex(1)
		self.m_describeRichtext:setText(("[color=" .. g.core.common.Color.ui[23] .. "]" .. g.core.lang:get(105006, {
			num = "[color=" .. g.core.common.Color.ui[1] .. "]" .. arg_2_4 - arg_2_3 .. "[/color]"
		}) .. "[/color]") .. "[color=" .. g.core.common.Color.ui[4] .. "]" .. g.core.config.scroll_stage_growth_info.get(arg_2_2).seen_directions .. "[/color]")
	end
end

function WarriorsProgressComp:_onClickExamine()
	local WarriorsAttrInfoPop
	local var_3_1 = true

	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "CLOSE"
	})

	if self._type == 1 then
		WarriorsAttrInfoPop = require("app.view.module.warriorsOfFate.view.WarriorsAttrInfoPop")
	elseif self._type == 2 then
		WarriorsAttrInfoPop = require("app.view.module.warriorsOfFate.view.WarriorsGeneralAttrPop")
		var_3_1 = true
	end

	g.core.module.ModuleManager:pushPopup(WarriorsAttrInfoPop.new({
		tabType = self._type
	}), {
		touchDisappear = var_3_1
	})
end

return WarriorsProgressComp
