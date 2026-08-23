local PreciousInfoComp = class("PreciousInfoComp", require("app.fairyGUI.precious.UI_PreciousInfoComp"))

function PreciousInfoComp:ctor()
	self._struct = nil
	self._curStar = 0
	self._talentSkillList = {}

	self:_initListView()
end

function PreciousInfoComp:_initListView()
	self.m_talentDescList:setVirtual()
	self.m_talentDescList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function PreciousInfoComp:_onRenderTalentList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._talentSkillList[arg_3_1 + 1])
end

function PreciousInfoComp:updateShow(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._struct = arg_4_1
	self._curStar = arg_4_1:getStar()

	local var_4_0 = arg_4_1:getCurStarAttr()

	for iter_4_0 = 1, #var_4_0 do
		self["m_attrComp" .. iter_4_0]:updateAttr({
			type = iter_4_0,
			value = var_4_0[iter_4_0]
		})
	end

	local var_4_1 = g.core.config.precious_privilege_info.fetch((arg_4_1:getPrivilegeId()))

	if var_4_1 then
		self.m_privilegeText:setText(var_4_1.description)
		self.m_privilegeGroup:setVisible(true)
	else
		self.m_privilegeGroup:setVisible(false)
	end

	self._talentSkillList = arg_4_1:getUpgradeTalents()

	self.m_talentDescList:setNumItems(#self._talentSkillList)
	self.m_talentGroup:setVisible(#self._talentSkillList > 0)
end

return PreciousInfoComp
