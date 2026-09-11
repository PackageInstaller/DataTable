local SummerRaceRankItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceRankItemView")
local SummerRaceRankView = class("SummerRaceRankView", ReduxView)
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

	local var_2_0 = {
		source = "rankDetail",
		rank = arg_2_0.rank,
		score = arg_2_0.score
	}

	var_2_0.playerName = arg_2_0.playerName or arg_2_0.nick
	var_2_0.buildData = var_0_4(arg_2_0.buildData or {})

	return var_2_0
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

function SummerRaceRankView:UIName()
	return "Widget/System/Activity_SummerRace/com/AbyssRankUIVariant"
end

function SummerRaceRankView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceRankView:Init()
	self:BindCfgUI()
	self:BindCfgUI(self.commonRankGo_)
	self:BindViewRuntime()
	self:AddUIListener()
end

function SummerRaceRankView:BindViewRuntime()
	self.rankItemList_ = LuaList.New(handler(self, self.IndexRankItem), self.uiListGo_, SummerRaceRankItemView)
	self.tabController_ = self.toggleConEx ~= nil and self.toggleConEx:GetController("tab") or nil
	self.tabNumController_ = self.toggleConEx ~= nil and self.toggleConEx:GetController("num") or nil
	self.commonPortrait_ = self.headItem_ ~= nil and CommonHeadPortrait.New(self.headItem_) or nil
	self.rankList_ = {}
end

function SummerRaceRankView:OnEnter()
	self:UpdateBar()

	self.outGameUpdateHandler_ = handler(self, self.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), self.outGameUpdateHandler_)

	self.rankActivityId_ = SummerRaceData:GetRankActivityId()

	if self.rankActivityId_ ~= nil and self.rankActivityId_ ~= 0 then
		RankAction.QueryActivityRank(self.rankActivityId_, 0)
	end

	self:RefreshView()
end

function SummerRaceRankView:OnTop()
	self:UpdateBar()
end

function SummerRaceRankView:UpdateBar()
	self.windowBarBackHandler_ = self.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(self.windowBarBackHandler_)
end

function SummerRaceRankView:OnBehind()
	return
end

function SummerRaceRankView:OnExit()
	var_0_6(self)
	var_0_7(self)
end

function SummerRaceRankView:AddUIListener()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:RefreshView()
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:RefreshView()
	end)
end

function SummerRaceRankView:IndexRankItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(self.rankList_[arg_18_1], arg_18_1, handler(self, self.OnRankItemClick))
end

function SummerRaceRankView:OnRankItemClick(arg_19_1, arg_19_2)
	SummerRaceAction.OpenInfoPop(var_0_5(arg_19_2))
end

function SummerRaceRankView:RefreshView()
	local var_20_0 = SummerRaceData:GetRankPageModel()

	self.rankList_ = var_20_0.rankList or {}

	if self.tabController_ ~= nil then
		self.tabController_:SetSelectedState(var_0_2)
	end

	if self.tabNumController_ ~= nil then
		self.tabNumController_:SetSelectedState(var_0_3)
	end

	self.rankItemList_:StartScroll(#self.rankList_)

	if var_20_0.selfRank then
		self.myRankLabel_.text = var_20_0.selfRank.rank == 0 and GetTips("MATRIX_RANK_NO_RANK") or var_20_0.selfRank.rank
		self.myScoreLabel_.text = tostring(var_20_0.selfRank.score or 0)
	else
		self.myRankLabel_.text = ""
		self.myScoreLabel_.text = ""
	end

	if self.nameLabel_ ~= nil then
		self.nameLabel_.text = tostring(PlayerData:GetPlayerInfo().nick or "")
	end

	if self.commonPortrait_ ~= nil then
		self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
		self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	end
end

function SummerRaceRankView:OnRankUpdate(arg_21_1)
	if arg_21_1 == nil or arg_21_1 == self.rankActivityId_ then
		self:RefreshView()
	end
end

function SummerRaceRankView:Dispose()
	var_0_6(self)
	var_0_7(self)

	if self.rankItemList_ then
		self.rankItemList_:Dispose()

		self.rankItemList_ = nil
	end

	if self.commonPortrait_ then
		self.commonPortrait_:Dispose()

		self.commonPortrait_ = nil
	end

	self.windowBarBackHandler_ = nil

	SummerRaceRankView.super.Dispose(self)
end

return SummerRaceRankView
