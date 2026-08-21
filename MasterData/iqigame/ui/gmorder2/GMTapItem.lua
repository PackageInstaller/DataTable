-- chunkname: @IQIGame\\UI\\GMOrder2\\GMTapItem.lua

local GMTapItem = {}

function GMTapItem.New(index, go, isFathe)
	local o = Clone(GMTapItem)

	o:Initialize(index, go, isFathe)

	return o
end

function GMTapItem:Initialize(index, go, isFather)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.transform = go.transform
	self.data = nil
	self.isFather = isFather
	self.index = index

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:SetSelect(false)
end

function GMTapItem:InitComponent()
	self.Btn = self.gameObject:GetComponent("Button")

	LuaUtility.SetGameObjectShow(self.GrayState, true)
	LuaUtility.SetGameObjectShow(self.Checkmark, false)
end

function GMTapItem:InitDelegate()
	function self.OnClickDelegate()
		self:_OnClick()
	end
end

function GMTapItem:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GMTapItem:AddListener()
	self.Btn.onClick:AddListener(self.OnClickDelegate)
end

function GMTapItem:RemoveListener()
	self.Btn.onClick:RemoveListener(self.OnClickDelegate)
end

function GMTapItem:Refresh(Data)
	self.data = Data

	if Data.Name ~= "" then
		UGUIUtil.SetText(self.GrayText, Data.Name)
		UGUIUtil.SetText(self.CheckText, Data.Name)
	else
		UGUIUtil.SetText(self.Name, tostring(Data.ID))
	end
end

function GMTapItem:_OnClick()
	self:SetSelect(true)
	EventDispatcher.Dispatch(EventID.GMTapClick, self.isFather, self)
end

function GMTapItem:SetSelect(show)
	LuaUtility.SetGameObjectShow(self.GrayState, not show)
	LuaUtility.SetGameObjectShow(self.Checkmark, show)
end

return GMTapItem
