local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.model.User.artifactData
local ArtifactInfoTabBaseComp = class("ArtifactInfoTabBaseComp", require("app.fairyGUI.artifact.UI_ArtifactInfoTabBaseComp"))

function ArtifactInfoTabBaseComp:ctor()
	return
end

function ArtifactInfoTabBaseComp:updateShow(arg_2_1)
	self._artifactStruct = arg_2_1.artifactData

	if self._artifactStruct then
		self:_updateAttrs()
		self:_updateSkill()
		self:_updateArtifactDesc()
	end
end

function ArtifactInfoTabBaseComp:_updateAttrs()
	local var_3_0 = self._artifactStruct:getBaseAttrsData()

	for iter_3_0 = 1, ArtifactConst.ATTR_NUM do
		if self["m_totalAttrComp" .. iter_3_0] then
			if var_3_0[iter_3_0] then
				self["m_totalAttrComp" .. iter_3_0]:setVisible(true)
				self["m_totalAttrComp" .. iter_3_0]:updateAttr(var_3_0[iter_3_0])
			else
				self["m_totalAttrComp" .. iter_3_0]:setVisible(false)
			end
		end
	end
end

function ArtifactInfoTabBaseComp:_updateSkill()
	self.m_skillIcon:updateIcon({
		artifact = self._artifactStruct
	})

	local var_4_0 = var_0_1:getSkillEnhanceInfoByBaseId((self._artifactStruct:getArtifactBaseId())).description or ""

	self.m_skillDescComp:getChild("title"):enableRich()
	self.m_skillDescComp:setText(var_4_0)
	self.m_skillNameText:setText(self._artifactStruct:getSkillInfo().name or "")

	local var_4_1 = self._artifactStruct:isHasWeaponSpirit()

	self.m_exSkill:setVisible(var_4_1)

	if var_4_1 then
		if self._artifactStruct:isAdjointSkillActive() then
			self.m_skillDescComp:setHeight(60)

			local var_4_2 = g.core.config.passive_skill_info.get((self._artifactStruct:getSpiritAdjointSkill()))
			local var_4_3, var_4_4 = g.core.utils.String.formatSkillEnchantInfoDesc(var_4_2.passive_skill_value, var_4_2.passive_skill_type)

			self.m_skillIcon2:updateSpiritSkillIcon({
				artifact = self._artifactStruct
			})
			self.m_skillDescComp2:getChild("title"):enableRich()
			self.m_skillDescComp2:setText(var_4_3)
			self.m_skillNameText2:setText(var_4_2.name)
			self.m_skillIcon2:setGrayed(false)
		else
			self.m_skillDescComp:setHeight(60)

			local var_4_5 = g.core.config.passive_skill_info.get((self._artifactStruct:getFirstActiveAdjointSkill()))
			local var_4_6, var_4_7 = g.core.utils.String.formatSkillEnchantInfoDesc(var_4_5.passive_skill_value, var_4_5.passive_skill_type)

			self.m_skillIcon2:updateSpiritSkillIcon({
				artifact = self._artifactStruct
			})
			self.m_skillDescComp2:getChild("title"):enableRich()
			self.m_skillDescComp2:setText(var_4_6)
			self.m_skillNameText2:setText(var_4_5.name)
			self.m_skillIcon2:setGrayed(true)
		end
	else
		self.m_skillDescComp:setHeight(144)
	end
end

function ArtifactInfoTabBaseComp:_updateArtifactDesc()
	self.m_descComp:setText(self._artifactStruct:getCfg().description or "")
end

return ArtifactInfoTabBaseComp
