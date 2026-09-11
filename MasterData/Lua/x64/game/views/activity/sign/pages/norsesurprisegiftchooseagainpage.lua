local NorseSurpriseGiftChooseAgainPage = class("NorseSurpriseGiftChooseAgainPage", ReduxView)

function NorseSurpriseGiftChooseAgainPage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseAgainUI"
end

function NorseSurpriseGiftChooseAgainPage:UIParent()
	return manager.ui.uiPop.transform
end

function NorseSurpriseGiftChooseAgainPage:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function NorseSurpriseGiftChooseAgainPage:AddListeners()
	self:AddBtnListener(self.btn_no, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn_yes, nil, function()
		self:Back()
		self:Back()
		NorseSurpriseGiftReceiveAction.ChooseHeartList(242832, self.heartList)
	end)
end

function NorseSurpriseGiftChooseAgainPage:OnEnter()
	NorseSurpriseGiftChooseAgainPage.super.OnEnter(self)

	self.sortList = self.params_.sortList

	self:RefreshView()
end

function NorseSurpriseGiftChooseAgainPage:OnExit()
	NorseSurpriseGiftChooseAgainPage.super.OnExit(self)
end

function NorseSurpriseGiftChooseAgainPage:Dispose()
	NorseSurpriseGiftChooseAgainPage.super.Dispose(self)

	if self.sortList then
		self.sortList = nil
	end

	if self.heartList then
		self.heartList = nil
	end
end

function NorseSurpriseGiftChooseAgainPage:RefreshView()
	self.tipsTxt_.text = GetTips("PROMPT")
	self.infoTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_1")
	self.heartList = {}

	for iter_10_0, iter_10_1 in ipairs(self.sortList) do
		table.insert(self.heartList, iter_10_1.id)
	end
end

return NorseSurpriseGiftChooseAgainPage
