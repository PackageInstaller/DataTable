local GameHelpProView = class("GameHelpProView", ReduxView)

function GameHelpProView:UIName()
	return "Widget/Common/Pop/UIfunctionpopup04"
end

function GameHelpProView:UIParent()
	return manager.ui.uiPop.transform
end

function GameHelpProView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function GameHelpProView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, GameHelpProItem)
	self.dotList_ = LuaList.New(handler(self, self.DotIndexItem), self.m_dotList, GameHelpProDotItem)
	self.hideBgController_ = self.m_controller:GetController("hideBg")
end

function GameHelpProView:AddUIListeners()
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.m_preBtn, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ - 1)
	end)
	self:AddBtnListener(self.m_nextBtn, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ + 1)
	end)
	self:AddBtnListener(self.m_closeBtn, nil, function()
		if self.exitCallback then
			self.exitCallback()
		end

		self:Back()
	end)
end

function GameHelpProView:OnPageChange(arg_9_1)
	self.pageIndex_ = arg_9_1

	SetActive(self.m_preBtn.gameObject, arg_9_1 > 1)
	SetActive(self.m_nextBtn.gameObject, arg_9_1 < #self.pages)
	self.dotList_:ScrollToIndex(arg_9_1)
end

function GameHelpProView:OnEnter()
	self.noCache = self.params_.noCache or false
	self.pages = self.params_.pages or {}
	self.isPrefab_ = self.params_.isPrefab or false
	self.hideBg_ = self.params_.hideBg or false
	self.hideHomeBtn = self.params_.hideHomeBtn or nil
	self.exitCallback = self.params_.exitCallback or nil

	local var_10_0 = self.params_.startIndex or 1

	self.list_:StartScroll(#self.pages, var_10_0, true, false)
	self.dotList_:StartScroll(#self.pages, var_10_0, true, false)
	self:OnPageChange(var_10_0)
	self.hideBgController_:SetSelectedState(tostring(self.hideBg_))

	self.params_.startIndex = nil
	self.onExitHandle_ = self.params_.exitHandle
end

function GameHelpProView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.pages[arg_11_1], self.isPrefab_)
end

function GameHelpProView:DotIndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.pageIndex_ == arg_12_1)
end

function GameHelpProView:OnExit()
	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", self:GetStayTime(), 50103)

	self.onExitHandle_ = nil

	if self.onExitHandle_ then
		self.onExitHandle_()
	end
end

function GameHelpProView:Cacheable()
	return not self.noCache
end

function GameHelpProView:Dispose()
	self.list_:Dispose()
	self.dotList_:Dispose()
	GameHelpProView.super.Dispose(self)
end

return GameHelpProView
