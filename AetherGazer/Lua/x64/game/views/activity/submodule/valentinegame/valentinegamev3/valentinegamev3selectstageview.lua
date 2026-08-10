local var_0_0 = class("ValentineGameV3SelectStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_ValentineUI/Alone_ValentineStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.completController1_ = arg_4_0.controllerEx1_:GetController("complet")
	arg_4_0.completController2_ = arg_4_0.controllerEx2_:GetController("complet")
	arg_4_0.completController3_ = arg_4_0.controllerEx3_:GetController("complet")
	arg_4_0.canReceiveController1_ = arg_4_0.controllerEx1_:GetController("canReceive")
	arg_4_0.canReceiveController2_ = arg_4_0.controllerEx2_:GetController("canReceive")
	arg_4_0.canReceiveController3_ = arg_4_0.controllerEx3_:GetController("canReceive")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn1_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 1,
			mainActivityID = arg_5_0.mainActivityID_,
			subActivityID = arg_5_0.subActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn2_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 2,
			mainActivityID = arg_5_0.mainActivityID_,
			subActivityID = arg_5_0.subActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn3_, nil, function()
		JumpTools.OpenPageByJump("valentineGameV3StagePopView", {
			index = 3,
			mainActivityID = arg_5_0.mainActivityID_,
			subActivityID = arg_5_0.subActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn1_, nil, function()
		ValentineGameAction:GetStoryReward(arg_5_0.mainActivityID_, arg_5_0.subActivityID_, arg_5_0.cfg_.stage_storyid_and_dorpid_1[1])
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn2_, nil, function()
		ValentineGameAction:GetStoryReward(arg_5_0.mainActivityID_, arg_5_0.subActivityID_, arg_5_0.cfg_.stage_storyid_and_dorpid_2[1])
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn3_, nil, function()
		ValentineGameAction:GetStoryReward(arg_5_0.mainActivityID_, arg_5_0.subActivityID_, arg_5_0.cfg_.stage_storyid_and_dorpid_3[1])
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.mainActivityID_ = arg_12_0.params_.mainActivityID
	arg_12_0.subActivityID_ = arg_12_0.params_.subActivityID
	arg_12_0.cfg_ = ActivityValentineV3StageCfg[arg_12_0.subActivityID_]
end

function var_0_0.RefreshUI(arg_13_0)
	if HeroCfg[arg_13_0.cfg_.hero_id] then
		arg_13_0.nameText_.text = HeroCfg[arg_13_0.cfg_.hero_id].suffix
	end

	arg_13_0.desText_.text = arg_13_0.cfg_.word
	arg_13_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_13_0.cfg_.hero_id)
	arg_13_0.name1_.text = arg_13_0.cfg_.stage_name_1
	arg_13_0.name2_.text = arg_13_0.cfg_.stage_name_2
	arg_13_0.name3_.text = arg_13_0.cfg_.stage_name_3
	arg_13_0.image1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. arg_13_0.cfg_.stage_image_1)
	arg_13_0.image2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. arg_13_0.cfg_.stage_image_2)
	arg_13_0.image3_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. arg_13_0.cfg_.stage_image_3)

	local var_13_0 = PlayerData:GetStoryList()

	if var_13_0[arg_13_0.cfg_.stage_storyid_and_dorpid_1[1]] == true or arg_13_0.params_.finishStoryID == arg_13_0.cfg_.stage_storyid_and_dorpid_1[1] then
		arg_13_0.completController1_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(arg_13_0.cfg_.stage_storyid_and_dorpid_1[1]) then
			arg_13_0.canReceiveController1_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_13_0.subActivityID_, 1)
			arg_13_0.canReceiveController1_:SetSelectedState("true")
		end
	else
		arg_13_0.completController1_:SetSelectedState("false")
		arg_13_0.canReceiveController1_:SetSelectedState("false")
	end

	if var_13_0[arg_13_0.cfg_.stage_storyid_and_dorpid_2[1]] == true or arg_13_0.params_.finishStoryID == arg_13_0.cfg_.stage_storyid_and_dorpid_2[1] then
		arg_13_0.completController2_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(arg_13_0.cfg_.stage_storyid_and_dorpid_2[1]) then
			arg_13_0.canReceiveController2_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_13_0.subActivityID_, 1)
			arg_13_0.canReceiveController2_:SetSelectedState("true")
		end
	else
		arg_13_0.completController2_:SetSelectedState("false")
		arg_13_0.canReceiveController2_:SetSelectedState("false")
	end

	if var_13_0[arg_13_0.cfg_.stage_storyid_and_dorpid_3[1]] == true or arg_13_0.params_.finishStoryID == arg_13_0.cfg_.stage_storyid_and_dorpid_3[1] then
		arg_13_0.completController3_:SetSelectedState("true")

		if ValentineGameData:GetStoryIDIsGetReward(arg_13_0.cfg_.stage_storyid_and_dorpid_3[1]) then
			arg_13_0.canReceiveController3_:SetSelectedState("false")
		else
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_13_0.subActivityID_, 1)
			arg_13_0.canReceiveController3_:SetSelectedState("true")
		end
	else
		arg_13_0.completController3_:SetSelectedState("false")
		arg_13_0.canReceiveController3_:SetSelectedState("false")
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_V3_DES")
	arg_14_0:RefreshUI()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnValentineGameV3GetReward(arg_16_0)
	arg_16_0:RefreshUI()
end

function var_0_0.OnValentineGameV3FinishStory(arg_17_0)
	arg_17_0:RefreshUI()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.super.Dispose(arg_18_0)
end

return var_0_0
