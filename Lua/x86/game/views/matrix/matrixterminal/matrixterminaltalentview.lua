local var_0_0 = class("MartixTerminalTalentView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Terminal/MatrixTerminalTalentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.giftDataList = {}

	for iter_4_0, iter_4_1 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group) do
		arg_4_0.giftDataList[iter_4_0] = MatrixTools.GetGiftListByGroup(iter_4_0)
	end

	arg_4_0.terminalList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_termianlList, MatrixTerminalGroupItem)
	arg_4_0.toggles_ = {}

	local var_4_0 = arg_4_0.m_switchContainer.childCount

	for iter_4_2 = 1, var_4_0 do
		local var_4_1 = arg_4_0.m_switchContainer:GetChild(iter_4_2 - 1)

		table.insert(arg_4_0.toggles_, var_4_1:GetComponent(typeof(Toggle)))
	end

	arg_4_0.infoController_ = ControllerUtil.GetController(arg_4_0.m_infoGo.transform, "state")
	arg_4_0.showRightInfoCnotroller_ = ControllerUtil.GetController(arg_4_0.transform_, "showRightInfo")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_6_0)
			if arg_6_0 then
				arg_5_0:SelectGroup(iter_5_0)
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.m_resetBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_RESET_TERMINAL_GIFT"),
			OkCallback = function()
				arg_5_0.data = {}

				arg_5_0:Refresh()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_levelBtn, nil, function()
		JumpTools.OpenPageByJump("matrixTerminalLevel")
	end)
	arg_5_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		arg_5_0:OnItemClick(0)
	end))
	arg_5_0:AddBtnListener(arg_5_0.m_infoUpBtn, nil, function()
		if not arg_5_0.curId then
			return
		end

		arg_5_0:UpGiftLevel(arg_5_0.curId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_infoUnlockBtn, nil, function()
		if not arg_5_0.curId then
			return
		end

		arg_5_0:UpGiftLevel(arg_5_0.curId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_infoPreviewBtn, nil, function()
		if not arg_5_0.curId then
			return
		end

		local var_13_0 = MatrixTerminalGiftCfg[arg_5_0.curId]
		local var_13_1 = arg_5_0.data[arg_5_0.curId] or 0

		if var_13_0.effect_id_list[var_13_1 + 1] then
			JumpTools.OpenPageByJump("matrixTerminalTalentPreview", {
				id = arg_5_0.curId,
				lv = var_13_1
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_infoMask, nil, function()
		arg_5_0:OnItemClick(0)
	end)
end

function var_0_0.UpGiftLevel(arg_15_0, arg_15_1)
	local var_15_0 = MatrixTerminalGiftCfg[arg_15_1]
	local var_15_1 = (arg_15_0.data[arg_15_1] or 0) + 1

	if var_15_0.cost[var_15_1] > arg_15_0.allPoint - arg_15_0:GetUsePoint() then
		ShowTips(GetTips("MATRIX_TERMINAL_GIFT_LACK"))

		return
	end

	if var_15_1 == 1 then
		ShowTips(GetTips("MATRIX_TERMINAL_GIFT_UNLOCK_SUCCESS"))
	else
		ShowTips(GetTips("MATRIX_TERMINAL_GIFT_UPGRADE_SUCCESS"))
	end

	arg_15_0.data[arg_15_0.curId] = var_15_1

	arg_15_0:Refresh()
	MatrixAction.CheckTerminalGiftRedPoint(arg_15_0.data)
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:ShowDefaultBar()
	manager.redPoint:bindUIandKey(arg_17_0.toggles_[1].gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE, {
		x = 313,
		y = 35
	})
	manager.redPoint:bindUIandKey(arg_17_0.toggles_[2].gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER, {
		x = 313,
		y = 35
	})

	arg_17_0.data = clone(MatrixData:GetTerminalGift())

	local var_17_0 = MatrixData:GetTerminalLevel()

	arg_17_0.allPoint = MatrixTerminalLevelCfg[var_17_0].point
	arg_17_0.toggles_[1].isOn = true

	arg_17_0:SelectGroup(1)

	local var_17_1 = arg_17_0.allPoint - arg_17_0:GetUsePoint()

	arg_17_0.m_giftLab.text = var_17_1

	local var_17_2 = MatrixData:GetTerminalLevel()
	local var_17_3 = MatrixData:GetTerminalExp()

	arg_17_0.m_levelLab.text = "" .. var_17_2

	if var_17_2 == #MatrixTerminalLevelCfg.all then
		local var_17_4 = MatrixTerminalLevelCfg[var_17_2].exp - MatrixTerminalLevelCfg[var_17_2 - 1].exp

		arg_17_0.m_expSlider.value = 1
		arg_17_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_17_4, var_17_4)
	else
		local var_17_5 = MatrixTerminalLevelCfg[var_17_2 + 1].exp - MatrixTerminalLevelCfg[var_17_2].exp

		arg_17_0.m_expSlider.value = var_17_3 / var_17_5
		arg_17_0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_17_3, var_17_5)
	end
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_18_0.toggles_[1].gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE)
	manager.redPoint:unbindUIandKey(arg_18_0.toggles_[2].gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER)

	arg_18_0.curPage = nil

	arg_18_0:OnItemClick(0)
	MatrixAction.QuerySetMatrixTerminalGift(arg_18_0.data)
end

function var_0_0.Refresh(arg_19_0)
	local var_19_0 = arg_19_0.allPoint - arg_19_0:GetUsePoint()

	arg_19_0.m_giftLab.text = var_19_0

	local var_19_1 = arg_19_0.terminalList_:GetItemList()

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		iter_19_1:RefreshData(arg_19_0.data, var_19_0)
	end

	if arg_19_0.curId and arg_19_0.curId ~= 0 then
		arg_19_0:RefreshInfo()
	end
end

function var_0_0.RefreshInfo(arg_20_0)
	local var_20_0 = MatrixTerminalGiftCfg[arg_20_0.curId]
	local var_20_1 = getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixTerminal/" .. var_20_0.icon)

	arg_20_0.m_infoIconImg.sprite = var_20_1

	local var_20_2 = arg_20_0.data[arg_20_0.curId] or 0

	arg_20_0.m_infoNameLab.text = GetI18NText(var_20_0.name)

	local var_20_3 = var_20_2 == 0 and 1 or var_20_2
	local var_20_4 = var_20_2 + 1

	arg_20_0.m_infoLvLab.text = var_20_3

	local var_20_5 = var_20_0.cost[var_20_4]

	arg_20_0.m_infoCostLab.text = var_20_5

	local var_20_6 = var_20_0.desc_list[var_20_3]

	arg_20_0.m_infoDesLab.text = MatrixDescCfg[var_20_6] and GetI18NText(MatrixDescCfg[var_20_6].desc) or ""

	local var_20_7 = var_20_0.pre_id
	local var_20_8 = arg_20_0.data[var_20_7] or 0
	local var_20_9 = var_20_7 ~= 0 and var_20_8 == 0
	local var_20_10 = var_20_0.limit_level

	if var_20_10 > MatrixData:GetTerminalLevel() then
		arg_20_0.m_infoLimitTip.text = string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), var_20_10)

		arg_20_0.infoController_:SetSelectedIndex(2)

		return
	end

	if var_20_9 then
		local var_20_11 = MatrixTerminalGiftCfg[var_20_7]

		arg_20_0.m_infoLimitTip.text = string.format(GetTips("MATRIX_TEAMINL_GIFT_UNLCOK"), GetI18NText(var_20_11.name))

		arg_20_0.infoController_:SetSelectedIndex(2)

		return
	end

	local var_20_12 = #var_20_0.effect_id_list

	if var_20_2 == 0 then
		arg_20_0.infoController_:SetSelectedIndex(0)
	elseif var_20_12 <= var_20_2 then
		arg_20_0.infoController_:SetSelectedIndex(3)
	else
		arg_20_0.infoController_:SetSelectedIndex(1)
	end
end

function var_0_0.OnItemClick(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 and arg_21_0.selectId == arg_21_1 then
		return
	end

	arg_21_0.selectId = arg_21_1

	local var_21_0 = false

	if arg_21_1 ~= 0 then
		arg_21_0.showRightInfoCnotroller_:SetSelectedIndex(1)

		arg_21_0.curId = arg_21_1

		arg_21_0:RefreshInfo(arg_21_1)

		var_21_0 = true
	else
		arg_21_0.showRightInfoCnotroller_:SetSelectedIndex(0)

		arg_21_0.curId = nil
		var_21_0 = false
	end

	local var_21_1 = arg_21_0.terminalList_:GetItemList()

	for iter_21_0, iter_21_1 in pairs(var_21_1) do
		iter_21_1:SetChoice(arg_21_0.selectId)
		iter_21_1:SetItemScrollMask(var_21_0)
	end

	arg_21_0:SetSelect(arg_21_2)
end

function var_0_0.SelectGroup(arg_22_0, arg_22_1)
	arg_22_0:OnItemClick(0)

	if arg_22_1 == arg_22_0.curPage then
		return
	end

	arg_22_0.curPage = arg_22_1
	arg_22_0.list = arg_22_0.giftDataList[arg_22_1] or {}

	arg_22_0.terminalList_:StartScrollByPosition(#arg_22_0.list, Vector2.New(0, 0))
end

function var_0_0.SetSelect(arg_23_0, arg_23_1)
	if arg_23_1 then
		local var_23_0 = arg_23_1.transform_.parent:TransformPoint(Vector3(0, 0, 0))
		local var_23_1 = -arg_23_0.m_scrollContent.transform:InverseTransformPoint(var_23_0).x

		arg_23_0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		arg_23_0:RemoveTween()

		arg_23_0.tween_ = LeanTween.value(arg_23_0.m_scrollContent, arg_23_0.m_scrollContent.transform.localPosition.x, var_23_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
			arg_23_0.m_scrollContent.transform.localPosition = Vector3(arg_24_0, 0, 0)
		end))
	else
		arg_23_0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end
end

function var_0_0.RemoveTween(arg_25_0)
	if arg_25_0.tween_ then
		arg_25_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_25_0.m_scrollContent)

		arg_25_0.tween_ = nil
	end
end

function var_0_0.IndexItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.allPoint - arg_26_0:GetUsePoint()

	arg_26_2:Refresh(arg_26_1, arg_26_0.list[arg_26_1], arg_26_0.data, arg_26_0.selectId, var_26_0)
	arg_26_2:RegistCallBack(handler(arg_26_0, arg_26_0.OnItemClick))
end

function var_0_0.GetUsePoint(arg_27_0)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(arg_27_0.data) do
		local var_27_1 = MatrixTerminalGiftCfg[iter_27_0]

		for iter_27_2 = 1, iter_27_1 do
			var_27_0 = var_27_0 + var_27_1.cost[iter_27_2]
		end
	end

	return var_27_0
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.terminalList_:Dispose()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
