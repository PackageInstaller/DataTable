local BloodCardUnlockCardPopView = class("BloodCardUnlockCardPopView", ReduxView)

function BloodCardUnlockCardPopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardUnlockCardUI"
end

function BloodCardUnlockCardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BloodCardUnlockCardPopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.cardItemList_ = LuaList.New(handler(self, self.IndexCard), self.uiList_, BloodCardVisualCardView)
end

function BloodCardUnlockCardPopView:InitUI()
	self:BindCfgUI()
end

function BloodCardUnlockCardPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function BloodCardUnlockCardPopView:OnEnter()
	self.cacheUnlockCardList_ = BloodCardData:GetCacheUnlockCard()

	table.sort(self.cacheUnlockCardList_, function(arg_8_0, arg_8_1)
		if BloodCardGameCardCfg[arg_8_0].kind ~= BloodCardGameCardCfg[arg_8_1].kind then
			return BloodCardGameCardCfg[arg_8_0].kind > BloodCardGameCardCfg[arg_8_1].kind
		end

		return arg_8_0 < arg_8_1
	end)
	self.cardItemList_:StartScroll(#self.cacheUnlockCardList_)

	self.timer_ = FrameTimer.New(function()
		for iter_9_0, iter_9_1 in ipairs(self.cardItemList_:GetItemList()) do
			if BloodCardGameCardCfg[iter_9_1.id_].kind ~= BloodCardConst.CARD_KIND.GOLD then
				iter_9_1:PlayAni("UI_CardVisual_UI_puntong")
			else
				iter_9_1:PlayAni("UI_CardVisual_UI_teshu")
			end
		end
	end, 0.5, 1):Start()
end

function BloodCardUnlockCardPopView:IndexCard(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.cacheUnlockCardList_[arg_10_1])
	arg_10_2:SetClickCallBack(function(arg_11_0)
		for iter_11_0, iter_11_1 in ipairs(self.cardItemList_:GetItemList()) do
			iter_11_1:ShowDescTips(arg_11_0, iter_11_0)
		end
	end)
end

function BloodCardUnlockCardPopView:OnExit()
	self.tiemr_ = nil

	BloodCardData:ClearCacheUnlockCard()
end

function BloodCardUnlockCardPopView:Dispose()
	if self.cardItemList_ then
		self.cardItemList_:Dispose()
	end

	BloodCardUnlockCardPopView.super.Dispose(self)
end

return BloodCardUnlockCardPopView
