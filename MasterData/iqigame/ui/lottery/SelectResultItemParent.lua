-- chunkname: @IQIGame\\UI\\Lottery\\SelectResultItemParent.lua

local LotteryRewardShowItemCell = require("IQIGame.UI.Lottery.LotteryRewardShowItemCell")
local m = {
	HasData = false,
	SelectIndex = 0,
	SelectResultItems = {}
}

function m.New(view, selectIndex, selectCallback, mainView)
	local obj = Clone(m)

	obj:Init(view, selectIndex, selectCallback, mainView)

	return obj
end

function m:Init(view, selectIndex, selectCallback, mainView)
	self.View = view
	self.mainView = mainView
	self.SelectIndex = selectIndex
	self.SelectCallback = selectCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	self.titleText = self.Title:GetComponent("Text").text

	self:AddListeners()
end

function m:AddListeners()
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
end

function m:RemoveListeners()
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
end

function m:SetData(drawResults)
	self:SetSelectState(false)

	self.HasData = table.len(drawResults) > 0

	for k, v in pairs(self.SelectResultItems) do
		v:Hide()
	end

	for k, v in pairs(drawResults) do
		local item = self:CreateItems(k)

		item:SetData(v)
	end
end

function m:CreateItems(index)
	local selectItem = self.SelectResultItems[index]

	if selectItem == nil then
		local ItemObj = UnityEngine.GameObject.Instantiate(self.resultItemPrefab)

		ItemObj.transform:SetParent(self.ResultGrid.transform, false)

		local itemLuaTable = LotteryRewardShowItemCell.New(ItemObj, self.mainView)

		self.SelectResultItems[index] = itemLuaTable
		selectItem = self.SelectResultItems[index]
	end

	selectItem:Show()

	return selectItem
end

function m:OnClickSelectBtn()
	if not self.HasData then
		return
	end

	if self.SelectCallback ~= nil then
		self.SelectCallback(self.SelectIndex)
	end
end

function m:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.SelectImg, state)
	self:SetBGState(state)
end

function m:SetBGState(state)
	LuaUtility.SetGameObjectShow(self.bg1, state)
	LuaUtility.SetGameObjectShow(self.bg2, not state)
	self:SetTitleTextState(state)
end

function m:SetTitleTextState(state)
	if state then
		UGUIUtil.SetText(self.Title, string.format(ColorCfg.White, self.titleText))
	else
		UGUIUtil.SetText(self.Title, string.format(ColorCfg.Lottery.NoSelectTitleText, self.titleText))
	end
end

function m:SetSelectBtnState(state)
	LuaUtility.SetGameObjectShow(self.SelectBtn, state)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.SelectResultItems) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
