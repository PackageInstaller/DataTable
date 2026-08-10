local var_0_0 = class("BloodCardUnlockCardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardUnlockCardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.cardItemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexCard), arg_3_0.uiList_, BloodCardVisualCardView)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.cacheUnlockCardList_ = BloodCardData:GetCacheUnlockCard()

	table.sort(arg_7_0.cacheUnlockCardList_, function(arg_8_0, arg_8_1)
		if BloodCardGameCardCfg[arg_8_0].kind ~= BloodCardGameCardCfg[arg_8_1].kind then
			return BloodCardGameCardCfg[arg_8_0].kind > BloodCardGameCardCfg[arg_8_1].kind
		end

		return arg_8_0 < arg_8_1
	end)
	arg_7_0.cardItemList_:StartScroll(#arg_7_0.cacheUnlockCardList_)

	arg_7_0.timer_ = FrameTimer.New(function()
		for iter_9_0, iter_9_1 in ipairs(arg_7_0.cardItemList_:GetItemList()) do
			if BloodCardGameCardCfg[iter_9_1.id_].kind ~= BloodCardConst.CARD_KIND.GOLD then
				iter_9_1:PlayAni("UI_CardVisual_UI_puntong")
			else
				iter_9_1:PlayAni("UI_CardVisual_UI_teshu")
			end
		end
	end, 0.5, 1):Start()
end

function var_0_0.IndexCard(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.cacheUnlockCardList_[arg_10_1])
	arg_10_2:SetClickCallBack(function(arg_11_0)
		for iter_11_0, iter_11_1 in ipairs(arg_10_0.cardItemList_:GetItemList()) do
			iter_11_1:ShowDescTips(arg_11_0, iter_11_0)
		end
	end)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.tiemr_ = nil

	BloodCardData:ClearCacheUnlockCard()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.cardItemList_ then
		arg_13_0.cardItemList_:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
