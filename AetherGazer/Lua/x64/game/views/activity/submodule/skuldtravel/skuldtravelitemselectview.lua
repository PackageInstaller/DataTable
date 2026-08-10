local var_0_0 = class("SkuldTravelItemSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelchoosepop"
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

	arg_4_0.itemselecthandle_ = handler(arg_4_0, arg_4_0.OnSelectItem)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.rendeler), arg_4_0.listgo_, SkuldTravelItemSelectItem)
	arg_4_0.isgetcontroller_ = ControllerUtil.GetController(arg_4_0.transform_, "isget")
end

function var_0_0.rendeler(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = TravelSkuldStoryCfg[arg_5_0.plotlist_[arg_5_1]].item_id

	arg_5_2:SetData(var_5_0, arg_5_0.params_.mapindex, arg_5_0.curitemid_)
	arg_5_2:SetSelecthandler(arg_5_0.itemselecthandle_)
end

function var_0_0.OnSelectItem(arg_6_0, arg_6_1)
	arg_6_0.curitemid_ = arg_6_1
	arg_6_0.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[arg_6_1].name)
	arg_6_0.desctext_.text = GetI18NText(TravelSkuldItemCfg[arg_6_1].desc)

	local var_6_0 = arg_6_0.list_:GetItemList()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1:RefreshSelectStatu(arg_6_1)
	end

	arg_6_0:RefreshGetStatu()
end

function var_0_0.RefreshGetStatu(arg_7_0)
	if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(arg_7_0.params_.mapindex, arg_7_0.curitemid_) then
		arg_7_0.isgetcontroller_:SetSelectedState("true")
	else
		arg_7_0.isgetcontroller_:SetSelectedState("false")
	end
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.travelbtn_, nil, function()
		local var_9_0 = SkuldTravelData:GetPlotIdByMapIdAndItemId(arg_8_0.params_.mapindex, arg_8_0.curitemid_)

		if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(arg_8_0.params_.mapindex, arg_8_0.curitemid_) then
			ShowMessageBox({
				content = GetTips("TRAVEL_SKULD_STORY_GETTED"),
				OkCallback = function()
					SkuldTravelAction:GotoTravel(var_9_0)
				end
			})
		else
			SkuldTravelAction:GotoTravel(var_9_0)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	if arg_12_0.curmapid_ ~= arg_12_0.params_.mapindex then
		arg_12_0.curmapid_ = arg_12_0.params_.mapindex
		arg_12_0.plotlist_ = TravelSkuldStoryCfg.get_id_list_by_location_id[arg_12_0.params_.mapindex]
		arg_12_0.curitemid_ = TravelSkuldStoryCfg[arg_12_0.plotlist_[1]].item_id
	end

	arg_12_0.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[arg_12_0.curitemid_].name)
	arg_12_0.desctext_.text = GetI18NText(TravelSkuldItemCfg[arg_12_0.curitemid_].desc)

	arg_12_0:RefreshGetStatu()
	arg_12_0.list_:StartScroll(#arg_12_0.plotlist_)
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.list_ then
		arg_14_0.list_:Dispose()

		arg_14_0.list_ = nil
	end

	arg_14_0.itemselecthandle_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
