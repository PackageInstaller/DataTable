-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_stagePanel_stageItem.lua

local ActivityStageUI_stagePanel_stageItem = {}

function ActivityStageUI_stagePanel_stageItem.New(go, mainView)
	local o = Clone(ActivityStageUI_stagePanel_stageItem)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_stagePanel_stageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityStageUI_stagePanel_stageItem:InitComponent()
	self.startsComponent = self.starts:GetComponent("StartsHelperComponent")
end

function ActivityStageUI_stagePanel_stageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ActivityStageUI_stagePanel_stageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ActivityStageUI_stagePanel_stageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ActivityStageUI_stagePanel_stageItem:OnClickButtonClick()
	if not self.isUnLock then
		NoticeModule.ShowNotice(49005)

		return
	end

	self.mainView:SelectStage(self)
end

function ActivityStageUI_stagePanel_stageItem:Selected()
	LuaUtility.SetGameObjectShow(self.imageSelect, true)
end

function ActivityStageUI_stagePanel_stageItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.imageSelect, false)
end

function ActivityStageUI_stagePanel_stageItem:OnDestroy()
	return
end

function ActivityStageUI_stagePanel_stageItem:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textName, self.data.Name)
	self.startsComponent:Refresh(self.mainView:GetPassStart(self.data.Id), #self.data.ChallengeDesc)
	self:UnSelected()

	self.isUnLock = true

	if self.data.UnlockConditionId and self.data.UnlockConditionId[1] then
		self.isUnLock = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.data.UnlockConditionId))

		local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.UnlockConditionId[1])

		LuaUtility.SetText(self.textLock, cfgCondition.Name)
	end

	LuaUtility.SetGameObjectShow(self.lockRoot, not self.isUnLock)
end

return ActivityStageUI_stagePanel_stageItem
