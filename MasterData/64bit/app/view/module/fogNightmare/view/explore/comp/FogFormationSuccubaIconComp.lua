local var_0_0 = g.core.const.ConstMgr.PreciousConst
local FogFormationSuccubaIconComp = class("FogFormationSuccubaIconComp", require("app.fairyGUI.fogNightmare.UI_FogFormationSuccubaIconComp"))

function FogFormationSuccubaIconComp:ctor()
	self._pos = 0

	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = -5,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._succubaStruct = nil
	self._unLock = true

	self:addClickListener(handler(self, self._onClick))
end

function FogFormationSuccubaIconComp:updateBtn(arg_2_1, arg_2_2)
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

function FogFormationSuccubaIconComp:setPos(arg_3_1)
	self._pos = arg_3_1
end

function FogFormationSuccubaIconComp:getPos()
	return self._pos
end

function FogFormationSuccubaIconComp:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3
end

function FogFormationSuccubaIconComp:onDragStart()
	self._isDrag = true

	self.m_succubaIcon:setAlpha(0.5)
end

function FogFormationSuccubaIconComp:onDragEnd()
	self.m_succubaIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false

		self.m_succubaIcon:setAlpha(1)
	end), 0.03)
end

function FogFormationSuccubaIconComp:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		self:dispatchCompEvent("clickAddSuccuba", {
			pos = self._pos
		})
	elseif not self._isDrag then
		if self._isOther and self._petInfo ~= nil then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petAdvId = self._petInfo.advance_id
			}), {
				touchDisappear = true,
				hideContinue = true
			})
		elseif not self._unLock and self._unLockText then
			g.core.module.ModuleManager:tip(self._unLockText)
		end
	end
end

function FogFormationSuccubaIconComp:setClickAddCall(arg_10_1)
	self._clickAddCall = arg_10_1
end

function FogFormationSuccubaIconComp:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	self.m_redPointComp:setId(0)
	self.m_redPointComp:setVisible(not self._isOther)
	self.m_isOtherController:setSelectedIndex(arg_11_1 and 1 or 0)
end

function FogFormationSuccubaIconComp:isOther()
	return self._isOther
end

function FogFormationSuccubaIconComp:checkRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._petPos
		}
	})
end

function FogFormationSuccubaIconComp:getComponentURL()
	return require("app.fairyGUI.fogNightmare.UI_FogFormationSuccubaIconComp").URL
end

function FogFormationSuccubaIconComp:getScriptFile()
	return "app.view.module.fogNightmare.view.explore.comp.FogFormationSuccubaIconComp"
end

function FogFormationSuccubaIconComp:getDragParam()
	if self._succubaStruct then
		return {
			data = self._succubaStruct,
			pos = self._pos
		}
	else
		return nil
	end
end

return FogFormationSuccubaIconComp
