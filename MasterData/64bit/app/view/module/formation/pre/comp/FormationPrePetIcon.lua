local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.PetConst
local FormationPrePetIcon = class("FormationPrePetIcon", require("app.fairyGUI.formation.UI_FormationPrePetIcon"))

function FormationPrePetIcon:ctor()
	self._clickAddCall = nil
	self._unLock = true
	self._isDrag = false
	self._petPos = 0
	self._petInfo = {}
	self._petStruct = nil
	self._unLockTip = nil
	self._isOther = false

	self.m_starGroupComp:initStar({
		gap = -2,
		index = 3,
		style = 2,
		num = 0,
		max = var_0_1.STAR_MAX
	})
	self:addClickListener(handler(self, self._onClick))
end

function FormationPrePetIcon:setPetPos(arg_2_1)
	self._petPos = arg_2_1
end

function FormationPrePetIcon:getPetPos()
	return self._petPos
end

function FormationPrePetIcon:updatePetFormatIcon(arg_4_1)
	self._petStruct = arg_4_1

	if arg_4_1 then
		self.m_petLoader:setURL(var_0_0:getPetIcon(arg_4_1:getCfg().resource))
		self.m_qualityLine:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(arg_4_1:getQuality()))
		self.m_rankText:setText(arg_4_1:getAdvCfg().stage)
		self.m_starGroupComp:setStarNum(arg_4_1:getStarNum())
		self.m_hasStarController:setSelectedIndex(1)
		self.m_hasPetController:setSelectedIndex(1)
	else
		self.m_qualityLine:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))
		self.m_hasPetController:setSelectedIndex(0)
	end
end

function FormationPrePetIcon:setIsLock(arg_5_1, arg_5_2, arg_5_3)
	self._unLock = not arg_5_1
	self._unLockTip = arg_5_3

	self.m_openText:setText(g.core.lang:get(202514, {
		level = arg_5_2
	}))
	self.m_isLockController:setSelectedIndex(arg_5_1 and 1 or 0)
end

function FormationPrePetIcon:onDragStart()
	self._isDrag = true

	self.m_petLoader:setAlpha(0.5)
end

function FormationPrePetIcon:onDragEnd()
	self.m_petLoader:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function FormationPrePetIcon:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		if self._clickAddCall then
			self._clickAddCall(self._petPos, self._petStruct and self._petStruct:getSid() or 0)
		end
	elseif not self._isDrag then
		if self._isOther and self._petStruct ~= nil then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petStruct = self._petStruct
			}), {
				touchDisappear = true,
				hideContinue = true
			})
		elseif not self._unLock and self._unLockTip then
			g.core.module.ModuleManager:tip(self._unLockTip)
		end
	end
end

function FormationPrePetIcon:setClickAddCall(arg_10_1)
	self._clickAddCall = arg_10_1
end

function FormationPrePetIcon:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	self.m_addImg:setVisible(not self._isOther)
	self.m_redPointComp:setId(0)
	self.m_redPointComp:setVisible(not self._isOther)
end

function FormationPrePetIcon:isOther()
	return self._isOther
end

function FormationPrePetIcon:checkRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = self._petPos
		}
	})
end

return FormationPrePetIcon
