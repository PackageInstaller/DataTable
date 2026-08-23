local var_0_0 = {
	IS_MODIFYING = 1,
	NOT_MODIFYING = 0
}
local var_0_1 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.FormationConst
local FormationPreTeamComp = class("FormationPreTeamComp", require("app.fairyGUI.formation.UI_FormationPreTeamComp"))

function FormationPreTeamComp:ctor()
	self._isInUse = false
	self._teamName = ""
	self._teamId = 0
	self._teamIndex = 0
	self._isMainTeam = false
	self._changeName = false
	self._fightStatus = false
	self._ids = {}
	self._type = var_0_4.POP_TYPE.PRESET
	self._editBtnCall = nil
	self.defaultTxt = g.core.lang:get(200021)
	self._levelDataList = {}
	self._minNameLength = g.core.config.parameter_info.fetch(var_0_1.PRE_FORMATION_MIN_NAME_LENGTH).parameter
	self._maxNameLength = g.core.config.parameter_info.fetch(var_0_1.PRE_FORMATION_MAX_NAME_LENGTH).parameter

	self:_initListener()
	self.m_isModifyingController:setSelectedIndex(var_0_0.NOT_MODIFYING)
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function FormationPreTeamComp:_initListener()
	self.m_changeNameBtn:addClickListener(handler(self, self._onChangeNameBtnClick))
	self.m_editBtn:addClickListener(handler(self, self._onEditBtnClick))
	self.m_nameInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputTextEnd))
	self.m_nameInput:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onInputTextBegin))
	self.m_cancelClick:addClickListener(handler(self, self._onCancelClick))
end

function FormationPreTeamComp:setData(arg_3_1, arg_3_2)
	self._ids = arg_3_1.ids or {}
	self._teamName = arg_3_1.teamName or ""
	self._teamIndex = arg_3_1.teamIndex or 0
	self._teamId = arg_3_1.teamId or 0
	self._isMainTeam = arg_3_1.isMainTeam or false
	self._fightStatus = arg_3_1.fightStatus or false
	self._type = arg_3_1.type or var_0_4.POP_TYPE.PRESET
	self._levelDataList = arg_3_1.levelDataList or {}
	self._editBtnCall = arg_3_2
end

function FormationPreTeamComp:updateComp(arg_4_1)
	self:_updateFormation()
	self:_updateOtherUI()
end

function FormationPreTeamComp:checkIsClickChangeName(arg_5_1)
	if self.m_changeNameBtn:containPoint(arg_5_1) then
		self:_onChangeNameBtnClick()
	end
end

function FormationPreTeamComp:_onChangeNameBtnClick()
	self.m_isModifyingController:setSelectedIndex(var_0_0.IS_MODIFYING)
	self.m_nameInput:setText("")
	self.m_label:setVisible(true)
end

function FormationPreTeamComp:_onEditBtnClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)

	if self._editBtnCall then
		self._editBtnCall(self._teamIndex)
	end
end

function FormationPreTeamComp:_onInputTextEnd()
	if self:_isNameValid() then
		local var_8_0 = self.m_nameInput:getText()

		if self._isMainTeam then
			g.core.network.GameNetProxy:send_C2S_Formation_ModifyName({
				name = var_8_0
			})
		else
			g.core.network.GameNetProxy:send_C2S_PresetFormation_NameModify({
				id = self._teamId,
				name = var_8_0
			})
		end
	end

	self:_updateOtherUI()
end

function FormationPreTeamComp:_onInputTextBegin()
	self.m_label:setVisible(false)
end

function FormationPreTeamComp:_onCancelClick()
	if self.m_isModifyingController:getSelectedIndex() == var_0_0.IS_MODIFYING then
		self.m_isModifyingController:setSelectedIndex(var_0_0.NOT_MODIFYING)
	end
end

function FormationPreTeamComp:_updateFormation()
	for iter_11_0 = 1, var_0_2.LINEUP_MAX do
		local var_11_0

		if self._ids[iter_11_0] and self._ids[iter_11_0] > 0 then
			var_11_0 = {
				sid = self._ids[iter_11_0]
			}
		end

		local var_11_3 = self._levelDataList[iter_11_0]
		local var_11_4, var_11_5, var_11_6

		if not self._levelDataList[iter_11_0] then
			var_11_3 = {}
			var_11_4 = var_11_3.rank or 0
			var_11_5 = iter_11_0
			var_11_6 = var_11_0
		end

		self["m_knightIcon" .. iter_11_0]:updateComp(iter_11_0, var_11_0, nil, true, false, var_11_3.level or 0, var_11_4)
	end
end

function FormationPreTeamComp:resetStatus()
	self.m_isModifyingController:setSelectedIndex(var_0_0.NOT_MODIFYING)
end

function FormationPreTeamComp:_updateOtherUI()
	self.m_teamNameTxt:setText(self._teamName, nil, true)
	self.m_teamIdTxt:setText(self._teamIndex)
	self.m_isMainTeamController:setSelectedIndex(self._isMainTeam and 1 or 0)
	self.m_isModifyingController:setSelectedIndex(var_0_0.NOT_MODIFYING)
	self.m_typeController:setSelectedIndex(self._type)
	self.m_changeNameBtn:setVisible(self._type == var_0_4.POP_TYPE.PRESET)
end

function FormationPreTeamComp:_isNameValid()
	local var_14_0 = g.core.lang:getNormalText(self.m_nameInput:getText() or "")
	local var_14_1, var_14_2 = g.core.utils.String.checkChannelStr(var_14_0)

	if var_14_1 then
		g.core.module.ModuleManager:tip(var_14_1)

		return false
	end

	local var_14_3 = #string.gsub(var_14_0, "[\x80-\xBF]", "") - var_14_2

	if var_14_0 == self._teamName then
		var_0_3:tip(g.core.lang:get(200023))
	elseif var_14_3 < self._minNameLength then
		var_0_3:tip(g.core.lang:get(200024, {
			num = self._minNameLength
		}))
	elseif var_14_3 > self._maxNameLength then
		var_0_3:tip(g.core.lang:get(101555, {
			num = self._maxNameLength
		}))
	elseif g.core.utils.Black:isMatchText(var_14_0) then
		var_0_3:tip(g.core.lang:get(1187))
	else
		return true
	end

	return false
end

return FormationPreTeamComp
