local AncientsFightBtn = class("AncientsFightBtn", require("app.fairyGUI.ancients.UI_AncientsFightBtn"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum

function var_0_0:ctor()
	self._btnEffect = nil

	self.m_Btn_icon:addClickListener(handler(self, self._onClickBtnIcon))
	self:setVisible(false)

	self._callback = nil

	self.m_playTimesComp:initView({
		closeDetailClick = true,
		getTimesFunc = function()
			return g.core.model.User.ancientsData:getLeftFightTimes()
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_BUYFIGHTTIMES,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_FIGHTTIMESNTF,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER
		},
		onGetTimes = function()
			g.core.module.ModuleManager:pushPopup(require("app.view.module.ancients.view.AncientsBuyFightCountPop").new(), {
				touchDisappear = true
			})
		end
	})
end

function var_0_0:onLoad()
	var_0_5:addEventListener(var_0_6.EVENT_CROSS_DAY_NOTIFY, handler(self, self._updateBtnEffect), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_ANCIENT_ENTER, handler(self, self._updateBtnEffect), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_ANCIENT_BUYFIGHTTIMES, handler(self, self._updateBtnEffect), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_ANCIENT_FIGHTTIMESNTF, handler(self, self._updateBtnEffect), self)
end

function var_0_0:_updateBtnEffect()
	if self.m_stateController:getSelectedIndex() == 1 and g.core.model.User.ancientsData:checkAncientsHasFightTimes() then
		if not self._btnEffect then
			self._btnEffect = self.m_battleBtnEffect:addEffectSpine({
				anim = "play",
				name = "eff_ui_ancients_battlebtnlight",
				isLoop = true
			})
		else
			self._btnEffect:setVisible(true)
		end
	elseif self._btnEffect then
		self._btnEffect:setVisible(false)
	end
end

function var_0_0:updateView(arg_6_1)
	local var_6_0 = g.core.model.User.ancientsData

	self._callback = arg_6_1.onClick

	if var_6_0:isFinalState() then
		local var_6_1 = var_6_0:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM)

		for iter_6_0 = 1, 3 do
			if not var_6_0:isPromoteByTeamId(iter_6_0, var_6_1.team_id) then
				self:setVisible(false)

				return
			end
		end
	end

	self:setVisible(true)
	self.m_ban_fightController:setSelectedIndex(var_6_0:isUserBanFight(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)

	local var_6_2 = var_6_0:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FIGHT

	self.m_show_resController:setSelectedIndex(var_6_2 and 1 or 0)

	if var_6_2 then
		self:updateLeftCount()
	end
end

function var_0_0.updateLeftCount(arg_7_0)
	return
end

function var_0_0:_onClickBtnIcon()
	if self._callback then
		self._callback()
	end
end

function var_0_0:updateMatchCd(arg_9_1)
	self.m_show_timeController:setSelectedIndex(1)
	self.m_Txt_time:setText((g.core.common.ServerTime:secondToMSString(arg_9_1)))
	self.m_show_resController:setSelectedIndex(0)
end

return var_0_0
