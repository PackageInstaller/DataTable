local var_0_0 = g.core.model.User.roleSkinData
local RoleSkinStrengthenTalentPop = class("RoleSkinStrengthenTalentPop", require("app.fairyGUI.roleSkin.UI_RoleSkinStrengthenTalentPop"), function()
	return fgui.GComponent:create({
		pkgName = "roleSkin",
		resName = "RoleSkinStrengthenTalentPop",
		pkgPath = "ui/roleSkin/roleSkin"
	}, ...)
end)

function RoleSkinStrengthenTalentPop:ctor(arg_2_1)
	self:showAtCenter()

	self._struct = arg_2_1
	self._talentList = var_0_0:getLevelTalentByGroup(self._struct:getLevelGroup())

	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function RoleSkinStrengthenTalentPop:onLoad()
	self.m_talentList:setNumItems(#self._talentList)
end

function RoleSkinStrengthenTalentPop:_onRenderTalentList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._talentList[arg_4_1 + 1], self._struct:getLevel() >= self._talentList[arg_4_1 + 1].level)
end

return RoleSkinStrengthenTalentPop
