local NorseSurpriseGiftResultsview = class("NorseSurpriseGiftResultsview", ReduxView)

function NorseSurpriseGiftResultsview:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftResultsUI"
end

function NorseSurpriseGiftResultsview:UIParent()
	return manager.ui.uiPop.transform
end

function NorseSurpriseGiftResultsview:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftResultsItem)
	self.uiList_2 = LuaList.New(handler(self, self.indexItem2), self.listGo_2, NorseSurpriseGiftResultsItem)
	self.effectCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("Effects")
end

function NorseSurpriseGiftResultsview:AddListeners()
	self:AddBtnListener(self.btn_bg, nil, function()
		self:Back()
		manager.notify:Invoke(NORSE_GIFT_PLAYANIM_DRAW)
	end)
end

function NorseSurpriseGiftResultsview:indexItem(arg_6_1, arg_6_2)
	HeroLongHead.SetProxy(arg_6_2, self.heroDataProxy)
	arg_6_2:SetData(self.draw_list[arg_6_1])

	if self.heartList and #self.heartList > 0 then
		arg_6_2:SetHeart(self.heartList)
	end
end

function NorseSurpriseGiftResultsview:indexItem2(arg_7_1, arg_7_2)
	HeroLongHead.SetProxy(arg_7_2, self.heroDataProxy)
	arg_7_2:SetData(self.delete_list[arg_7_1])

	if self.delete_list and #self.delete_list > 0 then
		arg_7_2:SetDelete(self.delete_list)
	end
end

function NorseSurpriseGiftResultsview:OnEnter()
	NorseSurpriseGiftResultsview.super.OnEnter(self)

	if self.params_.data then
		self.data = self.params_.data
	end

	self.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	self:RefreshView()

	self.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_5")
	self.tipsTxt2_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_6")
end

function NorseSurpriseGiftResultsview:OnExit()
	NorseSurpriseGiftResultsview.super.OnExit(self)
end

function NorseSurpriseGiftResultsview:Dispose()
	NorseSurpriseGiftResultsview.super.Dispose(self)

	if self.heroDataProxy then
		self.heroDataProxy = nil
	end

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.uiList_2 then
		self.uiList_2:Dispose()

		self.uiList_2 = nil
	end
end

function NorseSurpriseGiftResultsview:RefreshView()
	self.delete_list = self.data.delete_list
	self.draw_list = self.data.draw_list

	local var_11_0 = 1

	for iter_11_0, iter_11_1 in ipairs(self.heartList) do
		if iter_11_1 == self.draw_list[1] then
			var_11_0 = 0

			break
		end
	end

	self.effectCtrl:SetSelectedIndex(var_11_0)
	self.uiList_:StartScroll(#self.draw_list)
	self.uiList_2:StartScroll(#self.delete_list)
end

return NorseSurpriseGiftResultsview
