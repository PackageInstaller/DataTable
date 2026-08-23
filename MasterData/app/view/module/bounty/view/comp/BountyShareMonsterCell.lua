local var_0_0 = g.core.const.ConstMgr.BountyConst
local BountyShareMonsterCell = class("BountyShareMonsterCell", require("app.fairyGUI.bounty.UI_BountyShareMonsterCell"))

function BountyShareMonsterCell:ctor()
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = g.core.const.ConstMgr.KNIGHT_CONST.STAR_MAX
	})
	self:_initBtn()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function BountyShareMonsterCell:_initBtn()
	self.m_clickLoader:addClickListener(handler(self, self._onAwardOrBattleClick))
end

function BountyShareMonsterCell:updateMonsterCell(arg_3_1)
	self._monsterStruct = arg_3_1.monster

	local var_3_0 = arg_3_1.tabType

	self._tabType = arg_3_1.tabType

	self.m_iconLoader:setURL((g.core.common.Path:getKnightIconById(self._monsterStruct:getResInfo().icon_id)))
	self.m_nameText:setText(self._monsterStruct:getName())
	self.m_starComp:setStarNum(self._monsterStruct:getStarNum())
	self:updateCellTime()

	local var_3_1 = self._monsterStruct:getSummonUserId()
	local var_3_2 = var_3_1 == g.core.model.User:getId()

	if var_3_0 ~= var_0_0.SHARE_SEL_TYPE.MINE then
		self.m_typeController:setSelectedIndex(1)

		if self._monsterStruct:getSummonUserId() == g.core.model.User:getId() then
			self.m_clickGroup:setVisible(false)
		else
			self.m_clickGroup:setVisible(true)
		end
	else
		var_3_1 = self._monsterStruct:getKillUserId()

		local var_3_4 = self._monsterStruct:getShareType()

		self.m_descText:setText(var_3_4 == var_0_0.SHARE_SEL_TYPE.GUILD and g.core.lang:get(100507) or var_3_4 == var_0_0.SHARE_SEL_TYPE.CUR_SERVER and g.core.lang:get(422025) or var_3_4 == var_0_0.SHARE_SEL_TYPE.CROSS_SERVER and g.core.lang:get(1223) or g.core.lang:get(422026))
		self.m_typeController:setSelectedIndex(0)
		self.m_clickGroup:setVisible(true)
	end

	local var_3_6 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_3_1)

	if var_3_6 then
		self:_updateUser(var_3_6)
		self.m_hasUserController:setSelectedIndex(1)
	else
		self.m_hasUserController:setSelectedIndex(0)
	end

	local var_3_7 = self._monsterStruct:getRewardsByRewardType(var_0_0.MONSTER_REWARD_TYPE.KILL)

	self.m_awardIcon1:updateIcon(((var_3_2 or nil) and self._monsterStruct:getRewardsByRewardType(var_0_0.MONSTER_REWARD_TYPE.SHARE))[1])
	self.m_awardIcon2:updateIcon(self._monsterStruct:getRewardsByRewardType(var_0_0.MONSTER_REWARD_TYPE.EXTRA)[1])
	self.m_isCrossController:setSelectedIndex(0)

	local var_3_8 = self.m_userNameText:getPosition()

	var_3_8.y = 60

	if var_3_0 == var_0_0.SHARE_SEL_TYPE.MINE then
		local var_3_9 = self._monsterStruct:getKillUserId()

		self.m_clickGroup:setVisible(var_3_9 and var_3_9 > 0)
	elseif var_3_0 == var_0_0.SHARE_SEL_TYPE.CROSS_SERVER then
		self.m_isCrossController:setSelectedIndex(1)

		var_3_8.y = 46
	end

	self.m_userNameText:setPosition(var_3_8)
	self.m_award2Group:setVisible(var_3_0 <= var_0_0.SHARE_SEL_TYPE.GUILD and var_3_2 and self._monsterStruct:getShareType() == var_0_0.SHARE_SEL_TYPE.GUILD)
end

function BountyShareMonsterCell:_updateUser(arg_4_1)
	self.m_userIconComp:updateAsUser(arg_4_1)
	self.m_userNameText:setText(arg_4_1.name)
	self.m_powerText:setText(arg_4_1.fight_value)
	self.m_userGroup:setVisible(true)
	self.m_serverText:setText((g.core.platform.ServerListProxy:getServerById(arg_4_1.sid) or {
		name = ""
	}).name)
end

function BountyShareMonsterCell:updateCellTime()
	if not self._monsterStruct then
		self.m_timeText:setText("")

		return
	end

	local var_5_0 = self._monsterStruct:getExpireTime() - g.core.common.ServerTime:getTime()

	if self._tabType == var_0_0.SHARE_SEL_TYPE.MINE and self._monsterStruct:getKillUserId() ~= 0 then
		self.m_timeText:setText("")

		return
	end

	if var_5_0 <= 0 then
		self.m_timeText:setText("")
		self:dispatchCompEvent("share_monster_time_end")
	else
		local var_5_1 = {}

		var_5_1.time = g.core.common.ServerTime:getCountDownBySecond(var_5_0)

		self.m_timeText:setText(g.core.lang:get(422001, var_5_1))
	end
end

function BountyShareMonsterCell:_onAwardOrBattleClick()
	if self.m_typeController:getSelectedIndex() == 1 then
		self:_popBattlePop()
	else
		self:_getShareAward()
	end
end

function BountyShareMonsterCell:_getShareAward()
	local var_7_0 = self._monsterStruct:getKillUserId()

	if var_7_0 ~= 0 and var_7_0 ~= g.core.model.User:getId() then
		self:dispatchCompEvent("get_share_award", {
			monster = self._monsterStruct
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(422027))
	end
end

function BountyShareMonsterCell:_popBattlePop()
	self:dispatchCompEvent("pop_battle_pop", {
		monster = self._monsterStruct
	})
end

return BountyShareMonsterCell
