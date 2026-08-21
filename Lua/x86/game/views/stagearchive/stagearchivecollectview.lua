local var_0_0 = class("StageArchiveCollectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationTerminalRecordUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.groupItemList_ = {}
	arg_4_0.emptyController_ = arg_4_0.controllerEx_:GetController("empty")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.chpaterID_ = arg_7_0.params_.chapterID
	arg_7_0.unlockedArchiveList_ = StageTools.GetUnlockStageArchiveList(arg_7_0.chpaterID_)

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshEmpty()

	if not arg_8_0:GetIsEmpty() then
		arg_8_0:RefreshGroupItem()
		arg_8_0:ForceRebuildGroup()
	end
end

function var_0_0.RefreshEmpty(arg_9_0)
	arg_9_0.emptyController_:SetSelectedState(tostring(arg_9_0:GetIsEmpty()))
end

function var_0_0.GetIsEmpty(arg_10_0)
	return #arg_10_0.unlockedArchiveList_ == 0
end

function var_0_0.RefreshGroupItem(arg_11_0)
	arg_11_0.archiveGroupIDList_, arg_11_0.archiveGroupList_ = StageTools.ReorderStageArchiveListByGroup(arg_11_0.unlockedArchiveList_)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.archiveGroupIDList_) do
		if not arg_11_0.groupItemList_[iter_11_0] then
			local var_11_0 = Object.Instantiate(arg_11_0.groupItemGo_, arg_11_0.groupPanelTrans_)

			arg_11_0.groupItemList_[iter_11_0] = StageArchiveCollectGroupItem.New(var_11_0)
		end

		arg_11_0.groupItemList_[iter_11_0]:SetActive(true)
		arg_11_0.groupItemList_[iter_11_0]:SetData(iter_11_1, arg_11_0.archiveGroupList_[iter_11_1])
	end

	for iter_11_2 = #arg_11_0.archiveGroupIDList_ + 1, #arg_11_0.groupItemList_ do
		arg_11_0.groupItemList_[iter_11_2]:SetActive(false)
	end
end

function var_0_0.ForceRebuildGroup(arg_12_0)
	arg_12_0:StopForceRebuildGroup()

	arg_12_0.rebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.groupPanelTrans_)
		arg_12_0:StopForceRebuildGroup()
	end, 1, 1)

	arg_12_0.rebuildTimer_:Start()
end

function var_0_0.StopForceRebuildGroup(arg_14_0)
	if arg_14_0.rebuildTimer_ then
		arg_14_0.rebuildTimer_:Stop()

		arg_14_0.rebuildTimer_ = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:StopForceRebuildGroup()
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.groupItemList_) do
		iter_16_1:Dispose()
	end

	arg_16_0.groupItemList_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
