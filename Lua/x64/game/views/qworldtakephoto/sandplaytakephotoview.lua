local var_0_0 = class("SandPlayTakePhotoView", ReduxView)
local var_0_1 = "UI_QuanZhou_CollectBookMapPopUI_"
local var_0_2 = {
	extraScenic = 1,
	mainQuest = 2
}
local var_0_3 = 5

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookMapPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.mainController_:GetController("state")
	arg_4_0.photoIDList_ = {
		[var_0_2.extraScenic] = {},
		[var_0_2.mainQuest] = {}
	}
	arg_4_0.photoControllerList_ = {}
	arg_4_0.photoImgList_ = {
		[var_0_2.extraScenic] = {},
		[var_0_2.mainQuest] = {}
	}

	for iter_4_0, iter_4_1 in ipairs(QuanzhouPhotoCfg.all) do
		local var_4_0 = QuanzhouPhotoCfg[iter_4_1]

		if arg_4_0.photoIDList_[var_4_0.type] then
			table.insert(arg_4_0.photoIDList_[var_4_0.type], iter_4_1)
		end
	end

	for iter_4_2 = 1, var_0_3 do
		arg_4_0.photoControllerList_[iter_4_2] = arg_4_0.mainController_:GetController("phphoto" .. iter_4_2)
		arg_4_0.photoImgList_[var_0_2.extraScenic][iter_4_2] = arg_4_0["nd" .. iter_4_2 .. "Img_"]
		arg_4_0.photoImgList_[var_0_2.mainQuest][iter_4_2] = arg_4_0["ph" .. iter_4_2 .. "Img_"]
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullScreenBtn_, nil, function()
		if arg_5_0.isTaking_ then
			return
		end

		SetActive(arg_5_0.textBackGo_, false)

		if not arg_5_0.isAni_ then
			arg_5_0.isAni_ = true

			arg_5_0:PlayAni(arg_5_0.photoID_)
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.lvAnimator_:Play("default")
	arg_7_0.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_empty")

	arg_7_0.startLv_ = QWorldBookletTools.GetNdLevelInfo()
	arg_7_0.thingID_ = arg_7_0.params_.configID
	arg_7_0.photoID_ = QuanzhouPhotoCfg.get_id_list_by_thing_id[arg_7_0.thingID_][1]
	arg_7_0.photoCfg_ = QuanzhouPhotoCfg[arg_7_0.photoID_]
	arg_7_0.photoType_ = arg_7_0.photoCfg_.type
	arg_7_0.photoIndex_ = -1

	SetActive(arg_7_0.textBackGo_, true)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.photoIDList_[arg_7_0.photoType_]) do
		if iter_7_1 == arg_7_0.photoID_ then
			arg_7_0.photoIndex_ = iter_7_0
		end
	end

	arg_7_0.stateController_:SetSelectedState("photo")

	arg_7_0.isTaking_ = true
	arg_7_0.isAni_ = false
	arg_7_0.canClose_ = false

	manager.windowBar:HideBar()
	arg_7_0:RefreshUI()
	arg_7_0:DoTakingPhoto()
end

function var_0_0.DoTakingPhoto(arg_8_0)
	arg_8_0.isTaking_ = false

	arg_8_0.stateController_:SetSelectedState("ani")

	if arg_8_0.photoID_ == 2005 then
		arg_8_0.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_emty_photo5")
	else
		arg_8_0.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_emty")
	end

	QWorldData:AddHint(323641001)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.photoImg_.sprite = pureGetSpriteWithoutAtlas(arg_9_0.photoCfg_.pic)
	arg_9_0.photoText_.text = arg_9_0.photoCfg_.desc
	arg_9_0.lvText_.text = tostring(arg_9_0.startLv_)
	arg_9_0.lvShadowText_.text = tostring(arg_9_0.startLv_)
	arg_9_0.lvAfterText_.text = tostring(arg_9_0.startLv_ + 1)
	arg_9_0.lvShadowAfterText_.text = tostring(arg_9_0.startLv_ + 1)

	for iter_9_0, iter_9_1 in pairs(var_0_2) do
		for iter_9_2 = 1, var_0_3 do
			if QWorldBookletTools.CheckPhotoUnlock(arg_9_0.photoIDList_[iter_9_1][iter_9_2]) then
				if iter_9_1 == var_0_2.mainQuest then
					arg_9_0.photoControllerList_[iter_9_2]:SetSelectedState("unlock")
				end

				local var_9_0 = QuanzhouPhotoCfg[arg_9_0.photoIDList_[iter_9_1][iter_9_2]]

				arg_9_0.photoImgList_[iter_9_1][iter_9_2].sprite = pureGetSpriteWithoutAtlas(var_9_0.pic)
			elseif iter_9_1 == var_0_2.mainQuest then
				arg_9_0.photoControllerList_[iter_9_2]:SetSelectedState("lock")
			end
		end
	end
end

function var_0_0.PlayAni(arg_10_0, arg_10_1)
	local var_10_0 = var_0_1 .. tostring(arg_10_1)

	arg_10_0.mainAnimator_:Play(var_10_0)

	arg_10_0.aniTimer_ = FrameTimer.New(function()
		if arg_10_0.mainAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.8 then
			arg_10_0:StopPhotoTimer()

			arg_10_0.canClose_ = true
			arg_10_0.photoImgList_[arg_10_0.photoType_][arg_10_0.photoIndex_].sprite = pureGetSpriteWithoutAtlas(arg_10_0.photoCfg_.pic)

			if arg_10_0.photoType_ == var_0_2.mainQuest then
				arg_10_0.photoControllerList_[arg_10_0.photoIndex_]:SetSelectedState("unlock")
			end

			arg_10_0:PlayLvUpAni()
		end
	end, 1, -1)

	arg_10_0.aniTimer_:Start()
end

function var_0_0.PlayLvUpAni(arg_12_0)
	arg_12_0.lvAnimator_:Play("UI_lv1_cx")

	arg_12_0.lvTimer_ = FrameTimer.New(function()
		local var_13_0 = arg_12_0.lvAnimator_:GetCurrentAnimatorStateInfo(0)

		if var_13_0:IsName("UI_lv1_cx") and var_13_0.normalizedTime >= 1 then
			arg_12_0:StopLvTimer()
			arg_12_0.lvAnimator_:Play("default")
			arg_12_0.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_empty")

			arg_12_0.bookCanvas_.alpha = 0

			TimeTools.StartAfterSeconds(0.01, function()
				JumpTools.Back()
				manager.notify:Invoke(QWORLD_TAKE_PHOTO)
			end, {})
		end
	end, 1, -1)

	arg_12_0.lvTimer_:Start()
end

function var_0_0.StopAllTimer(arg_15_0)
	arg_15_0:StopPhotoTimer()
	arg_15_0:StopLvTimer()
end

function var_0_0.StopPhotoTimer(arg_16_0)
	if arg_16_0.aniTimer_ then
		arg_16_0.aniTimer_:Stop()

		arg_16_0.aniTimer_ = nil
	end
end

function var_0_0.StopLvTimer(arg_17_0)
	if arg_17_0.lvTimer_ then
		arg_17_0.lvTimer_:Stop()

		arg_17_0.lvTimer_ = nil
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:StopAllTimer()
	manager.windowBar:HideBar()
end

return var_0_0
