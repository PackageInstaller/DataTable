local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local var_0_1 = g.core.config.mystery_chapter_info
local MysteryBossInfoComp = class("MysteryBossInfoComp", require("app.fairyGUI.mystery.UI_MysteryBossInfoComp"))

function MysteryBossInfoComp:ctor()
	self._awards = {}
	self._bossData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListItemRender))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
end

function MysteryBossInfoComp:_onAwardListItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function MysteryBossInfoComp:updateBossInfo(arg_3_1)
	if self._bossData ~= arg_3_1 then
		self.m_enterTransition:play()
	end

	self._bossData = arg_3_1

	self.m_bossNameTxt:setText(arg_3_1:getBossName())
	self.m_recommendTxt:setText(g.core.lang:get(423505, {
		value = arg_3_1:getBossConfig().recommend
	}))

	self._challengeUserNum = arg_3_1:getBossRoomCount()
	self._roomMaxUserNum = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MYSTERYBOSS_MAX_USER_COUNT).parameter

	self.m_challengeNumTxt:setText(g.core.lang:get(423506, {
		cur = self._challengeUserNum,
		max = self._roomMaxUserNum
	}))

	self._leftCount = arg_3_1:getLeftCount()

	if self._bossData:getBossType() == var_0_0.BOSS_TYPE.NOMARL then
		self.m_battleCountTxt:setText(g.core.lang:get(423507, {
			num = self._leftCount
		}))
	else
		self.m_battleCountTxt:setText(g.core.lang:get(423527, {
			num = self._leftCount
		}))
	end

	self.m_recordComp:setSelected(false)

	local var_3_0 = arg_3_1:getHistoryKillers()

	self.m_recordComp:updateRecordComp(arg_3_1)
	self.m_recordComp:setVisible(#var_3_0 > 0)
	self.m_knightPicComp:updateKnight({
		scale = 0.9,
		baseId = arg_3_1:getBossMonsterInfo().res_id
	})

	self._awards = arg_3_1:getAwardsByRankIdx(1).data or {}

	self.m_awardList:setNumItems(#self._awards)

	if not arg_3_1:isUnlockBoss() then
		self.m_unlockDesc:setText(g.core.lang:get(423524, {
			name = var_0_1.get(self._bossData:getBossConfig().unlock_id).name
		}))
		self.m_canBattleController:setSelectedIndex(0)
	elseif arg_3_1:getBossState() == var_0_0.BOSS_STATE.UNOPEN_LIMIT then
		self.m_canBattleController:setSelectedIndex(1)
	else
		self.m_canBattleController:setSelectedIndex(2)
	end
end

function MysteryBossInfoComp:_onClickBattleBtn()
	if not self._bossData:isUnlockBoss() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423523))

		return false
	end

	if self._challengeUserNum >= self._roomMaxUserNum then
		g.core.module.ModuleManager:tip(g.core.lang:get(423508))

		return
	end

	if self._leftCount <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(423509))

		return
	end

	if self._bossData:getRebornCD() > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(423510))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERY_BOSS_MAIN_LAYER, {
		boss = self._bossData
	})
end

return MysteryBossInfoComp
