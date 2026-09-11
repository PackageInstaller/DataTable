local ValentineGameV2PlayerAnswerView = class("ValentineGameV2PlayerAnswerView", ReduxView)

function ValentineGameV2PlayerAnswerView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame2UI"
end

function ValentineGameV2PlayerAnswerView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2PlayerAnswerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV2PlayerAnswerView:InitUI()
	self:BindCfgUI()
end

function ValentineGameV2PlayerAnswerView:AddUIListener()
	for iter_5_0 = 1, 2 do
		self:AddBtnListener(self["chooseBtn" .. iter_5_0 .. "_"], nil, function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				ValentineGameData:CacheRandomQID(self.curQID_)
				ValentineGameAction:SetPoint(self.activityID_, 0, function()
					SDKTools.SendMessageToSDK("activity_valentine_opt", {
						question_id = self.curQID_,
						answer_id = iter_5_0,
						activity_id = self.activityID_
					})
					JumpTools.OpenPageByJump("/valentineGameV2ResultView", {
						activityID = self.activityID_,
						qID = self.curQID_,
						selectIndex = iter_5_0
					})
				end)
			elseif manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime))))
			else
				ShowTips(GetTips("TIME_OVER"))
			end
		end)
	end
end

function ValentineGameV2PlayerAnswerView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.cfg_ = ActivityValentineCfg[self.activityID_]

	local var_8_0 = ValentineGameData:GetData(self.activityID_) and ValentineGameData:GetData(self.activityID_).answerQuestionID or {}

	if #self.cfg_.qa_id == #var_8_0 then
		var_8_0 = {}

		ValentineGameData:ClearReadedQID(self.activityID_)
	end

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(self.cfg_.qa_id) do
		if table.indexof(var_8_0, iter_8_1) == false then
			table.insert(var_8_1, iter_8_1)
		end
	end

	self.curQID_ = var_8_1[math.random(#var_8_1)]

	self:RefreshUI()
end

function ValentineGameV2PlayerAnswerView:RefreshUI()
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.cfg_.hero_id .. "_split_1")

	self.heroImage_:SetNativeSize()

	self.qustionText_.text = ActivityValentineWordCfg[self.curQID_].question_desc

	for iter_9_0 = 1, 2 do
		self["chooseText" .. iter_9_0 .. "_"].text = ActivityValentineWordCfg[self.curQID_].answer_desc[iter_9_0]
	end
end

function ValentineGameV2PlayerAnswerView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
			activityID = self.activityID_
		})
	end)
end

function ValentineGameV2PlayerAnswerView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameV2PlayerAnswerView:Dispose()
	self.super.Dispose(self)
end

return ValentineGameV2PlayerAnswerView
