local var_0_0 = class("ChapterResidentActBaseView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ChapterResidentTools.GetResidentActPrafabPath(arg_1_1)
	local var_1_1 = Asset.Load(var_1_0)

	arg_1_0.gameObject_ = Object.Instantiate(var_1_1, arg_1_2)
	arg_1_0.chapterID = arg_1_1
	arg_1_0.activityID = ChapterClientCfg[arg_1_0.chapterID].activity_id

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	if arg_2_0.rewardListGo_ then
		arg_2_0.rewardList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexRewardItem), arg_2_0.rewardListGo_, CommonItemView)
	end

	arg_2_0.btnStateController_ = arg_2_0.controller_:GetController("btnState")

	arg_2_0:BindRed(true)
end

function var_0_0.IndexRewardItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_0.rewards[arg_3_1])
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.goBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
			ChapterResidentTools.GotoResidentActView(arg_4_0.activityID)
		end)
	end

	if arg_4_0.loadBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.loadBtn_, nil, function()
			local var_6_0 = ChapterClientCfg[arg_4_0.chapterID].asset_pend_key

			manager.assetPend:ShowAssetPendMessageBox(var_6_0)
		end)
	end

	if arg_4_0.descBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
			ChapterResidentTools.OpenResidentActTips(arg_4_0.activityID)
		end)
	end
end

function var_0_0.BindRed(arg_8_0, arg_8_1)
	local var_8_0 = ActivityTools.GetRedPointKey(arg_8_0.activityID) .. arg_8_0.activityID

	if arg_8_1 then
		if arg_8_0.goBtn_ then
			manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, var_8_0)
		end

		if arg_8_0.loadBtn_ then
			manager.redPoint:bindUIandKey(arg_8_0.loadBtn_.transform, var_8_0)
		end
	else
		if arg_8_0.goBtn_ then
			manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, var_8_0)
		end

		if arg_8_0.loadBtn_ then
			manager.redPoint:unbindUIandKey(arg_8_0.loadBtn_.transform, var_8_0)
		end
	end
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_10_0)
	if arg_10_0.titleDescTxt_ then
		local var_10_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_10_0.activityID][1]

		arg_10_0.titleDescTxt_.text = ActivityToggleCfg[var_10_0].desc
	end

	arg_10_0:RefreshProgressUI()
	arg_10_0:RefreshRewardUI()
	arg_10_0:RefreshBtnState()

	if not getData("ResidentAct", "NewTag_" .. arg_10_0.activityID) then
		saveData("ResidentAct", "NewTag_" .. arg_10_0.activityID, true)
		manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. arg_10_0.activityID, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.RefreshBtnState(arg_11_0)
	local var_11_0 = ChapterClientCfg[arg_11_0.chapterID].asset_pend_key

	if arg_11_0.btnStateController_ then
		if not manager.assetPend:CheckAssetPend(var_11_0) then
			arg_11_0.btnStateController_:SetSelectedState("assetpend")
		else
			arg_11_0.btnStateController_:SetSelectedState("normal")
		end
	end
end

function var_0_0.RefreshRewardUI(arg_12_0)
	local var_12_0 = ActivityCfg[arg_12_0.activityID]

	if arg_12_0.rewardList_ then
		local var_12_1 = {}
		local var_12_2 = {}
		local var_12_3 = var_12_0.reward_show_permanent ~= "" and var_12_0.reward_show_permanent or {}

		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			table.insert(var_12_1, rewardToItemTemplate({
				id = iter_12_1
			}, nil, true))
		end

		arg_12_0.rewards = ItemTools.SortRewardItemList(var_12_1)

		arg_12_0.rewardList_:StartScroll(#arg_12_0.rewards)
	end
end

function var_0_0.RefreshProgressUI(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = ChapterResidentTools.GetResidentActProgress(arg_13_0.activityID)

	if arg_13_0.progressValueTxt_ then
		if var_13_2 then
			arg_13_0.progressValueTxt_.text = var_13_2
		else
			arg_13_0.progressValueTxt_.text = var_13_0 .. "/" .. var_13_1
		end
	end

	if arg_13_0.progressValueImg_ then
		arg_13_0.progressValueImg_.fillAmount = var_13_0 / var_13_1
	end
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:BindRed(false)

	if arg_15_0.rewardList_ then
		arg_15_0.rewardList_:Dispose()

		arg_15_0.rewardList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
