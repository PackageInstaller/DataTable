local var_0_0 = g.core.const.ConstMgr.PreciousConst
local GveFormationSuccubaIconComp = class("GveFormationSuccubaIconComp", require("app.fairyGUI.gve.UI_GveFormationSuccubaIconComp"))

function GveFormationSuccubaIconComp:ctor()
	self._pos = 0

	self.m_starComp:initStar({
		index = 3,
		num = 0,
		style = 2,
		gap = -5,
		max = var_0_0.STAR_MAX_NUM
	})

	self._succubaStruct = nil
	self._unLock = true

	self:addClickListener(handler(self, self._onClick))
end

function GveFormationSuccubaIconComp:updateSuccubaIcon(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_succubaIcon:setIcon(g.core.common.Path:getSuccubaIconById(arg_2_1:getShowCfg().res))
		self.m_starComp:setStarNum(arg_2_1:getStar())
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_isOtherController:setSelectedIndex(0)

	self._succubaStruct = arg_2_1
end

function GveFormationSuccubaIconComp:setSuccubaPos(arg_3_1)
	self._pos = arg_3_1
end

function GveFormationSuccubaIconComp:getSuccubaPos()
	return self._pos
end

function GveFormationSuccubaIconComp:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3
end

function GveFormationSuccubaIconComp:onDragStart()
	self._isDrag = true

	self.m_succubaIcon:setAlpha(0.5)
end

function GveFormationSuccubaIconComp:onDragEnd()
	self.m_succubaIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false

		self.m_succubaIcon:setAlpha(1)
	end), 0.03)
end

function GveFormationSuccubaIconComp:_onClick()
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

function GveFormationSuccubaIconComp:setClickAddCall(arg_10_1)
	self._clickAddCall = arg_10_1
end

function GveFormationSuccubaIconComp:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	if self._isOther then
		self.m_redPointComp:setId(0)
	end

	self.m_redPointComp:setVisible(not self._isOther)
	self.m_isOtherController:setSelectedIndex(arg_11_1 and 1 or 0)
end

function GveFormationSuccubaIconComp:isOther()
	return self._isOther
end

function GveFormationSuccubaIconComp:checkRedPoint(arg_13_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._pos,
			formationStruct = arg_13_1
		}
	})
end

return GveFormationSuccubaIconComp
