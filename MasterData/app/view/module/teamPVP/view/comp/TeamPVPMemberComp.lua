local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_4 = g.core.common.Path
local TeamPVPMemberComp = class("TeamPVPMemberComp", require("app.fairyGUI.teamPVP.UI_TeamPVPMemberComp"))

function TeamPVPMemberComp:ctor()
	self._snapshot = nil
	self._battleUser = nil
	self._params = nil
	self._guid = 0
	self._compPosition = 0
	self._curPos = 0
	self._knightPic = nil
	self._showKnightId = 0
	self._captainId = 0

	self:addClickListener(handler(self, self._onClickSelf))
end

function TeamPVPMemberComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._compPosition = arg_2_3 or self._compPosition
	self._captainId = arg_2_2

	if not arg_2_1 then
		self.m_hasPlayerController:setSelectedIndex(0)

		self._snapshot = nil
		self._battleUser = nil
		self._params = nil
		self._guid = 0

		return
	end

	self.m_hasPlayerController:setSelectedIndex(1)

	self._snapshot = arg_2_1.snapshot
	self._battleUser = arg_2_1.battleUser
	self._params = arg_2_1
	self._guid = self._battleUser.guid
	self._curPos = self._battleUser.position

	self.m_isNpcController:setSelectedIndex(0)

	if self._battleUser.is_robot then
		self.m_nameTxt:setText((var_0_0:getRobotName(self._guid)))
	elseif self._battleUser.npc_type and self._battleUser.npc_type > 0 then
		self.m_npcNameTxt:setText(var_0_1.NPC_NAME[self._battleUser.npc_type])
		self.m_isNpcController:setSelectedIndex(1)
	else
		self.m_nameTxt:setText(self._snapshot.name)
	end

	self.m_fightValue:setText(g.core.lang:get(420401, {
		num = self._snapshot.fight_value
	}))
	self.m_rankLoader:setURL(var_0_4:getTeamPVPBadge128(self._battleUser.title))

	local var_2_0 = var_0_0:getKnightResId(self._params)

	if var_2_0 ~= self._showKnightId then
		self._showKnightId = var_2_0

		local var_2_1 = {
			resId = var_2_0
		}

		if self._snapshot and self._snapshot.base_id ~= 0 then
			var_2_1 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(self._snapshot)
		end

		var_2_1.base = true
		var_2_1.breath = true
		var_2_1.listener = handler(self, self._knightAnimEvent)

		if self._knightPic then
			self._knightPic:removeFromParent()

			self._knightPic = nil
		end

		self._knightPic = BattleKnight.new(var_2_1)

		self.m_knightHolder:addNode(self._knightPic)
		self._knightPic:setScale(0.8)
	end

	self.m_isReadyController:setSelectedIndex(self._battleUser.is_ready and 1 or 0)
	self.m_isCaptainController:setSelectedIndex(self._guid == self._captainId and 1 or 0)
	self.m_isHelpController:setSelectedIndex((self._guid == var_0_0:getMyGuid() or nil) and var_0_0:getChallengeNum() == 0 and 1 or 0)
	self:_updateFiveMapBuffEffect()
end

function TeamPVPMemberComp:_updateFiveMapBuffEffect()
	local var_3_0
	local var_3_1 = 0
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs((var_0_0:getTeamPlayers())) do
		if iter_3_1.battleUser.npc_type == var_0_1.NPC_TYPE.MASTER then
			var_3_0 = iter_3_1
			var_3_1 = iter_3_1.battleUser.position
		end
	end

	local var_3_3 = var_0_1.MAP_PARMAS[var_0_0:getMapId()].Line

	if var_3_0 then
		var_3_2 = (var_3_1 - 1) % var_3_3 + 1
	end

	self.m_buffEff:removeAllEffect()

	if (self._curPos - 1) % var_3_3 + 1 == var_3_2 and self._battleUser.npc_type ~= var_0_1.NPC_TYPE.MASTER then
		self.m_buffEff:addEffectSpine({
			isLoop = true,
			name = "group_battle_buff"
		})
	end
end

function TeamPVPMemberComp:_knightAnimEvent(arg_4_1, arg_4_2)
	if arg_4_1 and arg_4_1.animation == BattleConst.SPINE_ACTION_TYPE.IN and arg_4_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
	end
end

function TeamPVPMemberComp:_onClickSelf(arg_5_1)
	if not self:_checkCanClick() then
		return
	end

	local var_5_0
	local var_5_2

	if arg_5_1 then
		var_5_0 = {}

		local var_5_1 = arg_5_1:getInput():getTouch()

		var_5_0.x = var_5_1:getLocationInView().x
		var_5_0.y = var_5_1:getLocationInView().y
		var_5_2 = require("app.view.module.teamPVP.view.TeamPVPMemberMenuPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamPVP.view.TeamPVPMemberMenuPop").new({
		snapshot = self._snapshot,
		battleUser = self._battleUser,
		isCaptain = var_0_0:getMyGuid() == self._captainId,
		clickWorldPos = var_5_0
	}, var_5_0), {
		isUpdateBlack = false,
		hideContinue = true
	})
end

function TeamPVPMemberComp:_checkCanClick()
	if not self._battleUser or not self._snapshot then
		return false
	end

	if self._battleUser.npc_type and self._battleUser.npc_type > 0 then
		return false
	end

	return self._snapshot.id ~= g.core.model.User:getId()
end

function TeamPVPMemberComp:showComp(arg_7_1)
	self.m_showGroup:setVisible(arg_7_1)
end

function TeamPVPMemberComp:getCompPos()
	return self._compPosition
end

function TeamPVPMemberComp:getParams()
	return self._params
end

function TeamPVPMemberComp:getBattleUser()
	return (self._params or nil) and (self._params.battleUser or nil)
end

function TeamPVPMemberComp:getShowKnight()
	return self._showKnightId
end

function TeamPVPMemberComp:getShowKnightParam()
	return (self._snapshot and self._snapshot.base_id ~= 0 or nil) and g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(self._snapshot)
end

function TeamPVPMemberComp:hasPlayer()
	return self._snapshot
end

function TeamPVPMemberComp:getGuid()
	return self._guid
end

return TeamPVPMemberComp
