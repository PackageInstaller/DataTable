local SimBusinessGoodsInfoView = class("SimBusinessGoodsInfoView", ReduxView)

function SimBusinessGoodsInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessGoodsInfoView:Init()
	self:InitUI()

	self.itemList = LuaList.New(handler(self, self.indexItem), self.uilistGo_, SimBusinessShowItem)
	self.goodPage = SimBusinessGoodPage.New(self.pageGo)
end

function SimBusinessGoodsInfoView:InitUI()
	self:BindCfgUI()
end

function SimBusinessGoodsInfoView:OnEnter()
	self.goodList = SimBusinessGoodsCfg.all
	self.selectID = self.goodList[1]

	self:RefreshItemList()
	self:RefreshGoodInfo()
end

function SimBusinessGoodsInfoView:OnTop()
	return
end

function SimBusinessGoodsInfoView:OnEventRefreshView()
	self:RefreshGoodInfo()
	self.itemList:Refresh()
end

function SimBusinessGoodsInfoView:RefreshItemList()
	self.itemList:StartScroll(#self.goodList)
end

function SimBusinessGoodsInfoView:indexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshView(self.goodList[arg_8_1], SimBusinessConst.ShowItmeType.good, self.selectID, true, true)
	arg_8_2:RegisterClickItemFunc(handler(self, self.ClickItem))
end

function SimBusinessGoodsInfoView:ClickItem(arg_9_1)
	self.selectID = arg_9_1

	self.itemList:Refresh()
	self:RefreshGoodInfo()
end

function SimBusinessGoodsInfoView:RefreshGoodInfo()
	if self.selectID then
		self.goodPage:RefreshView(self.selectID)
	end
end

function SimBusinessGoodsInfoView:OnExit()
	return
end

function SimBusinessGoodsInfoView:Dispose()
	self.itemList:Dispose()
	self.goodPage:Dispose()
	SimBusinessGoodsInfoView.super.Dispose(self)
end

function SimBusinessGoodsInfoView:RegisterEvents()
	return
end

return SimBusinessGoodsInfoView
