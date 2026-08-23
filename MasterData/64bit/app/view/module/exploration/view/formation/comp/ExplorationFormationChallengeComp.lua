local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.explorationData
local var_0_2 = g.core.const.ConstMgr.ExplorationConst
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = g.core.config.massive_monster_team_info
local var_0_5 = g.core.config.profession_passive_info
local var_0_6 = g.core.config.passive_skill_info
local var_0_7 = g.core.config.skill_info
local BattleConst = require("app.view.battle.const.BattleConst")
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local ExplorationFormationChallengeComp = class("ExplorationFormationChallengeComp", require("app.fairyGUI.exploration.UI_ExplorationFormationChallengeComp"))

function ExplorationFormationChallengeComp:ctor()
	self._monsterInfo = nil
	self._teamIdList = {}
	self._curIndex = 1
	self._enemyList = {}
	self._awardList = {}
	self._deBufInfo = nil

	self:initView()
end

function ExplorationFormationChallengeComp:initView()
	self.m_teamList:setVirtual(self)
	self.m_teamList:setItemRenderer(handler(self, self._onRenderTeamList))
	self.m_teamList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTeamList))
	self.m_enemyList:setVirtual(self)
	self.m_enemyList:setItemRenderer(handler(self, self._onRenderEnemyList))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_debuffDesText:enableRich()
	self.m_debuffBtn:addClickListener(handler(self, self._onDebuffBtnClicked))
	self.m_diffTipBtn:addClickListener(handler(self, self._onDiffTipBtnClicked))
end

function ExplorationFormationChallengeComp:updateChallengeComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._monsterInfo = arg_3_1
	self._teamIdList = arg_3_2
	self._deBufInfo = arg_3_3
	self._diffTip = arg_3_4

	if #arg_3_2 > 1 then
		self.m_teamList:setNumItems(#arg_3_2)
		self.m_teamList:setSelectedIndex(0)
	end

	self:updateEnemyList()

	self._awardList = g.core.common.Drops:getGoodsArray(arg_3_1.reward)

	self.m_awardList:setNumItems(#self._awardList)

	if arg_3_1.guild_buff > 0 then
		self.m_hasBuffController:setSelectedIndex(1)
		self.m_buffIcon:updateBuffIcon(arg_3_1.guild_buff, var_0_2.BUFF.GUILD_TYPE, true)

		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs((var_0_1:getGuildBuffList())) do
			if g.core.config.exploration_guild_buff_info.get(iter_3_1.id).group == arg_3_1.guild_buff then
				var_3_0 = #iter_3_1.userIdList

				break
			end
		end

		self.m_buffCountText:setText(var_3_0)
	else
		self.m_hasBuffController:setSelectedIndex(0)
	end

	if arg_3_3 then
		local var_3_4 = math.max(arg_3_3.initValue - arg_3_3.ratio * math.floor((g.core.common.ServerTime:getTime() - var_0_1:getTimeData()) / arg_3_3.time), arg_3_3.limit) / 10

		var_3_4 = var_3_4 == math.ceil(var_3_4) and tostring(var_3_4) or string.format("%0.1f", var_3_4)

		self.m_debuffDesText:setText((g.core.lang:get(420698, {
			attrName = arg_3_3.attrName,
			attrValue = var_3_4
		})))
	end

	if self._diffTip then
		self.m_isDiffTipController:setSelectedIndex(1)
	else
		self.m_isDiffTipController:setSelectedIndex(0)
	end

	local var_3_5 = false

	for iter_3_2 = 1, 3 do
		if arg_3_1["passive_skill_owner" .. iter_3_2] > 0 then
			var_3_5 = true

			local var_3_6 = var_0_5.get(arg_3_1["passive_skill_owner" .. iter_3_2]).passive_skill_id
			local var_3_7 = var_0_6.get(var_3_6)

			self["m_skill" .. iter_3_2]:setVisible(true)
			self["m_skill" .. iter_3_2]:setPassiveId(var_3_6)
			self["m_skill" .. iter_3_2]:setIcon(var_0_0:getSkillIconById(var_0_7.get(var_3_7.passive_skill_value).icon))
		else
			self["m_skill" .. iter_3_2]:setVisible(false)
		end
	end

	self.m_hasProfessPassiveController:setSelectedIndex(var_3_5 and 1 or 0)

	local var_3_8 = 0
	local var_3_9 = 0

	for iter_3_3, iter_3_4 in ipairs(self._teamIdList) do
		var_3_9 = var_3_9 + var_0_4.get(iter_3_4).fight
		var_3_8 = var_3_8 + var_0_1:getFormationData():getFormationStruct(iter_3_3):getFightValue()
	end

	self.m_skipTip:setVisible(g.core.model.User:checkUserSkipBattle(var_3_8, var_3_9, 1))
end

function ExplorationFormationChallengeComp:updateEnemyList()
	local var_4_0 = var_0_4.get(self._teamIdList[self._curIndex])

	self._enemyList = {}

	for iter_4_0 = 1, var_0_3.LINEUP_MAX do
		table.insert(self._enemyList, var_4_0["knight_id_" .. iter_4_0])
	end

	self.m_fightValueText:setText(var_4_0.fight)
	self.m_enemyList:setNumItems(#self._enemyList)
	self:dispatchCompEvent("update_show_knight", {
		baseId = self._enemyList[1]
	})
end

function ExplorationFormationChallengeComp:_onClickTeamList(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 + 1 == self._curIndex then
		return
	end

	self._curIndex = var_5_0 + 1

	self:updateEnemyList()
end

function ExplorationFormationChallengeComp:_onRenderTeamList(arg_6_1, arg_6_2)
	local var_6_0 = #self._teamIdList == arg_6_1 + 1

	arg_6_2:getController("teamIndex"):setSelectedIndex(arg_6_1)
	arg_6_2:getController("isFinalBtn"):setSelectedIndex(var_6_0 and 1 or 0)
end

function ExplorationFormationChallengeComp:_onRenderAwardList(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._awardList[arg_7_1 + 1])
end

function ExplorationFormationChallengeComp:_onRenderEnemyList(arg_8_1, arg_8_2)
	local var_8_0 = g.core.config.knight_info.get(self._enemyList[arg_8_1 + 1])
	local var_8_1 = KnightStruct.new(var_8_0.advance_id)

	var_8_1:addCfgInfo(var_8_0)
	arg_8_2:updateIcon({
		isFogNightPop = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		struct = var_8_1,
		star = var_8_0.star
	})
end

function ExplorationFormationChallengeComp:_onClickBattleBtn()
	local var_9_0 = 0
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(self._teamIdList) do
		var_9_0 = var_9_0 + var_0_4.get(iter_9_1).fight
		var_9_1 = var_9_1 + var_0_1:getFormationData():getFormationStruct(iter_9_0):getFightValue()
	end

	if g.core.model.User:checkUserSkipBattle(var_9_1, var_9_0, 1) then
		self:dispatchCompEvent("click_battle_btn_and_skip")
	else
		self:dispatchCompEvent("click_battle_btn")
	end
end

function ExplorationFormationChallengeComp:_onDebuffBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationDebuffPop").new({
		buffInfo = self._deBufInfo
	}), {
		touchDisappear = true
	})
end

function ExplorationFormationChallengeComp:_onDiffTipBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationDiffTipPop").new(), {
		touchDisappear = true
	})
end

return ExplorationFormationChallengeComp
