local ThemeThirdBossTalentAttrPop = class("ThemeThirdBossTalentAttrPop", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentAttrPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeThirdBossTalentAttrPop",
		pkgName = "summerThemeThirdBoss",
		pkgPath = "ui/summerThemeThirdBoss/summerThemeThirdBoss"
	})
end)

function ThemeThirdBossTalentAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._bossData = arg_2_1.bossData
	self._attrList = {}
	self._skillList = {}
	self._attrList, self._skillList = self._bossData:getActiveAttrData()
end

function ThemeThirdBossTalentAttrPop:onLoad()
	local var_3_0 = #self._attrList > 0

	if #self._attrList > 0 then
		self.m_showComp:updateShowComp(self._attrList, self._skillList)
	end

	self.m_hasShowController:setSelectedIndex(var_3_0 and 1 or 0)
end

return ThemeThirdBossTalentAttrPop
