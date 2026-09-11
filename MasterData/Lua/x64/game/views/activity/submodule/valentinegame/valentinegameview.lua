local ValentineGameView = class("ValentineGameView", ReduxView)

function ValentineGameView:UIName()
	return ValentineGameTools.GetGameUIName(self.params_.mainActivityID)
end

function ValentineGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameView:InitUI()
	self:BindCfgUI()

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(ActivityCfg[self.params_.mainActivityID].sub_activity_list) do
		for iter_4_2, iter_4_3 in ipairs(ActivityValentineCfg[iter_4_1].qa_id) do
			var_4_0 = var_4_0 < #ActivityValentineWordCfg[iter_4_3].answer_desc and #ActivityValentineWordCfg[iter_4_3].answer_desc or var_4_0
		end
	end

	self.choose_ = {}
	self.chooseText_ = {}
	self.chooseName_ = {}
	self.chooseCanvasGroup_ = {}
	self.selfCon_ = {}
	self.otherCon_ = {}
	self.chooseCon_ = {}

	for iter_4_4 = 1, var_4_0 do
		self.choose_[iter_4_4] = self["choose_" .. iter_4_4]
		self.chooseText_[iter_4_4] = self["chooseText_" .. iter_4_4]
		self.chooseName_[iter_4_4] = self["chooseName_" .. iter_4_4]
		self.chooseCanvasGroup_[iter_4_4] = self["chooseCanvasGroup_" .. iter_4_4]
		self.selfCon_[iter_4_4] = ControllerUtil.GetController(self.choose_[iter_4_4].transform, "self")
		self.otherCon_[iter_4_4] = ControllerUtil.GetController(self.choose_[iter_4_4].transform, "other")
		self.chooseCon_[iter_4_4] = ControllerUtil.GetController(self.choose_[iter_4_4].transform, "choosing")
	end

	self.indexCon_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.stateCon_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.btnstateCon_ = ControllerUtil.GetController(self.gameObject_.transform, "btn")
end

function ValentineGameView:AddUIListeners()
	for iter_5_0, iter_5_1 in ipairs(self.choose_) do
		self:AddBtnListener(self.choose_[iter_5_0], nil, function()
			if self.curChoose_ ~= 0 then
				return
			end

			local var_6_0 = ActivityValentineCfg[self.activityID_].qa_id[self.curIndex_]

			SDKTools.SendMessageToSDK("activity_valentine_opt", {
				question_id = ActivityValentineCfg[self.activityID_].qa_id[self.curIndex_],
				answer_id = iter_5_0,
				activity_id = self.activityID_
			})

			if ActivityValentineWordCfg[var_6_0].correct_answer == iter_5_0 then
				self.correctCount_ = self.correctCount_ + 1
			end

			if self.curIndex_ >= #self.list_ then
				SDKTools.SendMessageToSDK("activity_valentine_over", {
					activity_id = self.correctCount_
				})
			end

			self.curChoose_ = iter_5_0

			self.selfCon_[iter_5_0]:SetSelectedState("true")
			self:StopTimer()
			self:Update()
		end)
	end

	self:AddBtnListener(self.nextBtn_, nil, function()
		self.curIndex_ = self.curIndex_ + 1

		self:Refresh()
	end)
	self:AddBtnListener(self.resultBtn_, nil, function()
		local var_8_0 = manager.time:GetServerTime()
		local var_8_1 = ActivityData:GetActivityData(self.mainActivityID_)

		if var_8_0 < var_8_1.startTime or var_8_0 >= var_8_1.stopTime then
			ShowTips("TIME_OVER")
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = self.mainActivityID_
			})

			return
		end

		ValentineGameAction:SetPoint(self.activityID_, self.count_)
	end)
end

function ValentineGameView:OnEnter()
	self.count_ = 0
	self.curIndex_ = 1
	self.activityID_ = self.params_.activityID
	self.mainActivityID_ = self.params_.mainActivityID
	self.correctCount_ = 0

	self:RefreshUI()
end

function ValentineGameView:RefreshUI()
	self.cfg_ = ActivityValentineCfg[self.activityID_]

	self.indexCon_:SetSelectedState(table.indexof(ActivityCfg[self.params_.mainActivityID].sub_activity_list, self.activityID_))

	self.name_.text = GetI18NText(self.cfg_.name)
	self.list_ = self.cfg_.qa_id

	for iter_10_0 = 1, #self.chooseName_ do
		self.chooseName_[iter_10_0].text = GetI18NText(self.cfg_.name)
	end

	self:Refresh()
end

function ValentineGameView:Refresh()
	self:Reset()
	self:RefreshTimer()
end

function ValentineGameView:Reset()
	self.curChoose_ = 0
	self.curAnsCfg_ = ActivityValentineWordCfg[self.list_[self.curIndex_]]

	for iter_12_0 = 1, #self.curAnsCfg_.answer_desc do
		self.selfCon_[iter_12_0]:SetSelectedState("false")
		self.otherCon_[iter_12_0]:SetSelectedState("false")
		self.chooseCon_[iter_12_0]:SetSelectedState("false")

		self.chooseCanvasGroup_[iter_12_0].alpha = 1
		self.chooseText_[iter_12_0].text = self.curAnsCfg_.answer_desc[iter_12_0] == "<nickname>" and GetI18NText(PlayerData:GetPlayerInfo().nick) or GetI18NText(self.curAnsCfg_.answer_desc[iter_12_0])

		SetActive(self.choose_[iter_12_0].gameObject, true)
	end

	for iter_12_1 = #self.curAnsCfg_.answer_desc + 1, #self.choose_ do
		SetActive(self.choose_[iter_12_1].gameObject, false)
	end

	self.title_.text = GetTips("TIP_QUESTION") .. GetTips("NUM_" .. self.curIndex_)
	self.desc_.text = GetI18NText(self.curAnsCfg_.question_desc)

	self.btnstateCon_:SetSelectedState("wait")
end

function ValentineGameView:RefreshTimer()
	self.think_.text = GetTips("TIP_SELECTING") .. "..."

	self.stateCon_:SetSelectedState("choosing")

	local var_13_0 = math.random(3, 6)
	local var_13_1 = 0

	self.timer_ = Timer.New(function()
		if var_13_1 < var_13_0 then
			var_13_1 = var_13_1 + 1
			self.think_.text = var_13_1 % 3 == 1 and GetTips("TIP_SELECTING") .. "." or var_13_1 % 3 == 2 and GetTips("TIP_SELECTING") .. ".." or GetTips("TIP_SELECTING") .. "..."
		else
			self.think_.text = GetTips("TIP_SELECT_OVER")

			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ValentineGameView:Update()
	self.otherCon_[self.curAnsCfg_.correct_answer]:SetSelectedState("true")

	self.ans_.text = GetI18NText(self.curAnsCfg_.hero_comment[self.curChoose_])

	self.stateCon_:SetSelectedState("result")

	for iter_15_0 = 1, #self.curAnsCfg_.answer_desc do
		if iter_15_0 ~= self.curAnsCfg_.correct_answer and iter_15_0 ~= self.curChoose_ then
			self.chooseCanvasGroup_[iter_15_0].alpha = 0.4
		end
	end

	if self.curChoose_ == self.curAnsCfg_.correct_answer then
		self.count_ = self.count_ + 1
	end

	if self.curIndex_ < #self.list_ then
		self.btnstateCon_:SetSelectedState("next")
	else
		self.btnstateCon_:SetSelectedState("result")
	end
end

function ValentineGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameView:OnValentineResult()
	JumpTools.OpenPageByJump("/valentineResult", {
		mainActivityID = self.params_.mainActivityID,
		activityID = self.params_.activityID,
		point = self.count_
	})
end

function ValentineGameView:OnTop()
	manager.windowBar:HideBar()
end

function ValentineGameView:OnExit()
	self:StopTimer()
end

function ValentineGameView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ValentineGameView
