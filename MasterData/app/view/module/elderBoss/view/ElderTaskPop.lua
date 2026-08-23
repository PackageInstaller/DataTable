local var_0_0 = g.core.model.User.elderBossData
local ElderTaskPop = class("ElderTaskPop", require("app.fairyGUI.elderBoss.UI_ElderTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ElderTaskPop",
		pkgPath = "ui/elderBoss/elderBoss",
		pkgName = "elderBoss"
	}, ...)
end)

function ElderTaskPop:ctor()
	self._taskDic = {}

	self:showAtCenter()
	self:_initView()
end

function ElderTaskPop:_updateData()
	self._taskDic = var_0_0:getTaskDic()
end

function ElderTaskPop:_initView()
	self.m_rewardShowList:setVirtual()
	self.m_rewardShowList:setItemRenderer(handler(self, self._onRewardListRenderer))
	self:addListen(self.m_rewardShowList)
	self.m_tabIndexController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabIndexChanged))
	self.m_oneKeyRewardBtn:addClickListener(handler(self, self._onOneKeyClick))
	self:_onTabIndexChanged()
end

function ElderTaskPop:_onRewardListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._taskDic[self.m_tabIndexController:getSelectedIndex() + 1][arg_5_1 + 1])
end

function ElderTaskPop:_onTabIndexChanged()
	local var_6_0 = self.m_tabIndexController:getSelectedIndex()

	self.m_oneKeyRewardBtn:setVisible(#var_0_0:getAllCanGetAwardId(var_6_0) > 1)
	self:_updateData()
	self.m_rewardShowList:setNumItems(#self._taskDic[var_6_0 + 1])

	if var_6_0 == 0 then
		self.m_progressTxt:setText(g.core.lang:get(432515, {
			num = var_0_0:getChallengeTimes()
		}))
	elseif var_6_0 == 1 then
		self.m_progressTxt:setText(g.core.lang:get(432516, {
			grade = var_0_0:getKillBossLevel()
		}))
	end
end

function ElderTaskPop:_onOneKeyClick()
	g.core.network.GameNetProxy:send_C2S_ElderBoss_TaskAward({
		ids = var_0_0:getAllCanGetAwardId(self.m_tabIndexController:getSelectedIndex())
	})
	self.m_oneKeyRewardBtn:setVisible(false)
end

function ElderTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_TASKAWARD, self._onRcvTaskAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGENOTIFY, self._onChallengeNotify, self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab1,
		customData = {
			tabIdx = 0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab2,
		customData = {
			tabIdx = 1
		}
	})
end

function ElderTaskPop:_onRcvTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	self:_updateData()
	self.m_rewardShowList:setNumItems(#self._taskDic[self.m_tabIndexController:getSelectedIndex() + 1])
end

function ElderTaskPop:_onChallengeNotify(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self.m_tabIndexController:getSelectedIndex()

	if var_10_0 == 1 then
		self:_updateData()
		self.m_rewardShowList:setNumItems(#self._taskDic[var_10_0 + 1])
		self.m_progressTxt:setText(g.core.lang:get(432516, {
			grade = var_0_0:getKillBossLevel()
		}))
		self.m_oneKeyRewardBtn:setVisible(#var_0_0:getAllCanGetAwardId(var_10_0) > 1)
	end
end

function ElderTaskPop:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "EVENT_ELDER_BOSS_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_ElderBoss_TaskAward({
			ids = {
				arg_11_2
			}
		})
		self.m_oneKeyRewardBtn:setVisible(#var_0_0:getAllCanGetAwardId((self.m_tabIndexController:getSelectedIndex())) > 1)
	end
end

return ElderTaskPop
