local ValentineGameV3SelectStageView = class("ValentineGameV3SelectStageView", ReduxView)

function ValentineGameV3SelectStageView:UIName()
	return "Widget/Version/Alone_ValentineUI/Alone_ValentineStageUI"
end

function ValentineGameV3SelectStageView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV3SelectStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV3SelectStageView:InitUI()
	self:BindCfgUI()

	self.completController1_ = self.controllerEx1_:GetController("complet")
	self.completController2_ = self.controllerEx2_:GetController("complet")
	self.completController3_ = self.controllerEx3_:GetController("complet")
	self.canReceiveController1_ = self.controllerEx1_:GetController("canReceive")
	self.canReceiveController2_ = self.controllerEx2_:GetController("canReceive")
	self.canReceiveController3_ = self.controllerEx3_:GetController("canReceive")
end

function ValentineGameV3SelectStageView:AddUIListener()
	self:AddBtnListener(self.btn1_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 1,
			mainActivityID = self.mainActivityID_,
			subActivityID = self.subActivityID_
		})
	end)
	self:AddBtnListener(self.btn2_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 2,
			mainActivityID = self.mainActivityID_,
			subActivityID = self.subActivityID_
		})
	end)
	self:AddBtnListener(self.btn3_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 3,
			mainActivityID = self.mainActivityID_,
			subActivityID = self.subActivityID_
		})
	end)
	self:AddBtnListener(self.rewardBtn1_, nil, function()
		ValentineGameAction:GetStoryReward(self.mainActivityID_, self.subActivityID_, self.cfg_.stage_storyid_and_dorpid_1[1])
	end)
	self:AddBtnListener(self.rewardBtn2_, nil, function()
		ValentineGameAction:GetStoryReward(self.mainActivityID_, self.subActivityID_, self.cfg_.stage_storyid_and_dorpid_2[1])
	end)
	self:AddBtnListener(self.rewardBtn3_, nil, function()
		ValentineGameAction:GetStoryReward(self.mainActivityID_, self.subActivityID_, self.cfg_.stage_storyid_and_dorpid_3[1])
	end)
end

function ValentineGameV3SelectStageView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.subActivityID_ = self.params_.subActivityID
	self.cfg_ = ActivityValentineV3StageCfg[self.subActivityID_]
end

function ValentineGameV3SelectStageView:RefreshUI()
	if HeroCfg[self.cfg_.hero_id] then
		self.nameText_.text = HeroCfg[self.cfg_.hero_id].suffix
	end

	self.desText_.text = self.cfg_.word
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg_.hero_id)
	self.name1_.text = self.cfg_.stage_name_1
	self.name2_.text = self.cfg_.stage_name_2
	self.name3_.text = self.cfg_.stage_name_3
	self.image1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. self.cfg_.stage_image_1)
	self.image2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. self.cfg_.stage_image_2)
	self.image3_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. self.cfg_.stage_image_3)

	local var_13_0 = PlayerData:GetStoryList()

	if var_13_0[self.cfg_.stage_storyid_and_dorpid_1[1]] == true or self.params_.finishStoryID == self.cfg_.stage_storyid_and_dorpid_1[1] then
		self.completController1_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(self.cfg_.stage_storyid_and_dorpid_1[1]) then
			self.canReceiveController1_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. self.subActivityID_, 1)
			self.canReceiveController1_:SetSelectedState("true")
		end
	else
		self.completController1_:SetSelectedState("false")
		self.canReceiveController1_:SetSelectedState("false")
	end

	if var_13_0[self.cfg_.stage_storyid_and_dorpid_2[1]] == true or self.params_.finishStoryID == self.cfg_.stage_storyid_and_dorpid_2[1] then
		self.completController2_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(self.cfg_.stage_storyid_and_dorpid_2[1]) then
			self.canReceiveController2_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. self.subActivityID_, 1)
			self.canReceiveController2_:SetSelectedState("true")
		end
	else
		self.completController2_:SetSelectedState("false")
		self.canReceiveController2_:SetSelectedState("false")
	end

	if var_13_0[self.cfg_.stage_storyid_and_dorpid_3[1]] == true or self.params_.finishStoryID == self.cfg_.stage_storyid_and_dorpid_3[1] then
		self.completController3_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(self.cfg_.stage_storyid_and_dorpid_3[1]) then
			self.canReceiveController3_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. self.subActivityID_, 1)
			self.canReceiveController3_:SetSelectedState("true")
		end
	else
		self.completController3_:SetSelectedState("false")
		self.canReceiveController3_:SetSelectedState("false")
	end
end

function ValentineGameV3SelectStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_V3_DES")
	self:RefreshUI()
end

function ValentineGameV3SelectStageView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameV3SelectStageView:OnValentineGameV3GetReward()
	self:RefreshUI()
end

function ValentineGameV3SelectStageView:OnValentineGameV3FinishStory()
	self:RefreshUI()
end

function ValentineGameV3SelectStageView:Dispose()
	self.super.Dispose(self)
end

return ValentineGameV3SelectStageView
