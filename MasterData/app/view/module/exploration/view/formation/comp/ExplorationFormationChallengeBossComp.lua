local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_1 = g.core.model.User.explorationData
local ExplorationFormationChallengeBossComp = class("ExplorationFormationChallengeBossComp", require("app.fairyGUI.exploration.UI_ExplorationFormationChallengeBossComp"))

function ExplorationFormationChallengeBossComp:ctor()
	self._bossInfo = nil
	self._curIndex = 1
	self._enemyList = {}
	self._awardList = {}

	self:initView()
end

function ExplorationFormationChallengeBossComp:initView()
	self.m_enemyList:setVirtual(self)
	self.m_enemyList:setItemRenderer(handler(self, self._onRenderEnemyList))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
end

function ExplorationFormationChallengeBossComp:updateChallengeComp(arg_3_1, arg_3_2)
	self._bossInfo = arg_3_1
	self._awardList = g.core.common.Drops:getGoodsArray(arg_3_1.battle_reward)

	self.m_awardList:setNumItems(#self._awardList)

	local var_3_0 = var_0_1:getBossCanChallengeCount()

	self.m_costTxt:setText(var_3_0)
	self.m_isEnoughController:setSelectedIndex(var_3_0 > 0 and 1 or 0)
	self:updateEnemyList(arg_3_2)
end

function ExplorationFormationChallengeBossComp:updateEnemyList(arg_4_1)
	self._enemyList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.units or {}) do
		if iter_4_1.id > 0 then
			local var_4_0 = {
				id = iter_4_1.id
			}

			var_4_0.name = iter_4_1.name or ""

			table.insert(self._enemyList, var_4_0)
		end
	end

	self.m_enemyList:setNumItems(#self._enemyList)
	self:dispatchCompEvent("update_show_knight", {
		baseId = arg_4_1.user.show_knight_id
	})
end

function ExplorationFormationChallengeBossComp:_onRenderAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awardList[arg_5_1 + 1])
end

function ExplorationFormationChallengeBossComp:_onRenderEnemyList(arg_6_1, arg_6_2)
	local var_6_0 = g.core.config.knight_info.get(self._enemyList[arg_6_1 + 1].id)
	local var_6_1 = KnightStruct.new(var_6_0.advance_id)

	var_6_1:addCfgInfo(var_6_0)
	var_6_1:setIsOtherUser(true, self._enemyList[arg_6_1 + 1].name or "")
	arg_6_2:updateIcon({
		isOthers = true,
		isFogNightPop = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		struct = var_6_1,
		star = var_6_0.star
	})
end

function ExplorationFormationChallengeBossComp:_onClickBattleBtn()
	self:dispatchCompEvent("click_battle_btn")
end

function ExplorationFormationChallengeBossComp:_onClickRankBtn()
	self:dispatchCompEvent("click_rank_btn")
end

return ExplorationFormationChallengeBossComp
