local AdvanceTestEntraceView = class("AdvanceTestEntraceView", ReduxView)

function AdvanceTestEntraceView:UIName()
	return "UI/AdvancetestingUI/ATestingEntraceUI"
end

function AdvanceTestEntraceView:UIParent()
	return manager.ui.uiPop.transform
end

function AdvanceTestEntraceView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.selectController_ = self.controller_:GetController("select")
end

function AdvanceTestEntraceView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/advanceTestMain", {
			activityID = self.selectID_
		})
	end)
end

function AdvanceTestEntraceView:OnEnter()
	self.activityIDList_ = AdvanceTestData:GetActivityList()
	self.selectID_ = 0

	for iter_7_0, iter_7_1 in ipairs(self.activityIDList_) do
		if not self.itemList_[iter_7_0] then
			self.itemList_[iter_7_0] = AdvanceTestEntraceItem.New(Object.Instantiate(self.entraceItem_, self.btnContent_), iter_7_0)

			self.itemList_[iter_7_0]:SetClickCallBack(function(arg_8_0)
				self:SelectItem(arg_8_0)
			end)
		end

		self.itemList_[iter_7_0]:SetData(iter_7_1)
		SetActive(self.itemList_[iter_7_0].gameObject_, true)
	end

	for iter_7_2 = #self.itemList_, #self.activityIDList_ + 1, -1 do
		SetActive(self.itemList_[iter_7_2].gameObject_, false)
	end

	self.scrollView_.enabled = #self.activityIDList_ > 3

	self:SelectItem(self.selectID_)
end

function AdvanceTestEntraceView:SelectItem(arg_9_1)
	self.selectID_ = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(self.itemList_) do
		iter_9_1:RefreshSelect(self.selectID_)
	end

	self.selectController_:SetSelectedState(tostring(self.selectID_ ~= 0))
end

function AdvanceTestEntraceView:Dispose()
	if self.itemList_ then
		for iter_10_0, iter_10_1 in ipairs(self.itemList_) do
			iter_10_1:Dispose()
		end

		self.itemList_ = nil
	end

	AdvanceTestEntraceView.super.Dispose(self)
end

return AdvanceTestEntraceView
