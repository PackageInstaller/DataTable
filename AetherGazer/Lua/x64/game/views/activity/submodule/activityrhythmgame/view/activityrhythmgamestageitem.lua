local var_0_0 = class("ActivityRhythmGameStageItem", ReduxView)

function var_0_0.IsOpenSectionInfo(arg_1_0)
	return arg_1_0:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = Object.Instantiate(arg_2_1, arg_2_2.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:Init()
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitLocalData()
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.stageBtn_, function()
		arg_5_0:OnClick()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.stageBtn2_, function()
		arg_5_0:OnClick()
	end)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()
	SetActive(arg_8_0.gameObject_, true)
	arg_8_0:BindController()
end

function var_0_0.InitLocalData(arg_9_0)
	arg_9_0.cfgID_ = 0
	arg_9_0.stageID_ = 0
	arg_9_0.activityID_ = 0
end

function var_0_0.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.BindController(arg_11_0)
	arg_11_0.starController_ = arg_11_0.controllerEx_:GetController("stars")
	arg_11_0.lockController_ = arg_11_0.controllerEx_:GetController("lock")
	arg_11_0.lineController_ = arg_11_0.controllerEx_:GetController("lineState")
	arg_11_0.selectController_ = arg_11_0.controllerEx_:GetController("select")
	arg_11_0.showStarsController_ = arg_11_0.controllerEx_:GetController("showStars")
	arg_11_0.stageController_ = arg_11_0.controllerEx_:GetController("stageState")
end

function var_0_0.ChangeStarController(arg_12_0, arg_12_1)
	arg_12_0.starController_:SetSelectedIndex(arg_12_1)
end

function var_0_0.ChangeLockController(arg_13_0, arg_13_1)
	arg_13_0.lockController_:SetSelectedIndex(arg_13_1)
end

function var_0_0.ChangeLineController(arg_14_0, arg_14_1)
	arg_14_0.lineController_:SetSelectedIndex(arg_14_1)
end

function var_0_0.ChangeSelectController(arg_15_0, arg_15_1)
	arg_15_0.selectController_:SetSelectedIndex(arg_15_1)
end

function var_0_0.ChangeShowStarsController(arg_16_0, arg_16_1)
	arg_16_0.showStarsController_:SetSelectedIndex(arg_16_1)
end

function var_0_0.ChangeStageController(arg_17_0, arg_17_1)
	arg_17_0.stageController_:SetSelectedIndex(arg_17_1)
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshStar()
	arg_18_0:RefreshLock()
	arg_18_0:RefreshText()
end

function var_0_0.RefreshStar(arg_19_0)
	if ActivityRhythmGameCfg[arg_19_0.cfgID_].three_star_need == "" then
		arg_19_0:ChangeShowStarsController(1)

		return
	end

	arg_19_0:ChangeShowStarsController(0)

	local var_19_0 = ActivityRhythmGameData:GetStarsByCfgID(arg_19_0.cfgID_)

	arg_19_0:ChangeStarController(#var_19_0)
end

function var_0_0.RefreshLock(arg_20_0)
	if ActivityRhythmGameData:IsUnlock(arg_20_0.cfgID_) then
		arg_20_0:ChangeLockController(0)
	else
		arg_20_0:ChangeLockController(1)
	end
end

function var_0_0.RefreshText(arg_21_0)
	local var_21_0 = BattleRhythmGameStageCfg[arg_21_0.stageID_]

	if var_21_0 then
		arg_21_0.stageText_.text = var_21_0.name
	end
end

function var_0_0.SetData(arg_22_0, arg_22_1)
	local var_22_0 = ActivityRhythmGameCfg[arg_22_1]

	arg_22_0.cfgID_ = arg_22_1
	arg_22_0.activityID_ = var_22_0.activity_id
	arg_22_0.stageID_ = var_22_0.stage_id
	arg_22_0.stageType_ = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME

	arg_22_0:RefreshUI()
end

function var_0_0.SetAddPos(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.transform_.localPosition = Vector3(arg_23_0.transform_.localPosition.x + arg_23_1, arg_23_0.transform_.localPosition.y + arg_23_2, arg_23_0.transform_.localPosition.z)
end

function var_0_0.SetLine(arg_24_0, arg_24_1)
	arg_24_0:ChangeLineController(arg_24_1)
end

function var_0_0.SetClickHandler(arg_25_0, arg_25_1)
	arg_25_0.onClickCallback_ = arg_25_1
end

function var_0_0.OnClick(arg_26_0)
	if arg_26_0.onClickCallback_ then
		arg_26_0.onClickCallback_(arg_26_0.cfgID_, arg_26_0.stageID_, arg_26_0.transform_.position)
	end
end

function var_0_0.GetPosition(arg_27_0)
	return arg_27_0.transform_.position
end

function var_0_0.RefreshSelect(arg_28_0, arg_28_1)
	if arg_28_0.cfgID_ == arg_28_1 then
		arg_28_0:ChangeSelectController(1)
	else
		arg_28_0:ChangeSelectController(0)
	end
end

return var_0_0
