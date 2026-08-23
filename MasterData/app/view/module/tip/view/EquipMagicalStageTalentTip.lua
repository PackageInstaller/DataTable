local EquipMagicalStageTalentTip = class("EquipMagicalStageTalentTip", require("app.fairyGUI.tip.UI_EquipMagicalStageTalentTip"), function()
	return fgui.GComponent:create({
		resName = "EquipMagicalStageTalentTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function EquipMagicalStageTalentTip:ctor(arg_2_1)
	self:showAtCenter()

	self._cfg = arg_2_1.cfg or {}
	self._style = arg_2_1.style
	self._activeNum = arg_2_1.activeNum or 0

	self.m_styleController:setSelectedIndex(arg_2_1.style)

	self._talentData = arg_2_1.talentData or {}

	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentItemRenderer))
end

function EquipMagicalStageTalentTip:onLoad()
	self:updateComp()
end

function EquipMagicalStageTalentTip:updateComp()
	self.m_talentList:setNumItems(#self._talentData)
end

function EquipMagicalStageTalentTip:_onTalentItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._talentData[arg_5_1 + 1], self._style, self._activeNum, self._cfg)
end

return EquipMagicalStageTalentTip
