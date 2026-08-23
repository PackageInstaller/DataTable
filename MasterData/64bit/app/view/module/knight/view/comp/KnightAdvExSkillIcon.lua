local KnightAdvExSkillIcon = class("KnightAdvExSkillIcon", require("app.fairyGUI.knight.UI_KnightAdvExSkillIcon"))

function KnightAdvExSkillIcon:ctor()
	self._knightStruct = nil

	self:addClickListener(handler(self, self._onClickDetail))
end

function KnightAdvExSkillIcon:updateKnightAdvExIcon(arg_2_1, arg_2_2)
	self.m_emptyController:setSelectedIndex(1)

	self._knightStruct = arg_2_1

	self:setIcon("res/common/icon/talent/" .. arg_2_2.icon .. ".png")
end

function KnightAdvExSkillIcon:setEmpty()
	self.m_emptyController:setSelectedIndex(0)

	self._knightStruct = nil

	self:setIcon("")
end

function KnightAdvExSkillIcon:_onClickDetail()
	if self._clickFunc then
		self._clickFunc()

		return
	end

	if self._knightStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightAssistantTip").new(self._knightStruct))
	end
end

function KnightAdvExSkillIcon:setClickCallFunc(arg_5_1)
	self._clickFunc = arg_5_1
end

return KnightAdvExSkillIcon
