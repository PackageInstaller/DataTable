-- chunkname: @IQIGame\\UI\\Story\\DialogueSelectPanelSelectItem.lua

local DialogueSelectPanelSelectItem = {}

function DialogueSelectPanelSelectItem.New(go, mainView)
	local o = Clone(DialogueSelectPanelSelectItem)

	o:Initialize(go, mainView)

	return o
end

function DialogueSelectPanelSelectItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.objectParent = self.gameObject.transform.parent.gameObject

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DialogueSelectPanelSelectItem:InitComponent()
	return
end

function DialogueSelectPanelSelectItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClickClick()
	end
end

function DialogueSelectPanelSelectItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.buttonClickDelegate)
end

function DialogueSelectPanelSelectItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.buttonClickDelegate)
end

function DialogueSelectPanelSelectItem:OnButtonClickClick()
	if self.mainView.isPlayingSelectAnimation then
		return
	end

	LuaUtility.PlayAnimation(self.objectParent, "selectContent_Get", nil, function()
		self.mainView:OnOptionClick(self.optionID)
		self.mainView:Close()

		self.mainView.isPlayingSelectAnimation = false
	end)
	self.mainView:PlayHideSelectAnimation(self.optionID)
	StoryUIApi:PlayClickOptionSound()
end

function DialogueSelectPanelSelectItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DialogueSelectPanelSelectItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DialogueSelectPanelSelectItem:ResetView()
	self:SetComplete(false)
end

function DialogueSelectPanelSelectItem:Refresh(optionID, cfgOptionID)
	self:ResetView()

	self.optionID = optionID

	LuaUtility.SetText(self.textOption, CfgUtil.GetCfgStoryTextDataWithID(optionID))

	if StoryModule.CheckOptionHadTrigger(cfgOptionID, optionID) then
		self:SetComplete(true)
	end
end

function DialogueSelectPanelSelectItem:SetComplete(isComplete)
	LuaUtility.SetGameObjectShow(self.objectHadSelected, isComplete)

	self.isComplete = isComplete
end

function DialogueSelectPanelSelectItem:PlayHideAnimation(completeEvent)
	LuaUtility.PlayAnimation(self.objectParent, "selectContent_Out2", nil, completeEvent)
end

return DialogueSelectPanelSelectItem
