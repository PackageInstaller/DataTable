local ActivityMatrixStoryReviewView = class("ActivityMatrixStoryReviewView", ReduxView)

function ActivityMatrixStoryReviewView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeStoryReviewUI"
end

function ActivityMatrixStoryReviewView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixStoryReviewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixStoryReviewView:InitUI()
	self:BindCfgUI()

	self.storyItems = {}
	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
end

function ActivityMatrixStoryReviewView:AddUIListener()
	return
end

function ActivityMatrixStoryReviewView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityMatrixStoryReviewView:OnEnter()
	local var_7_0

	if ActivityStoryCollect[ActivityConst.VOLUME_MATRIX] then
		var_7_0 = ActivityStoryCollect[ActivityConst.VOLUME_MATRIX].story_id or {}
	end

	self.storyList = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if manager.story:IsStoryPlayed(iter_7_1) then
			table.insert(self.storyList, iter_7_1)
		end
	end

	self:Refresh()
end

function ActivityMatrixStoryReviewView:Refresh()
	for iter_8_0 = 1, #self.storyList do
		self.storyItems[iter_8_0] = self.storyItems[iter_8_0] or ActivityMatrixStoryReviewItem.New((Object.Instantiate(self.m_item, self.m_content)))

		self.storyItems[iter_8_0]:SetData(self.storyList[iter_8_0])
		self.storyItems[iter_8_0]:SetActive(true)
	end

	for iter_8_1 = #self.storyList + 1, #self.storyItems do
		self.storyItems[iter_8_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	if #self.storyList == 0 then
		self.emptyController:SetSelectedIndex(1)
	else
		self.emptyController:SetSelectedIndex(0)
	end
end

function ActivityMatrixStoryReviewView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityMatrixStoryReviewView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.storyItems) do
		iter_10_1:Dispose()
	end

	self.storyItems = {}

	ActivityMatrixStoryReviewView.super.Dispose(self)
end

return ActivityMatrixStoryReviewView
