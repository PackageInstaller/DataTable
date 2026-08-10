local var_0_0 = class("IdolTraineeBattleComparePop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolPropertyComparePopup"
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

	arg_4_0.myInfoView = IdolTraineeTrainInfoPage.New(arg_4_0.player1Info_, handler(arg_4_0, arg_4_0.ChangeContentProperty), handler(arg_4_0, arg_4_0.ChangeContentSkill))

	arg_4_0.myInfoView:EnableLockControl(true)

	arg_4_0.enemyInfoView = IdolTraineeTrainInfoPage.New(arg_4_0.player2Info_, handler(arg_4_0, arg_4_0.ChangeContentProperty), handler(arg_4_0, arg_4_0.ChangeContentSkill))
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.userID = arg_7_0.params_.userID
	arg_7_0.friendType = arg_7_0.params_.friendType
	arg_7_0.stageID = arg_7_0.params_.stageID

	local var_7_0, var_7_1 = IdolTraineeData:GetCurAttackHeroInfo()

	arg_7_0.curHeroID_ = var_7_1

	local var_7_2 = IdolTraineeTools:GetHeroBattleInfoTemplate(nil, arg_7_0.userID, arg_7_0.friendType, arg_7_0.stageID)
	local var_7_3 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_7_0.curHeroID_)

	arg_7_0.myInfoView:RegisterEvents()
	arg_7_0.myInfoView:RefreshUI(var_7_3)
	arg_7_0.enemyInfoView:RefreshUI(var_7_2)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.myInfoView:RemoveAllEventListener()
end

function var_0_0.ChangeContentProperty(arg_9_0)
	arg_9_0.myInfoView:ChangeContent(1)
	arg_9_0.enemyInfoView:ChangeContent(1)
end

function var_0_0.ChangeContentSkill(arg_10_0)
	arg_10_0.myInfoView:ChangeContent(2)
	arg_10_0.enemyInfoView:ChangeContent(2)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.myInfoView:Dispose()
	arg_11_0.enemyInfoView:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
