local NorseSurpriseGiftWishPoolPage = class("NorseSurpriseGiftWishPoolPage", ReduxView)

function NorseSurpriseGiftWishPoolPage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftWishPoolUI"
end

function NorseSurpriseGiftWishPoolPage:UIParent()
	return manager.ui.uiMain.transform
end

function NorseSurpriseGiftWishPoolPage:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.onChooseHandler = handler(self, self.OnNorseGiftChooseSuccess)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftWishPoolItem)
end

function NorseSurpriseGiftWishPoolPage:AddListeners()
	self:AddBtnListener(self.btn_info, nil, function()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
end

function NorseSurpriseGiftWishPoolPage:indexItem(arg_6_1, arg_6_2)
	if self.choose_list and #self.choose_list >= 6 then
		arg_6_2:SetData(self.choose_list[arg_6_1])

		if self.draw_list and #self.draw_list > 0 then
			arg_6_2:SetDrawState(self.draw_list)
		end

		if self.result_role_id and self.result_role_id > 0 then
			arg_6_2:SetGetState(self.result_role_id)
		end
	end
end

function NorseSurpriseGiftWishPoolPage:OnTop()
	self:UpdateBar()
end

function NorseSurpriseGiftWishPoolPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_OPTIONAL_RANDOM_RULE")
end

function NorseSurpriseGiftWishPoolPage:OnEnter()
	NorseSurpriseGiftWishPoolPage.super.OnEnter(self)
	manager.notify:RegistListener(NORSE_GIFT_CHOOSE_SUCCESS, self.onChooseHandler)

	self.choose_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	if self.params_.choose_list then
		self.choose_list = self.params_.choose_list
	end

	self.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	self:RefreshView()
end

function NorseSurpriseGiftWishPoolPage:OnExit()
	NorseSurpriseGiftWishPoolPage.super.OnExit(self)
	manager.notify:RemoveListener(NORSE_GIFT_CHOOSE_SUCCESS, self.onChooseHandler)
	manager.windowBar:HideBar()
end

function NorseSurpriseGiftWishPoolPage:Dispose()
	NorseSurpriseGiftWishPoolPage.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

function NorseSurpriseGiftWishPoolPage:RefreshView()
	TimeTools.StartAfterSeconds(0.033, function()
		if self.choose_list and #self.choose_list >= 6 then
			self.uiList_:StartScroll(#self.choose_list)
		else
			self.uiList_:StartScroll(6)
		end
	end, {})
end

function NorseSurpriseGiftWishPoolPage:OnNorseGiftChooseSuccess(arg_14_1)
	self.choose_list = arg_14_1
	self.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	self:RefreshView()
end

return NorseSurpriseGiftWishPoolPage
