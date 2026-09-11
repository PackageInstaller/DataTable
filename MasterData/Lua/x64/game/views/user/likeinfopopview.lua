local LikeInfoPopView = class("LikeInfoPopView", ReduxView)

function LikeInfoPopView:UIName()
	return "Widget/System/UserInfor/LikerecordUI"
end

function LikeInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function LikeInfoPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LikeInfoPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, LikeInfoPopItem)
end

function LikeInfoPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData(self.listInfo_[self.curList_[arg_5_1].id], self.curList_[arg_5_1].time)
end

function LikeInfoPopView:AddUIListeners()
	self:AddBtnListener(self.leftBtn_, nil, function()
		self.index_ = self.index_ - 1
		self.params_.index = self.index_

		self:TryGetInfo()
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self.index_ = self.index_ + 1
		self.params_.index = self.index_

		self:TryGetInfo()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function LikeInfoPopView:OnEnter()
	self.list_ = {}
	self.listInfo_ = {}

	for iter_10_0, iter_10_1 in ipairs((PlayerData:GetLikeInfo())) do
		table.insert(self.list_, {
			id = iter_10_1.id,
			time = iter_10_1.time
		})
	end

	self.index_ = self.params_.index

	self:TryGetInfo()
end

function LikeInfoPopView:TryGetInfo()
	local var_11_0 = {}

	self.curList_ = {}

	for iter_11_0 = (self.index_ - 1) * GameSetting.profile_like_page_num.value[1] + 1, self.index_ * GameSetting.profile_like_page_num.value[1] do
		if not self.list_[iter_11_0] then
			break
		end

		local var_11_1 = self.list_[iter_11_0].id

		table.insert(self.curList_, self.list_[iter_11_0])

		if not self.listInfo_[var_11_1] then
			table.insert(var_11_0, var_11_1)
		end
	end

	if #var_11_0 <= 0 then
		self:RefreshUI()
		self.scrollHelper_:StartScroll(#self.curList_)
	else
		ForeignInfoAction:GetSimpleForeignInfo(var_11_0)
	end
end

function LikeInfoPopView:RefreshUI()
	self.page_.text = self.index_

	SetActive(self.leftBtn_.gameObject, self.index_ ~= 1)
	SetActive(self.rightBtn_.gameObject, self.index_ * GameSetting.profile_like_page_num.value[1] < #self.list_)
end

function LikeInfoPopView:OnGetSimpleForeignInfo(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self.listInfo_[iter_13_1.user_id] = {
			id = iter_13_1.user_id,
			nick = iter_13_1.base_info.nick,
			icon = iter_13_1.base_info.icon,
			frame = iter_13_1.base_info.icon_frame,
			level = iter_13_1.level
		}
	end

	self:RefreshUI()
	self.scrollHelper_:StartScroll(#self.curList_)
end

function LikeInfoPopView:OnExit()
	self.curList_ = {}

	for iter_14_0, iter_14_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_14_1:OnExit()
	end
end

function LikeInfoPopView:Dispose()
	self:RemoveAllEventListener()

	for iter_15_0, iter_15_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_15_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	LikeInfoPopView.super.Dispose(self)
end

return LikeInfoPopView
