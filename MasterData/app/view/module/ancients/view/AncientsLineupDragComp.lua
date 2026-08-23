local AncientsLineupDragComp = class("AncientsLineupDragComp", require("app.fairyGUI.ancients.UI_AncientsLineupDragComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self._compPosArray = {}
	self._compPosReverseArray = {}

	for iter_1_0 = 1, 9 do
		table.insert(self._compPosArray, self:getChild("Comp_pos" .. iter_1_0))
		table.insert(self._compPosReverseArray, self:getChild("Comp_pos" .. 9 - iter_1_0 + 1))
	end

	self._compUsers = {}
	self._selectedCompUser = nil

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	for iter_1_1, iter_1_2 in ipairs(self._compPosArray) do
		iter_1_2:setFormationPos(iter_1_1)
		iter_1_2:setEmpty(true)
	end
end

function var_0_0:_onTouchBegin(arg_2_1)
	if g.core.model.User.ancientsData:isFinalState() and not g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) then
		return
	end

	arg_2_1:captureTouch()

	self._selectedCompUser = self:_getCompUserByLocation((arg_2_1:getInput():getTouch():getLocation()))

	if not self._selectedCompUser then
		return
	end
end

function var_0_0:_onTouchMove(arg_3_1)
	if not self._selectedCompUser then
		return
	end

	local var_3_0 = arg_3_1:getInput()

	self._selectedCompUser:setPosAndZOrder(var_3_0.x, display.height - var_3_0:getTouch():getLocation().y)
end

function var_0_0:_onTouchEnd(arg_4_1)
	if not self._selectedCompUser then
		return
	end

	local var_4_0 = self._selectedCompUser:displayObject():getBoundingBox()

	var_4_0.x = var_4_0.x + var_0_2.DRAG_RECT_ADJUST.x
	var_4_0.width = var_0_2.DRAG_RECT_ADJUST.width
	var_4_0.height = var_0_2.DRAG_RECT_ADJUST.height

	local var_4_1

	for iter_4_0, iter_4_1 in ipairs(self._compPosReverseArray) do
		if cc.rectIntersectsRect(var_4_0, (iter_4_1:displayObject():getBoundingBox())) then
			var_4_1 = iter_4_1

			break
		end
	end

	if var_4_1 then
		local var_4_2 = self._selectedCompUser:getFormationPos()
		local var_4_3 = var_4_1:getFormationPos()

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_PlayerMove)

		if g.core.model.User.ancientsData:isFinalState() then
			g.core.network.GameNetProxy:send_C2S_Ancient_FinalFormation({
				origin_pos = var_4_2,
				target_pos = var_4_3
			})
		else
			g.core.network.GameNetProxy:send_C2S_Ancient_Formation({
				origin_pos = var_4_2,
				target_pos = var_4_3
			})
		end
	else
		local var_4_4, var_4_5 = self:_calCompUserPos((self._selectedCompUser:getFormationPos()))

		self._selectedCompUser:setPosAndZOrder(var_4_4, var_4_5)
	end

	self._selectedCompUser = nil
end

function var_0_0:_reset()
	self.m_Comp_parent:removeChildren()

	self._compUsers = {}
end

function var_0_0:updateView()
	self:_reset()

	for iter_6_0, iter_6_1 in ipairs((g.core.model.User.ancientsData:getTeamUsers(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))) do
		local var_6_0 = g.core.model.User.ancientsData:getUserFormationPos(iter_6_1.user_id, var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

		if var_6_0 > 0 then
			local var_6_1 = require("app.view.module.ancients.view.AncientsLineupUserComp").new({
				teamUser = iter_6_1,
				formationPos = var_6_0
			})

			var_6_1:setSize(110, 110)
			var_6_1:setPivot(0.5, 0.5, true)
			self.m_Comp_parent:addChild(var_6_1)

			local var_6_2, var_6_3 = self:_calCompUserPos(var_6_0)

			var_6_1:setPosAndZOrder(var_6_2, var_6_3)
			table.insert(self._compUsers, var_6_1)
		end
	end

	self:_updateCompPosEmptyState()
end

function var_0_0:updateCompUsersFormationPos()
	for iter_7_0, iter_7_1 in ipairs(self._compUsers) do
		local var_7_0 = g.core.model.User.ancientsData:getUserFormationPos(iter_7_1:getUserId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

		if var_7_0 > 0 then
			local var_7_1, var_7_2 = self:_calCompUserPos(var_7_0)

			iter_7_1:setPosAndZOrder(var_7_1, var_7_2)
			iter_7_1:setFormationPos(var_7_0)
		end
	end

	self:_updateCompPosEmptyState()
end

function var_0_0:updateUsersBaseInfo(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._compUsers) do
		iter_8_1:updateUserBaseInfo()
	end
end

function var_0_0:_updateCompPosEmptyState()
	for iter_9_0, iter_9_1 in ipairs(self._compPosArray) do
		iter_9_1:setEmpty(self:_getCompUserByFormationPos(iter_9_0) == nil)
	end
end

function var_0_0:_calCompUserPos(arg_10_1)
	local var_10_0 = self._compPosArray[arg_10_1]:getPosition()

	return var_10_0.x - 10, var_10_0.y - 80
end

function var_0_0:_getCompUserByLocation(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self._compUsers) do
		if iter_11_1:containPoint(arg_11_1) then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0:_getCompUserByFormationPos(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._compUsers) do
		if iter_12_1:getFormationPos() == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

return var_0_0
