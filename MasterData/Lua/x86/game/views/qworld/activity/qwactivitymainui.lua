ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local QWActivityMainUI = class("QWActivityMainUI", ActivityMainBasePanel)

function QWActivityMainUI:GetUIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_MainUI/SandPlay_MainUI"
end

local var_0_1 = {
	[10107] = {
		activityId = 313581,
		hint = 313641001
	},
	[10110] = {
		activityId = 311462,
		hint = 313641002
	}
}
local var_0_2 = 313581001

function QWActivityMainUI:isHasLeftTimeDes()
	return true
end

function QWActivityMainUI:OnEnter()
	QWActivityMainUI.super.OnEnter(self)
	self:AddEventListeners()
	self:UpdatePreview()
	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function QWActivityMainUI:OnExit()
	QWActivityMainUI.super.OnExit(self)
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function QWActivityMainUI:AddListeners()
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		for iter_6_0, iter_6_1 in pairs(var_0_1) do
			if (QWorldQuestTool.GetMainQuestStatus(iter_6_0) == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH or QWorldQuestTool.GetMainQuestStatus(iter_6_0) == QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS) and not getData("qworld", "main_view_quest_" .. iter_6_0) and ActivityData:GetActivityIsOpen(iter_6_1.activityId) then
				saveData("qworld", "main_view_quest_" .. iter_6_0, true)
			end
		end

		self:EnterQWorld()
	end)
	self:BindHelpBtn("ACTIVITY_SPRING_SANDPLAY_TIP_1")
end

function QWActivityMainUI:AddEventListeners()
	self:RegistEventListener(ACTIVITY_RED_ENVELOPE_NEW_DAY, function()
		self:RefreshUI()
	end)
end

function QWActivityMainUI:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

local function var_0_3()
	for iter_10_0, iter_10_1 in pairs(var_0_1) do
		if QWorldQuestTool.GetMainQuestStatus(iter_10_0) == QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS and not getData("qworld", "main_view_quest_" .. iter_10_0) and ActivityData:GetActivityIsOpen(iter_10_1.activityId) then
			return true, SandPlayHintCfg[iter_10_1.hint].desc, "TextureConfig/SandPlay/MiniIcon/" .. SandPlayHintCfg[iter_10_1.hint].icon
		end
	end

	if RedEnvelopeData:IsCanGetReward() and QWorldTools.CheckTagCanOpen(313581) then
		return true, SandPlayHintCfg[var_0_2].desc, "TextureConfig/SandPlay/MiniIcon/" .. SandPlayHintCfg[var_0_2].icon
	end

	return false
end

function QWActivityMainUI:RefreshUI()
	self.entrustBtnTxt_.text = GetTips("BATTLE_READY_2")

	local var_11_1, var_11_2, var_11_3 = var_0_3()

	self.activityIcon.spriteSync = var_11_3
	self.activityTxt_.text = var_11_2

	SetActive(self.hintRoot_, var_11_1)
end

function QWActivityMainUI:EnterQWorld()
	local var_12_0 = SandPlayMapCfg[QWorldMgr:GetActivityMap(self.activityID_)]
	local var_12_1 = var_12_0 and var_12_0.story_id

	if not (var_12_0 and var_12_0.story_id) or var_12_1 == 0 or manager.story:IsStoryPlayed(var_12_1) then
		LaunchQWorld(false, self.activityID_)
	else
		manager.story:StartStoryById(var_12_1, function()
			LaunchQWorld(false, self.activityID_)
		end)
	end
end

return QWActivityMainUI
