-- chunkname: @IQIGame\\UI\\GmOrderUI.lua

local GmOrderUI = {
	cfgDatas = {},
	itemList = {}
}

GmOrderUI = Base:Extend("GmOrderUI", "IQIGame.Onigao.UI.GmOrderUI", GmOrderUI)

local OptionData = UnityEngine.UI.Dropdown.OptionData

function GmOrderUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	self.DropDownMenu = self.DropDownMenu:GetComponent("Dropdown")

	function self.DelegateDropdownCallback(index)
		self:DropDownCallBack(index)
	end

	function self.DelegateCloseBtn()
		self:OnCloseBtnClick()
	end

	function self.DelegateSendBtn()
		self:SendBtnClick()
	end

	self.InfoInputField = self.ParamValue:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.cfgDatas = GmOrderModule.GmOrderCfgData
	self.ExecuteLuaButton = self.ExecuteLuaButton:GetComponent("UnityEngine.UI.Button")
	self.ExecuteLuaInputField = self.ExecuteLuaInputField:GetComponent("UnityEngine.UI.InputField")

	function self.DelegateExecuteLua()
		local f = _G.loadstring(self.ExecuteLuaInputField.text)

		f()
	end
end

function GmOrderUI:GetPreloadAssetPaths()
	return nil
end

function GmOrderUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GmOrderUI:IsManualShowOnOpen(userData)
	return false
end

function GmOrderUI:GetBGM(userData)
	return nil
end

function GmOrderUI:OnOpen(userData)
	self:InitOrder()
end

function GmOrderUI:OnClose(userData)
	return
end

function GmOrderUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.SureBtn:GetComponent("Button").onClick:AddListener(self.DelegateSendBtn)
	self.DropDownMenu.onValueChanged:AddListener(self.DelegateDropdownCallback)
	self.ExecuteLuaButton.onClick:AddListener(self.DelegateExecuteLua)
end

function GmOrderUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.SureBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSendBtn)
	self.DropDownMenu.onValueChanged:RemoveListener(self.DelegateDropdownCallback)
	self.ExecuteLuaButton.onClick:RemoveListener(self.DelegateExecuteLua)
end

function GmOrderUI:OnPause()
	return
end

function GmOrderUI:OnResume()
	return
end

function GmOrderUI:OnCover()
	return
end

function GmOrderUI:OnReveal()
	return
end

function GmOrderUI:OnRefocus(userData)
	return
end

function GmOrderUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GmOrderUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GmOrderUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GmOrderUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GmOrderUI:OnDestroy()
	self.itemList = nil
end

function GmOrderUI:OnCloseBtnClick()
	UIModule.CloseSelf(self)
end

function GmOrderUI:InitOrder()
	self.DropDownMenu:ClearOptions()

	for i = 1, #self.cfgDatas do
		self:CreateDropdown(self.cfgDatas[i])
	end

	self.DropDownMenu.value = 0

	self.DropDownMenu:Select()

	self.DropDownMenu.captionText.text = self.itemList[1].Name .. self.itemList[1].Order
	self.dropdownText = self.itemList[1].Order
	self.curParam = self.itemList[1].ParamNum

	if self.curParam == nil or self.curParam <= 0 then
		self.ItemId.gameObject:SetActive(false)
		self.InfoInputField.gameObject:SetActive(false)
	else
		self.ItemId.gameObject:SetActive(true)
		self.InfoInputField.gameObject:SetActive(true)
		UGUIUtil.SetText(self.ItemId, self.itemList[1].Describe)
	end
end

function GmOrderUI:SendBtnClick()
	if self.InfoInputField.gameObject.activeSelf then
		local InputContent = self.InfoInputField.text
		local ArrayContent = self:Split(InputContent, " ")
		local ArrayLen = #ArrayContent

		if self.InfoInputField.text == nil or self.InfoInputField.text == "" or ArrayLen < self.curParam then
			NoticeModule.ShowNotice(10009)

			return
		end
	end

	local index = string.find(self.dropdownText, "/", 1)
	local len = string.len(self.dropdownText)
	local subString = string.sub(self.dropdownText, index, len)
	local CChatPOD = {}

	CChatPOD.channel = 3
	CChatPOD.type = 1
	CChatPOD.target = ""

	if self.curParam > 0 then
		CChatPOD.content = tostring(subString .. " " .. self.InfoInputField.text)
	else
		CChatPOD.content = tostring(subString)
	end

	self.InfoInputField.text = ""

	net_centerChat.sendChat(CChatPOD)
	NoticeModule.ShowNotice(14008)
end

function GmOrderUI:CreateDropdown(cfgData)
	local data = OptionData.New(cfgData.Name .. cfgData.Order)

	data.text = cfgData.Name .. cfgData.Order

	self.DropDownMenu.options:Add(data)
	table.insert(self.itemList, cfgData)
end

function GmOrderUI:DropDownCallBack(index)
	self.dropdownText = self.itemList[index + 1].Order
	self.curParam = self.itemList[index + 1].ParamNum

	if self.curParam == nil or self.curParam <= 0 then
		self.ItemId.gameObject:SetActive(false)
		self.InfoInputField.gameObject:SetActive(false)
	else
		self.ItemId.gameObject:SetActive(true)
		self.InfoInputField.gameObject:SetActive(true)
		UGUIUtil.SetText(self.ItemId, self.itemList[index + 1].Describe)
	end
end

function GmOrderUI:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}

	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)

		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))

			break
		end

		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end

	return nSplitArray
end

return GmOrderUI
