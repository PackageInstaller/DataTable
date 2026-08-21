-- chunkname: @IQIGame\\UI\\Maze\\MazeBusinessmanShopElement_ItemDetails.lua

local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local m = {}

function m.New(view, closeFunc)
	local obj = Clone(m)

	obj:Init(view, closeFunc)

	return obj
end

function m:Init(view, closeFunc)
	self.View = view
	self.closeFunc = closeFunc

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.__delegateOnClickCloseBtn()
		self:__OnClickCloseBtn()
	end

	function self.__delegateOnClickBuyBtn()
		self:__BuyItem()
	end

	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.buffGroupTitle)

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnClickCloseBtn)
	self.BuyBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnClickBuyBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickCloseBtn)
	self.BuyBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickBuyBtn)
end

function m:SetData(stageEventLinkPod, itemData)
	self.stageEventLinkPod = stageEventLinkPod
	self.shopItemData = itemData

	local itemCfg = CfgItemTable[self.shopItemData.itemCid]
	local itemIconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, itemIconPath, self.BuffIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.BuffName, itemCfg.Name)
	UGUIUtil.SetText(self.BuffDesc, itemCfg.ItemTips)

	local canBuyItem = itemData.limitNum > 0 and not MazeModule.GetHasBuffByCid(itemData.itemCid)

	self.BuyBtn:GetComponent("GrayComponent"):SetGray(not canBuyItem)
	self.buffGroupTitleItemView:SetData(self.shopItemData.Id)

	self.descScrollView:GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function m:__BuyItem()
	if self.shopItemData.limitNum <= 0 or MazeModule.GetHasBuffByCid(self.shopItemData.itemCid) then
		NoticeModule.ShowNotice(12016)

		return
	end

	MazeModule.OnSubmitEvent(self.stageEventLinkPod.curEventId, 0, self.shopItemData.Id, 1)
end

function m:__OnClickCloseBtn()
	if self.closeFunc ~= nil then
		self.closeFunc()
	end

	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.buffGroupTitleItemView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
