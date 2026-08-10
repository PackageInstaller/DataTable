local var_0_0 = class("ActivitySkinResultRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawTools.GetDrawResultUIName(arg_1_0.params_.mainActivityID)
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
		arg_4_0.itemList_[iter_4_0] = ActivitySkinResultRewardItem.New(arg_4_0["item_" .. iter_4_0])
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityskinDraw", {
			activityID = arg_5_0.params_.mainActivityID,
			isSceneDrawed = arg_5_0.isScene_,
			sceneDrawedId = arg_5_0.sceneId_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.replaceList_ = arg_7_0.params_.replaceList

	arg_7_0:RefreshReplace()
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshReplace(arg_8_0)
	arg_8_0.isReplaceScene_ = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.replaceList_) do
		local var_8_0 = ActivityLimitedDrawPoolCfg[iter_8_1].reward[1][1]

		if ItemCfg[var_8_0].type == ItemConst.ITEM_TYPE.SCENE then
			arg_8_0.isReplaceScene_ = true
		end
	end
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.list_ = arg_9_0.params_.list
	arg_9_0.isScene_ = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.list_) do
		local var_9_0 = ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]

		if ItemCfg[var_9_0].type == ItemConst.ITEM_TYPE.SCENE and var_9_0 ~= HomeSceneSettingData:GetCurScene() and not arg_9_0.isReplaceScene_ then
			arg_9_0.isScene_ = true
			arg_9_0.sceneId_ = var_9_0

			break
		end
	end

	arg_9_0:RefreshItemList()
end

function var_0_0.RefreshItemList(arg_10_0)
	for iter_10_0 = 1, 10 do
		local var_10_0 = arg_10_0.list_[iter_10_0]
		local var_10_1 = arg_10_0.itemList_[iter_10_0]
		local var_10_2 = arg_10_0.params_.replaceList or {}

		var_10_1:SetData(var_10_0, iter_10_0, table.indexof(var_10_2, var_10_0))
	end
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.isScene_ = false
	arg_12_0.sceneId_ = 0
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemList_) do
		iter_13_1:Dispose()
	end

	arg_13_0.itemList_ = nil

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
