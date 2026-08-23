local WushChallengeComp = class("WushChallengeComp", require("app.fairyGUI.wush.UI_WushChallengeComp"))
local var_0_1 = g.core.config.dead_battle_checkpoint_info
local var_0_2 = g.core.config.dead_battle_floor_info

function WushChallengeComp:ctor()
	self._index = 1

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListItemRenderer))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_dangerTransition:play()
end

function WushChallengeComp:updateComp(arg_2_1)
	local var_2_0, var_2_1, var_2_2

	if arg_2_1 then
		var_2_0 = arg_2_1.index or 1

		if arg_2_1 then
			var_2_1 = arg_2_1.stageId or 1

			if arg_2_1 then
				var_2_2 = arg_2_1.floorId or 1
			end
		end
	end

	self._index = var_2_0 - 1

	local var_2_3 = var_0_2.get(var_2_2)
	local var_2_4 = var_0_1.get(var_2_1)
	local var_2_5 = g.core.model.User:getFightValue()
	local var_2_6 = var_2_4["monster_fight_" .. var_2_0]

	self.m_fightLabel:setText(var_2_4["monster_fight_" .. var_2_0])
	self.m_dangerImg:setVisible(var_2_5 < var_2_6)
	self.m_conditionLabel:setText(var_2_3.success_directions)

	self._drops = g.core.common.Drops:getGoodsArray(var_2_4["award_id_" .. var_2_0])

	local var_2_7 = g.core.model.User.themeData:getThemeDropByModule(g.core.const.ConstMgr.ActivityConst.HOLIDAY_MODULE_TYPE.WUSH)

	if var_2_7 then
		local var_2_8 = {}

		table.insertto(var_2_8, var_2_7)
		table.insertto(var_2_8, self._drops)

		self._drops = var_2_8
	end

	if #self._drops > 0 then
		self.m_rewardList:setNumItems(#self._drops)
	end
end

function WushChallengeComp:playEnterAni()
	self.m_enterTransition:play()
end

function WushChallengeComp:_onListItemRenderer(arg_4_1, arg_4_2)
	if self._drops[arg_4_1 + 1] then
		arg_4_2:updateIcon(self._drops[arg_4_1 + 1])
		arg_4_2:setCtrlState("scaleIndex", {
			index = 3
		})
	end
end

function WushChallengeComp:_onClickBattle()
	if g.core.model.User.wushData:getLeftFailTimes() > 0 then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_ChallengeBegin({
			index = self._index
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303030))
	end
end

function WushChallengeComp:doAutoAction()
	self:_onClickBattle()

	return true
end

return WushChallengeComp
