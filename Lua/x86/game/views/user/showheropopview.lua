local var_0_0 = class("ShowHeroPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/HeroshowUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ShowHeroPopItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshData(arg_5_0.list_[arg_5_1], arg_5_0.isForeign_)
	arg_5_2:RegistClickFunction(function()
		if manager.windowBar:GetWhereTag() ~= nil then
			if not arg_5_0.isForeign_ then
				ShowTips("PROFILE_ROLES_SET_PROMPT")
			end

			return
		end

		if not arg_5_0.isForeign_ then
			local var_6_0 = arg_5_0.list_[arg_5_1].hero_id ~= 0 and arg_5_0.list_[arg_5_1].hero_id or nil

			JumpTools.OpenPageByJump("/HeroShowChange", {
				heroID = var_6_0
			})
		else
			local var_6_1 = arg_5_0.list_[arg_5_1].hero_id

			if var_6_1 ~= 0 then
				ForeignInfoAction:TryToCheckForeignHeroInfo(arg_5_0.userID_, var_6_1, 1, function()
					JumpTools.OpenPageByJump("/newHero", {
						pageIndex = 1,
						isEnter = true,
						notShowBar = true,
						hid = var_6_1,
						type = HeroConst.HERO_DATA_TYPE.FOREIGN
					}, ViewConst.SYSTEM_ID.PLAYER_INFO)
				end)
			end
		end
	end)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.list_ = {}
	arg_10_0.userID_ = arg_10_0.params_.userID
	arg_10_0.isForeign_ = arg_10_0.params_.isForeign

	if arg_10_0.params_.isBack and arg_10_0.params_.heroListGetter then
		arg_10_0.params_.heroList = arg_10_0.params_.heroListGetter()
	end

	local var_10_0 = arg_10_0.params_.heroList

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0.list_[iter_10_0] = iter_10_1
	end

	for iter_10_2 = #arg_10_0.list_ + 1, 3 do
		arg_10_0.list_[iter_10_2] = {}
		arg_10_0.list_[iter_10_2].hero_id = 0
		arg_10_0.list_[iter_10_2].star = 0
		arg_10_0.list_[iter_10_2].level = 0
		arg_10_0.list_[iter_10_2].using_skin = 0
	end

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function var_0_0.OnExit(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.scrollHelper_:GetItemList()) do
		iter_11_1:OnExit()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllEventListener()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.scrollHelper_:GetItemList()) do
		iter_12_1:Dispose()
	end

	arg_12_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
