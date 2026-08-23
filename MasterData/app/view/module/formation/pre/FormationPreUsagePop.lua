local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.const.ConstMgr.FormationConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.formationData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.event.EventManager
local FormationPreUsagePop = class("FormationPreUsagePop", require("app.fairyGUI.formation.UI_FormationPreUsagePop"), function()
	return fgui.GComponent:create({
		resName = "FormationPreUsagePop",
		pkgPath = "ui/formation/formation",
		pkgName = "formation"
	})
end)

function FormationPreUsagePop:ctor(arg_2_1)
	self._type = arg_2_1.type or var_0_1.POP_TYPE.PRESET
	self._curSelectedIndex = arg_2_1.index or var_0_1.MAIN_FORMATION_INDEX
	self._recommendTeam = arg_2_1.recommendTeam or {}
	self._needLineupNum = 0
	self._maxTeamNum = var_0_3:getMaxFormationCount() + 1
	self._isFightEnable = false
	self._isTipChangeName = true
	self._mainFormationTeam = {}
	self._mainKnightData = {}
	self._teamLevelDataList = {}
	self._curNeedChangeTeamIndex = 0

	self:showAtCenter()
	self:_initData()
	self:_initListView()
	self:_initListener()
	self.m_typeController:setSelectedIndex(self._type)
	self.m_selectBtn:setVisible(self._isFightEnable)
end

function FormationPreUsagePop:_initData()
	local var_3_0 = var_0_4:getFormationKnights()

	for iter_3_0 = 1, var_0_0.LINEUP_MAX do
		self._mainFormationTeam[iter_3_0] = var_3_0[iter_3_0] or 0
	end

	for iter_3_1 = 1, var_0_0.LINEUP_MAX do
		local var_3_1 = var_0_4:getKnight({
			pos = iter_3_1
		})

		if var_3_1 then
			self._mainKnightData[iter_3_1] = {
				level = var_3_1:getLevel(),
				rank = var_3_1:getAdvStageAndLevel(),
				id = var_3_1:getServerId()
			}
		end
	end

	self._teamLevelDataList[var_0_1.MAIN_FORMATION_INDEX] = self._mainKnightData
end

function FormationPreUsagePop:_initListView()
	self.m_teamList:setVirtual()
	self.m_teamList:setItemRenderer(handler(self, self._onTeamItemRenderer))
end

function FormationPreUsagePop:_initListener()
	self.m_tipBtn:addClickListener(handler(self, self._onTipBtnClick))
	self.m_teamList:addClickListener(handler(self, self._onTeamListClick))
	self.m_selectBtn:addClickListener(handler(self, self._onSelectBtnClick))
	self.m_changeCheckBtn:addClickListener(handler(self, self._onClickInterchangeBtn))
end

function FormationPreUsagePop:onLoad()
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT, handler(self, self._onS2CPresetFormationInherit), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_NAMEMODIFY, handler(self, self._onS2CPresetFormationNameModify), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_MODIFYNAME, handler(self, self._onS2CPresetFormationNameModify), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH, handler(self, self._onS2CPresetFormationFlush), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._onS2CFormationChangeFormation), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE, handler(self, self._onS2CPresetFormationSave), self)

	if not var_0_3:isGetPreFormationData() then
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Flush({
			tp = var_0_1.PRESET_FORMATION_TYPE.MAIN
		})
	else
		self:updateView()
		self.m_teamList:setSelectedIndex(self._curSelectedIndex)
		self.m_teamList:scrollToView(math.max(self._curSelectedIndex - 1, 0))
	end

	self.m_changeCheckBtn:setSelected(var_0_3:isInterchangeFormation())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FormationPreUsagePop:_onTeamItemRenderer(arg_7_1, arg_7_2)
	local var_7_0 = {}

	if arg_7_1 == var_0_1.MAIN_FORMATION_INDEX then
		var_7_0.ids = self._mainFormationTeam
		var_7_0.teamName = var_0_3:getMainName()
		var_7_0.fightStatus = false
		var_7_0.teamId = 0
		var_7_0.isMainTeam = true
	else
		local var_7_1 = var_0_3:getPreFormation(arg_7_1)

		var_7_0.ids = var_7_1:getKnightIds()
		var_7_0.teamName = var_7_1:getFormationName()
		var_7_0.fightStatus = var_7_1:isFormationFightEnable() == var_0_1.USE_CONDITION_STATE.NONE
		var_7_0.teamId = var_7_1:getFormationUniqueId()
		var_7_0.isMainTeam = false
	end

	var_7_0.teamIndex = arg_7_1
	var_7_0.type = self._type
	var_7_0.levelDataList = self._teamLevelDataList[arg_7_1]

	arg_7_2:setData(var_7_0, handler(self, self._onClickCellEditBtn))
	arg_7_2:updateComp()
end

function FormationPreUsagePop:_onClickCellEditBtn(arg_8_1)
	if self._type == var_0_1.POP_TYPE.PRESET then
		self._isTipChangeName = false

		self:dispatchCompEvent("FormationPreUsagePop_cell_editBtn_Select", {
			index = arg_8_1
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	elseif self._type == var_0_1.POP_TYPE.ONEKEY then
		if table.nums(self._recommendTeam.notOwnKnightData) > 0 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.knightBag.view.KnightOneKeyConfirmPop").new({
				notOwnKnightData = self._recommendTeam.notOwnKnightData,
				index = arg_8_1,
				confirmCallBack = handler(self, self._saveFormation)
			})))
		else
			self:_saveFormation(arg_8_1)
		end
	end
end

function FormationPreUsagePop:_saveFormation(arg_9_1)
	local var_9_0 = self._recommendTeam.knightIds or {}
	local var_9_1 = self._recommendTeam.artifactIds or {}

	if arg_9_1 == var_0_1.MAIN_FORMATION_INDEX then
		for iter_9_0 = 1, var_0_0.LINEUP_MAX do
			if var_9_0[iter_9_0] and var_9_0[iter_9_0] ~= 0 then
				self._needLineupNum = self._needLineupNum + 1

				local var_9_2 = g.core.model.User.knightsData:getKnightByAdvanceId(var_9_0[iter_9_0])

				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = g.core.network.proto.TYPE_KNIGHT,
					pos = iter_9_0,
					id = var_9_2:getServerId()
				})
			end
		end

		for iter_9_1 = 1, var_0_0.LINEUP_MAX do
			if var_9_1[iter_9_1] and var_9_1[iter_9_1] ~= 0 then
				self._needLineupNum = self._needLineupNum + 1

				local var_9_3 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_1[iter_9_1])

				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = g.core.network.proto.TYPE_ARTIFACT,
					pos = iter_9_1,
					id = var_9_3:getServerOnlyId()
				})
			end
		end
	else
		local var_9_4 = var_0_3:getPreFormation(arg_9_1)

		for iter_9_2 = 1, var_0_0.LINEUP_MAX do
			if var_9_0[iter_9_2] and var_9_0[iter_9_2] ~= 0 then
				var_9_4:formationKnight(iter_9_2, g.core.model.User.knightsData:getKnightByAdvanceId(var_9_0[iter_9_2]):getServerId())
			else
				var_9_4:formationKnight(iter_9_2, 0)
			end
		end

		for iter_9_3 = 1, var_0_0.LINEUP_MAX do
			if var_9_1[iter_9_3] and var_9_1[iter_9_3] ~= 0 then
				var_9_4:formationArtifact(iter_9_3, g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_1[iter_9_3]):getServerOnlyId())
			else
				var_9_4:formationArtifact(iter_9_3, 0)
			end
		end

		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(var_9_4:toOutBaseFormation())
			}
		})
	end
end

function FormationPreUsagePop:_onTipBtnClick()
	var_0_2:pushPopup((require("app.view.base.component.HelpPop").new({
		id = 300
	})))
end

function FormationPreUsagePop:_onTeamListClick(arg_11_1)
	local var_11_0 = self.m_teamList:getSelectedIndex()

	if self._curSelectedIndex ~= var_11_0 then
		local var_11_1 = self.m_teamList:itemIndexToChildIndex(self._curSelectedIndex)

		self._curSelectedIndex = var_11_0

		if var_11_1 >= 0 and var_11_1 < self.m_teamList:numChildren() then
			self.m_teamList:getChildAt(var_11_1):resetStatus()
		end

		local var_11_2 = self.m_teamList:itemIndexToChildIndex(var_11_0)

		if var_11_2 >= 0 and var_11_2 < self.m_teamList:numChildren() then
			self.m_teamList:getChildAt(var_11_2):checkIsClickChangeName((arg_11_1:getInput():getTouch():getLocation()))
		end
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Large_03)
	self:updateBtn()
end

function FormationPreUsagePop:_onSelectBtnClick()
	if self._type == var_0_1.POP_TYPE.PRESET then
		self:_PresetSelectClick()
	else
		self:_myTeamSelectClick()
	end
end

function FormationPreUsagePop:_onClickInterchangeBtn()
	var_0_3:setInterchangeFormation((self.m_changeCheckBtn:isSelected()))
	self:dispatchCompEvent("Select_Interchange_Btn")
end

function FormationPreUsagePop:_PresetSelectClick()
	if self.m_canFightController:getSelectedIndex() == 0 then
		local var_14_0 = var_0_3:getPreFormation(self._curSelectedIndex):isFormationFightEnable()

		if var_14_0 == var_0_1.USE_CONDITION_STATE.KNIGHT then
			var_0_2:tip(g.core.lang:get(200029))
		elseif var_14_0 == var_0_1.USE_CONDITION_STATE.PET then
			var_0_2:tip(g.core.lang:get(200033))
		end

		return
	end

	local var_14_1 = var_0_3:getPreFormation(self._curSelectedIndex)

	if var_14_1:getFormationUniqueId() > 0 then
		if not var_14_1:isValidName() then
			self._isTipChangeName = false

			g.core.network.GameNetProxy:send_C2S_PresetFormation_NameModify({
				id = var_14_1:getFormationUniqueId(),
				name = var_14_1:getFormationName()
			})

			self._curNeedChangeTeamIndex = self._curSelectedIndex

			return
		end

		g.core.network.GameNetProxy:send_C2S_PresetFormation_Inherit({
			preset_id = var_14_1:getFormationUniqueId(),
			artifact_id = var_14_1:getAutoLineupArtifact()
		})
		var_0_3:refreshPreDataByCurFormation()
	end
end

function FormationPreUsagePop:_myTeamSelectClick()
	local var_15_0 = {}

	var_15_0 = self._curSelectedIndex == var_0_1.MAIN_FORMATION_INDEX and self._mainFormationTeam or var_0_3:getPreFormation(self._curSelectedIndex):getKnightIds()

	for iter_15_0 = 1, var_0_0.LINEUP_MAX do
		if var_15_0[iter_15_0] and var_15_0[iter_15_0] > 0 then
			self:dispatchCompEvent("FormationPreUsagePop_Preset_Select", {
				ids = var_15_0
			})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

			return
		end
	end

	var_0_2:tip(g.core.lang:get(200020))
end

function FormationPreUsagePop:_onS2CPresetFormationInherit(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function FormationPreUsagePop:_onS2CPresetFormationNameModify(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if self._curNeedChangeTeamIndex > 0 then
		local var_17_0 = var_0_3:getPreFormation(self._curNeedChangeTeamIndex)

		if var_17_0:getFormationUniqueId() > 0 then
			g.core.network.GameNetProxy:send_C2S_PresetFormation_Inherit({
				preset_id = var_17_0:getFormationUniqueId(),
				artifact_id = var_17_0:getAutoLineupArtifact()
			})
			var_0_3:refreshPreDataByCurFormation()
		end

		self._curNeedChangeTeamIndex = 0
	else
		self.m_teamList:setNumItems(self._maxTeamNum)

		if self._isTipChangeName then
			var_0_2:tip(g.core.lang:get(200025))
		end

		self._isTipChangeName = true
	end
end

function FormationPreUsagePop:_onS2CPresetFormationFlush(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self:updateView()
	self.m_teamList:setSelectedIndex(self._curSelectedIndex)
	self.m_teamList:scrollToView(self._curSelectedIndex)
end

function FormationPreUsagePop:_onS2CFormationChangeFormation(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if self._type == var_0_1.POP_TYPE.ONEKEY then
		self._needLineupNum = self._needLineupNum - 1

		if self._needLineupNum == 0 then
			local var_19_0 = var_0_4:getFormationKnights()

			for iter_19_0 = 1, var_0_0.LINEUP_MAX do
				self._mainFormationTeam[iter_19_0] = var_19_0[iter_19_0] or 0
			end

			self.m_teamList:setNumItems(self._maxTeamNum)
			g.core.module.ModuleManager:tip(g.core.lang:get(433502))
		end
	end
end

function FormationPreUsagePop:_onS2CPresetFormationSave(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if self._type == var_0_1.POP_TYPE.ONEKEY then
		self.m_teamList:setNumItems(self._maxTeamNum)
		g.core.module.ModuleManager:tip(g.core.lang:get(433502))
	end
end

function FormationPreUsagePop:updateTeamLevel()
	for iter_21_0 = 1, var_0_3:getMaxFormationCount() do
		local var_21_0 = {}

		for iter_21_1 = 1, var_0_0.LINEUP_MAX do
			var_21_0[iter_21_1] = var_21_0[iter_21_1] or self._mainKnightData[iter_21_1] or {}
		end

		self._teamLevelDataList[iter_21_0] = var_21_0
	end
end

function FormationPreUsagePop:updateView()
	self:updateBtn()
	self:updateTeamLevel()
	self.m_teamList:setNumItems(self._maxTeamNum)
end

function FormationPreUsagePop:updateBtn()
	local var_23_0 = self._curSelectedIndex == var_0_1.MAIN_FORMATION_INDEX

	if self._curSelectedIndex == var_0_1.MAIN_FORMATION_INDEX then
		self._isFightEnable = false
	else
		self._isFightEnable = var_0_3:getPreFormation(self._curSelectedIndex):isFormationFightEnable() == var_0_1.USE_CONDITION_STATE.NONE
	end

	if self._type == var_0_1.POP_TYPE.PRESET then
		self.m_selectBtn:setVisible(not var_23_0)
		self.m_canFightController:setSelectedIndex(self._isFightEnable and 1 or 0)
		self.m_changeCheckBtn:setVisible(self._isFightEnable)
	elseif self._type == var_0_1.POP_TYPE.MYTEAM then
		self.m_selectBtn:setVisible(true)
		self.m_canFightController:setSelectedIndex(1)
	end
end

return FormationPreUsagePop
