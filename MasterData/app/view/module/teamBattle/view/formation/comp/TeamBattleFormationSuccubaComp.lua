local var_0_0 = g.core.const.ConstMgr.PreciousConst
local TeamBattleFormationSuccubaComp = class("TeamBattleFormationSuccubaComp", require("app.fairyGUI.teamBattle.UI_TeamBattleFormationSuccubaComp"))

function TeamBattleFormationSuccubaComp:ctor()
	self._pos = 0

	self.m_starComp:initStar({
		gap = -5,
		style = 2,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._succubaStruct = nil
	self._unLock = true

	self:addClickListener(handler(self, self._onClick))
end

function TeamBattleFormationSuccubaComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0

	if arg_2_2 ~= 0 then
		var_2_0 = g.core.model.User.succubaData:getSuccubaBySid(arg_2_2)

		self.m_isEmptyController:setSelectedIndex(0)
		self.m_succubaIcon:setIcon(g.core.common.Path:getSuccubaIconById(var_2_0:getShowCfg().res))
		self.m_starComp:setStarNum(var_2_0:getStar())
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_isOtherController:setSelectedIndex(0)

	self._pos = arg_2_1
	self._mulIndex = arg_2_3
	self._succubaStruct = var_2_0
end

function TeamBattleFormationSuccubaComp:setStationPos(arg_3_1)
	self._pos = arg_3_1
end

function TeamBattleFormationSuccubaComp:getStationPos()
	return self._pos
end

function TeamBattleFormationSuccubaComp:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3
end

function TeamBattleFormationSuccubaComp:onDragStart()
	self._isDrag = true

	self.m_succubaIcon:setAlpha(0.5)
end

function TeamBattleFormationSuccubaComp:onDragEnd()
	self.m_succubaIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false

		self.m_succubaIcon:setAlpha(1)
	end), 0.03)
end

function TeamBattleFormationSuccubaComp:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		self:dispatchCompEvent("gve_formation_click_add_succuba", {
			pos = self._pos
		})
	elseif not self._isDrag then
		if self._isOther and self._succubaStruct ~= nil then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.succuba.view.SuccubaInfoPop").new({
				succubaStruct = self._succubaStruct
			}), {
				touchDisappear = true,
				hideContinue = true
			})
		elseif not self._unLock and self._unLockText then
			g.core.module.ModuleManager:tip(self._unLockText)
		end
	end
end

function TeamBattleFormationSuccubaComp:setClickAddCall(arg_10_1)
	self._clickAddCall = arg_10_1
end

function TeamBattleFormationSuccubaComp:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	self.m_redPointComp:setId(0)
	self.m_redPointComp:setVisible(not self._isOther)
	self.m_isOtherController:setSelectedIndex(arg_11_1 and 1 or 0)
end

function TeamBattleFormationSuccubaComp:isOther()
	return self._isOther
end

function TeamBattleFormationSuccubaComp:checkRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._pos
		}
	})
end

function TeamBattleFormationSuccubaComp:getSuccubaSid()
	return self._succubaStruct and self._succubaStruct:getSid() or 0
end

function TeamBattleFormationSuccubaComp:isEmpty()
	return self.m_isEmptyController:getSelectedIndex() == 1
end

function TeamBattleFormationSuccubaComp:becomeTo(arg_16_1)
	self:updateComp(arg_16_1:getStationPos(), arg_16_1:getSuccubaSid(), self._mulIndex)
end

function TeamBattleFormationSuccubaComp:setFormationType(arg_17_1)
	self._formationType = arg_17_1
end

return TeamBattleFormationSuccubaComp
