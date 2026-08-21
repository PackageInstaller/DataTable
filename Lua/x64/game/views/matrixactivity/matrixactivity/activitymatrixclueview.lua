local var_0_0 = class("ActivityMatrixClueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeCluesToCollectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, ActivityMatrixClueItem)
	arg_4_0.pageIndex_ = 1
	arg_4_0.clues = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0.list_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnPageChange))
	arg_5_0:AddBtnListener(arg_5_0.m_preBtn, nil, function()
		arg_5_0.list_:SwitchToPage(arg_5_0.pageIndex_ - 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_nextBtn, nil, function()
		arg_5_0.list_:SwitchToPage(arg_5_0.pageIndex_ + 1)
	end)
end

function var_0_0.OnPageChange(arg_8_0, arg_8_1)
	arg_8_0.pageIndex_ = arg_8_1

	ActivityMatrixAction.SetSelectClue(arg_8_1)

	local var_8_0 = arg_8_0.clues[arg_8_1]

	if var_8_0 then
		ActivityMatrixAction.SetClueRead(arg_8_0.main_matrix_activity_id, var_8_0.clue_id)
	end

	local var_8_1 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.clues) do
		if not ActivityMatrixData:GetClueRead(arg_8_0.main_matrix_activity_id, iter_8_1.clue_id) then
			var_8_1 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(arg_8_0.m_nextBtn.transform, var_8_1)
	SetActive(arg_8_0.m_preBtn.gameObject, arg_8_1 > 1)
	SetActive(arg_8_0.m_nextBtn.gameObject, arg_8_1 < #arg_8_0.clues)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.main_matrix_activity_id = arg_10_0.params_.main_matrix_activity_id
	arg_10_0.clues = ActivityMatrixData:GetMatrixClue(arg_10_0.main_matrix_activity_id)

	arg_10_0.list_:StartScroll(#arg_10_0.clues, 1, true, false)

	local var_10_0 = ActivityMatrixAction:GetSelectClue()
	local var_10_1 = math.min(var_10_0, #arg_10_0.clues)

	arg_10_0.list_:SwitchToPage(var_10_1)
	arg_10_0:OnPageChange(var_10_1)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.clues[arg_11_1].clue_id

	arg_11_2:SetData(var_11_0)
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.list_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
