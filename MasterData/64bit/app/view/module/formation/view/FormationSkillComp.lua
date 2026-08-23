local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.UniteTokenConst
local FormationSkillComp = class("FormationSkillComp", require("app.fairyGUI.formation.UI_FormationSkillComp"))

function FormationSkillComp:ctor()
	self._canFormatNum = 0
	self._lineupTokenData = {}
	self._skillComps = {}
	self._dragInst = fgui.DragDropManager:getInstance()

	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:_initFormatIcon()
end

function FormationSkillComp:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function FormationSkillComp:_initFormatIcon()
	for iter_3_0 = 1, var_0_1.FORMAT_UNITE_NUM_MAX do
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. iter_3_0]) then
			self._canFormatNum = self._canFormatNum + 1

			self["m_skill" .. iter_3_0]:setSkillPos(iter_3_0)

			self._skillComps[self._canFormatNum] = self["m_skill" .. iter_3_0]

			self["m_skill" .. iter_3_0]:setDraggable(true)
			self["m_skill" .. iter_3_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSkill))
			self["m_skill" .. iter_3_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSkill))
		else
			self["m_skill" .. iter_3_0]:updateFormatUnlock((g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. iter_3_0])))
		end
	end
end

function FormationSkillComp:showAllFormatIcon()
	self._canFormatNum = 0
	self._skillComps = {}

	for iter_4_0 = 1, var_0_1.FORMAT_UNITE_NUM_MAX do
		self._canFormatNum = self._canFormatNum + 1

		self["m_skill" .. iter_4_0]:setSkillPos(iter_4_0)

		self._skillComps[self._canFormatNum] = self["m_skill" .. iter_4_0]

		self["m_skill" .. iter_4_0]:setDraggable(false)
		self["m_skill" .. iter_4_0]:setIsOtherStyle()
	end
end

function FormationSkillComp:updateFormatInfo()
	self._lineupTokenData = var_0_0.uniteTokenData:getLineupTokenList()

	for iter_5_0 = 1, self._canFormatNum do
		self._skillComps[iter_5_0]:updateTokenFormatIcon(self._lineupTokenData[iter_5_0])
	end
end

function FormationSkillComp:updateFormatInfoByLineupTokens(arg_6_1)
	for iter_6_0 = 1, self._canFormatNum do
		self._skillComps[iter_6_0]:updateTokenFormatIcon(arg_6_1[iter_6_0])
	end
end

function FormationSkillComp:_dragLineupSkill(arg_7_1)
	arg_7_1:preventDefault()

	local var_7_0 = arg_7_1:getSender()
	local var_7_1 = self._lineupTokenData[var_7_0:getSkillPos()] or {}

	if next(var_7_1) then
		self._dragId = var_7_1:getAdvanceId()

		self._dragInst:startDrag(var_7_0.m_skillIcon:getIcon(), self._dragId, (arg_7_1:getInput():getTouchId()))

		self._dragComp = var_7_0

		self._dragComp:onDragStart()
		self:onDragStart()
	end
end

function FormationSkillComp:_dropLineupSkill(arg_8_1)
	local var_8_0 = arg_8_1:getSender():getSkillPos()
	local var_8_1 = self._lineupTokenData[var_8_0] or {}
	local var_8_2 = next(var_8_1) and var_8_1:getAdvanceId() or 0
	local var_8_3 = arg_8_1:getDataValue() or 0

	if var_8_0 <= var_0_1.FORMAT_UNITE_NUM_MAX and var_8_3 ~= 0 and var_8_2 ~= var_8_3 then
		local var_8_4 = var_0_0.uniteTokenData:getTokenByAdvId(var_8_3)

		if var_8_4 and var_8_4:getPos() ~= var_8_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = 2,
				pos = var_8_0,
				id = var_8_3
			})

			self._dragPos = var_8_0
		end
	end

	self._dragId = 0
end

function FormationSkillComp:_onTouchBegin(arg_9_1)
	arg_9_1:captureTouch()
end

function FormationSkillComp:_onTouchEnd()
	if self._dragId ~= 0 and self._dragComp then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = 2,
			pos = 0,
			id = self._dragId
		})
	end

	if self._dragComp then
		self._dragComp:onDragEnd()

		self._dragComp = nil

		self:onDragEnd()
	end
end

function FormationSkillComp:onDragStart()
	for iter_11_0 = 1, var_0_1.FORMAT_UNITE_NUM_MAX do
		if self._skillComps[iter_11_0] then
			self._skillComps[iter_11_0]:onOtherDragStart()
		end
	end
end

function FormationSkillComp:onDragEnd()
	for iter_12_0 = 1, var_0_1.FORMAT_UNITE_NUM_MAX do
		if self._skillComps[iter_12_0] then
			self._skillComps[iter_12_0]:onOtherDragEnd()
		end
	end
end

return FormationSkillComp
