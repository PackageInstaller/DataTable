local FragmentExchangeView = class("FragmentExchangeView", ReduxView)
local HeroTools = import("game.tools.HeroTools")

function FragmentExchangeView:UIName()
	return "Widget/System/Shop/ShopExchangePopUI"
end

function FragmentExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function FragmentExchangeView:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItemView)
	self.resultList = LuaList.New(handler(self, self.indexItem2), self.list2Go_, FragmentExchangeItem)
	self.controller = self.controller_:GetController("state")
end

function FragmentExchangeView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnOK_, nil, function()
		if #self.itemList_ == 0 then
			self:Back()
		else
			ShopAction.ResolveFragment()
		end
	end)
	self:AddBtnListener(self.btnCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnLock_, nil, function()
		ShowTips("NO_EXCHANGE_HERO_PIECE")
	end)
end

function FragmentExchangeView:OnResolveFragment(arg_9_1)
	if #self.itemList_ == 0 then
		return
	end

	if arg_9_1.result == 0 then
		ShowTips("EXCHANGE_SUCCESS")
		self:Back()
	else
		ShowTips(arg_9_1.result)

		return
	end
end

function FragmentExchangeView:indexItem(arg_10_1, arg_10_2)
	self.pieceList_[arg_10_1].clickFun = function(self)
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end
	self.pieceList_[arg_10_1].selectStyle = true

	CommonTools.SetCommonData(arg_10_2, self.pieceList_[arg_10_1])
end

function FragmentExchangeView:indexItem2(arg_12_1, arg_12_2)
	arg_12_2:SetData({
		number = 1,
		id = self.itemList_[arg_12_1].id,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	}, self.itemList_[arg_12_1].num)
end

function FragmentExchangeView:RefreshPiece()
	self.pieceList_ = HeroTools.GetCanExchangeHero()

	self.scrollHelper:StartScroll(#self.pieceList_)
end

function FragmentExchangeView:RefreshGetItemNum()
	if not self.pieceList_ then
		return
	end

	self.itemList_ = ShopTools.GetFragmentList()

	self.resultList:StartScroll(#self.itemList_)
end

function FragmentExchangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FragmentExchangeView:UpdateView()
	self.controller:SetSelectedState(#ShopTools.GetFragmentList() == 0 and "none" or "have")

	self.noneTxt_.text = GetTips("NO_EXCHANGE_HERO_PIECE")
	self.titleTxt_.text = GetTips("DEBRIS_EXCHANGE")
	self.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_2")
end

function FragmentExchangeView:OnEnter()
	self:UpdateView()
	self:RefreshPiece()
	self:RefreshGetItemNum()
end

function FragmentExchangeView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper:Dispose()
	self.resultList:Dispose()
	FragmentExchangeView.super.Dispose(self)
end

return FragmentExchangeView
