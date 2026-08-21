-- chunkname: @IQIGame\\UI\\CommonTips\\Element\\TipsSourcesElement.lua

local __JumpItem = {}

function __JumpItem.New(view)
	local obj = Clone(__JumpItem)

	obj:__Init(view)

	return obj
end

function __JumpItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__gotoBtnClickProxy()
		self:__Jump()
	end

	self.gotoBtn:GetComponent("Button").onClick:AddListener(self.__gotoBtnClickProxy)
end

function __JumpItem:Hide()
	self.gameObject:SetActive(false)
end

function __JumpItem:Show(functionId)
	self.gameObject:SetActive(true)

	self.cfgData = CfgFunctionTable[functionId]

	if self.cfgData == nil then
		self:Hide()

		return
	end

	self:RefreshItemInfo()
end

function __JumpItem:RefreshItemInfo()
	local isOpen = true
	local title = ""

	title = self.cfgData.Name
	self.isOpen = JumpModule.CheckConditionIsPass(self.cfgData)
	self.approachText:GetComponent("Text").text = ItemTipsApi:GetItemColorTitle(self.isOpen, title)

	LuaUtility.SetGameObjectShow(self.onState, self.isOpen)
	LuaUtility.SetGameObjectShow(self.offState, not self.isOpen)
end

function __JumpItem:__Jump()
	if self.cfgData.SceneType == 0 and self.cfgData.FunctionType == 0 then
		return
	end

	JumpModule.Jump(self.cfgData.Id)
end

function __JumpItem:Dispose()
	self.cfgData = nil

	self.gotoBtn:GetComponent("Button").onClick:RemoveListener(self.__gotoBtnClickProxy)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

local TipsSourcesElement = {
	jumpItemTable = {}
}

TipsSourcesElement.JumpItem = __JumpItem

function TipsSourcesElement.New(view)
	local obj = Clone(TipsSourcesElement)

	obj:__Init(view)

	return obj
end

function TipsSourcesElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.ItemTemplate:SetActive(false)
	self:__AddListeners()
end

function TipsSourcesElement:__AddListeners()
	return
end

function TipsSourcesElement:__RemoveListeners()
	return
end

function TipsSourcesElement:Dispose()
	self:__RemoveListeners()
	self:__DisposeAllJumpItem()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TipsSourcesElement:Hide()
	self.gameObject:SetActive(false)
end

function TipsSourcesElement:Show(functionIds)
	if #functionIds == 0 then
		self:Hide()

		return
	end

	self:__HideAllJumpItem()

	for i = 1, #functionIds do
		local jumpItem = self:__GetFreeJumpItem()

		jumpItem:Show(functionIds[i])
	end

	self.gameObject:SetActive(true)
end

function TipsSourcesElement:__GetFreeJumpItem()
	for i = 1, #self.jumpItemTable do
		if not self.jumpItemTable[i].gameObject.activeSelf then
			return self.jumpItemTable[i]
		end
	end

	local itemObj = UnityEngine.Object.Instantiate(self.ItemTemplate)

	itemObj.transform:SetParent(self.ItemTemplate.transform.parent.transform, false)

	local jumpItem = self.JumpItem.New(itemObj)

	table.insert(self.jumpItemTable, jumpItem)

	return jumpItem
end

function TipsSourcesElement:__HideAllJumpItem()
	for i = 1, #self.jumpItemTable do
		self.jumpItemTable[i]:Hide()
	end
end

function TipsSourcesElement:__DisposeAllJumpItem()
	for i = 1, #self.jumpItemTable do
		self.jumpItemTable[i]:Dispose()
	end

	self.jumpItemTable = nil
end

return TipsSourcesElement
