local BloodCardRecommendCardGroupPopView = class("BloodCardRecommendCardGroupPopView", ReduxView)

function BloodCardRecommendCardGroupPopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardBuildSelectDeckUI"
end

function BloodCardRecommendCardGroupPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BloodCardRecommendCardGroupPopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
	self.groupList_ = LuaList.New(handler(self, self.IndexCardGroup), self.groupUIList_, BloodCardRecommendCardGroupItem)
end

function BloodCardRecommendCardGroupPopView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		BloodCardData:SetRecommendCardSetID(self.selectID_)
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function BloodCardRecommendCardGroupPopView:OnEnter()
	self.recommendCardGroupIDList_ = BloodCardGameRecommendCardSetCfg.all
	self.selectTabIndex_ = self.params_.selectTabIndex

	self:SelectItem(BloodCardGameRecommendCardSetCfg.all[1])
	self.groupList_:StartScroll(#self.recommendCardGroupIDList_)
end

function BloodCardRecommendCardGroupPopView:IndexCardGroup(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.recommendCardGroupIDList_[arg_8_1])
	arg_8_2:SetClickCallBack(function(arg_9_0)
		self:SelectItem(arg_9_0)
	end)
end

function BloodCardRecommendCardGroupPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_RECOMMEND_RULE")
end

function BloodCardRecommendCardGroupPopView:SelectItem(arg_11_1)
	self.selectID_ = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(self.groupList_:GetItemList()) do
		iter_11_1:RefreshSelect(self.selectID_)
	end

	if arg_11_1 and arg_11_1 ~= 0 then
		self.descText_.text = BloodCardGameRecommendCardSetCfg[arg_11_1].desc
	end

	self.selectController_:SetSelectedState(tostring(self.selectID_ ~= 0))
end

function BloodCardRecommendCardGroupPopView:Dispose()
	if self.groupList_ then
		self.groupList_:Dispose()
	end

	BloodCardRecommendCardGroupPopView.super.Dispose(self)
end

return BloodCardRecommendCardGroupPopView
