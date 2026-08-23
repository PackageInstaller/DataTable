local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst
local var_0_3 = g.core.const.ConstMgr.SuccubaConst
local GveFormationBottomComp = class("GveFormationBottomComp", require("app.fairyGUI.gve.UI_GveFormationBottomComp"))
local var_0_5 = g.core.const.ConstMgr.PetConst.LINEUP_MAX

function GveFormationBottomComp:ctor()
	self._startPos = 0
	self._isShowSlef = false
	self._dragUniteComp = nil
	self._dragPetComp = nil
	self._formationData = var_0_0:getGveFormationData()

	self.m_stateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStateControlChanged))
	self:initBottom()
end

function GveFormationBottomComp:initBottom()
	self.m_changeBtn2:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET)))
end

function GveFormationBottomComp:initComp()
	for iter_3_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_3_0]:setSkillPos(iter_3_0)
		self["m_uniteBtn" .. iter_3_0]:setDraggable(true)
		self["m_uniteBtn" .. iter_3_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSkill))
		self["m_uniteBtn" .. iter_3_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSkill))
	end

	for iter_3_1 = 1, var_0_5 do
		self["m_pet" .. iter_3_1]:setPetPos(iter_3_1)
		self["m_pet" .. iter_3_1]:setDraggable(true)
		self["m_pet" .. iter_3_1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupPet))
		self["m_pet" .. iter_3_1]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupPet))
	end

	for iter_3_2 = 1, var_0_3.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_3_2]:setSuccubaPos(iter_3_2)
		self["m_succubaComp" .. iter_3_2]:setDraggable(true)
		self["m_succubaComp" .. iter_3_2]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSuccuba))
		self["m_succubaComp" .. iter_3_2]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSuccuba))
	end
end

function GveFormationBottomComp:setIsShowSelf(arg_4_1)
	self._isShowSlef = arg_4_1 == true
end

function GveFormationBottomComp:_dragLineupSkill(arg_5_1)
	arg_5_1:preventDefault()

	local var_5_0 = arg_5_1:getSender()

	if var_5_0:isOther() then
		return
	end

	local var_5_1 = var_5_0:getSkillPos()
	local var_5_2 = self._formationData:getUniteByPos(var_5_1)

	if var_5_2 then
		self._startPos = var_5_1

		fgui.DragDropManager:getInstance():startDrag(var_5_0.m_skillIcon:getIcon(), var_5_2:getAdvanceId(), (arg_5_1:getInput():getTouchId()))

		self._dragUniteComp = var_5_0

		self._dragUniteComp:onDragStart()
	end
end

function GveFormationBottomComp:_dropLineupSkill(arg_6_1)
	local var_6_0 = arg_6_1:getSender()
	local var_6_1 = var_6_0:getSkillPos()

	if var_6_1 <= var_0_2.FORMAT_UNITE_NUM_MAX and var_6_1 ~= self._startPos then
		local var_6_2 = self._formationData:getFormationStruct()

		var_6_2:lineupUniteToken(var_6_1, var_6_2:getUniteTokenSid(self._startPos))
		self._dragUniteComp:setSkillPos(self._startPos)
		var_6_0:setSkillPos(var_6_1)

		self._startPos = 0

		var_0_1:tip(g.core.lang:get(200006))
	end

	self:updateComp()
end

function GveFormationBottomComp:_dragLineupPet(arg_7_1)
	arg_7_1:preventDefault()

	local var_7_0 = arg_7_1:getSender()

	if var_7_0:isOther() then
		return
	end

	local var_7_1 = var_7_0:getPetPos()
	local var_7_2 = self._formationData:getPetByPos(var_7_1)

	if var_7_2 then
		self._startPos = var_7_1

		fgui.DragDropManager:getInstance():startDrag("ui://gve/GveFormationPetIcon", var_7_2:getSid(), (arg_7_1:getInput():getTouchId()))

		local var_7_3 = fgui.DragDropManager:getInstance()
		local var_7_4 = var_7_3:getAgent():getComponent()

		if var_7_3 then
			var_7_4:bindLua("app.view.module.gve.view.gveFormation.comp.GveFormationPetIcon")
			var_7_4:updatePetFormatIcon(self._formationData:getPetByPos(var_7_1))
		end

		self._dragPetComp = var_7_0

		self._dragPetComp:onDragStart()
	end
end

function GveFormationBottomComp:_dropLineupPet(arg_8_1)
	local var_8_0 = arg_8_1:getSender()
	local var_8_1 = var_8_0:getPetPos()

	if var_8_1 <= var_0_5 and var_8_1 ~= self._startPos then
		local var_8_2 = self._formationData:getFormationStruct()

		var_8_2:lineupPet(var_8_1, var_8_2:getPetSid(self._startPos))
		self._dragPetComp:setPetPos(self._startPos)
		var_8_0:setPetPos(var_8_1)

		self._startPos = 0

		var_0_1:tip(g.core.lang:get(200006))
	end

	self._moveComp = nil

	self:updateComp()
end

function GveFormationBottomComp:_dragLineupSuccuba(arg_9_1)
	arg_9_1:preventDefault()

	local var_9_0 = arg_9_1:getSender()

	if var_9_0:isOther() then
		return
	end

	local var_9_1 = var_9_0:getSuccubaPos()
	local var_9_2 = self._formationData:getSuccubaPos(var_9_1)

	if var_9_2 then
		self._startPos = var_9_1

		fgui.DragDropManager:getInstance():startDrag("ui://gve/GveFormationSuccubaIconComp", var_9_2:getSid(), (arg_9_1:getInput():getTouchId()))

		local var_9_3 = fgui.DragDropManager:getInstance()
		local var_9_4 = var_9_3:getAgent():getComponent()

		if var_9_3 then
			var_9_4:bindLua("app.view.module.gve.view.gveFormation.comp.GveFormationSuccubaIconComp")
			var_9_4:updateSuccubaIcon(self._formationData:getSuccubaPos(var_9_1))
		end

		self._dragSuccubaComp = var_9_0

		self._dragSuccubaComp:onDragStart()
	end
end

function GveFormationBottomComp:_dropLineupSuccuba(arg_10_1)
	local var_10_0 = arg_10_1:getSender()
	local var_10_1 = var_10_0:getSuccubaPos()

	if var_10_1 <= var_0_3.FORMAT_SUCCUBA_NUM_MAX and var_10_1 ~= self._startPos then
		local var_10_2 = self._formationData:getFormationStruct()

		var_10_2:lineupSuccuba(var_10_1, var_10_2:getSuccubaSid(self._startPos))
		self._dragSuccubaComp:setSuccubaPos(self._startPos)
		var_10_0:setSuccubaPos(var_10_1)

		self._startPos = 0

		var_0_1:tip(g.core.lang:get(200006))
	end

	self._moveComp = nil

	self:updateComp()
end

function GveFormationBottomComp:checkIsTouchEnd(arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1:getInput():getTouch()

	if var_11_0 and self._startPos > 0 then
		local var_11_1 = var_11_0:getLocation()
		local var_11_2 = self.m_stateController:getSelectedIndex()

		if var_11_2 == 0 then
			if self["m_uniteBtn" .. self._startPos] and not self["m_uniteBtn" .. self._startPos]:containPoint(var_11_1) then
				self._formationData:lineupUnite(self._startPos, nil)
			end
		elseif var_11_2 == 1 then
			if self["m_pet" .. self._startPos] and not self["m_pet" .. self._startPos]:containPoint(var_11_1) then
				self._formationData:lineupPet(self._startPos, nil)
			end
		elseif var_11_2 == 2 and self["m_succubaComp" .. self._startPos] and not self["m_succubaComp" .. self._startPos]:containPoint(var_11_1) then
			self._formationData:lineupSuccuba(self._startPos, nil)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.GVE_CHANGE_SUCCUBA)
		end

		self._startPos = 0

		self:updateComp()
	end

	if self._dragUniteComp then
		self._dragUniteComp:onDragEnd()

		self._dragUniteComp = nil
	end

	if self._dragPetComp then
		self._dragPetComp:onDragEnd()

		self._dragPetComp = nil
	end

	if self._dragSuccubaComp then
		self._dragSuccubaComp:onDragEnd()

		self._dragSuccubaComp = nil
	end
end

function GveFormationBottomComp:updateComp(arg_12_1)
	if self._isShowSlef then
		for iter_12_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
			self["m_uniteBtn" .. iter_12_0]:updateTokenFormatIcon(self._formationData:getUniteByPos(iter_12_0))
			self["m_uniteBtn" .. iter_12_0]:setIsOtherStyle(false)
			self["m_uniteBtn" .. iter_12_0]:checkRedPoint()
		end

		for iter_12_1 = 1, var_0_5 do
			self["m_pet" .. iter_12_1]:updatePetFormatIcon(self._formationData:getPetByPos(iter_12_1))
			self["m_pet" .. iter_12_1]:setIsOtherStyle(false)
			self["m_pet" .. iter_12_1]:checkRedPoint()
		end

		for iter_12_2 = 1, var_0_3.FORMAT_SUCCUBA_NUM_MAX do
			self["m_succubaComp" .. iter_12_2]:updateSuccubaIcon(self._formationData:getSuccubaPos(iter_12_2))
			self["m_succubaComp" .. iter_12_2]:setIsOtherStyle(false)
			self["m_succubaComp" .. iter_12_2]:checkRedPoint()
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_changeBtn3:getChild("redPointComp"),
			customData = {
				formationStruct = self._formationData:getFormationStruct()
			}
		})
		self:_onUpdatePetAndUniteTabRedPoint()
	else
		for iter_12_3 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
			self["m_uniteBtn" .. iter_12_3]:updateMonsterIcon(arg_12_1)
			self["m_uniteBtn" .. iter_12_3]:setIsOtherStyle(true)
			self["m_uniteBtn" .. iter_12_3]:checkRedPoint()
		end

		for iter_12_4 = 1, var_0_5 do
			self["m_pet" .. iter_12_4]:updateMonsterIcon(arg_12_1)
			self["m_pet" .. iter_12_4]:setIsOtherStyle(true)
			self["m_pet" .. iter_12_4]:checkRedPoint()
		end

		for iter_12_5 = 1, var_0_3.FORMAT_SUCCUBA_NUM_MAX do
			self["m_succubaComp" .. iter_12_5]:updateSuccubaIcon(nil)
			self["m_succubaComp" .. iter_12_5]:setIsOtherStyle(true)
			self["m_succubaComp" .. iter_12_5]:checkRedPoint()
		end

		self.m_petRedComp:setShow(false)
		self.m_uniteRedComp:setShow(false)
	end
end

function GveFormationBottomComp:_onStateControlChanged()
	if self._isShowSlef then
		self:_onUpdatePetAndUniteTabRedPoint()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_changeBtn3:getChild("redPointComp"),
			customData = {
				formationStruct = self._formationData:getFormationStruct()
			}
		})
	end
end

function GveFormationBottomComp:_onUpdatePetAndUniteTabRedPoint()
	local var_14_0 = self.m_stateController:getSelectedIndex() ~= 0 and 1 or -1
	local var_14_1 = self.m_stateController:getSelectedIndex() ~= 1 and 0 or -1

	if var_14_0 >= 0 then
		self.m_uniteRedComp:setShow(self._formationData:isChangeBtnHasRedPoint(var_14_0))
	else
		self.m_uniteRedComp:setShow(false)
	end

	if var_14_1 >= 0 then
		self.m_petRedComp:setShow(self._formationData:isChangeBtnHasRedPoint(var_14_1))
	else
		self.m_petRedComp:setShow(false)
	end
end

return GveFormationBottomComp
