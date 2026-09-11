ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SkuldActivityMainView = class("SkuldActivityMainView", ActivityMainBasePanel)
local var_0_2 = 1011243

function SkuldActivityMainView:GetUIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_EntranceUI"
end

function SkuldActivityMainView:Init()
	SkuldActivityMainView.super.Init(self)
end

function SkuldActivityMainView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if SkuldSystemData:GetClientKey("IsShowEmptyDreamPop") or BattleStageData:GetStageClearTimes(var_0_2) > 0 then
			JumpTools.OpenPageByJump("/skuldSystemEnterView")
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SKULD_PRE_CHAPTER"),
				OkCallback = function()
					SkuldSystemAction.SendMark("IsShowEmptyDreamPop")
					JumpTools.OpenPageByJump("/skuldSystemEnterView")
				end
			})
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			JumpTools.OpenPageByJump("/skuldSystemTaskView")
		else
			local var_6_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

			if manager.time:GetServerTime() < var_6_0.startTime then
				ShowTips(string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_6_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end
	end)
	self:AddBtnListener(self.emptyDreamBtn_, nil, function()
		JumpTools.JumpToPage({
			309,
			12112
		})
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("SKULD_SYSTEM_TIPS_1")
		})
	end)
end

function SkuldActivityMainView:OnEnter()
	SkuldActivityMainView.super.OnEnter(self)
	self:UpdatePreview()

	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		SetActive(self.taskGo_, true)

		self.timeLable_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	elseif manager.time:GetServerTime() < var_9_0.startTime then
		SetActive(self.taskGo_, false)
	elseif manager.time:GetServerTime() > var_9_0.stopTime then
		SetActive(self.taskGo_, false)
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				SetActive(self.taskGo_, true)

				self.timeLable_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
			elseif manager.time:GetServerTime() < var_9_0.startTime then
				SetActive(self.taskGo_, false)
			elseif manager.time:GetServerTime() > var_9_0.stopTime then
				SetActive(self.taskGo_, false)
			end
		end, 1, -1)
	end

	self.timer_:Start()

	local var_9_1 = 0
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM].chapter_list) do
		for iter_9_2, iter_9_3 in pairs(ChapterCfg[iter_9_1].section_id_list) do
			table.insert(var_9_2, iter_9_3)

			if BattleStageData:GetStageClearTimes(iter_9_3) > 0 then
				var_9_1 = var_9_1 + 1
			end
		end
	end

	self.emptyDreamFillText_.text = math.floor(var_9_1 / #var_9_2 * 100) .. "%"
	self.emptyDreamFillImage_.fillAmount = var_9_1 / #var_9_2
	self.desText_.text = GetTips("SKULD_ACTIVITY_DES")
	self.btnText_.text = GetTips("SKULD_ACTIVITY_MAINVIEW_BTN")

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK)
	manager.redPoint:bindUIandKey(self.btn_.transform, RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN)
end

function SkuldActivityMainView:OnExit()
	self:StopTimer()
	SkuldActivityMainView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK)
	manager.redPoint:unbindUIandKey(self.btn_.transform, RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN)
end

function SkuldActivityMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldActivityMainView:isHasLeftTimeDes()
	return true
end

function SkuldActivityMainView:Dispose()
	self:StopTimer()
	self.super.Dispose(self)
end

return SkuldActivityMainView
