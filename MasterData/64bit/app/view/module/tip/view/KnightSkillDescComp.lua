local KnightSkillDescComp = class("KnightSkillDescComp", require("app.fairyGUI.tip.UI_KnightSkillDescComp"))
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.config.passive_skill_info
local var_0_3 = g.core.config.skill_info
local BaseConst = require("app.view.base.const.BaseConst")
local var_0_6 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_7 = g.core.const.ConstMgr.SkillConst
local var_0_8 = g.core.lang
local var_0_9 = {
	NOT_ACTIVE = 1,
	IS_ACTIVE = 0
}

function KnightSkillDescComp:ctor()
	self._skillsDescData = {}
	self._param = {}
	self._skillType = 0

	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onItemRenderer), 0.1, true)
end

function KnightSkillDescComp:updateComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._param = arg_2_1

	local var_2_0 = var_0_3.get(arg_2_1.skillId)

	self.m_skillIcon:updateIcon({
		skillId = arg_2_1.skillId,
		skillExtraData = arg_2_1.skillExtraData
	})

	local var_2_1 = ""

	var_2_1 = arg_2_1.isPassive and g.core.utils.String.formatPassiveSkillDesc(arg_2_1.skillId) or g.core.utils.String.formatSkillDesc(arg_2_1.skillId)

	self.m_descText:getChild("title"):enableRich()
	self.m_descText:setTitle(var_2_1)
	self:_updateArtifactRelatedDesc(arg_2_1.skillExtraData)

	self._skillType = var_2_0.skill_type

	if arg_2_1.skillDescList then
		self._skillsDescData = arg_2_1.skillDescList or {}

		self.m_descList:setNumItems1(#self._skillsDescData)

		return
	end

	if not arg_2_1.isForceStyle then
		self._skillsDescData = {}

		local var_2_2 = var_0_7.getSkillBigType(var_2_0.skill_type)

		if var_2_2 == var_0_7.SKILL_BIG_TYPE.ACTIVE then
			self:_updateActiveSkill(arg_2_1, (var_0_7.getSkillKeysBySkillType(self._skillType)))
		elseif var_2_2 == var_0_7.SKILL_BIG_TYPE.PASSIVE then
			self:_updatePassiveSkill(arg_2_1)
		end

		self.m_descList:setNumItems1(#self._skillsDescData)
	else
		self.m_skillIcon.m_levelShowTypeController:setSelectedIndex(1)
	end
end

function KnightSkillDescComp:_updateActiveSkill(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.skillKey
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs((var_0_1:getInfoListByAdvId(arg_3_1.knightAdvId, true))) do
		local var_3_2 = {}
		local var_3_3 = iter_3_1[var_3_0]

		if not var_3_1[iter_3_1[var_3_0]] and not (arg_3_2.shieldKey and iter_3_1[arg_3_2.shieldKey] == 1 or false) then
			var_3_1[var_3_3] = true

			local var_3_4 = var_0_3.get(var_3_3)

			var_3_2.text = g.core.utils.String.formatSkillDesc(var_3_3)
			var_3_2.level = self:_getPromoteDescLevel({
				skillLv = var_3_4.level,
				promoteLv = iter_3_1.star,
				promoteType = var_0_7.SKILL_PROMOTE_TYPE.UNLOCK,
				promoteCond = arg_3_2.promoteCond
			})

			if arg_3_1.star >= iter_3_1.star then
				var_3_2.state = var_0_9.IS_ACTIVE or var_0_9.NOT_ACTIVE
			end

			table.insert(self._skillsDescData, var_3_2)
		end
	end
end

function KnightSkillDescComp:_updatePassiveSkill(arg_4_1)
	self._skillsDescData = {}

	local var_4_1 = var_0_1:getKnight({
		advance_id = arg_4_1.knightAdvId
	})
	local var_4_2 = arg_4_1.star or var_4_1:getStarLv()
	local var_4_3 = var_4_1:getAdvanceLevel()
	local var_4_4

	if var_4_1:getQuality() >= var_0_6.UR then
		var_4_4 = var_0_7.SKILL_PROMOTE_COND.STAR_UP or var_0_7.SKILL_PROMOTE_COND.ADVANCE
	end

	local var_4_5, var_4_6 = var_4_1:getPassiveListNew()

	for iter_4_0, iter_4_1 in pairs(var_4_6) do
		local var_4_7 = {}
		local var_4_8 = var_0_3.get(var_0_2.get(iter_4_1.skillId).passive_skill_value)

		var_4_7.text = g.core.utils.String.formatPassiveSkillDesc(iter_4_1.skillId)

		local var_4_9 = {
			skillLv = var_4_8.level,
			promoteLv = iter_4_1.talentLevel
		}

		if iter_4_0 == 1 then
			var_4_9.promoteType = var_0_7.SKILL_PROMOTE_TYPE.UNLOCK or var_0_7.SKILL_PROMOTE_TYPE.LEVEL_UP
		end

		var_4_9.promoteCond = var_4_4
		var_4_7.level = self:_getPromoteDescLevel(var_4_9)

		if (var_4_4 == var_0_7.SKILL_PROMOTE_COND.STAR_UP and var_4_2 or var_4_3) >= iter_4_1.talentLevel then
			var_4_7.state = var_0_7.SKILL_STATE.IS_ACTIVE or var_0_7.SKILL_STATE.NOT_ACTIVE
		end

		table.insert(self._skillsDescData, var_4_7)
	end
end

function KnightSkillDescComp:_getPromoteDescLevel(arg_5_1)
	if arg_5_1.promoteCond == var_0_7.SKILL_PROMOTE_COND.STAR_UP then
		return var_0_8:get(201302, {
			level = arg_5_1.skillLv,
			star = arg_5_1.promoteLv
		})
	elseif arg_5_1.promoteCond == var_0_7.SKILL_PROMOTE_COND.ADVANCE then
		if arg_5_1.promoteType == var_0_7.SKILL_PROMOTE_TYPE.UNLOCK then
			return var_0_8:get(201304, {
				level = arg_5_1.skillLv,
				advanceLevel = arg_5_1.promoteLv
			})
		elseif arg_5_1.promoteType == var_0_7.SKILL_PROMOTE_TYPE.LEVEL_UP then
			return var_0_8:get(201305, {
				level = arg_5_1.skillLv,
				advanceLevel = arg_5_1.promoteLv
			})
		end
	end
end

function KnightSkillDescComp:_onItemRenderer(arg_6_1, arg_6_2)
	if self._skillsDescData[arg_6_1 + 1] then
		arg_6_2:updateCell(self._skillsDescData[arg_6_1 + 1])
	end
end

function KnightSkillDescComp:_updateArtifactRelatedDesc(arg_7_1)
	self.m_isHasArtifactRelatedController:setSelectedIndex(0)
	self.m_skillGroup:setY(140)

	if arg_7_1 and arg_7_1.extraType == BaseConst.BASE_SKILL_EXTRA_TYPE.ARTIFACT then
		self.m_relatedDesc:setText(g.core.model.User.artifactData:getSkillEnhanceInfoByBaseId((arg_7_1.data:getArtifactBaseId())).description)
		self.m_isHasArtifactRelatedController:setSelectedIndex(1)
	end
end

return KnightSkillDescComp
