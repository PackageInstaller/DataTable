local HanafudaCheckCombineView = class("HanafudaCheckCombineView", ReduxView)

function HanafudaCheckCombineView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCheckUI"
end

function HanafudaCheckCombineView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaCheckCombineView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HanafudaCheckCombineView:InitUI()
	self:BindCfgUI()

	self.uiList = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, HanafudaCardView)
	self.uiCombineList_ = LuaList.New(handler(self, self.IndexCombineItem), self.combineList_, HanafudaCombineItem)
	self.titleController_ = ControllerUtil.GetController(self.transform_, "title")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "changeBtn")
	self.btnController_ = ControllerUtil.GetController(self.changeBtn_.transform, "btn")
end

function HanafudaCheckCombineView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.changeBtn_, nil, function()
		self.state = self.state == 1 and 2 or 1

		self:RefreshState()
	end)
end

function HanafudaCheckCombineView:IndexCombineItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_1, self.cardCombineDataList_[arg_8_1], self.playerType_)
end

function HanafudaCheckCombineView:OnEnter()
	self.playerType_ = self.params_.playerType
	self.callback_ = self.params_.callback
	self.state = 1

	self:RefreshState()

	if self.playerType_ == HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE then
		self.titleController_:SetSelectedState("player")

		self.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	else
		self.titleController_:SetSelectedState("enemy")

		self.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end
end

function HanafudaCheckCombineView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.cardDataList_[arg_10_1])
end

function HanafudaCheckCombineView:RefreshState()
	if self.state == 1 then
		self.stateController_:SetSelectedState("list")
		self.btnController_:SetSelectedState("combination")

		self.cardDataList_ = HanafudaData:GetCardsListByType(self.playerType_)

		self.uiList:StartScroll(#self.cardDataList_)
	elseif self.state == 2 then
		self.stateController_:SetSelectedState("combination")
		self.btnController_:SetSelectedState("deck")

		self.cardCombineDataList_ = HanafudaData:GetCombineList()

		self.uiCombineList_:StartScroll(#self.cardCombineDataList_)
	end
end

function HanafudaCheckCombineView:OnExit()
	if self.callback_ then
		self.callback_()
	end
end

function HanafudaCheckCombineView:Dispose()
	if self.uiList then
		self.uiList:Dispose()
	end

	if self.uiCombineList_ then
		self.uiCombineList_:Dispose()
	end

	HanafudaCheckCombineView.super.Dispose(self)
end

return HanafudaCheckCombineView
