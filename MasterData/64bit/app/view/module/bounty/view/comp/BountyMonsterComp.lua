local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.const.ConstMgr.BountyConst
local BountyMonsterComp = class("BountyMonsterComp", require("app.fairyGUI.bounty.UI_BountyMonsterComp"))

function BountyMonsterComp:ctor()
	self._monsterStruct = nil
	self._timeSchedule = nil

	self:_initComp()
end

function BountyMonsterComp:_initComp()
	self.m_starComp:initStar({
		style = 1,
		num = 0,
		gap = 0,
		index = 3,
		max = var_0_0.STAR_MAX
	})
	self.m_challengeBtn:addClickListener(handler(self, self._onChallengeBtnClicked))
	self.m_shareBtn:addClickListener(handler(self, self._onShareBtnClicked))
	self.m_switchTransition:setHook("cut", handler(self, self._onHandleCutHook))
end

function BountyMonsterComp:onLoad()
	self:_onStartTimeSchedule()
end

function BountyMonsterComp:onUnload()
	self:_onStopTimeSchedule()
end

function BountyMonsterComp:updateCompByStruct(arg_5_1)
	self._monsterStruct = arg_5_1

	if not self._monsterStruct then
		self:_onStopTimeSchedule()

		return
	end

	self.m_monsterIconComp:setIcon((g.core.common.Path:getMiddleKnightPicById(self._monsterStruct:getResInfo().icon_id)))
	self.m_nameTxt:setText(self._monsterStruct:getName())
	self.m_starComp:setStarNum(self._monsterStruct:getStarNum())

	if self._monsterStruct:getSummonUserId() == g.core.model.User:getId() then
		local var_5_0 = self._monsterStruct:getRewardsByRewardType(var_0_1.MONSTER_REWARD_TYPE.KILL) or {}

		for iter_5_0 = 1, 2 do
			if var_5_0[iter_5_0] then
				self["m_killRwdIcon" .. iter_5_0]:updateIcon(var_5_0[iter_5_0])
				self["m_killRwdIcon" .. iter_5_0]:setVisible(true)
			else
				self["m_killRwdIcon" .. iter_5_0]:setVisible(false)
			end
		end

		self.m_showKillController:setSelectedIndex(1)
	else
		self.m_showKillController:setSelectedIndex(0)
	end

	local var_5_1 = self._monsterStruct:getRewardsByRewardType(var_0_1.MONSTER_REWARD_TYPE.SHARE) or {}

	for iter_5_1 = 1, 2 do
		if var_5_1[iter_5_1] then
			self["m_shareRwdIcon" .. iter_5_1]:updateIcon(var_5_1[iter_5_1])
			self["m_shareRwdIcon" .. iter_5_1]:setVisible(true)
		else
			self["m_shareRwdIcon" .. iter_5_1]:setVisible(false)
		end
	end

	local var_5_2 = self._monsterStruct:getShareType()

	if var_5_2 == var_0_1.SHARE_SEL_TYPE.MINE then
		self.m_shareBtn:setTitle(g.core.lang:get(422042))
	else
		self.m_shareBtn:setTitle(g.core.lang:get(422001 + var_5_2))
	end
end

function BountyMonsterComp:_updateMonsterExpireTimeTip()
	local var_6_0 = self._monsterStruct:getExpireTime() - g.core.common.ServerTime:getTime()

	if var_6_0 <= 0 then
		self.m_challengeTipText:setText("")
		self:dispatchCompEvent("limitTimeEnd")
	else
		local var_6_1 = {}

		var_6_1.time = g.core.common.ServerTime:getCountDownBySecond(var_6_0)

		self.m_challengeTipText:setText(g.core.lang:get(422001, var_6_1))
	end
end

function BountyMonsterComp:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateMonsterExpireTimeTip), 1)
end

function BountyMonsterComp:_onStopTimeSchedule()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function BountyMonsterComp:_onChallengeBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.bounty.view.pop.BountyBattlePop").new({
		monster = self._monsterStruct
	}), {
		touchDisappear = true
	})
end

function BountyMonsterComp:shareCurMonster()
	self:_onShareBtnClicked()
end

function BountyMonsterComp:_onShareBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.bounty.view.BountyShareEnsurePop").new({
		monster = self._monsterStruct
	}), {
		touchDisappear = true
	})
end

function BountyMonsterComp:playSummonEffect()
	self.m_effCard:removeAllEffect()
	self.m_effCard:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = "eff_ui_bounty_card"
	})
	self.m_enterTransition:play()
end

function BountyMonsterComp:playSwitchEffect(arg_13_1)
	self._monsterStruct = arg_13_1

	self.m_switchTransition:play()
	self.m_effCard:removeAllEffect()
	self.m_effCard:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play2",
		name = "eff_ui_bounty_card"
	})
end

function BountyMonsterComp:_onHandleCutHook()
	self:updateCompByStruct(self._monsterStruct)
end

return BountyMonsterComp
