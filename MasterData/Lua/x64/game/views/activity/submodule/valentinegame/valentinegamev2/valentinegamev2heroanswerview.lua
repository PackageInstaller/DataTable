local ValentineGameV2HeroAnswerView = class("ValentineGameV2HeroAnswerView", ReduxView)

function ValentineGameV2HeroAnswerView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame1UI"
end

function ValentineGameV2HeroAnswerView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2HeroAnswerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV2HeroAnswerView:InitUI()
	self:BindCfgUI()

	for iter_4_0 = 1, 3 do
		self["controller" .. iter_4_0 .. "_"] = ControllerUtil.GetController(self["chooseBtn" .. iter_4_0 .. "_"].transform, "get")
	end
end

function ValentineGameV2HeroAnswerView:AddUIListener()
	for iter_5_0 = 1, 3 do
		self:AddBtnListener(self["chooseBtn" .. iter_5_0 .. "_"], nil, function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				SDKTools.SendMessageToSDK("activity_valentine_opt", {
					answer_id = 0,
					question_id = self.cfg_.hero_qa_id[iter_5_0],
					activity_id = self.activityID_
				})
				ValentineGameData:CacheChooseQID(self.cfg_.hero_qa_id[iter_5_0])
				manager.story:StartStoryById(ActivityValentineWordCfg[self.cfg_.hero_qa_id[iter_5_0]].stroy_id_list[1], function(arg_7_0)
					JumpTools.OpenPageByJump("/valentineGameV2PlayerAnswerView", {
						activityID = self.activityID_
					})
				end, true)
			elseif manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime))))
			else
				ShowTips(GetTips("TIME_OVER"))
			end
		end)
	end
end

function ValentineGameV2HeroAnswerView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.cfg_ = ActivityValentineCfg[self.activityID_]

	self:RefreshUI()
end

function ValentineGameV2HeroAnswerView:RefreshUI()
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.cfg_.hero_id .. "_split_1")

	self.heroImage_:SetNativeSize()

	for iter_9_0 = 1, 3 do
		self["chooseText" .. iter_9_0 .. "_"].text = ActivityValentineWordCfg[self.cfg_.hero_qa_id[iter_9_0]].question_desc

		if table.indexof(ValentineGameData:GetData(self.activityID_).selectQuestionID, self.cfg_.hero_qa_id[iter_9_0]) then
			self["controller" .. iter_9_0 .. "_"]:SetSelectedState("true")
		else
			self["controller" .. iter_9_0 .. "_"]:SetSelectedState("false")
		end
	end
end

function ValentineGameV2HeroAnswerView:OnTop()
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

function ValentineGameV2HeroAnswerView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameV2HeroAnswerView:Dispose()
	self.super.Dispose(self)
end

return ValentineGameV2HeroAnswerView
