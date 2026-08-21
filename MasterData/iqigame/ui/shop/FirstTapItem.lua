-- chunkname: @IQIGame\\UI\\Shop\\FirstTapItem.lua

local FirstTapItem = {
	Index = 0
}

function FirstTapItem.New(go, isRecommend)
	local o = Clone(FirstTapItem)

	o:Initialize(go, isRecommend)

	return o
end

function FirstTapItem:Initialize(go, isRecommend)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.isRecommend = isRecommend

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:SetSelect(false)
	self:SetRedDotState(false)
end

function FirstTapItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function FirstTapItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end
end

function FirstTapItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function FirstTapItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function FirstTapItem:OnButtonClick()
	self:SetSelect(true)
	EventDispatcher.Dispatch(EventID.ShopUIFirstTagClickEvent, self)
end

function FirstTapItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function FirstTapItem:SetSelect(isSelect)
	LuaUtility.SetGameObjectShow(self.PickState, isSelect)
	LuaUtility.SetGameObjectShow(self.CommonState, not isSelect)
end

function FirstTapItem:SetGameObjectName(name)
	self.gameObject.name = name
end

function FirstTapItem:SetIndex(index)
	self.Index = index
end

function FirstTapItem:Refresh(Data)
	self.Data = Data

	if self.isRecommend then
		-- block empty
	else
		UGUIUtil.SetText(self.textName, self.Data.TagName)
		UGUIUtil.SetText(self.GreyTextName, self.Data.TagName)
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.Data.NormaToggleImg), self.GreyTitleImg:GetComponent("Image"))
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.Data.CheckToggleImg), self.TitleImg1:GetComponent("Image"))
	end
end

function FirstTapItem:SetRedDotState(state)
	LuaUtility.SetGameObjectShow(self.RedDot, state)
end

function FirstTapItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return FirstTapItem
