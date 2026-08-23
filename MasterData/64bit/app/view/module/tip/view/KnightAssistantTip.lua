local var_0_0 = g.core.model.User.knightsData
local KnightAssistantTip = class("KnightAssistantTip", require("app.fairyGUI.tip.UI_KnightAssistantTip"), function()
	return fgui.GComponent:create({
		resName = "KnightAssistantTip",
		pkgName = "tip",
		pkgPath = "ui/tip/tip"
	})
end)

function KnightAssistantTip:ctor(arg_2_1)
	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentRenderer))

	self._knightStruct = arg_2_1

	self:updateAssistantTip()
end

function KnightAssistantTip:updateAssistantTip()
	if self._knightStruct then
		self._talentData = var_0_0:getAssistantTalent(self._knightStruct)

		self.m_talentList:setNumItems(#self._talentData)
	end
end

function KnightAssistantTip:_onTalentRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAssistantCell(self._talentData[arg_4_1 + 1])
end

return KnightAssistantTip
