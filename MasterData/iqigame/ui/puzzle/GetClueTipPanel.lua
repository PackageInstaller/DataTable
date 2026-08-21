-- chunkname: @IQIGame\\UI\\Puzzle\\GetClueTipPanel.lua

local GetClueTipPanel = {}

function GetClueTipPanel.New(go, mainView)
	local o = Clone(GetClueTipPanel)

	o:Initialize(go, mainView)

	return o
end

function GetClueTipPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GetClueTipPanel:InitComponent()
	self.clueImg = self.clueImg:GetComponent("Image")
end

function GetClueTipPanel:InitDelegate()
	function self.delegateOnClickButtonMask()
		self:OnClickButtonMask()
	end
end

function GetClueTipPanel:AddListener()
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMask)
end

function GetClueTipPanel:RemoveListener()
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMask)
end

function GetClueTipPanel:OnClickButtonMask()
	if self.OnConfirmCallBack then
		self.OnConfirmCallBack()

		self.OnConfirmCallBack = nil
	end

	self:Close()
end

function GetClueTipPanel:OnDestroy()
	return
end

function GetClueTipPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GetClueTipPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GetClueTipPanel:Refresh(clueID, onConfirmCallBack)
	self.OnConfirmCallBack = onConfirmCallBack

	local cfg = CfgUtil.GetCfgCluesDataWithID(clueID)

	LuaUtility.LoadImage(self, cfg.Icon, self.clueImg)
	LuaUtility.SetText(self.nameText, cfg.CluesName)
	LuaUtility.SetText(self.descText, cfg.Des)
end

return GetClueTipPanel
