local HellaPinballChapterSelectPopView = class("HellaPinballChapterSelectPopView", ReduxView)

function HellaPinballChapterSelectPopView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_ChapterPopUI"
end

function HellaPinballChapterSelectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function HellaPinballChapterSelectPopView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function HellaPinballChapterSelectPopView:InitUI()
	self.chapterUIList_ = LuaList.New(handler(self, self.OnCreateChapterItem), self.uiList_, HellaPinballChapterItem)
end

function HellaPinballChapterSelectPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function HellaPinballChapterSelectPopView:OnEnter()
	self:UpdateData()
	self:RefreshUI()
end

function HellaPinballChapterSelectPopView:UpdateData()
	self.selectChapter_ = PinballData:GetLastEnterStageCategory()
	self.chapterList_ = PinballData:GetDisplayStageList()
end

function HellaPinballChapterSelectPopView:OnCreateChapterItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_1, self.chapterList_[arg_9_1])
	arg_9_2:SetSelect(self.chapterList_[arg_9_1] == self.selectChapter_)
	arg_9_2:SetClickCallBack(function(arg_10_0)
		for iter_10_0, iter_10_1 in pairs(self.chapterUIList_:GetItemList()) do
			if iter_10_1.index_ == arg_10_0 then
				iter_10_1:SetSelect(true)
			else
				iter_10_1:SetSelect(false)
			end
		end

		self.selectChapter_ = self.chapterList_[arg_10_0]

		PinballData:SetLastEnterStageCategory(self.chapterList_[arg_10_0])
	end)
end

function HellaPinballChapterSelectPopView:RefreshUI()
	self.chapterUIList_:StartScroll(#self.chapterList_, table.indexof(self.chapterList_, self.selectChapter_), true)
end

function HellaPinballChapterSelectPopView:OnExit()
	return
end

function HellaPinballChapterSelectPopView:Dispose()
	if self.chapterUIList_ then
		self.chapterUIList_:Dispose()
	end

	HellaPinballChapterSelectPopView.super.Dispose(self)
end

return HellaPinballChapterSelectPopView
