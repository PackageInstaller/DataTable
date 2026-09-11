local PolyhedronTerminalView = class("PolyhedronTerminalView", ReduxView)

function PolyhedronTerminalView:UIName()
	return "Widget/System/Polyhedron/Terminal/PolyhedronTalentUI"
end

function PolyhedronTerminalView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronTerminalView:Init()
	self:InitUI()
	self:AddUIListener()

	local var_3_0 = handler(self, self.OnItemClick)

	self.itemList = {}

	for iter_3_0, iter_3_1 in ipairs(PolyhedronTerminalCfg.all) do
		local var_3_1 = PolyhedronTerminalItem.New(self.m_tablentContent:Find(iter_3_1), iter_3_1)

		var_3_1:RegistCallBack(var_3_0)
		table.insert(self.itemList, var_3_1)
	end

	self.lineList = {}

	for iter_3_2 = 0, self.m_lineContent.childCount - 1 do
		local var_3_2 = self.m_lineContent:GetChild(iter_3_2).gameObject

		table.insert(self.lineList, (PolyhedronTerminalLine.New(var_3_2, var_3_2.name)))
	end

	self.showTipContorller = ControllerUtil.GetController(self.transform_, "showTip")
	self.infoController_ = ControllerUtil.GetController(self.m_infoTrans, "state")
	self.selectId = 0
end

function PolyhedronTerminalView:InitUI()
	self:BindCfgUI()
end

function PolyhedronTerminalView:AddUIListener()
	self:AddBtnListener(self.m_infoMask, nil, function()
		self:OnItemClick(0)
	end)
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		self:OnItemClick(0)
	end))
	self:AddBtnListener(self.m_resetBtn, nil, function()
		if #self.data == 0 then
			return
		end

		local var_8_0 = handler(self, self.OnResetDataBak)

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_RESET_TERMINAL_GIFT"),
			SecondTip = GetTips("WEEK_RESET_TIME"),
			SecondValue = PolyhedronData:GetResetTimes(),
			OkCallback = function()
				if PolyhedronData:GetResetTimes() > 0 then
					PolyhedronAction.ResetTerminal(var_8_0)
				else
					ShowTips(GetTips("MATRIX_TERMINAL_NO_REFRESH_TIMES"))
				end
			end
		})
	end)
	self:AddBtnListener(self.m_levelBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTerminalLevel")
	end)
	self:AddBtnListener(self.m_infoUnlockBtn, nil, function()
		if self.selectId == 0 then
			return
		end

		self:UnlockTerminal(self.selectId)
	end)
end

function PolyhedronTerminalView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronTerminalView:OnEnter()
	self.m_content.localPosition = Vector3(0, -127, 0)
	self.data = clone(PolyhedronData:GetTerminalGift())
	self.data_bak = clone(self.data)
	self.allPoint = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point

	local var_13_0 = PolyhedronData:GetTerminalLevel()

	self.m_levelLab.text = "" .. var_13_0
	self.m_expSlider.value = var_13_0 == #PolyhedronTerminalLevelCfg.all and 1 or PolyhedronData:GetTerminalExp() / (PolyhedronTerminalLevelCfg[var_13_0 + 1].exp - PolyhedronTerminalLevelCfg[var_13_0].exp)

	self:RegistEventListener(POLYHEDRON_TERMINAL_RESET, function()
		self.data = {}

		self:RefreshUI()
	end)
	self:RefreshUI()
end

function PolyhedronTerminalView:OnPolyhedronGameUpdate()
	self:RefreshUI()
end

function PolyhedronTerminalView:GetUsePoint()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self.data) do
		var_16_0 = var_16_0 + PolyhedronTerminalCfg[iter_16_1].cost
	end

	return var_16_0
end

function PolyhedronTerminalView:OnResetDataBak()
	self.data_bak = {}
end

function PolyhedronTerminalView:IsEqual()
	for iter_18_0, iter_18_1 in pairs(self.data) do
		if not table.indexof(self.data_bak, iter_18_1) then
			return false
		end
	end

	return true
end

function PolyhedronTerminalView:OnExit()
	if not self:IsEqual() then
		PolyhedronAction.QuerySetTerminal(self.data)
	end

	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:OnItemClick(0)
end

function PolyhedronTerminalView:UnlockTerminal(arg_20_1)
	if table.indexof(self.data, arg_20_1) then
		self:RefreshUI()

		return
	end

	if PolyhedronTerminalCfg[arg_20_1].cost > self.allPoint - self:GetUsePoint() then
		ShowTips(GetTips("POLYHEDRON_TERMINAL_LACK_POINT"))

		return
	end

	ShowTips(GetTips("POLYHEDRON_TERMINAL_UNLOCK_SUCCESS"))
	table.insert(self.data, arg_20_1)
	self:RefreshUI()
end

function PolyhedronTerminalView:OnItemClick(arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		self.showTipContorller:SetSelectedIndex(1)
	else
		self.showTipContorller:SetSelectedIndex(0)
	end

	if arg_21_1 == 0 and self.selectId == arg_21_1 then
		return
	end

	self.selectId = arg_21_1

	if arg_21_2 then
		local var_21_0 = self.m_scrollContent.transform:InverseTransformPoint((arg_21_2.transform_:TransformPoint(Vector3(0, 0, 0))))

		self.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		self:RemoveTween()

		self.tween_ = LeanTween.moveLocal(self.m_scrollContent.gameObject, Vector3.New(-var_21_0.x, -var_21_0.y, 0), 0.2)
	else
		self:RemoveTween()

		self.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end

	self:RefreshUI()
end

function PolyhedronTerminalView:RefreshUI()
	self.m_resetTimeLabel_.text = PolyhedronData:GetResetTimes()

	if #self.data == 0 then
		-- block empty
	end

	local var_22_0 = self.allPoint - self:GetUsePoint()

	self.m_pointLab.text = var_22_0

	for iter_22_0, iter_22_1 in ipairs(self.itemList) do
		local var_22_1 = iter_22_1:GetId()

		iter_22_1:SetChoice(var_22_1 == self.selectId)
		iter_22_1:SetData(self.data, table.indexof(self.data, var_22_1) and 0 or var_22_0 < PolyhedronTerminalCfg[var_22_1].cost and 3 or self:GetCanUnlock(var_22_1) and 1 or 2)
	end

	for iter_22_2, iter_22_3 in ipairs(self.lineList) do
		iter_22_3:SetData(self.data)
	end

	if self.selectId == 0 then
		return
	end

	local var_22_3 = PolyhedronTerminalCfg[self.selectId]

	self.m_infoIconImg.sprite = getSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. PolyhedronTerminalCfg[self.selectId].icon)
	self.m_infoNameLab.text = GetI18NText(var_22_3.name)
	self.m_infoCostLab.text = var_22_3.cost
	self.m_infoDesLab.text = GetI18NText(var_22_3.desc)

	local var_22_4, var_22_5 = self:GetCanUnlock(self.selectId)

	if not var_22_4 then
		self.m_infoLimitTip.text = var_22_5

		self.infoController_:SetSelectedIndex(2)

		return
	end

	if table.indexof(self.data, self.selectId) then
		self.infoController_:SetSelectedIndex(3)
	else
		self.infoController_:SetSelectedIndex(0)
	end
end

function PolyhedronTerminalView:GetCanUnlock(arg_23_1)
	if PolyhedronTerminalCfg[arg_23_1].need_level > PolyhedronData:GetTerminalLevel() then
		do return false, string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_UNLOCK"), PolyhedronTerminalCfg[arg_23_1].need_level) end

		local var_23_0 = 0
	end

	for iter_23_0, iter_23_1 in ipairs(PolyhedronTerminalCfg[arg_23_1].pre_id_list) do
		if iter_23_1 == 0 or table.indexof(self.data, iter_23_1) then
			return true, ""
		else
			var_23_0 = iter_23_1
		end
	end

	return false, GetTips("POLYHEDRON_TERMINAL_GIFT_UNLCOK")
end

function PolyhedronTerminalView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function PolyhedronTerminalView:OnPolyhedronGameUpdate()
	self:RefreshUI()
end

function PolyhedronTerminalView:Dispose()
	for iter_26_0, iter_26_1 in ipairs(self.itemList) do
		iter_26_1:Dispose()
	end

	self.itemList = {}

	for iter_26_2, iter_26_3 in ipairs(self.lineList) do
		iter_26_3:Dispose()
	end

	self.lineList = {}

	PolyhedronTerminalView.super.Dispose(self)
end

return PolyhedronTerminalView
