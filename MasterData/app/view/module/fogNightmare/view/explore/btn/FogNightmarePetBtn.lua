local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.PetConst
local var_0_4 = g.core.model.User.gveDataMgr:getGveFormationData()
local FogNightmarePetBtn = class("FogNightmarePetBtn", require("app.fairyGUI.fogNightmare.UI_FogNightmarePetBtn"))

function FogNightmarePetBtn:ctor()
	self._unLock = true
	self._isDrag = false
	self._petPos = 0
	self._petInfo = {}
	self._petData = {}
	self._unLockText = nil
	self._isOther = false

	self.m_starGroupComp:initStar({
		gap = -2,
		style = 2,
		index = 3,
		num = 0,
		max = var_0_3.STAR_MAX
	})
	self:addClickListener(handler(self, self._onClick))
end

function FogNightmarePetBtn:setPos(arg_2_1)
	self._petPos = arg_2_1

	local var_2_0 = var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. arg_2_1])

	self._unLock = var_2_0

	local var_2_1, var_2_2 = var_0_0:getModuleUnlockLevelAndComment(var_0_1["PET_LINE_UP_" .. arg_2_1])

	self._unLockText = g.core.lang:get(202514, {
		level = var_2_1
	})

	self.m_isLockController:setSelectedIndex(var_2_0 and 0 or 1)
	self.m_openText:setText(self._unLockText)
end

function FogNightmarePetBtn:getPos()
	return self._petPos
end

function FogNightmarePetBtn:updateBtn(arg_4_1)
	self._petData = arg_4_1

	if arg_4_1 then
		self.m_petLoader:setURL(var_0_2:getPetIcon(arg_4_1:getCfg().resource))
		self.m_qualityLine:setURL(var_0_2:getMulTeamLeftVerticalQualityBarURL(arg_4_1:getQuality()))
		self.m_rankText:setText(arg_4_1:getAdvCfg().stage)
		self.m_starGroupComp:setStarNum(arg_4_1:getStarNum())
		self.m_hasStarController:setSelectedIndex(1)
		self.m_hasPetController:setSelectedIndex(1)
	else
		self.m_qualityLine:setURL(var_0_2:getMulTeamLeftVerticalQualityBarURL(0))
		self.m_hasPetController:setSelectedIndex(0)
	end
end

function FogNightmarePetBtn:onDragStart()
	self._isDrag = true

	self.m_petLoader:setAlpha(0.5)
end

function FogNightmarePetBtn:onDragEnd()
	self.m_petLoader:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function FogNightmarePetBtn:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		self:dispatchCompEvent("clickAddPet", {
			pos = self._petPos
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

function FogNightmarePetBtn:setIsOtherStyle(arg_9_1)
	self._isOther = arg_9_1 == true

	self:setVisible(not self._isOther or self._petInfo ~= nil)
end

function FogNightmarePetBtn:isOther()
	return self._isOther
end

function FogNightmarePetBtn:checkRedPoint()
	if self._isOther then
		self.m_redPointComp:setShow(false)

		return
	end

	if self.m_qualityController:getSelectedIndex() == 0 then
		if var_0_4:isHasPetCanUp() then
			self.m_redPointComp:setShow(true)
		else
			self.m_redPointComp:setShow(false)
		end
	else
		self.m_redPointComp:setShow(false)
	end
end

function FogNightmarePetBtn:getComponentURL()
	return require("app.fairyGUI.fogNightmare.UI_FogNightmarePetBtn").URL
end

function FogNightmarePetBtn:getScriptFile()
	return "app.view.module.fogNightmare.view.explore.btn.FogNightmarePetBtn"
end

function FogNightmarePetBtn:getDragParam()
	if self._petData then
		return {
			data = self._petData,
			pos = self._petPos
		}
	else
		return nil
	end
end

return FogNightmarePetBtn
