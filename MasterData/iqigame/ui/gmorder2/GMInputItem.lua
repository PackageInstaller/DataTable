-- chunkname: @IQIGame\\UI\\GMOrder2\\GMInputItem.lua

GMInputItem = {}

function GMInputItem.New(go)
	local o = Clone(GMInputItem)

	o:Initialize(go)

	return o
end

function GMInputItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.transform = go.transform
	self.InputCallBack = nil

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GMInputItem:InitComponent()
	self.InputField = self.Input:GetComponent("IQIGame.Onigao.Game.UI.InputField")
end

function GMInputItem:InitDelegate()
	function self.Delegation_OnInputValueChanged()
		self:OnInputChange()
	end
end

function GMInputItem:AddListener()
	self.InputField.onValueChanged:AddListener(self.Delegation_OnInputValueChanged)
end

function GMInputItem:RemoveListener()
	self.InputField.onValueChanged:RemoveListener(self.Delegation_OnInputValueChanged)
end

function GMInputItem:OnInputChange()
	if self.InputCallBack then
		self:InputCallBack()
	end
end

function GMInputItem:RegisterInputChangeCallBack(callBack)
	self.InputCallBack = callBack
end

function GMInputItem:GetInputText()
	if self.InputField then
		return self.InputField.text
	end

	return nil
end

function GMInputItem:Refresh(Data, inputDefault)
	if Data then
		UGUIUtil.SetText(self.Name, Data)
	end

	if inputDefault then
		self.InputField.text = inputDefault
	end
end

function GMInputItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return GMInputItem
