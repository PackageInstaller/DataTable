local DormIlluDancePage = class("DormIlluDancePage", ReduxView)

function DormIlluDancePage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.recordIndex_ = nil

	self:InitData()
	self:InitUI()
end

function DormIlluDancePage:InitData()
	self.allIDList_ = IdolDanceDIYActionCfg.all
end

function DormIlluDancePage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, DormIlluDanceItem)
end

function DormIlluDancePage:AddUIListener()
	return
end

function DormIlluDancePage:Show(arg_5_1)
	self:InitData()
	self:RefreshData()
	self:RefreshUI(arg_5_1)
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.RefreshAll))
end

function DormIlluDancePage:Hide()
	return
end

function DormIlluDancePage:OnClickFliter()
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List
	})
	self:RefreshData()
	self:RefreshUI()
end

function DormIlluDancePage:RefreshAll()
	self:RefreshData()
	self:RefreshUI()
end

function DormIlluDancePage:RefreshData()
	self.allIDList_ = {}

	for iter_9_0, iter_9_1 in ipairs(IdolDanceDIYActionCfg.all) do
		if IdolTraineeTools.FilterDIYDanceAction == nil or IdolTraineeTools.FilterDIYDanceAction(iter_9_1) then
			table.insert(self.allIDList_, iter_9_1)
		end
	end
end

function DormIlluDancePage:RefreshUI(arg_10_1)
	self.uiList_:StartScroll(#self.allIDList_)
	self.uiList_:Refresh()

	if self.recordIndex_ and arg_10_1 then
		self.uiList_:ScrollToIndex(self.recordIndex_)
	end
end

function DormIlluDancePage:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()
	end

	self.recordIndex_ = nil

	DormIlluDancePage.super.Dispose(self)
end

function DormIlluDancePage:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, self.allIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		self:OpenDetailView(arg_13_0, arg_13_1)
	end)
end

function DormIlluDancePage:OpenDetailView(arg_14_1, arg_14_2)
	self.recordIndex_ = arg_14_2

	JumpTools.OpenPageByJump("/dormIlluDanceDetail", {
		danceID = arg_14_1,
		danceIDList = self.allIDList_
	})
end

return DormIlluDancePage
