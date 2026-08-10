local var_0_0 = class("DormIlluHeroPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitData()
	arg_1_0:InitUI()
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.allIDList_ = arg_2_0:GetAllID()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, DormIlluHeroItem)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_5_0, arg_5_0.Refresh))
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI(arg_5_1)
end

function var_0_0.Hide(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_0.OnClickFliter(arg_7_0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Hero_Filter_List
	})
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshData(arg_9_0, arg_9_1)
	arg_9_0.allIDList_ = HeroTools.GetHeroShowIDList(arg_9_0:GetAllID(), arg_9_1)
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1)
	arg_10_0.uiList_:StartScroll(#arg_10_0.allIDList_)

	if arg_10_0.recordIndex_ and arg_10_1 then
		arg_10_0.uiList_:ScrollToIndex(arg_10_0.recordIndex_)
	end

	arg_10_0.uiList_:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.recordIndex_ = nil

	arg_11_0.uiList_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, arg_12_0.allIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		arg_12_0:OpenDetailView(arg_13_0, arg_13_1)
	end)
end

function var_0_0.OpenDetailView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.recordIndex_ = arg_14_2

	JumpTools.OpenPageByJump("/dormIlluHeroDetail", {
		heroID = arg_14_1,
		heroIDList = arg_14_0.allIDList_
	})
end

function var_0_0.GetAllID(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if BackHomeHeroCfg[iter_15_1] and not HeroTools.GetIsHide(iter_15_1) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	CommonTools.UniversalSortEx(var_15_1, {
		map = function(arg_16_0)
			if HeroTools.GetHeroIsUnlock(arg_16_0) then
				return 1
			end

			return 0
		end
	}, {
		map = function(arg_17_0)
			return DormData:GetHeroArchiveID(arg_17_0)
		end
	}, {
		ascend = true,
		map = function(arg_18_0)
			local var_18_0 = DormData:GetHeroArchiveID(arg_18_0)

			return table.indexof(HeroRecordCfg[var_18_0].hero_id, arg_18_0) or 0
		end
	})

	return var_15_1
end

return var_0_0
