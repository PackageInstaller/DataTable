local NorseSurpriseGiftReceivePage = class("NorseSurpriseGiftReceivePage", ReduxView)

function NorseSurpriseGiftReceivePage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftReceiveUI"
end

function NorseSurpriseGiftReceivePage:UIParent()
	return manager.ui.uiPop.transform
end

function NorseSurpriseGiftReceivePage:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftReceiveItem)
	self.btnCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("btn")
end

function NorseSurpriseGiftReceivePage:AddListeners()
	self:AddBtnListener(self.btnClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn_true, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_5"),
			OkCallback = function()
				NorseSurpriseGiftReceiveAction.ReceiveRewardRole(242832, self.infocfg.id)
				self:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function NorseSurpriseGiftReceivePage:indexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.draw_list[arg_9_1], arg_9_1)
	arg_9_2:SetSelect(self.infocfg)

	if self.heart_list and #self.heart_list > 0 then
		arg_9_2:SetHeart(self.heart_list)
	end

	arg_9_2:RegistCallBack(function(arg_10_0)
		self.infocfg = arg_10_0 == self.infocfg.id and {
			id = 0,
			flag = 1
		} or {
			flag = 0,
			id = arg_10_0
		}

		for iter_10_0, iter_10_1 in ipairs((self.uiList_:GetItemList())) do
			iter_10_1:SetSelect(self.infocfg)

			if self.heart_list and #self.heart_list > 0 then
				iter_10_1:SetHeart(self.heart_list)
			end
		end

		self:RefreshChooseBtn(self.infocfg.flag)
	end)
end

function NorseSurpriseGiftReceivePage:RefreshChooseBtn(arg_11_1)
	self.btnCtrl:SetSelectedIndex(arg_11_1)
end

function NorseSurpriseGiftReceivePage:OnTop()
	self:UpdateBar()
end

function NorseSurpriseGiftReceivePage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NorseSurpriseGiftReceivePage:OnEnter()
	NorseSurpriseGiftReceivePage.super.OnEnter(self)

	self.infocfg = {
		id = 0,
		flag = 1
	}

	self:RefreshView()
	self.btnCtrl:SetSelectedIndex(1)

	self.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_4")
end

function NorseSurpriseGiftReceivePage:OnExit()
	NorseSurpriseGiftReceivePage.super.OnExit(self)
	manager.windowBar:HideBar()
end

function NorseSurpriseGiftReceivePage:Dispose()
	NorseSurpriseGiftReceivePage.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

function NorseSurpriseGiftReceivePage:RefreshView()
	self.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.heart_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	TimeTools.StartAfterSeconds(0.033, function()
		self.uiList_:StartScroll(#self.draw_list)
	end, {})
end

return NorseSurpriseGiftReceivePage
