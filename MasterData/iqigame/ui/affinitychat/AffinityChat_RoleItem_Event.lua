-- chunkname: @IQIGame\\UI\\AffinityChat\\AffinityChat_RoleItem_Event.lua

local AffinityChat_RoleItem_Event = {}
local dataName_eventItem = "eventItem"
local stateName_selected = "selected"
local stateName_unSelected = "unSelected"

function AffinityChat_RoleItem_Event.New(go, mainView)
	local o = Clone(AffinityChat_RoleItem_Event)

	o:Initialize(go, mainView)

	return o
end

function AffinityChat_RoleItem_Event:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AffinityChat_RoleItem_Event:InitComponent()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function AffinityChat_RoleItem_Event:InitDelegate()
	return
end

function AffinityChat_RoleItem_Event:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function AffinityChat_RoleItem_Event:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function AffinityChat_RoleItem_Event:OnClickButtonClick()
	self.mainView:OnEventClick(self)
end

function AffinityChat_RoleItem_Event:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AffinityChat_RoleItem_Event:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AffinityChat_RoleItem_Event:GetActive()
	return self.gameObject.activeSelf
end

function AffinityChat_RoleItem_Event:Selected()
	LuaUtility.SetStateController(self.gameObject, dataName_eventItem, stateName_selected)
end

function AffinityChat_RoleItem_Event:UnSelected()
	LuaUtility.SetStateController(self.gameObject, dataName_eventItem, stateName_unSelected)
end

function AffinityChat_RoleItem_Event:OnDestroy()
	self:RemoveListener()
end

function AffinityChat_RoleItem_Event:Refresh(Data, index, isNew, isPlayAni)
	self.data = Data
	self.index = index

	local cfgGroupData = CfgUtil.GetCfgFavorMessageGroupDataWithID(self.data.cid)

	if not LuaUtility.StrIsNullOrEmpty(cfgGroupData.Icon) then
		LuaUtility.LoadImage(self, cfgGroupData.Icon, self.imageIcon:GetComponent("Image"))
	end

	LuaUtility.SetText(self.textName, cfgGroupData.Name)
	self:UnSelected()
	self:RefreshNew(isNew)

	if isPlayAni then
		LuaUtility.PlayAnimation(self.gameObject, "eventItem")
	end
end

function AffinityChat_RoleItem_Event:RefreshNew(isNew)
	LuaUtility.SetGameObjectShow(self.newsImg, isNew)
end

return AffinityChat_RoleItem_Event
