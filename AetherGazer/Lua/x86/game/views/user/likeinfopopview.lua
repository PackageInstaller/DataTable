local var_0_0 = class("LikeInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/LikerecordUI"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, LikeInfoPopItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.curList_[arg_5_1]
	local var_5_1 = var_5_0.time
	local var_5_2 = var_5_0.id

	arg_5_2:RefreshData(arg_5_0.listInfo_[var_5_2], var_5_1)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.leftBtn_, nil, function()
		arg_6_0.index_ = arg_6_0.index_ - 1
		arg_6_0.params_.index = arg_6_0.index_

		arg_6_0:TryGetInfo()
	end)
	arg_6_0:AddBtnListener(arg_6_0.rightBtn_, nil, function()
		arg_6_0.index_ = arg_6_0.index_ + 1
		arg_6_0.params_.index = arg_6_0.index_

		arg_6_0:TryGetInfo()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.list_ = {}
	arg_10_0.listInfo_ = {}

	local var_10_0 = PlayerData:GetLikeInfo()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(arg_10_0.list_, {
			id = iter_10_1.id,
			time = iter_10_1.time
		})
	end

	arg_10_0.index_ = arg_10_0.params_.index

	arg_10_0:TryGetInfo()
end

function var_0_0.TryGetInfo(arg_11_0)
	local var_11_0 = (arg_11_0.index_ - 1) * GameSetting.profile_like_page_num.value[1] + 1
	local var_11_1 = arg_11_0.index_ * GameSetting.profile_like_page_num.value[1]
	local var_11_2 = {}

	arg_11_0.curList_ = {}

	for iter_11_0 = var_11_0, var_11_1 do
		local var_11_3 = arg_11_0.list_[iter_11_0]

		if not var_11_3 then
			break
		end

		local var_11_4 = var_11_3.id

		table.insert(arg_11_0.curList_, var_11_3)

		if not arg_11_0.listInfo_[var_11_4] then
			table.insert(var_11_2, var_11_4)
		end
	end

	if #var_11_2 <= 0 then
		arg_11_0:RefreshUI()
		arg_11_0.scrollHelper_:StartScroll(#arg_11_0.curList_)
	else
		ForeignInfoAction:GetSimpleForeignInfo(var_11_2)
	end
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.page_.text = arg_12_0.index_

	SetActive(arg_12_0.leftBtn_.gameObject, arg_12_0.index_ ~= 1)
	SetActive(arg_12_0.rightBtn_.gameObject, arg_12_0.index_ * GameSetting.profile_like_page_num.value[1] < #arg_12_0.list_)
end

function var_0_0.OnGetSimpleForeignInfo(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0.listInfo_[iter_13_1.user_id] = {
			id = iter_13_1.user_id,
			nick = iter_13_1.base_info.nick,
			icon = iter_13_1.base_info.icon,
			frame = iter_13_1.base_info.icon_frame,
			level = iter_13_1.level
		}
	end

	arg_13_0:RefreshUI()
	arg_13_0.scrollHelper_:StartScroll(#arg_13_0.curList_)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.curList_ = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.scrollHelper_:GetItemList()) do
		iter_14_1:OnExit()
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllEventListener()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.scrollHelper_:GetItemList()) do
		iter_15_1:Dispose()
	end

	arg_15_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
