local var_0_0 = class("ActivityMatrixStoryReviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeStoryReviewUI"
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

	arg_4_0.storyItems = {}
	arg_4_0.emptyController = ControllerUtil.GetController(arg_4_0.transform_, "empty")
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = ActivityStoryCollect[ActivityConst.VOLUME_MATRIX] and ActivityStoryCollect[ActivityConst.VOLUME_MATRIX].story_id or {}

	arg_7_0.storyList = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if manager.story:IsStoryPlayed(iter_7_1) then
			table.insert(arg_7_0.storyList, iter_7_1)
		end
	end

	arg_7_0:Refresh()
end

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = #arg_8_0.storyList

	for iter_8_0 = 1, var_8_0 do
		if not arg_8_0.storyItems[iter_8_0] then
			local var_8_1 = Object.Instantiate(arg_8_0.m_item, arg_8_0.m_content)

			arg_8_0.storyItems[iter_8_0] = ActivityMatrixStoryReviewItem.New(var_8_1)
		end

		local var_8_2 = arg_8_0.storyList[iter_8_0]

		arg_8_0.storyItems[iter_8_0]:SetData(var_8_2)
		arg_8_0.storyItems[iter_8_0]:SetActive(true)
	end

	local var_8_3 = #arg_8_0.storyItems

	for iter_8_1 = var_8_0 + 1, var_8_3 do
		arg_8_0.storyItems[iter_8_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_content)

	if #arg_8_0.storyList == 0 then
		arg_8_0.emptyController:SetSelectedIndex(1)
	else
		arg_8_0.emptyController:SetSelectedIndex(0)
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.storyItems) do
		iter_10_1:Dispose()
	end

	arg_10_0.storyItems = {}

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
