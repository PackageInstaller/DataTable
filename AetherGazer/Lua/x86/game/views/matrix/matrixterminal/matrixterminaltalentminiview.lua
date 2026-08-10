local var_0_0 = class("MartixTerminalTalentView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/Matrix/Terminal/MatrixTerminalTalentMiniUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.giftDataList = {}

	for iter_5_0, iter_5_1 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group) do
		arg_5_0.giftDataList[iter_5_0] = MatrixTools.GetGiftListByGroup(iter_5_0)
	end

	arg_5_0.terminalList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_termianlList, MatrixTerminalGroupItem)
	arg_5_0.toggles_ = {}

	local var_5_0 = arg_5_0.m_switchContainer.childCount

	for iter_5_2 = 1, var_5_0 do
		local var_5_1 = arg_5_0.m_switchContainer:GetChild(iter_5_2 - 1)

		table.insert(arg_5_0.toggles_, var_5_1:GetComponent(typeof(Toggle)))
	end

	arg_5_0.showRightInfoCnotroller_ = ControllerUtil.GetController(arg_5_0.transform_, "showRightInfo")
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.toggles_) do
		arg_6_0:AddToggleListener(iter_6_1, function(arg_7_0)
			if arg_7_0 then
				arg_6_0:SelectGroup(iter_6_0)
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.m_levelBtn, nil, function()
		JumpTools.OpenPageByJump("matrixTerminalLevel")
	end)
	arg_6_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		arg_6_0:OnItemClick(0)
	end))
	arg_6_0:AddBtnListener(arg_6_0.m_infoMask, nil, function()
		arg_6_0:OnItemClick(0)
	end)
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.data = clone(MatrixData:GetCurrentTerminalGifi())
	arg_13_0.allPoint = 0

	local var_13_0 = MatrixData:GetTerminalLevel()

	arg_13_0.allPoint = MatrixTerminalLevelCfg[var_13_0].point
	arg_13_0.hasPoint = arg_13_0.allPoint - arg_13_0:GetUsePoint()
	arg_13_0.m_giftLab.text = arg_13_0.hasPoint
	arg_13_0.toggles_[1].isOn = true

	arg_13_0:SelectGroup(1)

	local var_13_1 = MatrixData:GetTerminalLevel()
	local var_13_2 = MatrixData:GetTerminalExp()

	arg_13_0.m_levelLab.text = "" .. var_13_1

	if var_13_1 == #MatrixTerminalLevelCfg.all then
		local var_13_3 = MatrixTerminalLevelCfg[var_13_1].exp - MatrixTerminalLevelCfg[var_13_1 - 1].exp

		arg_13_0.m_expSlider.value = 1
		arg_13_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_13_3, var_13_3)
	else
		local var_13_4 = MatrixTerminalLevelCfg[var_13_1 + 1].exp - MatrixTerminalLevelCfg[var_13_1].exp

		arg_13_0.m_expSlider.value = var_13_2 / var_13_4
		arg_13_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_13_2, var_13_4)
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.curPage = nil

	arg_14_0:OnItemClick(0)
end

function var_0_0.RefreshInfo(arg_15_0)
	if not arg_15_0.data[arg_15_0.curId] then
		local var_15_0 = 0
	end

	local var_15_1 = MatrixTerminalGiftCfg[arg_15_0.curId]
	local var_15_2 = arg_15_0.data[arg_15_0.curId] or 0

	arg_15_0.m_infoNameLab.text = GetI18NText(var_15_1.name)

	local var_15_3 = var_15_2 == 0 and 1 or var_15_2
	local var_15_4 = var_15_2 + 1

	arg_15_0.m_infoLvLab.text = var_15_3

	local var_15_5 = var_15_1.desc_list[var_15_3]

	arg_15_0.m_infoDesLab.text = MatrixDescCfg[var_15_5] and GetI18NText(MatrixDescCfg[var_15_5].desc) or ""

	local var_15_6 = getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixTerminal/" .. var_15_1.icon)

	arg_15_0.m_infoIconImg.sprite = var_15_6
end

function var_0_0.OnItemClick(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 and arg_16_0.selectId == arg_16_1 then
		return
	end

	arg_16_0.selectId = arg_16_1

	local var_16_0 = false

	if arg_16_1 ~= 0 then
		arg_16_0.showRightInfoCnotroller_:SetSelectedIndex(1)

		arg_16_0.curId = arg_16_1

		arg_16_0:RefreshInfo(arg_16_1)

		var_16_0 = true
	else
		arg_16_0.showRightInfoCnotroller_:SetSelectedIndex(0)

		arg_16_0.curId = nil
		var_16_0 = false
	end

	local var_16_1 = arg_16_0.terminalList_:GetItemList()

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		iter_16_1:SetChoice(arg_16_0.selectId)
		iter_16_1:SetItemScrollMask(var_16_0)
	end

	arg_16_0:SetSelect(arg_16_2)
end

function var_0_0.SelectGroup(arg_17_0, arg_17_1)
	arg_17_0:OnItemClick(0)

	if arg_17_1 == arg_17_0.curPage then
		return
	end

	arg_17_0.curPage = arg_17_1
	arg_17_0.list = arg_17_0.giftDataList[arg_17_1] or {}

	arg_17_0.terminalList_:StartScrollByPosition(#arg_17_0.list, Vector2.New(0, 0))
end

function var_0_0.SetSelect(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = arg_18_1.transform_.parent:TransformPoint(Vector3(0, 0, 0))
		local var_18_1 = -arg_18_0.m_scrollContent.transform:InverseTransformPoint(var_18_0).x + 100

		arg_18_0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		arg_18_0:RemoveTween()

		arg_18_0.tween_ = LeanTween.value(arg_18_0.m_scrollContent, arg_18_0.m_scrollContent.transform.localPosition.x, var_18_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			arg_18_0.m_scrollContent.transform.localPosition = Vector3(arg_19_0, 0, 0)
		end))
	else
		arg_18_0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end
end

function var_0_0.RemoveTween(arg_20_0)
	if arg_20_0.tween_ then
		arg_20_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_20_0.m_scrollContent)

		arg_20_0.tween_ = nil
	end
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:Refresh(arg_21_1, arg_21_0.list[arg_21_1], arg_21_0.data, arg_21_0.selectId, arg_21_0.hasPoint)
	arg_21_2:RegistCallBack(handler(arg_21_0, arg_21_0.OnItemClick))
end

function var_0_0.GetUsePoint(arg_22_0)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_0.data) do
		local var_22_1 = MatrixTerminalGiftCfg[iter_22_0]

		for iter_22_2 = 1, iter_22_1 do
			var_22_0 = var_22_0 + var_22_1.cost[iter_22_2]
		end
	end

	return var_22_0
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.terminalList_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
