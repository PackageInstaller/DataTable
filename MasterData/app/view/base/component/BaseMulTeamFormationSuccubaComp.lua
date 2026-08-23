local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local BaseMulTeamFormationSuccubaComp = class("BaseMulTeamFormationSuccubaComp", require("app.fairyGUI.base_new.UI_BaseMulTeamFormationSuccubaComp"))

function BaseMulTeamFormationSuccubaComp:ctor()
	self._pos = 0

	self.m_starComp:initStar({
		gap = -5,
		style = 2,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX
	})

	self._succubaStruct = nil
	self._unLock = true

	self:addClickListener(handler(self, self._onClick))
end

function BaseMulTeamFormationSuccubaComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
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

function BaseMulTeamFormationSuccubaComp:setStationPos(arg_3_1)
	self._pos = arg_3_1
end

function BaseMulTeamFormationSuccubaComp:getStationPos()
	return self._pos
end

function BaseMulTeamFormationSuccubaComp:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3
end

function BaseMulTeamFormationSuccubaComp:onDragStart()
	self._isDrag = true

	self.m_succubaIcon:setAlpha(0.5)
end

function BaseMulTeamFormationSuccubaComp:resetCompAlpha()
	self.m_succubaIcon:setAlpha(1)
end

function BaseMulTeamFormationSuccubaComp:onDragEnd()
	self.m_succubaIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false

		self.m_succubaIcon:setAlpha(1)
	end), 0.03)
end

function BaseMulTeamFormationSuccubaComp:_onClick()
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

function BaseMulTeamFormationSuccubaComp:setClickAddCall(arg_11_1)
	self._clickAddCall = arg_11_1
end

function BaseMulTeamFormationSuccubaComp:setIsOtherStyle(arg_12_1)
	self._isOther = arg_12_1 == true

	if self._isOther then
		self.m_redPointComp:setId(0)
	end

	self.m_redPointComp:setVisible(not self._isOther)
	self.m_isOtherController:setSelectedIndex(arg_12_1 and 1 or 0)
end

function BaseMulTeamFormationSuccubaComp:isOther()
	return self._isOther
end

function BaseMulTeamFormationSuccubaComp:checkRedPoint(arg_14_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._pos,
			formationType = arg_14_1.formationType,
			formationIndex = arg_14_1.formationIndex
		}
	})
end

function BaseMulTeamFormationSuccubaComp:getSuccubaSid()
	return self._succubaStruct and self._succubaStruct:getSid() or 0
end

function BaseMulTeamFormationSuccubaComp:isEmpty()
	return self.m_isEmptyController:getSelectedIndex() == 1
end

function BaseMulTeamFormationSuccubaComp:becomeTo(arg_17_1)
	self:updateComp(arg_17_1:getStationPos(), arg_17_1:getSuccubaSid(), self._mulIndex)
end

function BaseMulTeamFormationSuccubaComp:setFormationType(arg_18_1)
	self._formationType = arg_18_1
end

return BaseMulTeamFormationSuccubaComp
