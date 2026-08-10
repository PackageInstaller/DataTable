local var_0_0 = class("QWorldBookletMainView", ReduxView)
local var_0_1 = {
	extraScenic = 1,
	mainQuest = 2
}
local var_0_2 = 5
local var_0_3 = 2003
local var_0_4 = 2005

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookUI"
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

	arg_4_0.curTabIndex_ = 0

	arg_4_0:SetTabExtraScenicTextAndShadow()
	arg_4_0:SetTabMainQuestTextAndShadow()
	arg_4_0:SetBookNameTextAndShadow()

	arg_4_0.idList_ = QWorldBookletTools.GetNdLevelIDList()
	arg_4_0.curLv_ = 0
	arg_4_0.maxLv_ = 0
	arg_4_0.photoBtn_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}
	arg_4_0.photoAnimator_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}
	arg_4_0.photoImage_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}

	for iter_4_0 = 1, var_0_2 do
		arg_4_0.photoBtn_[var_0_1.extraScenic][iter_4_0] = arg_4_0["nd" .. iter_4_0 .. "Btn_"]
		arg_4_0.photoBtn_[var_0_1.mainQuest][iter_4_0] = arg_4_0["ph" .. iter_4_0 .. "Btn_"]
		arg_4_0.photoAnimator_[var_0_1.extraScenic][iter_4_0] = arg_4_0["nd" .. iter_4_0 .. "Ctrl_"]
		arg_4_0.photoAnimator_[var_0_1.mainQuest][iter_4_0] = arg_4_0["ph" .. iter_4_0 .. "Ctrl_"]
		arg_4_0.photoImage_[var_0_1.extraScenic][iter_4_0] = arg_4_0["nd" .. iter_4_0 .. "Img_"]
		arg_4_0.photoImage_[var_0_1.mainQuest][iter_4_0] = arg_4_0["ph" .. iter_4_0 .. "Img_"]
	end

	arg_4_0.photoIdList_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}

	for iter_4_1, iter_4_2 in ipairs(QuanzhouPhotoCfg.all) do
		local var_4_0 = QuanzhouPhotoCfg[iter_4_2]

		if arg_4_0.photoIdList_[var_4_0.type] then
			table.insert(arg_4_0.photoIdList_[var_4_0.type], iter_4_2)
		end
	end

	for iter_4_3 = 1, #arg_4_0.photoImage_[var_0_1.mainQuest] do
		local var_4_1 = QuanzhouPhotoCfg[arg_4_0.photoIdList_[var_0_1.mainQuest][iter_4_3]]

		arg_4_0.photoImage_[var_0_1.mainQuest][iter_4_3].spriteAsync = var_4_1.pic
	end

	arg_4_0.tabController_ = arg_4_0.mainControllerEx_:GetController("tab")
	arg_4_0.ndlvController_ = arg_4_0.mainControllerEx_:GetController("ndlv")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.extraScenicBtn_, nil, function()
		if arg_5_0.curTabIndex_ ~= var_0_1.extraScenic then
			arg_5_0:SwitchTab(var_0_1.extraScenic)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.mainQuestBtn_, nil, function()
		if arg_5_0.curTabIndex_ ~= var_0_1.mainQuest then
			arg_5_0:SwitchTab(var_0_1.mainQuest)
		end
	end)

	for iter_5_0 = 1, var_0_2 do
		arg_5_0:AddBtnListener(arg_5_0.photoBtn_[var_0_1.extraScenic][iter_5_0], nil, function()
			JumpTools.OpenPageByJump("qWorldBookletPhotoPop", {
				photoId = arg_5_0.photoIdList_[var_0_1.extraScenic][iter_5_0]
			})
		end)
		arg_5_0:AddBtnListener(arg_5_0.photoBtn_[var_0_1.mainQuest][iter_5_0], nil, function()
			if QWorldBookletTools.CheckPhotoUnlock(arg_5_0.photoIdList_[var_0_1.mainQuest][iter_5_0]) then
				JumpTools.OpenPageByJump("qWorldBookletPhotoPop", {
					photoId = arg_5_0.photoIdList_[var_0_1.mainQuest][iter_5_0]
				})
			else
				ShowTips("GOON_STORY_TO_GET")
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.levelRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/qWorldBookletLevel")
	end)
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(arg_11_0.extraScenicBtn_.gameObject, QWorldSystemData:IsSystemOpened(var_0_3))

	arg_11_0.curLv_, arg_11_0.maxLv_ = QWorldBookletTools.GetNdLevelInfo()

	arg_11_0:RefreshLevelTitle()
	arg_11_0:SwitchTab(var_0_1.mainQuest)
	manager.redPoint:bindUIandKey(arg_11_0.levelRewardBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.stageAnimTimer_ then
		arg_12_0.stageAnimTimer_:Stop()

		arg_12_0.stageAnimTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_12_0.levelRewardBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function var_0_0.RefreshLevelTitle(arg_13_0)
	arg_13_0:SetLevelTextAndShadow()

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.idList_) do
		if iter_13_0 > arg_13_0.curLv_ then
			break
		end

		if not ActivityPointData:IsCompleteID(iter_13_1) then
			var_13_0 = iter_13_1
		end
	end

	if var_13_0 == 0 then
		arg_13_0.ndlvController_:SetSelectedState("normal")
	else
		local var_13_1 = ActivityPointRewardCfg[var_13_0]

		arg_13_0.levelRewardImg_.sprite = ItemTools.getItemSprite(var_13_1.reward_item_list[1][1])

		arg_13_0.ndlvController_:SetSelectedState("reward")
	end
end

function var_0_0.SwitchTab(arg_14_0, arg_14_1)
	arg_14_0.curTabIndex_ = arg_14_1

	arg_14_0.tabController_:SetSelectedState(tostring(arg_14_1))

	for iter_14_0 = 1, #arg_14_0.photoAnimator_[arg_14_1] do
		local var_14_0 = QWorldBookletTools.CheckPhotoUnlock(arg_14_0.photoIdList_[arg_14_1][iter_14_0])
		local var_14_1 = QuanzhouPhotoCfg[arg_14_0.photoIdList_[arg_14_1][iter_14_0]]

		if var_14_0 then
			if not getData("QWorldBookletAnimData", "MainViewPhotoUnlock" .. arg_14_0.photoIdList_[arg_14_1][iter_14_0]) then
				saveData("QWorldBookletAnimData", "MainViewPhotoUnlock" .. arg_14_0.photoIdList_[arg_14_1][iter_14_0], 1)
				arg_14_0.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock", 0, 0)
			else
				arg_14_0.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock_emty_01", 0, 0)
			end
		else
			arg_14_0.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock_emty", 0, 0)
		end

		if var_14_1 and arg_14_1 == var_0_1.extraScenic then
			arg_14_0.photoImage_[arg_14_1][iter_14_0].spriteAsync = var_14_0 and var_14_1.pic or var_14_1.pre_pic
		end
	end

	if arg_14_1 == var_0_1.mainQuest then
		arg_14_0:RefreshProgressBar()
	end
end

local var_0_5 = 90

function var_0_0.RefreshProgressBar(arg_15_0)
	arg_15_0.curPhotoStage_ = 0

	if QWorldBookletTools.CheckPhotoUnlock(arg_15_0.photoIdList_[var_0_1.mainQuest][2]) then
		arg_15_0.curPhotoStage_ = 1
	end

	if QWorldBookletTools.CheckPhotoUnlock(arg_15_0.photoIdList_[var_0_1.mainQuest][4]) then
		arg_15_0.curPhotoStage_ = 2
	end

	if QWorldBookletTools.CheckPhotoUnlock(arg_15_0.photoIdList_[var_0_1.mainQuest][5]) then
		arg_15_0.curPhotoStage_ = 3
	end

	local var_15_0 = getData("QWorldBookletAnimData", "MainViewStage") or 0

	arg_15_0.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. var_15_0, 0, 1)

	if var_15_0 < arg_15_0.curPhotoStage_ then
		arg_15_0.animStage_ = var_15_0 + 1
		arg_15_0.waitingForTick_ = 0
		arg_15_0.stageAnimTimer_ = FrameTimer.New(function()
			if arg_15_0.waitingForTick_ < var_0_5 then
				arg_15_0.waitingForTick_ = arg_15_0.waitingForTick_ + 1

				return
			elseif arg_15_0.waitingForTick_ == var_0_5 then
				if arg_15_0.animStage_ > 0 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_ui_walk", "")
				end

				arg_15_0.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. arg_15_0.animStage_, 0, 0)

				arg_15_0.waitingForTick_ = arg_15_0.waitingForTick_ + 1

				return
			end

			if arg_15_0.mainStageAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				if arg_15_0.curPhotoStage_ > arg_15_0.animStage_ then
					arg_15_0.animStage_ = arg_15_0.animStage_ + 1

					if arg_15_0.animStage_ > 0 then
						manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_ui_walk", "")
					end

					arg_15_0.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. arg_15_0.animStage_, 0, 0)
				elseif arg_15_0.stageAnimTimer_ then
					arg_15_0.stageAnimTimer_:Stop()

					arg_15_0.stageAnimTimer_ = nil
				end
			end
		end, 1, -1)

		arg_15_0.stageAnimTimer_:Start()
		saveData("QWorldBookletAnimData", "MainViewStage", arg_15_0.curPhotoStage_)
	end
end

function var_0_0.SetLevelTextAndShadow(arg_17_0)
	for iter_17_0 = 1, 4 do
		arg_17_0["levelText" .. iter_17_0].text = arg_17_0.curLv_ .. "<size=60>/" .. arg_17_0.maxLv_ .. "</size>"
	end
end

function var_0_0.SetTabExtraScenicTextAndShadow(arg_18_0)
	local var_18_0 = SandPlaySystemCfg[var_0_3]

	if not var_18_0 then
		return
	end

	for iter_18_0 = 1, 4 do
		arg_18_0["tabNameText1_" .. iter_18_0].text = var_18_0.name
	end
end

function var_0_0.SetTabMainQuestTextAndShadow(arg_19_0)
	local var_19_0 = SandPlaySystemCfg[var_0_4]

	if not var_19_0 then
		return
	end

	for iter_19_0 = 1, 4 do
		arg_19_0["tabNameText2_" .. iter_19_0].text = var_19_0.name
	end
end

function var_0_0.SetBookNameTextAndShadow(arg_20_0)
	for iter_20_0 = 1, 4 do
		arg_20_0["bookNameText" .. iter_20_0].text = QWorldBookletTools.GetBookletSystemName()
	end
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
