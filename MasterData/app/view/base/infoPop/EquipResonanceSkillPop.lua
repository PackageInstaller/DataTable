local var_0_0 = g.core.model.User.equipmentData
local EquipResonanceSkillPop = class("EquipResonanceSkillPop", require("app.fairyGUI.infoPop.UI_EquipResonanceSkillPop"), function()
	return fgui.GComponent:create({
		resName = "EquipResonanceSkillPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	}, ...)
end)

function EquipResonanceSkillPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}
	self._data = arg_2_1 or {}
	self._equipId = arg_2_1.equipId or 0
	self._curLevel = arg_2_1.curLevel or 0

	self.m_skillList:setVirtual()
	self.m_skillList:setItemRenderer(handler(self, self._onItemRender))

	self._talentData = {}
end

function EquipResonanceSkillPop:updateView(arg_3_1)
	if self._equipId == 0 then
		return
	end

	self._talentData = {}

	for iter_3_0, iter_3_1 in ipairs((var_0_0:getEquipResonanceInfos(self._equipId))) do
		self._talentData[#self._talentData + 1] = {
			level = iter_3_1.level,
			levelName = iter_3_1.name,
			talent = iter_3_1.talent_skill
		}
	end

	self.m_skillList:setNumItems(#self._talentData)
end

function EquipResonanceSkillPop:onLoad()
	self:updateView()
end

function EquipResonanceSkillPop:onUnload()
	return
end

function EquipResonanceSkillPop:_onItemRender(arg_6_1, arg_6_2)
	local var_6_0 = self._talentData[arg_6_1 + 1]

	if self._talentData[arg_6_1 + 1] then
		arg_6_2:updateSkillCell(var_6_0)
	end

	arg_6_2:setActive(self._curLevel >= var_6_0.level)
end

return EquipResonanceSkillPop
