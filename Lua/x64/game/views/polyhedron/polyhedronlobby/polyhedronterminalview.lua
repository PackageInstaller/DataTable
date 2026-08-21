local var_0_0 = class("PolyhedronTerminalView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/Terminal/PolyhedronTalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	local var_3_0 = handler(arg_3_0, arg_3_0.OnItemClick)

	arg_3_0.itemList = {}

	for iter_3_0, iter_3_1 in ipairs(PolyhedronTerminalCfg.all) do
		local var_3_1 = arg_3_0.m_tablentContent:Find(iter_3_1)
		local var_3_2 = PolyhedronTerminalItem.New(var_3_1, iter_3_1)

		var_3_2:RegistCallBack(var_3_0)
		table.insert(arg_3_0.itemList, var_3_2)
	end

	arg_3_0.lineList = {}

	local var_3_3 = arg_3_0.m_lineContent.childCount

	for iter_3_2 = 0, var_3_3 - 1 do
		local var_3_4 = arg_3_0.m_lineContent:GetChild(iter_3_2).gameObject
		local var_3_5 = var_3_4.name
		local var_3_6 = PolyhedronTerminalLine.New(var_3_4, var_3_5)

		table.insert(arg_3_0.lineList, var_3_6)
	end

	arg_3_0.showTipContorller = ControllerUtil.GetController(arg_3_0.transform_, "showTip")
	arg_3_0.infoController_ = ControllerUtil.GetController(arg_3_0.m_infoTrans, "state")
	arg_3_0.selectId = 0
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_infoMask, nil, function()
		arg_5_0:OnItemClick(0)
	end)
	arg_5_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		arg_5_0:OnItemClick(0)
	end))
	arg_5_0:AddBtnListener(arg_5_0.m_resetBtn, nil, function()
		if #arg_5_0.data == 0 then
			return
		end

		local var_8_0 = handler(arg_5_0, arg_5_0.OnResetDataBak)

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
	arg_5_0:AddBtnListener(arg_5_0.m_levelBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTerminalLevel")
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_infoUnlockBtn, nil, function()
		if arg_5_0.selectId == 0 then
			return
		end

		arg_5_0:UnlockTerminal(arg_5_0.selectId)
	end)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.m_content.localPosition = Vector3(0, -127, 0)
	arg_13_0.data = clone(PolyhedronData:GetTerminalGift())
	arg_13_0.data_bak = clone(arg_13_0.data)

	local var_13_0 = PolyhedronData:GetTerminalLevel()

	arg_13_0.allPoint = PolyhedronTerminalLevelCfg[var_13_0].point

	local var_13_1 = PolyhedronData:GetTerminalLevel()
	local var_13_2 = PolyhedronData:GetTerminalExp()

	arg_13_0.m_levelLab.text = "" .. var_13_1

	if var_13_1 == #PolyhedronTerminalLevelCfg.all then
		arg_13_0.m_expSlider.value = 1
	else
		local var_13_3 = PolyhedronTerminalLevelCfg[var_13_1 + 1].exp - PolyhedronTerminalLevelCfg[var_13_1].exp

		arg_13_0.m_expSlider.value = var_13_2 / var_13_3
	end

	arg_13_0:RegistEventListener(POLYHEDRON_TERMINAL_RESET, function()
		arg_13_0.data = {}

		arg_13_0:RefreshUI()
	end)
	arg_13_0:RefreshUI()
end

function var_0_0.OnPolyhedronGameUpdate(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.GetUsePoint(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.data) do
		var_16_0 = var_16_0 + PolyhedronTerminalCfg[iter_16_1].cost
	end

	return var_16_0
end

function var_0_0.OnResetDataBak(arg_17_0)
	arg_17_0.data_bak = {}
end

function var_0_0.IsEqual(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.data) do
		if not table.indexof(arg_18_0.data_bak, iter_18_1) then
			return false
		end
	end

	return true
end

function var_0_0.OnExit(arg_19_0)
	if not arg_19_0:IsEqual() then
		PolyhedronAction.QuerySetTerminal(arg_19_0.data)
	end

	manager.windowBar:HideBar()
	arg_19_0:RemoveAllEventListener()
	arg_19_0:OnItemClick(0)
end

function var_0_0.UnlockTerminal(arg_20_0, arg_20_1)
	if table.indexof(arg_20_0.data, arg_20_1) then
		arg_20_0:RefreshUI()

		return
	end

	if PolyhedronTerminalCfg[arg_20_1].cost > arg_20_0.allPoint - arg_20_0:GetUsePoint() then
		ShowTips(GetTips("POLYHEDRON_TERMINAL_LACK_POINT"))

		return
	end

	ShowTips(GetTips("POLYHEDRON_TERMINAL_UNLOCK_SUCCESS"))
	table.insert(arg_20_0.data, arg_20_1)
	arg_20_0:RefreshUI()
end

function var_0_0.OnItemClick(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		arg_21_0.showTipContorller:SetSelectedIndex(1)
	else
		arg_21_0.showTipContorller:SetSelectedIndex(0)
	end

	if arg_21_1 == 0 and arg_21_0.selectId == arg_21_1 then
		return
	end

	arg_21_0.selectId = arg_21_1

	if arg_21_2 then
		local var_21_0 = arg_21_2.transform_:TransformPoint(Vector3(0, 0, 0))
		local var_21_1 = arg_21_0.m_scrollContent.transform:InverseTransformPoint(var_21_0)
		local var_21_2 = Vector3.New(-var_21_1.x, -var_21_1.y, 0)

		arg_21_0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		arg_21_0:RemoveTween()

		arg_21_0.tween_ = LeanTween.moveLocal(arg_21_0.m_scrollContent.gameObject, var_21_2, 0.2)
	else
		arg_21_0:RemoveTween()

		arg_21_0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end

	arg_21_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.m_resetTimeLabel_.text = PolyhedronData:GetResetTimes()

	if #arg_22_0.data == 0 then
		-- block empty
	end

	local var_22_0 = arg_22_0.allPoint - arg_22_0:GetUsePoint()

	arg_22_0.m_pointLab.text = var_22_0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.itemList) do
		local var_22_1 = iter_22_1:GetId()

		iter_22_1:SetChoice(var_22_1 == arg_22_0.selectId)

		local var_22_2 = 0
		local var_22_3 = PolyhedronTerminalCfg[var_22_1]
		local var_22_4 = table.indexof(arg_22_0.data, var_22_1) and 0 or var_22_0 < var_22_3.cost and 3 or arg_22_0:GetCanUnlock(var_22_1) and 1 or 2

		iter_22_1:SetData(arg_22_0.data, var_22_4)
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.lineList) do
		iter_22_3:SetData(arg_22_0.data)
	end

	if arg_22_0.selectId == 0 then
		return
	end

	local var_22_5 = PolyhedronTerminalCfg[arg_22_0.selectId]
	local var_22_6 = getSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. var_22_5.icon)

	arg_22_0.m_infoIconImg.sprite = var_22_6
	arg_22_0.m_infoNameLab.text = GetI18NText(var_22_5.name)

	local var_22_7 = var_22_5.cost

	arg_22_0.m_infoCostLab.text = var_22_7
	arg_22_0.m_infoDesLab.text = GetI18NText(var_22_5.desc)

	local var_22_8, var_22_9 = arg_22_0:GetCanUnlock(arg_22_0.selectId)

	if not var_22_8 then
		arg_22_0.m_infoLimitTip.text = var_22_9

		arg_22_0.infoController_:SetSelectedIndex(2)

		return
	end

	if table.indexof(arg_22_0.data, arg_22_0.selectId) then
		arg_22_0.infoController_:SetSelectedIndex(3)
	else
		arg_22_0.infoController_:SetSelectedIndex(0)
	end
end

function var_0_0.GetCanUnlock(arg_23_0, arg_23_1)
	local var_23_0 = PolyhedronTerminalCfg[arg_23_1]
	local var_23_1 = var_23_0.need_level

	if var_23_1 > PolyhedronData:GetTerminalLevel() then
		return false, string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_UNLOCK"), var_23_1)
	end

	local var_23_2 = var_23_0.pre_id_list
	local var_23_3 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if iter_23_1 == 0 or table.indexof(arg_23_0.data, iter_23_1) then
			return true, ""
		else
			var_23_3 = iter_23_1
		end
	end

	local var_23_4 = PolyhedronTerminalCfg[var_23_3]

	return false, GetTips("POLYHEDRON_TERMINAL_GIFT_UNLCOK")
end

function var_0_0.RemoveTween(arg_24_0)
	if arg_24_0.tween_ then
		arg_24_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_24_0.m_scrollContent)

		arg_24_0.tween_ = nil
	end
end

function var_0_0.OnPolyhedronGameUpdate(arg_25_0)
	arg_25_0:RefreshUI()
end

function var_0_0.Dispose(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.itemList) do
		iter_26_1:Dispose()
	end

	arg_26_0.itemList = {}

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.lineList) do
		iter_26_3:Dispose()
	end

	arg_26_0.lineList = {}

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
