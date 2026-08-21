local var_0_0 = class("ActivitySkinDrawDLCPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawTools.GetDLCPopUIName(arg_1_0.params_.mainActivity)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.dlcItemClickHandler_ = handler(arg_3_0, arg_3_0.OnDLCItemClick)
	arg_3_0.getBtnCon_ = arg_3_0.getBtnCon_:GetController("get")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.dlcList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, ActivitySkinDrawDLCItem)
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
	arg_4_0.criplayer_.statusChangeCallback = handler(arg_4_0, arg_4_0.CirMovieStatusChange)
	arg_4_0.getBtnController_ = arg_4_0.getBtnCon_:GetController("get")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		if arg_5_0.isGet_ then
			return
		end

		arg_5_0:Back()

		if arg_5_0.activityID_ then
			ActivitySkinDrawTools.JumpToDLCSource(arg_5_0.cfg_.source[1], arg_5_0.activityID_)
		end
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetSelected(arg_8_1 == arg_8_0.selectedIndex_)
	arg_8_2:RegisterClickCallBack(arg_8_0.dlcItemClickHandler_)
	arg_8_2:SetData(arg_8_1, arg_8_0.dlcIdList_[arg_8_1])
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.sceneID_ = arg_9_0.params_.sceneID
	arg_9_0.dlcIdList_ = HomeSceneBundleCfg.get_id_list_by_scene_id[arg_9_0.sceneID_]

	arg_9_0:RefreshSelected(1)
	arg_9_0.dlcList_:StartScroll(#arg_9_0.dlcIdList_)
	SetActive(arg_9_0.getBtn_.gameObject, arg_9_0.activityID_ ~= nil)
end

function var_0_0.RefreshSelected(arg_10_0, arg_10_1)
	arg_10_0.selectedIndex_ = arg_10_1

	if arg_10_0.selectedIndex_ > #arg_10_0.dlcIdList_ then
		arg_10_0.selectedIndex_ = 1
	end

	arg_10_0.cfg_ = HomeSceneBundleCfg[arg_10_0.dlcIdList_[arg_10_0.selectedIndex_]]
	arg_10_0.dlcNameText_.text = arg_10_0.cfg_.name
	arg_10_0.dlcDescText_.text = arg_10_0.cfg_.desc
	arg_10_0.getPathText_.text = arg_10_0.cfg_.source_desc
	arg_10_0.isGet_ = ItemTools.getItemNum(arg_10_0.cfg_.item_id) > 0

	arg_10_0.getBtnCon_:SetSelectedState(arg_10_0.isGet_ and "get" or "none")
	arg_10_0:RefreshMovie()
end

function var_0_0.RefreshMovie(arg_11_0)
	arg_11_0.criMovie_:Stop()

	local var_11_0 = arg_11_0.cfg_.start_path

	if var_11_0 then
		SetFile(arg_11_0.criplayer_, nil, var_11_0, CriMana.Player.SetMode.New)
		arg_11_0.criMovie_:Play()
	end
end

function var_0_0.CirMovieStatusChange(arg_12_0, arg_12_1)
	local var_12_0 = tostring(arg_12_1)

	if var_12_0 == "PlayEnd" or var_12_0 == "Stop" then
		if var_12_0 == "PlayEnd" then
			arg_12_0.selectedIndex_ = arg_12_0.selectedIndex_ + 1
		end

		arg_12_0:RefreshSelected(arg_12_0.selectedIndex_)
		arg_12_0.dlcList_:Refresh()
	end
end

function var_0_0.OnDLCItemClick(arg_13_0, arg_13_1)
	arg_13_0:RefreshSelected(arg_13_1)
	arg_13_0.dlcList_:Refresh()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.dlcList_ then
		arg_15_0.dlcList_:Dispose()
	end

	arg_15_0.dlcIdList_ = nil

	arg_15_0:RemoveAllListeners()
	arg_15_0.super.Dispose(arg_15_0)
end

return var_0_0
