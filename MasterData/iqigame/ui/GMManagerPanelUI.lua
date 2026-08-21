-- chunkname: @IQIGame\\UI\\GMManagerPanelUI.lua

local GMManagerPanelUI = {}

GMManagerPanelUI = Base:Extend("GMManagerPanelUI", "IQIGame.Onigao.UI.GMManagerPanelUI", GMManagerPanelUI)

function GMManagerPanelUI:OnInit()
	self:InitDelegate()
	self:InitComponent()
end

function GMManagerPanelUI:InitComponent()
	self.ToggleStoryGM = self.ToggleStoryGM.transform:Find("Toggle"):GetComponent("Toggle")
	self.ToggleHideUI = self.ToggleHideUI.transform:Find("Toggle"):GetComponent("Toggle")
	self.TestPackToggleCom = self.TestPackItem.transform:Find("Toggle"):GetComponent("Toggle")
end

function GMManagerPanelUI:InitDelegate()
	function self.DelegateClostBtn()
		UIModule.CloseSelf(self)
	end

	function self.DelegateGMItemToggle(ison)
		self:GMToggleChanged(ison)
	end

	function self.DelegateGuideItemToggle(ison)
		self:GuideToggleChaged(ison)
	end

	function self.DelegateChangeHotFixUrlItem(ison)
		self:HotFixUrlChangeItem(ison)
	end

	function self.DelegateOpenInspector(isOn)
		self:OpenInspectorToggleChanged(isOn)
	end

	function self.StoryGMDelegate(isOn)
		self:StoryGMToggle(isOn)
	end

	function self.hideUIDelegate(isOn)
		self:HideUI(isOn)
	end

	function self.DelegateHideTestTitle(isOn)
		self:HideTestTitleToggleChanged(isOn)
	end

	function self.DelegateOnClickCrashBtn()
		self:OnClickCrashBtn()
	end

	function self.delegateOnClickButtonClearSimpleGuide()
		PlayerPrefsUtil.DeleteKey("", Constant.PlayerPrefsConst.SimpleGuideRecord)
		PlayerPrefsUtil.Save()
	end

	function self.delegateOnClickButtonClearChallengeTip()
		PlayerPrefsUtil.DeleteKey("", Constant.PlayerPrefsConst.ChallengeTipData)
		PlayerPrefsUtil.Save()
	end

	function self.playerPosGMDelegate(isOn)
		PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.PlayerPosShow, tostring(isOn))
		PlayerPrefsUtil.Save()
	end

	function self.CVContinuousDelegate(isOn)
		PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.CVContinuous, tostring(isOn))
		PlayerPrefsUtil.Save()
	end

	function self.delegateOnClickTestPack(isOn)
		PlayerPrefsUtil.SetString("GM", Constant.PlayerPrefsConst.Key_Change_To_Test_Pack, tostring(isOn))
		PlayerPrefsUtil.Save()
	end
end

function GMManagerPanelUI:GetPreloadAssetPaths()
	return nil
end

function GMManagerPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GMManagerPanelUI:IsManualShowOnOpen(userData)
	return false
end

function GMManagerPanelUI:GetBGM(userData)
	return nil
end

function GMManagerPanelUI:OnOpen(userData)
	PlayerModule.disableGuide = PlayerPrefsUtil.GetString("", "OpenGuidePrefs") == "true"
	PlayerModule.GMToggle = PlayerPrefsUtil.GetString("", "OpenGMPrefs") == "true"
	PlayerModule.isOpenInspector = PlayerPrefsUtil.GetString("", "OpenInspectorPrefs") == "true"
	self.GuideItem.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", "OpenGuidePrefs") == "true"
	self.HotFixUrltem.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", "ChangeHotFixUrlPrefs") == "true"
	self.GMItem.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", "OpenGMPrefs") == "true"
	self.OpenInspector.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerModule.isOpenInspector
	self.ToggleStoryGM.isOn = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.StoryMultipleSpeed) == "true"
	self.ToggleHideUI.isOn = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.HideUIControl) == "true"
	self.DonotDisplayUID.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", "HideTestTitle") == "true"
	self.TogglePlayerPos.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.PlayerPosShow) == "true"
	self.ToggleCVContinuous.transform:Find("Toggle"):GetComponent("Toggle").isOn = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.CVContinuous) == "true"
	self.TestPackToggleCom.isOn = PlayerPrefsUtil.GetString("GM", Constant.PlayerPrefsConst.Key_Change_To_Test_Pack, "false") == "true"

	local inspectorParent = GameObject.Find("Inspector")

	if inspectorParent then
		self.inspectorObj = inspectorParent.transform:Find("InspectorCanvas")

		if self.inspectorObj then
			self.inspectorObj.gameObject:SetActive(PlayerModule.isOpenInspector)
		end
	end
end

function GMManagerPanelUI:OnClose(userData)
	return
end

function GMManagerPanelUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateClostBtn)
	self.GuideItem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.DelegateGuideItemToggle)
	self.GMItem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.DelegateGMItemToggle)
	self.HotFixUrltem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.DelegateChangeHotFixUrlItem)
	self.OpenInspector.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOpenInspector)
	self.DonotDisplayUID.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.DelegateHideTestTitle)
	self.TogglePlayerPos.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.playerPosGMDelegate)
	self.ToggleCVContinuous.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:AddListener(self.CVContinuousDelegate)
	self.ToggleStoryGM.onValueChanged:AddListener(self.StoryGMDelegate)
	self.ToggleHideUI.onValueChanged:AddListener(self.hideUIDelegate)
	self.CrashButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCrashBtn)
	self.buttonClearSimpleGuide:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClearSimpleGuide)
	self.buttonClearChallengeTip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClearChallengeTip)
	self.TestPackToggleCom.onValueChanged:AddListener(self.delegateOnClickTestPack)
end

function GMManagerPanelUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClostBtn)
	self.GuideItem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateGuideItemToggle)
	self.GMItem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateGMItemToggle)
	self.HotFixUrltem.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateChangeHotFixUrlItem)
	self.OpenInspector.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOpenInspector)
	self.DonotDisplayUID.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateHideTestTitle)
	self.TogglePlayerPos.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.playerPosGMDelegate)
	self.ToggleCVContinuous.transform:Find("Toggle"):GetComponent("Toggle").onValueChanged:RemoveListener(self.CVContinuousDelegate)
	self.ToggleStoryGM.onValueChanged:RemoveListener(self.StoryGMDelegate)
	self.ToggleHideUI.onValueChanged:RemoveListener(self.hideUIDelegate)
	self.CrashButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCrashBtn)
	self.buttonClearSimpleGuide:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClearSimpleGuide)
	self.buttonClearChallengeTip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClearChallengeTip)
	self.TestPackToggleCom.onValueChanged:RemoveListener(self.delegateOnClickTestPack)
end

function GMManagerPanelUI:OnPause()
	return
end

function GMManagerPanelUI:OnResume()
	return
end

function GMManagerPanelUI:OnCover()
	return
end

function GMManagerPanelUI:OnReveal()
	return
end

function GMManagerPanelUI:OnRefocus(userData)
	return
end

function GMManagerPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GMManagerPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GMManagerPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GMManagerPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GMManagerPanelUI:OnDestroy()
	self.TestPackToggleCom = nil
end

function GMManagerPanelUI:GMToggleChanged(ison)
	PlayerModule.GMToggle = ison

	PlayerPrefsUtil.SetString("", "OpenGMPrefs", tostring(ison))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:GuideToggleChaged(ison)
	PlayerModule.disableGuide = ison

	PlayerPrefsUtil.SetString("", "OpenGuidePrefs", tostring(ison))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:HotFixUrlChangeItem(ison)
	PlayerPrefsUtil.SetString("", "ChangeHotFixUrlPrefs", tostring(ison))
	PlayerPrefsUtil.Save()

	if ison then
		UGUIUtil.SetText(self.CurHotFixUrl, GameEntry.ProjectSetting.BuildInfo.GameUpdateUrl)
	else
		UGUIUtil.SetText(self.CurHotFixUrl, "非SDK模式")
	end
end

function GMManagerPanelUI:OpenInspectorToggleChanged(isOn)
	if self.inspectorObj ~= nil then
		self.inspectorObj.gameObject:SetActive(isOn)
	else
		isOn = false
	end

	PlayerModule.isOpenInspector = isOn

	PlayerPrefsUtil.SetString("", "OpenInspectorPrefs", tostring(isOn))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:HideTestTitleToggleChanged(isOn)
	PlayerModule.HideTestTitle = isOn

	local gameObject = GameObject.Find("UIDShowRoot")

	if gameObject ~= nil then
		LuaUtility.SetGameObjectShow(gameObject, not isOn)
	end

	PlayerPrefsUtil.SetString("", "HideTestTitle", tostring(isOn))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:StoryGMToggle(isOn)
	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.StoryMultipleSpeed, tostring(isOn))
	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.StoryGMFight, tostring(isOn))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:HideUI(isOn)
	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.HideUIControl, tostring(isOn))
	PlayerPrefsUtil.Save()
end

function GMManagerPanelUI:OnClickCrashBtn()
	return
end

return GMManagerPanelUI
