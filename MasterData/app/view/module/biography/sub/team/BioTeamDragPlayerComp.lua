local var_0_0 = g.core.model.User.bioData
local BioTeamDragPlayerComp = class("BioTeamDragPlayerComp", require("app.fairyGUI.biography.UI_BioTeamDragPlayerComp"))

function BioTeamDragPlayerComp:ctor(arg_1_1)
	self._memberPicNode = nil
	self._isInBattle = false

	self.m_tickOutBtn:addClickListener(handler(self, self._onTickOutPlayer))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._playerTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._playerTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._playerTouchEnd))
end

function BioTeamDragPlayerComp:init(arg_2_1)
	self._pos = arg_2_1
	self._initialPos = self:getPosition()
	self._isDragging = false
end

function BioTeamDragPlayerComp:resetPos()
	self:setPosition(self._initialPos)
end

function BioTeamDragPlayerComp:updateComp(arg_4_1)
	self._data = arg_4_1

	self:_updateSpineAndDesc(arg_4_1)
	self.m_prepareSateController:setSelectedIndex(0)
	self:setTouchable(arg_4_1.isSelfCaptain)

	if not arg_4_1 or not arg_4_1.member then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end

	self.m_onlyShowSpineController:setSelectedIndex(0)
	self.m_showTickOutController:setSelectedIndex(0)

	if arg_4_1.isSelfCaptain and not arg_4_1.member.captain then
		self.m_showTickOutController:setSelectedIndex(1)
	end

	self.m_isCaptainController:setSelectedIndex(arg_4_1.member.captain and 0 or 1)
	self.m_prepareSateController:setSelectedIndex(not arg_4_1.member.captain and arg_4_1.member.prepare and 1 or 0)
end

function BioTeamDragPlayerComp:getSelfData()
	return clone(self._data)
end

function BioTeamDragPlayerComp:_updateSpineAndDesc(arg_6_1)
	local var_6_0 = arg_6_1 and arg_6_1.member

	self:_showMemberPic(arg_6_1 and arg_6_1.member)
	self.m_playerDescComp:update(var_6_0)
end

function BioTeamDragPlayerComp:_onTickOutPlayer(arg_7_1)
	arg_7_1:stopPropagation()

	local var_7_0 = var_0_0:getMemberAtPos(self._pos)

	if var_7_0 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.KICK_OUT)
		g.core.network.GameNetProxy:send_C2S_Biography_KickOutTeam({
			id = var_0_0:getTeamInfo().campaign_id,
			kick_id = var_7_0.user.id
		})
	end
end

function BioTeamDragPlayerComp:_playerTouchBegin(arg_8_1)
	if self._data.member then
		arg_8_1:captureTouch()
		self:dispatchCompEvent("DragStart", self._pos)
	end
end

function BioTeamDragPlayerComp:_playerTouchMove(arg_9_1)
	if self._data.member then
		local var_9_0 = arg_9_1:getInput():getPosition()

		self:setPosition(cc.p(var_9_0.x, var_9_0.y))

		self._isDragging = true

		self:dispatchCompEvent("DragMove", self._pos)
	end
end

function BioTeamDragPlayerComp:_playerTouchEnd(arg_10_1)
	if self._isDragging then
		self._isDragging = false

		if self._data.member then
			self:dispatchCompEvent("DragEnd", self._data.member.position == 1 and 2 or 1, (arg_10_1:getInput():getTouch():getLocation()))
		end
	end

	self:dispatchCompEvent("resetOrder")
end

function BioTeamDragPlayerComp:_getKnightPicUrl(arg_11_1)
	if arg_11_1 and arg_11_1.user then
		local var_11_0

		if arg_11_1.robot and arg_11_1.user.robot_type and arg_11_1.user.robot_type ~= 0 and arg_11_1.user.robot_type ~= 999 then
			var_11_0 = tonumber(g.core.config.robot_info.get(arg_11_1.user.base_id).res_id)
		else
			var_11_0 = g.core.model.User:getUserUniqueAdvanceId(arg_11_1.user.base_id)

			local var_11_1 = self:_getKnightRes(arg_11_1.user)

			if var_11_1 then
				var_11_0 = var_11_1
			end
		end

		return g.core.common.Path:getMiddleKnightPicById(var_11_0), (g.core.config.knight_base_info.get(var_11_0))
	end
end

function BioTeamDragPlayerComp:_createPicAlphaNode(arg_12_1)
	local var_12_0, var_12_1 = self:_getKnightPicUrl(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_2 = 200
	local var_12_3 = fgui.UIPackage:createObject("biography", "BioTeamDragMaskComp")

	var_12_3:getChild("knightPicLoader"):setURL(var_12_0)

	local var_12_4 = var_12_3:getSize()
	local var_12_5 = cc.AlphaNode:create()

	var_12_5:setAnchorPoint(0.5, 0.5)
	var_12_5:setContentSize(var_12_4)
	var_12_5:addChild((var_12_3:popDisplayObject()))
	var_12_5:showChangingVertRect(cc.rect(0, var_12_2, 0, var_12_4.height - var_12_2 * 2), var_12_2)

	return var_12_5
end

function BioTeamDragPlayerComp:_showMemberPic(arg_13_1)
	if self._memberPicNode then
		self._memberPicNode:removeFromParent()

		self._memberPicNode = nil
	end

	if not arg_13_1 then
		return
	end

	if self.m_maskSpineComp then
		self._memberPicNode = self:_createPicAlphaNode(arg_13_1)

		self.m_maskSpineComp:addNode(self._memberPicNode)
	end
end

function BioTeamDragPlayerComp:_getKnightRes(arg_14_1)
	local var_14_0
	local var_14_1

	if arg_14_1.dress_id and arg_14_1.dress_id ~= 0 then
		var_14_1 = g.core.config.knight_base_info.get(g.core.config.knight_info.get(arg_14_1.base_id).sex == 0 and g.core.config.dress_info.get(arg_14_1.dress_id).woman_res_id or g.core.config.dress_info.get(arg_14_1.dress_id).man_res_id)
	end

	if var_14_1 then
		var_14_0 = var_14_1.painted_id
	end

	local var_14_3

	if arg_14_1.show_knight_id then
		var_14_3 = arg_14_1.show_knight_id or 0

		if var_14_3 == 0 then
			var_14_3 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
		end
	end

	local var_14_4 = arg_14_1.show_knight_dress or 0
	local var_14_5

	if var_14_4 and var_14_4 > 0 then
		var_14_5 = g.core.config.knight_base_info.get(g.core.config.skin_info.get(var_14_4).res)
	elseif var_14_3 and var_14_3 > 0 then
		var_14_5 = g.core.config.knight_base_info.get(g.core.config.knight_info.get(var_14_3).res_id)
	end

	return (var_14_5 and var_14_5.painted_id or nil) and var_14_5.painted_id
end

function BioTeamDragPlayerComp:resumeInitialPos()
	self:setPosition(self._initialPos)
end

function BioTeamDragPlayerComp:setIsBattle(arg_16_1)
	self._isInBattle = arg_16_1
end

return BioTeamDragPlayerComp
