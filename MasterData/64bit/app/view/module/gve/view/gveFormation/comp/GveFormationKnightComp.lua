local var_0_0 = g.core.config.monster_team_info
local var_0_1 = g.core.config.monster_info
local var_0_2 = g.core.config.artifact_info
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.config.knight_base_info
local var_0_5 = g.core.model.User.gveDataMgr
local var_0_6 = g.core.common.Path
local GveFormationKnightComp = class("GveFormationKnightComp", require("app.fairyGUI.gve.UI_GveFormationKnightComp"))
local var_0_8 = {
	ELITE = 1,
	NONE = 0,
	BOSS = 2
}

function GveFormationKnightComp:ctor()
	self._formationData = var_0_5:getGveFormationData()
	self._pos = 0
	self._knightStruct = nil
	self._monsterData = nil
	self._isMonster = nil
	self._knightAdvId = 0
	self._isTouching = false

	self.m_knightClickNode:addClickListener(handler(self, self._onClickAddBtn))
	self.m_artifactIcon1:getChild("icon"):setGloaderMask(true, 0.3)
end

function GveFormationKnightComp:updateComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._pos = arg_2_1
	self._isMonster = arg_2_3

	if not arg_2_3 then
		self._knightStruct = arg_2_2

		self.m_isMonsterController:setSelectedIndex(0)
		self:updateView()
	else
		self.m_isMonsterController:setSelectedIndex(1)
		self:updateMonster(arg_2_2, arg_2_4, arg_2_5)
	end
end

function GveFormationKnightComp:updateView()
	self.m_hasHpController:setSelectedIndex(0)
	self.m_knightTypeController:setSelectedIndex(var_0_8.NONE)

	if not self._knightStruct then
		self.m_qualityController:setSelectedIndex(0)
		self.m_isActiveArtifactController:setSelectedIndex(0)
		self.m_hasMaskController:setSelectedIndex(0)
		self.m_lockStateController:setSelectedIndex(0)

		return
	end

	self.m_qualityController:setSelectedIndex(self._knightStruct:getQuality())
	self.m_knightIcon:setIcon(var_0_6:getKnightPicRes(self._knightStruct:getResInfo().painted_id))
	self.m_keepsakeLoader:setURL(var_0_6:getHalidomResourceById(var_0_5:getGveBagData():getBranchCfgByBranchId((var_0_5:getGveBagData():getCoreHalidomBranch())).small_grey_icon))
	self.m_levelText:setText(var_0_5:getGveBagData():getCoreHalidomLevel())
	self.m_starGroupComp:initStar({
		gap = -10,
		index = 3,
		num = self._knightStruct:getStarLv()
	})

	local var_3_0 = self._formationData:getKnightActionBySid(self._knightStruct:getServerId())

	self.m_actionText:setText(g.core.lang:get(309026, {
		action = var_3_0
	}))

	if var_3_0 >= var_0_5:getGveBaseCfg().action_cost then
		self.m_actionIsEnoughController:setSelectedIndex(1)

		if self._formationData:checkKnightIsUsed(self._knightStruct:getServerId()) then
			self.m_lockStateController:setSelectedIndex(2)
			self.m_hasMaskController:setSelectedIndex(1)
		else
			self.m_lockStateController:setSelectedIndex(0)
			self.m_hasMaskController:setSelectedIndex(0)
		end
	else
		self.m_actionIsEnoughController:setSelectedIndex(0)
		self.m_hasMaskController:setSelectedIndex(1)
		self.m_lockStateController:setSelectedIndex(1)
	end

	self:updateArtifact(self._formationData:getArtifactByPos(self._pos))
end

function GveFormationKnightComp:updateArtifact(arg_4_1)
	if arg_4_1 then
		local var_4_0 = var_0_6:getArtifactFormationImg(arg_4_1:getCfg().res_id)

		self.m_artifactIcon:setIcon(var_4_0)
		self.m_artifactIcon1:setIcon(var_4_0)
		self.m_artifactStarText:setText((arg_4_1:getStar()))
		self.m_isActiveArtifactController:setSelectedIndex(arg_4_1:isOwn() and 1 or 0)
	else
		self.m_isActiveArtifactController:setSelectedIndex(0)

		local var_4_1 = self._formationData:getArtifactByKnightSid(self._knightStruct:getServerId())

		if not var_4_1 then
			return
		end

		self.m_artifactIcon1:setIcon((var_0_6:getArtifactFormationImg(var_4_1:getCfg().res_id)))
	end
end

function GveFormationKnightComp:updateMonster(arg_5_1, arg_5_2, arg_5_3)
	self.m_hasHpController:setSelectedIndex(1)
	self.m_hasMaskController:setSelectedIndex(0)
	self.m_lockStateController:setSelectedIndex(0)

	if arg_5_1.isBossInfo then
		local var_5_0 = arg_5_1.info
		local var_5_1 = arg_5_1.monsterIndex

		if arg_5_1.monsterIndex == 0 then
			self:_updateMonsterByTeamId(var_5_0.boss_team, var_5_0, var_0_8.BOSS)
			self.m_levelText:setText(var_5_0.boss_equip_lv)
		else
			self:_updateMonsterByTeamId(var_5_0["guard_" .. var_5_1], var_5_0, var_0_8.ELITE, var_5_0["guard_" .. var_5_1 .. "_elite"])
			self.m_levelText:setText(var_5_0.guard_equip_lv)
		end

		local var_5_2 = var_0_5:getGveData():getBossData(var_5_0.id):getHpByIndexAndPos(var_5_1, self._pos)

		if var_5_2 <= 0 then
			self.m_hasMaskController:setSelectedIndex(1)
		end

		self.m_hpBar:setValue(var_5_2)
	else
		local var_5_3 = arg_5_1.info

		self.m_levelText:setText(arg_5_1.info.equip_level)

		local var_5_4 = var_0_3.fetch(var_5_3["knight_id_" .. self._pos])

		if var_5_4 then
			self._knightAdvId = var_5_4.advance_id or 0

			self.m_keepsakeLoader:setURL((var_0_6:getHalidomResourceById(var_0_5:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))
			self.m_hpBar:setMax(1000)

			local var_5_6 = (var_0_5:getGveData():getCurGridBaseData(arg_5_2, arg_5_3).hp or {})[self._pos] or 1000

			self.m_hpBar:setValue(var_5_6)

			if var_5_6 <= 0 then
				self.m_hasMaskController:setSelectedIndex(1)
			end

			self.m_starGroupComp:initStar({
				gap = -10,
				index = 3,
				num = var_5_4.star
			})

			local var_5_7 = var_0_4.get(var_5_4.res_id)

			self.m_knightIcon:setIcon(var_0_6:getKnightPicRes(var_5_7.painted_id))

			local var_5_8 = var_0_2.fetch(var_5_3["artifact_id_" .. self._pos])

			if var_5_8 then
				local var_5_9 = var_0_6:getArtifactFormationImg(var_5_8.res_id)

				self.m_artifactIcon:setIcon(var_5_9)
				self.m_artifactIcon1:setIcon(var_5_9)
				self.m_artifactStarText:setText(var_5_8.star)
				self.m_isActiveArtifactController:setSelectedIndex(1)
			else
				self.m_artifactIcon:setIcon("")
				self.m_artifactIcon1:setIcon("")
				self.m_isActiveArtifactController:setSelectedIndex(0)
			end

			self.m_knightTypeController:setSelectedIndex(var_0_8.NONE)
			self.m_qualityController:setSelectedIndex(var_5_7.quality)
		else
			self.m_hpBar:setValue(0)
			self.m_qualityController:setSelectedIndex(0)
		end
	end
end

function GveFormationKnightComp:_updateMonsterByTeamId(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = var_0_1.fetch(var_0_0.get(arg_6_1, 1)["monster_" .. self._pos])

	if var_6_0 then
		self._knightAdvId = var_6_0.advance_id or 0

		self.m_hpBar:setMax(var_6_0.initial_hp)
		self.m_keepsakeLoader:setURL((var_0_6:getHalidomResourceById(var_0_5:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))

		local var_6_1 = var_0_4.fetch(var_6_0.res_id)

		if var_6_1 then
			self.m_starGroupComp:initStar({
				gap = -10,
				index = 3,
				num = var_6_0.star
			})
			self.m_knightIcon:setIcon(var_0_6:getKnightPicRes(var_6_1.painted_id))

			local var_6_2 = var_0_2.fetch(var_6_0.artifact_id)

			if var_6_2 then
				local var_6_3 = var_0_6:getArtifactFormationImg(var_6_2.res_id)

				self.m_artifactIcon:setIcon(var_6_3)
				self.m_artifactIcon1:setIcon(var_6_3)
				self.m_artifactStarText:setText(var_6_2.star)
				self.m_isActiveArtifactController:setSelectedIndex(1)
			else
				self.m_artifactIcon:setIcon("")
				self.m_artifactIcon1:setIcon("")
				self.m_isActiveArtifactController:setSelectedIndex(0)
			end

			self.m_knightTypeController:setSelectedIndex(((arg_6_3 == var_0_8.BOSS or nil) and arg_6_2.boss_team_elite) == self._pos and arg_6_3 or var_0_8.NONE)
			self.m_qualityController:setSelectedIndex(var_6_0.quality)
		else
			self.m_qualityController:setSelectedIndex(0)
		end
	else
		self.m_qualityController:setSelectedIndex(0)
	end
end

function GveFormationKnightComp:_onClickAddBtn()
	if self._isMonster and self._knightAdvId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = self._knightAdvId
		}), {
			touchDisappear = true,
			hideContinue = true
		})

		return
	end

	if self._isTouching then
		return
	end

	if self._pos == 0 then
		return
	end

	self:dispatchCompEvent("gve_formation_click_add_knight", {
		pos = self._pos
	})
end

function GveFormationKnightComp:setCompTouch(arg_8_1)
	self._isTouching = not arg_8_1
end

function GveFormationKnightComp:hasKnight()
	return self._knightStruct ~= nil
end

return GveFormationKnightComp
