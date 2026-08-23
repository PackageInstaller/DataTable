local BioTeamInviteFloatService = class("BioTeamInviteFloatService")

function BioTeamInviteFloatService:ctor()
	self._rootTipLayer = g.core.layer.LayerManager:getSysTipLayer()
	self._floatQueen = {}
	self._gap = 20
	self._beginShowPosY = 125
	self._maxShowNum = 2
	self._inviteCoolTime = 10
	self._ignoreModule = {
		g.view.entrance.BIO_TEAM,
		g.view.entrance.STORY_DIALOG,
		g.view.entrance.STORY_DARK_CURTAIN,
		g.view.entrance.STORY_MOVIE,
		g.view.entrance.BATTLE,
		g.view.entrance.RECRUIT,
		g.view.entrance.PUZZLE_GAME,
		g.view.entrance.STORY_ILLUSTRATION,
		g.view.entrance.PRIMARY_RECRUIT,
		g.view.entrance.HOME_LAND_TRAIN,
		g.view.entrance.GUILD_FIGHT_CHARIOT_BATTLE,
		g.view.entrance.GUILD_STATUE,
		g.view.entrance.DUNGEON,
		g.view.entrance.SILENT_UPGRADE,
		g.view.entrance.MYSTERY_BOSS_MAIN_LAYER
	}

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_NOTIFYINVITEE, self._onGetBioInviteFloat, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BIOGRAPHY_NOTIFYINVITEE_REMOVE, self._onCompCoolDownOver, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_CONFIRMINVITE, self._onNetRecvTeamInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYINVITE, self._onGetTeamPVPInviteFloat, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_CONFIRMINVITE, self._onNetRecvTeamPVPInfo, self)
end

function BioTeamInviteFloatService:_onGetBioInviteFloat(arg_2_1, arg_2_2, arg_2_3)
	if g.core.common.Setting:getValue(g.core.common.Setting.ACCEPT_BIO_TEAM_INVITE) ~= false then
		if not self:checkIsCanShow() then
			return
		end

		if #self._floatQueen >= self._maxShowNum then
			return
		end

		local var_2_0 = self._rootTipLayer
		local var_2_1 = fgui.GComponent:create()
		local var_2_2 = fgui.UIPackage:createObject("base_new", "BioTeamBeInvitedComp")

		var_2_1:addChild(var_2_2)
		var_2_0:addChild(var_2_1)

		local var_2_3 = {
			posY = 0,
			comp = var_2_2,
			teamId = arg_2_3.team_id,
			invitationData = arg_2_3
		}

		table.insert(self._floatQueen, var_2_3)
		var_2_2:updateBioTeamInfo(arg_2_3, self._inviteCoolTime)
		var_2_2:setX(display.width)
		g.core.model.User.bioData:delInvited(var_2_3.teamId)
	end

	self:_adaptPos()
end

function BioTeamInviteFloatService:_onGetTeamPVPInviteFloat(arg_3_1, arg_3_2, arg_3_3)
	if g.core.common.Setting:getValue(g.core.common.Setting.ACCEPT_BIO_TEAM_INVITE) ~= false then
		if not self:checkIsCanShow() then
			return
		end

		if #self._floatQueen >= self._maxShowNum then
			return
		end

		local var_3_0 = self._rootTipLayer
		local var_3_1 = fgui.GComponent:create()
		local var_3_2 = fgui.UIPackage:createObject("base_new", "TeamPVPBeInvitedComp")

		var_3_1:addChild(var_3_2)
		var_3_0:addChild(var_3_1)

		local var_3_3 = {
			posY = 0,
			comp = var_3_2,
			teamId = arg_3_3.invitaion.room_id,
			invitationData = arg_3_3.invitaion
		}

		table.insert(self._floatQueen, var_3_3)
		var_3_2:updateTeamPVPInfo(arg_3_3.invitaion, self._inviteCoolTime)
		var_3_2:setX(display.width)
		g.core.model.User.teamPvpData:delReceivedInvited(var_3_3.teamId)
	end

	self:_adaptPos()
end

function BioTeamInviteFloatService:_onCompCoolDownOver(arg_4_1, arg_4_2)
	if arg_4_2 and arg_4_2.teamId then
		for iter_4_0 = #self._floatQueen, 1, -1 do
			if self._floatQueen[iter_4_0].teamId == arg_4_2.teamId then
				if self._floatQueen[iter_4_0].comp then
					self._floatQueen[iter_4_0].comp:getParent():removeSelf()

					self._floatQueen[iter_4_0].comp = nil
				end

				table.remove(self._floatQueen, iter_4_0)
			end
		end
	end

	self:_adaptPos()
	self:_checkIsHasLeftCanShow()
end

function BioTeamInviteFloatService:_checkIsHasLeftCanShow()
	for iter_5_0, iter_5_1 in ipairs((g.core.model.User.bioData:getInvitedInfo())) do
		if #self._floatQueen >= self._maxShowNum then
			break
		end

		if iter_5_1 and g.core.common.ServerTime:getTime() - iter_5_1.invite_time < self._inviteCoolTime then
			self:_onGetBioInviteFloat(nil, nil, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in ipairs((g.core.model.User.teamPvpData:getInvitedInfo())) do
		if #self._floatQueen >= self._maxShowNum then
			break
		end

		if iter_5_3 and g.core.common.ServerTime:getTime() - iter_5_3.create_time < self._inviteCoolTime then
			self:_onGetTeamPVPInviteFloat(nil, nil, iter_5_3)
		end
	end
end

function BioTeamInviteFloatService:_adaptPos()
	for iter_6_0, iter_6_1 in ipairs(self._floatQueen) do
		local var_6_0

		if iter_6_1.comp then
			iter_6_1.comp:setY(self._beginShowPosY)

			var_6_0 = self._beginShowPosY + iter_6_1.comp:getHeight() + self._gap
		end
	end
end

function BioTeamInviteFloatService:_onNetRecvTeamInfo(arg_7_1, arg_7_2, arg_7_3)
	if g.core.model.User.bioData:getTeamInfo().id > 0 then
		for iter_7_0, iter_7_1 in ipairs(self._floatQueen) do
			if iter_7_1.comp and iter_7_1.comp.getOpen and iter_7_1.comp:getOpen() then
				iter_7_1.comp:getParent():removeSelf()

				iter_7_1.comp = nil
			end
		end

		self._floatQueen = {}

		local var_7_0 = g.core.module.ModuleManager:getCurModule()

		if not var_7_0 then
			return
		end

		if var_7_0.module ~= g.view.entrance.BIO_TEAM then
			g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.BIO_TEAM)
		end
	else
		local var_7_1 = false

		for iter_7_2 = #self._floatQueen, 1, -1 do
			if self._floatQueen[iter_7_2].teamId == arg_7_3.team_id then
				if self._floatQueen[iter_7_2].comp and self._floatQueen[iter_7_2].comp.getOpen and self._floatQueen[iter_7_2].comp:getOpen() then
					self._floatQueen[iter_7_2].comp:getParent():removeSelf()

					self._floatQueen[iter_7_2].comp = nil
				end

				table.remove(self._floatQueen, iter_7_2)

				var_7_1 = true
			end
		end

		if var_7_1 then
			self:_adaptPos()
			self:_checkIsHasLeftCanShow()
		end
	end
end

function BioTeamInviteFloatService:_onNetRecvTeamPVPInfo(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = g.core.model.User.teamPvpData:getTeamInfo()

	if var_8_0 and var_8_0.id and var_8_0.id > 0 then
		for iter_8_0, iter_8_1 in ipairs(self._floatQueen) do
			if iter_8_1.comp and iter_8_1.comp.getOpen and iter_8_1.comp:getOpen() then
				iter_8_1.comp:getParent():removeSelf()

				iter_8_1.comp = nil
			end
		end

		self._floatQueen = {}

		local var_8_1 = g.core.module.ModuleManager:getCurModule()

		if not var_8_1 then
			return
		end

		if var_8_1.module ~= g.view.entrance.TEAM_PVP_TEAM_LAYER then
			g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.TEAM_PVP_TEAM_LAYER)
		end
	else
		local var_8_2 = false

		for iter_8_2 = #self._floatQueen, 1, -1 do
			if self._floatQueen[iter_8_2].teamId == arg_8_3.room_id then
				if self._floatQueen[iter_8_2].comp and self._floatQueen[iter_8_2].comp.getOpen and self._floatQueen[iter_8_2].comp:getOpen() then
					self._floatQueen[iter_8_2].comp:getParent():removeSelf()

					self._floatQueen[iter_8_2].comp = nil
				end

				table.remove(self._floatQueen, iter_8_2)

				var_8_2 = true
			end
		end

		if var_8_2 then
			self:_adaptPos()
			self:_checkIsHasLeftCanShow()
		end
	end
end

function BioTeamInviteFloatService:checkIsCanShow()
	if g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() then
		return
	end

	local var_9_0 = g.core.module.ModuleManager:getCurModule()

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0.module

	if not var_9_0.module then
		return
	end

	local var_9_2 = g.core.module.ModuleManager:getCurRootModule()

	for iter_9_0, iter_9_1 in ipairs(self._ignoreModule) do
		if var_9_1 == iter_9_1 or var_9_2 == iter_9_1 then
			return false
		end
	end

	return true
end

function BioTeamInviteFloatService:judgeIsRefuseBioInviteIfEnterModule()
	if self._floatQueen and #self._floatQueen > 0 and not self:checkIsCanShow() then
		for iter_10_0 = #self._floatQueen, 1, -1 do
			if self._floatQueen[iter_10_0].comp then
				if self._floatQueen[iter_10_0].comp and self._floatQueen[iter_10_0].comp.getOpen and self._floatQueen[iter_10_0].comp:getOpen() then
					self._floatQueen[iter_10_0].comp:getParent():removeSelf()

					self._floatQueen[iter_10_0].comp = nil
				end

				table.remove(self._floatQueen, iter_10_0)
			end
		end
	end
end

return BioTeamInviteFloatService
