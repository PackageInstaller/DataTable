local var_0_0 = g.core.model.User.mysteryData
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_2 = g.core.config.monster_info
local var_0_3 = g.core.const.ConstMgr.MysteryConst
local MysteryChallengeComp = class("MysteryChallengeComp", require("app.fairyGUI.mystery.UI_MysteryChallengeComp"))

function MysteryChallengeComp:ctor()
	self._stageInfo = {}
	self._awards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onEnemyItemRender))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
end

function MysteryChallengeComp:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function MysteryChallengeComp:_onEnemyItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = g.core.common.Goods.TYPE_KNIGHT,
		info = self._enemyList[arg_3_1 + 1].info,
		icon = g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(self._enemyList[arg_3_1 + 1].resId).icon_id)
	})
	arg_3_2:getIconComp():setStar(self._enemyList[arg_3_1 + 1].star)
end

function MysteryChallengeComp:updateComp(arg_4_1)
	self._stageInfo = arg_4_1
	self._awards = var_0_0:getStageDataById(arg_4_1.id):getDropAwards()
	self._curChapterId = var_0_0:getCurChapterId()
	self._chapterData = var_0_0:getChapterDataById(self._curChapterId)
	self._chapterCfg = self._chapterData:getChapterConfig()

	self.m_awardList:setNumItems(#self._awards)

	local var_4_0 = g.core.config.monster_team_info.get(var_0_0:getSwitchMonsterTeamId(arg_4_1.monster_team), 1)

	self.m_fightValueText:setText(var_4_0.fight)

	self._enemyList = {}

	for iter_4_0 = 1, 6 do
		if var_4_0["monster_" .. iter_4_0] > 0 then
			local var_4_1 = var_0_2.get(var_4_0["monster_" .. iter_4_0])

			table.insert(self._enemyList, {
				resId = var_4_1.res_id,
				info = g.core.config.knight_info.get(var_4_1.advance_id),
				star = var_4_1.star
			})
		end
	end

	self.m_enemyList:setNumItems(#self._enemyList)
	self.m_descTxt:setVisible(false)

	if arg_4_1.type == var_0_3.MAP_ITEM_TYPE.ELITE_MONSTER then
		self.m_isEliteController:setSelectedIndex(1)

		local var_4_2 = self._chapterData:getNextMysteryChapterId()

		if var_4_2 ~= 0 then
			self.m_descTxt:setText(g.core.lang:get(423006, {
				str = var_0_0:getChapterDataById(var_4_2):getChapterConfig().name
			}))
			self.m_descTxt:setVisible(true)
		end
	else
		self.m_isEliteController:setSelectedIndex(0)

		local var_4_3 = self._chapterCfg["monster" .. self._chapterData:getMonsterIndexByGroup(arg_4_1.group) + 1]

		if var_4_3 and var_4_3 > 0 then
			local var_4_4 = self._chapterData:getMonsterListByGroup(var_4_3)

			if var_4_4 and next(var_4_4) then
				self.m_descTxt:setText(g.core.lang:get(423024, {
					str = var_4_4[1].stage_name
				}))
				self.m_descTxt:setVisible(true)
			end
		end
	end
end

function MysteryChallengeComp:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function MysteryChallengeComp:_onClickBattleBtn()
	if self._stageInfo.type == var_0_3.MAP_ITEM_TYPE.ELITE_MONSTER then
		local var_6_0 = self._chapterData:getChapterConfig().open_level

		if var_0_0:getDailyChallengeEliteTime() == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(423018))
		elseif var_6_0 > g.core.model.User:getLevel() then
			g.core.module.ModuleManager:tip((g.core.lang:get(423001, {
				level = var_6_0
			})))
		else
			g.core.network.GameNetProxy:send_C2S_Mystery_Elite_ChallengeBegin({
				monster_id = self._stageInfo.id
			})
		end
	elseif self._stageInfo.type == var_0_3.MAP_ITEM_TYPE.MONSTER then
		g.core.network.GameNetProxy:send_C2S_Mystery_Monster_ChallengeBegin({
			monster_id = self._stageInfo.id
		})
	end
end

return MysteryChallengeComp
