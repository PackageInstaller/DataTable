local var_0_0 = class("FragmentExchangeView", ReduxView)
local var_0_1 = import("game.tools.HeroTools")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopExchangePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, CommonItemView)
	arg_3_0.resultList = LuaList.New(handler(arg_3_0, arg_3_0.indexItem2), arg_3_0.list2Go_, FragmentExchangeItem)
	arg_3_0.controller = arg_3_0.controller_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnOK_, nil, function()
		if #arg_4_0.itemList_ == 0 then
			arg_4_0:Back()
		else
			ShopAction.ResolveFragment()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnCancel_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnLock_, nil, function()
		ShowTips("NO_EXCHANGE_HERO_PIECE")
	end)
end

function var_0_0.OnResolveFragment(arg_9_0, arg_9_1)
	if #arg_9_0.itemList_ == 0 then
		return
	end

	if arg_9_1.result == 0 then
		ShowTips("EXCHANGE_SUCCESS")
		arg_9_0:Back()
	else
		ShowTips(arg_9_1.result)

		return
	end
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.pieceList_[arg_10_1]

	function var_10_0.clickFun(arg_11_0)
		ShowPopItem(POP_ITEM, {
			arg_11_0.id,
			arg_11_0.number
		})
	end

	var_10_0.selectStyle = true

	CommonTools.SetCommonData(arg_10_2, var_10_0)
end

function var_0_0.indexItem2(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.itemList_[arg_12_1]

	arg_12_2:SetData({
		number = 1,
		id = var_12_0.id,
		clickFun = function(arg_13_0)
			ShowPopItem(POP_ITEM, {
				arg_13_0.id,
				arg_13_0.number
			})
		end
	}, var_12_0.num)
end

function var_0_0.RefreshPiece(arg_14_0)
	arg_14_0.pieceList_ = var_0_1.GetCanExchangeHero()

	arg_14_0.scrollHelper:StartScroll(#arg_14_0.pieceList_)
end

function var_0_0.RefreshGetItemNum(arg_15_0)
	if not arg_15_0.pieceList_ then
		return
	end

	arg_15_0.itemList_ = ShopTools.GetFragmentList()

	arg_15_0.resultList:StartScroll(#arg_15_0.itemList_)
end

function var_0_0.Init(arg_16_0)
	arg_16_0:InitUI()
	arg_16_0:AddUIListener()
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.controller:SetSelectedState(#ShopTools.GetFragmentList() == 0 and "none" or "have")

	arg_17_0.noneTxt_.text = GetTips("NO_EXCHANGE_HERO_PIECE")
	arg_17_0.titleTxt_.text = GetTips("DEBRIS_EXCHANGE")
	arg_17_0.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_2")
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:UpdateView()
	arg_18_0:RefreshPiece()
	arg_18_0:RefreshGetItemNum()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	arg_19_0.scrollHelper:Dispose()
	arg_19_0.resultList:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
