local var_0_0 = class("SeaWarfareBattleReadyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationStageBase"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
	arg_4_0:InitMarinerList()
	arg_4_0:InitSkillList()
	arg_4_0:InitController()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBattle_, nil, function()
		if arg_5_0.selectedSkillID_ == nil then
			ShowTips("NEED_EQUIP_SKILL")

			return
		end

		arg_5_0:LaunchBattle()
	end)
end

function var_0_0.InitMarinerList(arg_7_0)
	arg_7_0.marinerItemList_ = {}

	local var_7_0 = arg_7_0.maerinerPanelTrans_.childCount

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = SeaWarfareMarinerItem.New(arg_7_0.maerinerPanelTrans_:GetChild(iter_7_0 - 1).gameObject)

		arg_7_0.marinerItemList_[#arg_7_0.marinerItemList_ + 1] = var_7_1
	end
end

function var_0_0.InitSkillList(arg_8_0)
	arg_8_0.selectSkillHandler_ = handler(arg_8_0, arg_8_0.OnSelectSkill)
	arg_8_0.skillItemList_ = {}

	local var_8_0 = arg_8_0.skillPanelTrans_.childCount

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_0.skillPanelTrans_:GetChild(iter_8_0 - 1)
		local var_8_2 = SeaWarfareSkillItem.New(var_8_1.gameObject)

		var_8_2:SetClickCallback(arg_8_0.selectSkillHandler_)

		arg_8_0.skillItemList_[#arg_8_0.skillItemList_ + 1] = var_8_2
	end
end

function var_0_0.InitController(arg_9_0)
	arg_9_0.selectSkillController_ = arg_9_0.selectSkillControllerEx_:GetController("select")
	arg_9_0.battleBtnController_ = arg_9_0.controllerEx_:GetController("battleBtn")
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_12_0.needSkipUnloadModel_ = true

		arg_12_0:Back()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:InitCamera()
	arg_14_0:InitParams()
	arg_14_0:RefreshUI()
	arg_14_0:PlayEnterAnim()
end

function var_0_0.InitCamera(arg_15_0)
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
end

function var_0_0.InitParams(arg_16_0)
	arg_16_0.stageID_ = arg_16_0.params_.stageID
	arg_16_0.selectedSkillID_ = nil
	arg_16_0.recommendSkillID_ = SeaWarfareStageCfg[arg_16_0.stageID_].recommend_skill
	arg_16_0.needSkipUnloadModel_ = false
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:CloseCamera()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.marinerItemList_) do
		iter_17_1:ResetAnim()
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.skillItemList_) do
		iter_17_3:ResetAnim()
	end

	if not arg_17_0.needSkipUnloadModel_ then
		SeaWarfareModelView:GetInstance():Unload()
	end

	arg_17_0:StopAnim()
end

function var_0_0.CloseCamera(arg_18_0)
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshMarinerList()
	arg_19_0:RefreshSkillList()
	arg_19_0:RefreshStageInfo()
	arg_19_0:RefreshSelectedSkillInfo()
	arg_19_0:RefreshPopSkillInfo()
end

function var_0_0.RefreshMarinerList(arg_20_0)
	arg_20_0.marinerIDList_ = SeaWarfareTools.GetMarinerIDList()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.marinerItemList_) do
		local var_20_0 = arg_20_0.marinerIDList_[iter_20_0]

		iter_20_1:SetData(var_20_0)
	end
end

function var_0_0.RefreshSkillList(arg_21_0)
	arg_21_0.skillIDList_ = SeaWarfareTools.GetSkillIDList()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.skillItemList_) do
		local var_21_0 = arg_21_0.skillIDList_[iter_21_0]

		iter_21_1:SetData(var_21_0)
		iter_21_1:SetSelect(arg_21_0.selectedSkillID_ == var_21_0)
		iter_21_1:SetRecommend(arg_21_0.recommendSkillID_ == var_21_0)
	end
end

function var_0_0.IndexMarinerItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.marinerIDList_[arg_22_1]

	arg_22_2:SetData(var_22_0)
end

function var_0_0.IndexSkillItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.skillIDList_[arg_23_1]

	arg_23_2:SetData(var_23_0)
	arg_23_2:SetClickCallback(arg_23_0.selectSkillHandler_)
	arg_23_2:SetSelect(arg_23_0.selectedSkillID_ == var_23_0)
	arg_23_2:SetRecommend(arg_23_0.recommendSkillID_ == var_23_0)
end

function var_0_0.OnSelectSkill(arg_24_0, arg_24_1)
	arg_24_0.selectedSkillID_ = arg_24_1

	arg_24_0:RefreshSelectedSkillInfo()
	arg_24_0:RefreshSkillSelect()
	arg_24_0:RefreshPopSkillInfo()
	arg_24_0:RefreshSkillCamera()
	arg_24_0:RefreshBattleBtn()
end

function var_0_0.RefreshSkillSelect(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.skillItemList_) do
		local var_25_0 = iter_25_1:GetSKillID()

		iter_25_1:SetSelect(var_25_0 == arg_25_0.selectedSkillID_)
	end
end

function var_0_0.RefreshSkillCamera(arg_26_0)
	local var_26_0 = table.indexof(arg_26_0.skillIDList_, arg_26_0.selectedSkillID_)

	SeaWarfareModelView:GetInstance():SwitchModelAnim(var_26_0)
end

function var_0_0.RefreshStageInfo(arg_27_0)
	local var_27_0 = SeaWarfareStageCfg[arg_27_0.stageID_]

	arg_27_0.mechanismDesc_.text = var_27_0.desc
end

function var_0_0.RefreshSelectedSkillInfo(arg_28_0)
	if arg_28_0.selectedSkillID_ then
		local var_28_0 = SeaWarfareSkillCfg[arg_28_0.selectedSkillID_]

		arg_28_0.selectedSKillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. var_28_0.icon_show)
	end
end

function var_0_0.RefreshPopSkillInfo(arg_29_0)
	if arg_29_0.selectedSkillID_ then
		arg_29_0.selectedSkillName_.text = SeaWarfareSkillCfg[arg_29_0.selectedSkillID_].name
		arg_29_0.selectedSkillDesc_.text = SeaWarfareSkillCfg[arg_29_0.selectedSkillID_].desc
		arg_29_0.selectedSkillTag_.text = SeaWarfareSkillCfg[arg_29_0.selectedSkillID_].tag
	end

	arg_29_0.selectSkillController_:SetSelectedState(arg_29_0.selectedSkillID_ and "on" or "off")
end

function var_0_0.RefreshBattleBtn(arg_30_0)
	arg_30_0.battleBtnController_:SetSelectedState(arg_30_0.selectedSkillID_ and "on" or "off")
end

function var_0_0.Dispose(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.marinerItemList_) do
		iter_31_1:Dispose()
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.skillItemList_) do
		iter_31_3:Dispose()
	end

	var_0_0.super.Dispose(arg_31_0)
end

function var_0_0.LaunchBattle(arg_32_0)
	SeaWarfareTools.LaunchBattle(arg_32_0.stageID_, arg_32_0.selectedSkillID_, SeaWarfareTools.GetUnlockMarinerIDList())
end

function var_0_0.PlayEnterAnim(arg_33_0)
	arg_33_0:StopAnim()

	arg_33_0.enterAnimTimer_ = SeaWarfareTools.PlayAnim(arg_33_0.enterAnim_, "UI_right_cx", handler(arg_33_0, arg_33_0.OnEnterAnimEnd))
end

function var_0_0.OnEnterAnimEnd(arg_34_0)
	arg_34_0:StopAnim()

	for iter_34_0, iter_34_1 in pairs(arg_34_0.marinerItemList_) do
		iter_34_1:PlayAnim()
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_0.skillItemList_) do
		iter_34_3:PlayFirstUnlockAnim()
	end
end

function var_0_0.StopAnim(arg_35_0)
	arg_35_0.enterAnim_.enabled = false

	if arg_35_0.enterAnimTimer_ then
		arg_35_0.enterAnimTimer_:Stop()

		arg_35_0.enterAnimTimer_ = nil
	end
end

return var_0_0
