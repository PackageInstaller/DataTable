local AncientsCoopTeamInfoPop = class("AncientsCoopTeamInfoPop", require("app.fairyGUI.ancients.UI_AncientsCoopTeamInfoPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsCoopTeamInfoPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function var_0_1:ctor(arg_2_1)
	self:getView():center(true)
	self.m_Btn_join:addClickListener(handler(self, self._onClickBtnJoin))
	self.m_Btn_cancel:addClickListener(handler(self, self._onClickBtnCancel))
	self.m_Btn_chat:addClickListener(handler(self, self._onClickChat))
	self.m_List_team:setVirtual(self)
	self.m_List_team:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self.m_is_finalController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)

	self._teamId = arg_2_1.teamId
	self._teamData = nil
	self._isApply = false
	self._captain = 0
	self._userArr = {}
	self._teamUserMap = {}
	self._captainSnapShot = nil
end

function var_0_1:onLoad()
	g.core.network.GameNetProxy:send_C2S_Ancient_GetTeamInfo({
		team_id = self._teamId
	})
	self.m_Btn_cancel:setVisible(false)
	self.m_Btn_join:setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETTEAMINFO, handler(self, self._onRevTeamInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onRevSnapShot), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_REQJOIN, handler(self, self._onUpdateApplyRecord1), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DELETEAPPLY, handler(self, self._onUpdateApplyRecord2), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RET_ERROR, handler(self, self._onRetError), self)
end

function var_0_1:_onUpdateApplyRecord1(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._isApply = not self._isApply

	self:_updateView()
end

function var_0_1:_onUpdateApplyRecord2(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._isApply = not self._isApply

	self:_updateView()
end

function var_0_1:_onRevTeamInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._teamData = arg_6_4.team
	self._isApply = arg_6_4.is_apply
	self._captain = self._teamData.captain

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._teamData.users) do
		self._teamUserMap[iter_6_1.user_id] = iter_6_1

		table.insert(var_6_0, iter_6_1.user_id)
	end

	g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
		user_ids = var_6_0
	})
end

function var_0_1:_onRevSnapShot(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._userArr = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_4.snapshots) do
		table.insert(self._userArr, {
			snapShot = iter_7_1,
			user = self._teamUserMap[iter_7_1.id],
			isLeader = iter_7_1.id == self._captain
		})

		if iter_7_1.id == self._captain then
			self._captainSnapShot = iter_7_1
		end
	end

	for iter_7_2 = 1, 4 do
		if iter_7_2 > #self._userArr then
			table.insert(self._userArr, {})
		end
	end

	self:_updateView()
end

function var_0_1._onRetError(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_4 == g.core.network.proto.MSG_S2C_Ancient_GetTeamInfo then
		g.core.module.ModuleManager:popModule()
	end
end

function var_0_1:_updateView()
	if self._teamData == nil then
		return
	end

	if g.core.model.User.ancientsData:isFinalState() then
		self.m_same_countryController:setSelectedIndex(1)
		self.m_Txt_rank:setText(g.core.lang:get(109810, {
			num = (self._teamData.score_rank == 0 or nil) and self._teamData.promote_rank
		}))
	else
		self.m_same_countryController:setSelectedIndex(1)
	end

	self.m_Txt_name:setText(self._teamData.name)
	self.m_Comp_pet:updateIcon((g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_PET,
		value = g.core.config.ancients_pet_info.get(self._teamData.pet.base_id).advance_id
	})))
	self.m_Txt_soulLv:setText(g.core.lang:get(433336, {
		level = self._teamData.pet.level
	}))
	self.m_Txt_num:setText(#self._teamData.users .. "/4")
	self.m_Txt_fight:setText(self._teamData.pet_fight_value)
	self.m_Txt_bool:setText((self._teamData.confirm or nil) and (g.core.lang:get(433392) or g.core.lang:get(433393)))
	self.m_Txt_limit:setText(g.core.lang:get(433337, {
		level = self._teamData.apply_level
	}))
	self.m_Txt_point:setText(self._teamData.score)
	table.sort(self._userArr, function(arg_10_0, arg_10_1)
		if arg_10_0.isLeader and not arg_10_1.isLeader then
			return true
		end

		if not arg_10_0.isLeader and not arg_10_1.isLeader then
			local var_10_0, var_10_1

			if arg_10_0.snapShot then
				var_10_0 = arg_10_0.snapShot.fight_value or 0

				if arg_10_1.snapShot then
					var_10_1 = arg_10_1.snapShot.fight_value or 0
				end
			end

			return var_10_1 < var_10_0
		end
	end)
	self.m_List_team:setNumItems(#self._userArr)
	self.m_Btn_cancel:setVisible(self._isApply)
	self.m_Btn_join:setVisible(not self._isApply and not (g.core.model.User.ancientsData:getAncientsState() > g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP) and not (g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and not g.core.model.User.ancientsData:hasFinalFightQualification()) and not (g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and g.core.model.User.ancientsData:hasFinalFightQualification() and self._teamData.promote_rank <= 0))
end

function var_0_1:_onClickBtnJoin()
	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.REVIEW then
		g.core.module.ModuleManager:tip(g.core.lang:get(433368))

		return
	end

	if (g.core.model.User.ancientsData:getTeam(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM) and g.core.model.User.ancientsData:getTeam(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM).team_id or 0) == self._teamData.team_id then
		g.core.module.ModuleManager:tip(g.core.lang:get(433367))

		return
	end

	if g.core.model.User.ancientsData:isForbiddenJoinTeam() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433355, {
			time = g.core.model.User.ancientsData:getForbiddenJoinTeamCDStr()
		}))

		return
	end

	if self._teamData.apply_level > g.core.model.User:getLevel() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433363))

		return
	end

	if #self._teamData.users >= 4 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433404))

		return
	end

	if g.core.model.User.ancientsData:teamForbiddenJoin(self._teamData.join_user_cd_time) and not self._teamData.confirm then
		g.core.module.ModuleManager:tip(g.core.lang:get(433356, {
			time = g.core.model.User.ancientsData:getCDStr(self._teamData.join_user_cd_time)
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_ReqJoin({
		team_id = self._teamData.team_id
	})
end

function var_0_1:_onClickBtnCancel()
	g.core.network.GameNetProxy:send_C2S_Ancient_DeleteApply({
		team_id = self._teamData.team_id
	})
end

function var_0_1:_onRenderListTeamCell(arg_13_1, arg_13_2)
	arg_13_2:updateCell(self._userArr[arg_13_1 + 1])
end

function var_0_1:_onClickChat()
	if g.core.model.User.chatData:isInBlackList(self._captainSnapShot.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1042))

		return
	end

	if g.core.model.User:getId() == self._captainSnapShot.id then
		g.core.module.ModuleManager:tip(g.core.lang:get(1044))

		return
	end

	local var_14_0 = {
		id = self._captainSnapShot.id,
		name = self._captainSnapShot.name,
		base_id = self._captainSnapShot.base_id
	}

	g.core.model.User.chatData:setPrivateChatPInfo(var_14_0)
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.CHAT, {
		type = g.core.const.ConstMgr.ChatConst.SINGLE,
		user = var_14_0
	})
end

return var_0_1
