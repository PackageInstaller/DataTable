local var_0_0 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceRankItemView")
local var_0_1 = class("SummerRaceRankView", ReduxView)
local var_0_2 = "all"
local var_0_3 = "01"

local function var_0_4(arg_1_0)
	if type(arg_1_0) ~= "table" then
		return arg_1_0
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if type(iter_1_1) == "table" then
			local var_1_1 = {}

			for iter_1_2, iter_1_3 in pairs(iter_1_1) do
				var_1_1[iter_1_2] = iter_1_3
			end

			var_1_0[iter_1_0] = var_1_1
		else
			var_1_0[iter_1_0] = iter_1_1
		end
	end

	return var_1_0
end

local function var_0_5(arg_2_0)
	if type(arg_2_0) ~= "table" then
		return {
			source = "rankDetail"
		}
	end

	if type(arg_2_0.battleInfoParams) == "table" then
		return var_0_4(arg_2_0.battleInfoParams)
	end

	return {
		source = "rankDetail",
		rank = arg_2_0.rank,
		score = arg_2_0.score,
		playerName = arg_2_0.playerName or arg_2_0.nick,
		buildData = var_0_4(arg_2_0.buildData or {})
	}
end

local function var_0_6(arg_3_0)
	if arg_3_0.outGameUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventOutGameUpdated(), arg_3_0.outGameUpdateHandler_)

		arg_3_0.outGameUpdateHandler_ = nil
	end
end

local function var_0_7(arg_4_0)
	if arg_4_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_4_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function var_0_1.UIName(arg_5_0)
	return "Widget/System/Activity_SummerRace/com/AbyssRankUIVariant"
end

function var_0_1.UIParent(arg_6_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:BindCfgUI(arg_7_0.commonRankGo_)
	arg_7_0:BindViewRuntime()
	arg_7_0:AddUIListener()
end

function var_0_1.BindViewRuntime(arg_8_0)
	arg_8_0.rankItemList_ = LuaList.New(handler(arg_8_0, arg_8_0.IndexRankItem), arg_8_0.uiListGo_, var_0_0)
	arg_8_0.tabController_ = arg_8_0.toggleConEx ~= nil and arg_8_0.toggleConEx:GetController("tab") or nil
	arg_8_0.tabNumController_ = arg_8_0.toggleConEx ~= nil and arg_8_0.toggleConEx:GetController("num") or nil
	arg_8_0.commonPortrait_ = arg_8_0.headItem_ ~= nil and CommonHeadPortrait.New(arg_8_0.headItem_) or nil
	arg_8_0.rankList_ = {}
end

function var_0_1.OnEnter(arg_9_0)
	arg_9_0:UpdateBar()

	arg_9_0.outGameUpdateHandler_ = handler(arg_9_0, arg_9_0.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), arg_9_0.outGameUpdateHandler_)

	arg_9_0.rankActivityId_ = SummerRaceData:GetRankActivityId()

	if arg_9_0.rankActivityId_ ~= nil and arg_9_0.rankActivityId_ ~= 0 then
		RankAction.QueryActivityRank(arg_9_0.rankActivityId_, 0)
	end

	arg_9_0:RefreshView()
end

function var_0_1.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_1.UpdateBar(arg_11_0)
	arg_11_0.windowBarBackHandler_ = arg_11_0.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_11_0.windowBarBackHandler_)
end

function var_0_1.OnBehind(arg_13_0)
	return
end

function var_0_1.OnExit(arg_14_0)
	var_0_6(arg_14_0)
	var_0_7(arg_14_0)
end

function var_0_1.AddUIListener(arg_15_0)
	arg_15_0:AddBtnListener(arg_15_0.clubBtn_, nil, function()
		arg_15_0:RefreshView()
	end)
	arg_15_0:AddBtnListener(arg_15_0.allBtn_, nil, function()
		arg_15_0:RefreshView()
	end)
end

function var_0_1.IndexRankItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_0.rankList_[arg_18_1], arg_18_1, handler(arg_18_0, arg_18_0.OnRankItemClick))
end

function var_0_1.OnRankItemClick(arg_19_0, arg_19_1, arg_19_2)
	SummerRaceAction.OpenInfoPop(var_0_5(arg_19_2))
end

function var_0_1.RefreshView(arg_20_0)
	local var_20_0 = SummerRaceData:GetRankPageModel()

	arg_20_0.rankList_ = var_20_0.rankList or {}

	if arg_20_0.tabController_ ~= nil then
		arg_20_0.tabController_:SetSelectedState(var_0_2)
	end

	if arg_20_0.tabNumController_ ~= nil then
		arg_20_0.tabNumController_:SetSelectedState(var_0_3)
	end

	arg_20_0.rankItemList_:StartScroll(#arg_20_0.rankList_)

	if var_20_0.selfRank then
		local var_20_1

		if var_20_0.selfRank.rank == 0 then
			var_20_1 = GetTips("MATRIX_RANK_NO_RANK")
		else
			var_20_1 = var_20_0.selfRank.rank
		end

		arg_20_0.myRankLabel_.text = var_20_1
		arg_20_0.myScoreLabel_.text = tostring(var_20_0.selfRank.score or 0)
	else
		arg_20_0.myRankLabel_.text = ""
		arg_20_0.myScoreLabel_.text = ""
	end

	if arg_20_0.nameLabel_ ~= nil then
		arg_20_0.nameLabel_.text = tostring(PlayerData:GetPlayerInfo().nick or "")
	end

	if arg_20_0.commonPortrait_ ~= nil then
		arg_20_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
		arg_20_0.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	end
end

function var_0_1.OnRankUpdate(arg_21_0, arg_21_1)
	if arg_21_1 == nil or arg_21_1 == arg_21_0.rankActivityId_ then
		arg_21_0:RefreshView()
	end
end

function var_0_1.Dispose(arg_22_0)
	var_0_6(arg_22_0)
	var_0_7(arg_22_0)

	if arg_22_0.rankItemList_ then
		arg_22_0.rankItemList_:Dispose()

		arg_22_0.rankItemList_ = nil
	end

	if arg_22_0.commonPortrait_ then
		arg_22_0.commonPortrait_:Dispose()

		arg_22_0.commonPortrait_ = nil
	end

	arg_22_0.windowBarBackHandler_ = nil

	var_0_1.super.Dispose(arg_22_0)
end

return var_0_1
