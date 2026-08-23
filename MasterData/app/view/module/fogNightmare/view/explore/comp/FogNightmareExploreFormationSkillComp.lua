local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst
local var_0_3 = g.core.const.ConstMgr.PetConst
local var_0_4 = g.core.const.ConstMgr.SuccubaConst
local FogNightmareExploreFormationSkillComp = class("FogNightmareExploreFormationSkillComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreFormationSkillComp"))

function FogNightmareExploreFormationSkillComp:ctor()
	self._uniteTokens = {}
	self._pets = {}
	self._isPetUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET)
	self._succubas = {}
	self._isSuccubaUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET)
	self._dragInst = fgui.DragDropManager:getInstance()
	self._formationIdx = -1
end

function FogNightmareExploreFormationSkillComp:initUI()
	for iter_2_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_2_0]:setSkillPos(iter_2_0)
		self["m_uniteBtn" .. iter_2_0]:setDraggable(true)
		self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragStart))
		self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dragEnd))
	end

	for iter_2_1 = 1, var_0_3.LINEUP_MAX do
		self["m_petBtn" .. iter_2_1]:setPos(iter_2_1)
		self["m_petBtn" .. iter_2_1]:setDraggable((var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. iter_2_1])))
		self["m_petBtn" .. iter_2_1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragStart))
		self["m_petBtn" .. iter_2_1]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dragEnd))
	end

	self.m_isUnlockController:setSelectedIndex(self._isPetUnlock and 1 or 0)

	if not self._isPetUnlock then
		self.m_changeBtnPet:setVisible(false)
	else
		self.m_changeBtnPet:setVisible(true)
	end

	for iter_2_2 = 1, var_0_4.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_2_2]:setPos(iter_2_2)
		self["m_succubaComp" .. iter_2_2]:setDraggable(true)
		self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragStart))
		self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dragEnd))
	end

	if not self._isSuccubaUnlock then
		self.m_changeBtnSuccuba:setVisible(false)
	else
		self.m_changeBtnSuccuba:setVisible(true)
	end
end

function FogNightmareExploreFormationSkillComp:setIsOther(arg_3_1)
	self._isOther = arg_3_1
end

function FogNightmareExploreFormationSkillComp:setBtnDraggable(arg_4_1)
	for iter_4_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_4_0]:setDraggable(arg_4_1)
	end

	for iter_4_1 = 1, var_0_3.LINEUP_MAX do
		self["m_petBtn" .. iter_4_1]:setDraggable(var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. iter_4_1]) and arg_4_1)
	end

	for iter_4_2 = 1, var_0_4.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_4_2]:setDraggable(true)
	end
end

function FogNightmareExploreFormationSkillComp:_changeUniteToken(arg_5_1, arg_5_2)
	self._uniteTokens[arg_5_2] = arg_5_1

	self:_updateUniteToken(arg_5_2)
end

function FogNightmareExploreFormationSkillComp:_changePet(arg_6_1, arg_6_2)
	self._pets[arg_6_2] = arg_6_1

	self:_updatePet(arg_6_2)
end

function FogNightmareExploreFormationSkillComp:_changeSuccuba(arg_7_1, arg_7_2)
	self._succubas[arg_7_2] = self._isOther and arg_7_1 or arg_7_1:getSid()

	self:_updatePet(arg_7_2)
end

function FogNightmareExploreFormationSkillComp:updateComp(arg_8_1, arg_8_2)
	self._uniteTokens = arg_8_1.uniteTokens
	self._pets = arg_8_1.pets
	self._succubas = arg_8_1.succubas or {}
	self._formationIdx = arg_8_2

	self:_updateUniteToken()
	self:_updatePet()
	self:_updateSuccuba()
end

function FogNightmareExploreFormationSkillComp:_updateUniteToken(arg_9_1)
	if not arg_9_1 then
		for iter_9_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
			self["m_uniteBtn" .. iter_9_0]:updateBtn(self._uniteTokens[iter_9_0])
		end
	else
		self["m_uniteBtn" .. arg_9_1]:updateBtn(self._uniteTokens[arg_9_1])
	end
end

function FogNightmareExploreFormationSkillComp:_updatePet(arg_10_1)
	if not arg_10_1 then
		for iter_10_0 = 1, var_0_3.LINEUP_MAX do
			self["m_petBtn" .. iter_10_0]:updateBtn(self._pets[iter_10_0])
		end
	else
		self["m_petBtn" .. arg_10_1]:updateBtn(self._pets[arg_10_1])
	end
end

function FogNightmareExploreFormationSkillComp:_updateSuccuba(arg_11_1)
	if not arg_11_1 then
		for iter_11_0 = 1, var_0_4.FORMAT_SUCCUBA_NUM_MAX do
			self["m_succubaComp" .. iter_11_0]:updateBtn(self._isOther and self._succubas[iter_11_0] or g.core.model.User.succubaData:getSuccubaBySid(self._succubas[iter_11_0] or 0))
		end
	else
		self["m_succubaComp" .. arg_11_1]:updateBtn(self._isOther and self._succubas[arg_11_1] or g.core.model.User.succubaData:getSuccubaBySid(self._succubas[arg_11_1] or 0))
	end
end

function FogNightmareExploreFormationSkillComp:_dragStart(arg_12_1)
	arg_12_1:preventDefault()

	local var_12_0 = arg_12_1:getSender()
	local var_12_1 = var_12_0:getDragParam()

	if not var_12_1 or self._isOther then
		return
	end

	self._dragInst:startDrag(var_12_0:getComponentURL(), 1, (arg_12_1:getInput():getTouchId()))

	local var_12_2 = self._dragInst:getAgent():getComponent()

	if var_12_2 then
		fgui.UIPackage.iterObject(var_12_2)
		fgui.UIPackage.bindUIComponent(var_12_2, var_12_0:getScriptFile(), var_12_2:getParent())
		var_12_2:setPos(var_12_1.pos)
		var_12_2:updateBtn(var_12_1.data)
	end

	self._dragPos = var_12_1.pos
end

function FogNightmareExploreFormationSkillComp:_dragEnd(arg_13_1)
	local var_13_0 = self.m_styleController:getSelectedIndex()
	local var_13_1 = {}

	if var_13_0 == 0 then
		for iter_13_0 = 1, 10 do
			if not self["m_uniteBtn" .. iter_13_0] then
				break
			end

			table.insert(var_13_1, self["m_uniteBtn" .. iter_13_0])
		end
	elseif var_13_0 == 1 then
		for iter_13_1 = 1, 10 do
			if not self["m_petBtn" .. iter_13_1] then
				break
			end

			if var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. iter_13_1]) then
				table.insert(var_13_1, self["m_petBtn" .. iter_13_1])
			end
		end
	elseif var_13_0 == 2 then
		for iter_13_2 = 1, var_0_4.FORMAT_SUCCUBA_NUM_MAX do
			if not self["m_succubaComp" .. iter_13_2] then
				break
			end

			if true then
				table.insert(var_13_1, self["m_succubaComp" .. iter_13_2])
			end
		end
	end

	local var_13_2 = arg_13_1 and arg_13_1:getInput():getTouch()
	local var_13_3 = self._dragPos
	local var_13_4 = g.core.model.User.fogNightmareData:getFormationData():getLineUpFormation(self._formationIdx)

	for iter_13_3, iter_13_4 in ipairs(var_13_1) do
		if iter_13_4:containPoint((var_13_2:getLocation())) then
			if var_13_0 == 0 then
				var_13_4:switchUniteToken(var_13_3, iter_13_4:getPos())
				self:_updateUniteToken()

				break
			end

			if var_13_0 == 1 then
				var_13_4:switchPet(var_13_3, iter_13_4:getPos())
				self:_updatePet()

				break
			end

			if var_13_0 == 2 then
				var_13_4:switchSuccuba(var_13_3, iter_13_4:getPos())
				self:_updateSuccuba()
			end

			break
		end
	end
end

return FogNightmareExploreFormationSkillComp
