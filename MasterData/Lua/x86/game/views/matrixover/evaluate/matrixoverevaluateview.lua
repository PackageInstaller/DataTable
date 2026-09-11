local MatrixOverEvaluateView = class("MatrixOverEvaluateView", ReduxView)

function MatrixOverEvaluateView:UIName()
	return "UI/PopUp/MatrixAssessPop"
end

function MatrixOverEvaluateView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixOverEvaluateView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.evaluateItemList_ = {}
end

function MatrixOverEvaluateView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.sureBtn_, nil, function()
		self:Back()
	end)
end

function MatrixOverEvaluateView:OnEnter()
	local var_7_0 = MatrixData:GetEvaluateList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		self.evaluateItemList_[iter_7_0] = self.evaluateItemList_[iter_7_0] or MatrixOverEvaluateItem.New(self.evaluateItem_, self.evaluateParent_)

		self.evaluateItemList_[iter_7_0]:SetEvaluateID(iter_7_1)
	end

	for iter_7_2 = #var_7_0 + 1, #self.evaluateItemList_ do
		self.evaluateItemList_[iter_7_2]:Show(false)
	end
end

function MatrixOverEvaluateView:OnExit()
	return
end

function MatrixOverEvaluateView:Dispose()
	MatrixOverEvaluateView.super.Dispose(self)

	for iter_9_0, iter_9_1 in ipairs(self.evaluateItemList_) do
		iter_9_1:Dispose()
	end

	self.evaluateItemList_ = nil
end

return MatrixOverEvaluateView
