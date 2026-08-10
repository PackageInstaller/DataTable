local var_0_0 = class("ActivitySkinResultRewardViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetDrawResultUIName(arg_1_0.params_.mainActivityID)
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

	arg_4_0.itemList_ = {}

	for iter_4_0 = 1, 10 do
		arg_4_0.itemList_[iter_4_0] = ActivitySkinResultRewardItemOld.New(arg_4_0["item_" .. iter_4_0])
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityskinDrawOld", {
			activityID = arg_5_0.params_.mainActivityID,
			isSceneDrawed = arg_5_0.isScene_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.list_ = arg_8_0.params_.list
	arg_8_0.isScene_ = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.list_) do
		local var_8_0 = ActivityLimitedDrawPoolCfg[iter_8_1].reward[1][1]

		if ItemCfg[var_8_0].type == ItemConst.ITEM_TYPE.SCENE and var_8_0 ~= HomeSceneSettingData:GetCurScene() then
			arg_8_0.isScene_ = true

			break
		end
	end

	arg_8_0:RefreshItemList()
end

function var_0_0.RefreshItemList(arg_9_0)
	for iter_9_0 = 1, 10 do
		local var_9_0 = arg_9_0.list_[iter_9_0]
		local var_9_1 = arg_9_0.itemList_[iter_9_0]
		local var_9_2 = arg_9_0.params_.replaceList or {}

		var_9_1:SetData(var_9_0, iter_9_0, table.indexof(var_9_2, var_9_0))
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.isScene_ = false
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.itemList_ = nil

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
