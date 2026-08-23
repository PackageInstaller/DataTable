local var_0_0 = g.core.const.ConstMgr.PreciousConst
local FormationSuccubaIconComp = class("FormationSuccubaIconComp", require("app.fairyGUI.formation.UI_FormationSuccubaIconComp"))

function FormationSuccubaIconComp:ctor()
	self._pos = 0

	self.m_starComp:initStar({
		style = 2,
		gap = -5,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._succubaStruct = nil
	self._unLock = true

	self:addClickListener(handler(self, self._onClick))
end

function FormationSuccubaIconComp:updateSuccubaIcon(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_succubaIcon:setIcon(g.core.common.Path:getSuccubaIconById(arg_2_1:getShowCfg().res))
		self.m_starComp:setStarNum(arg_2_1:getStar())

		local var_2_0 = arg_2_1:getStage()

		if var_2_0 > 0 then
			self.m_advLevel:setText(g.core.lang:get(2050, {
				level = var_2_0
			}))
		else
			self.m_advLevel:setText("")
		end
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_isOtherController:setSelectedIndex(0)

	self._succubaStruct = arg_2_1
end

function FormationSuccubaIconComp:setSuccubaPos(arg_3_1)
	self._pos = arg_3_1
end

function FormationSuccubaIconComp:getSuccubaPos()
	return self._pos
end

function FormationSuccubaIconComp:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3
end

function FormationSuccubaIconComp:onDragStart()
	self._isDrag = true

	self.m_succubaIcon:setAlpha(0.5)
end

function FormationSuccubaIconComp:onDragEnd()
	self.m_succubaIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false

		self.m_succubaIcon:setAlpha(1)
	end), 0.03)
end

function FormationSuccubaIconComp:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		if self._clickAddCall then
			self._clickAddCall(self._pos)
		end
	elseif self._isDrag or self._isOther and self._petStruct ~= nil then
		-- block empty
	elseif not self._unLock and self._unLockTip then
		g.core.module.ModuleManager:tip(self._unLockTip)
	end
end

function FormationSuccubaIconComp:setClickAddCall(arg_10_1)
	self._clickAddCall = arg_10_1
end

function FormationSuccubaIconComp:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	self.m_redPointComp:setId(0)
	self.m_redPointComp:setVisible(not self._isOther)
	self.m_isOtherController:setSelectedIndex(arg_11_1 and 1 or 0)
end

function FormationSuccubaIconComp:isOther()
	return self._isOther
end

function FormationSuccubaIconComp:checkRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._pos
		}
	})
end

return FormationSuccubaIconComp
