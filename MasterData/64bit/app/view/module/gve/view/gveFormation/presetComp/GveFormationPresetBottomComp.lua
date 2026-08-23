local var_0_0 = g.core.model.User.uniteTokenData
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.const.ConstMgr.UniteTokenConst
local var_0_4 = g.core.const.ConstMgr.PetConst
local var_0_5 = g.core.const.ConstMgr.SuccubaConst
local GveFormationPresetBottomComp = class("GveFormationPresetBottomComp", require("app.fairyGUI.gve.UI_GveFormationPresetBottomComp"))

function GveFormationPresetBottomComp:ctor()
	self._startPos = 0
	self._presetFormationStruct = nil
	self._dragUniteComp = nil
	self._dragPetComp = nil
end

function GveFormationPresetBottomComp:initComp()
	for iter_2_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_2_0]:setSkillPos(iter_2_0)
		self["m_uniteBtn" .. iter_2_0]:setDraggable(true)
		self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSkill))
		self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSkill))
	end

	for iter_2_1 = 1, var_0_4.LINEUP_MAX do
		self["m_pet" .. iter_2_1]:setPetPos(iter_2_1)
		self["m_pet" .. iter_2_1]:setDraggable(true)
		self["m_pet" .. iter_2_1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupPet))
		self["m_pet" .. iter_2_1]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupPet))
	end

	for iter_2_2 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_2_2]:setSuccubaPos(iter_2_2)
		self["m_succubaComp" .. iter_2_2]:setDraggable(true)
		self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSuccuba))
		self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSuccuba))
	end

	self:initBottom()
end

function GveFormationPresetBottomComp:initBottom()
	self.m_changeBtn2:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET)))
end

function GveFormationPresetBottomComp:_dragLineupSkill(arg_4_1)
	arg_4_1:preventDefault()

	local var_4_0 = arg_4_1:getSender()
	local var_4_1 = var_4_0:getSkillPos()
	local var_4_2 = self._presetFormationStruct:getUniteTokenSid(var_4_1)

	if var_4_2 and var_4_2 > 0 then
		self._startPos = var_4_1

		fgui.DragDropManager:getInstance():startDrag(var_4_0.m_skillIcon:getIcon(), var_4_2, (arg_4_1:getInput():getTouchId()))

		self._dragUniteComp = var_4_0

		self._dragUniteComp:onDragStart()
	end
end

function GveFormationPresetBottomComp:_dropLineupSkill(arg_5_1)
	local var_5_0 = arg_5_1:getSender():getSkillPos()

	if var_5_0 <= var_0_3.FORMAT_UNITE_NUM_MAX and var_5_0 ~= self._startPos then
		self._presetFormationStruct:lineupUniteToken(var_5_0, self._presetFormationStruct:getUniteTokenSid(self._startPos))

		self._startPos = 0

		var_0_2:tip(g.core.lang:get(200006))
	end

	self:updatePresetBottomComp()
end

function GveFormationPresetBottomComp:_dragLineupPet(arg_6_1)
	arg_6_1:preventDefault()

	local var_6_0 = arg_6_1:getSender()
	local var_6_1 = var_6_0:getPetPos()
	local var_6_2 = self._presetFormationStruct:getPetSid(var_6_1)

	if var_6_2 and var_6_2 > 0 then
		self._startPos = var_6_1

		fgui.DragDropManager:getInstance():startDrag("ui://gve/GveFormationPetIcon", var_6_2, (arg_6_1:getInput():getTouchId()))

		local var_6_3 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_6_3 then
			var_6_3:bindLua("app.view.module.gve.view.gveFormation.comp.GveFormationPetIcon")
			var_6_3:updatePetFormatIcon((var_0_1:getPetBySid(var_6_2)))
		end

		self._dragPetComp = var_6_0

		self._dragPetComp:onDragStart()
	end
end

function GveFormationPresetBottomComp:_dropLineupPet(arg_7_1)
	local var_7_0 = arg_7_1:getSender():getPetPos()

	if var_7_0 <= var_0_4.LINEUP_MAX and var_7_0 ~= self._startPos then
		self._presetFormationStruct:lineupPet(var_7_0, self._presetFormationStruct:getPetSid(self._startPos))

		self._startPos = 0

		var_0_2:tip(g.core.lang:get(200006))
	end

	self._moveComp = nil

	self:updatePresetBottomComp()
end

function GveFormationPresetBottomComp:_dragLineupSuccuba(arg_8_1)
	arg_8_1:preventDefault()

	local var_8_0 = arg_8_1:getSender()
	local var_8_1 = var_8_0:getSuccubaPos()
	local var_8_2 = self._presetFormationStruct:getSuccubaSid(var_8_1)

	if var_8_2 and var_8_2 > 0 then
		self._startPos = var_8_1

		fgui.DragDropManager:getInstance():startDrag("ui://gve/GveFormationSuccubaIconComp", var_8_2, (arg_8_1:getInput():getTouchId()))

		local var_8_3 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_8_3 then
			var_8_3:bindLua("app.view.module.gve.view.gveFormation.comp.GveFormationSuccubaIconComp")
			var_8_3:updateSuccubaIcon((g.core.model.User.succubaData:getSuccubaBySid(var_8_2)))
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_changeBtn3:getChild("redPointComp"),
				customData = {
					formationStruct = self._presetFormationStruct
				}
			})
		end

		self._dragSuccubaComp = var_8_0

		self._dragSuccubaComp:onDragStart()
	end
end

function GveFormationPresetBottomComp:_dropLineupSuccuba(arg_9_1)
	local var_9_0 = arg_9_1:getSender():getSuccubaPos()

	if var_9_0 <= var_0_5.FORMAT_SUCCUBA_NUM_MAX and var_9_0 ~= self._startPos then
		self._presetFormationStruct:lineupSuccuba(var_9_0, self._presetFormationStruct:getSuccubaSid(self._startPos))

		self._startPos = 0

		var_0_2:tip(g.core.lang:get(200006))
	end

	self._moveComp = nil

	self:updatePresetBottomComp()
end

function GveFormationPresetBottomComp:checkIsTouchEnd(arg_10_1)
	local var_10_0 = arg_10_1 and arg_10_1:getInput():getTouch()

	if var_10_0 and self._startPos > 0 then
		local var_10_1 = var_10_0:getLocation()
		local var_10_2 = self.m_stateController:getSelectedIndex()

		if var_10_2 == 0 then
			if self["m_uniteBtn" .. self._startPos] and not self["m_uniteBtn" .. self._startPos]:containPoint(var_10_1) then
				self._presetFormationStruct:lineupUniteToken(self._startPos, nil)
			end
		elseif var_10_2 == 1 then
			if self["m_pet" .. self._startPos] and not self["m_pet" .. self._startPos]:containPoint(var_10_1) then
				self._presetFormationStruct:lineupPet(self._startPos, nil)
			end
		elseif var_10_2 == 2 and self["m_succubaComp" .. self._startPos] and not self["m_succubaComp" .. self._startPos]:containPoint(var_10_1) then
			self._presetFormationStruct:lineupSuccuba(self._startPos, nil)
		end

		self._startPos = 0

		self:updatePresetBottomComp()
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

function GveFormationPresetBottomComp:updatePresetBottomComp()
	if not self._presetFormationStruct then
		return
	end

	self:updatePresetBottomPetComp()
	self:updatePresetBottomUniteComp()
	self:updatePresetBottomSuccubaComp()
end

function GveFormationPresetBottomComp:updatePresetBottomPetComp()
	for iter_12_0 = 1, var_0_4.LINEUP_MAX do
		self["m_pet" .. iter_12_0]:updatePetFormatIcon((var_0_1:getPetBySid(self._presetFormationStruct:getPetSid(iter_12_0))))
	end
end

function GveFormationPresetBottomComp:updatePresetBottomUniteComp()
	for iter_13_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_13_0]:updateTokenFormatIcon((var_0_0:getTokenByAdvId(self._presetFormationStruct:getUniteTokenSid(iter_13_0))))
	end
end

function GveFormationPresetBottomComp:updatePresetBottomSuccubaComp()
	for iter_14_0 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_14_0]:updateSuccubaIcon((g.core.model.User.succubaData:getSuccubaBySid((self._presetFormationStruct:getSuccubaSid(iter_14_0)))))
		self["m_succubaComp" .. iter_14_0]:setIsOtherStyle(false)
		self["m_succubaComp" .. iter_14_0]:checkRedPoint(self._presetFormationStruct)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeBtn3:getChild("redPointComp"),
		customData = {
			formationStruct = self._presetFormationStruct
		}
	})
end

function GveFormationPresetBottomComp:setPresetFormationStruct(arg_15_1)
	self._presetFormationStruct = arg_15_1
end

function GveFormationPresetBottomComp:_onUpdatePetAndUniteTabRedPoint()
	local var_16_0 = self.m_stateController:getSelectedIndex() ~= 0 and 1 or -1
	local var_16_1 = self.m_stateController:getSelectedIndex() ~= 1 and 0 or -1

	if var_16_0 >= 0 then
		self.m_uniteRedComp:setShow(self._formationData:isChangeBtnHasRedPoint(var_16_0))
	else
		self.m_uniteRedComp:setShow(false)
	end

	if var_16_1 >= 0 then
		self.m_petRedComp:setShow(self._formationData:isChangeBtnHasRedPoint(var_16_1))
	else
		self.m_petRedComp:setShow(false)
	end
end

return GveFormationPresetBottomComp
