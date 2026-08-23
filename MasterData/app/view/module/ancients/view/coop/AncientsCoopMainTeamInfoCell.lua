local AncientsCoopMainTeamInfoCell = class("AncientsCoopMainTeamInfoCell", require("app.fairyGUI.ancients.UI_AncientsCoopMainTeamInfoCell"))

function var_0_0:ctor()
	self._transition = self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)

	self:addClickListener(handler(self, self._onClickSelf))

	self._id = 0
end

function var_0_0:onLoad()
	self:setVisible(false)

	self._playTransition = false
end

function var_0_0:updateTeamCellInfo(arg_3_1, arg_3_2)
	if not self._playTransition then
		self._playTransition = true

		self:newScheduleOnce(function()
			self:setVisible(true)
			self._transition:play()
		end, 0.03 * arg_3_2)
	end

	self.m_Txt_level:setText(g.core.lang:get(202043, {
		level = arg_3_1.level
	}))
	self.m_Txt_name:setText(g.core.lang:get(433332, {
		name = arg_3_1.name
	}))
	self.m_Txt_num:setText(arg_3_1.member_num .. "/")
	self.m_Txt_fight:setText(arg_3_1.pet_fight_value)

	self._id = arg_3_1.team_id

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.captain)

	if var_3_0 then
		self.m_knightIcon:setIcon(g.core.common.Path:getKnightPicRes((var_3_0.show_knight_dress > 0 or nil) and var_3_0.show_knight_dress))
	end
end

function var_0_0:_onClickSelf()
	if self._id ~= 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
			teamId = self._id
		})
	end
end

return var_0_0
