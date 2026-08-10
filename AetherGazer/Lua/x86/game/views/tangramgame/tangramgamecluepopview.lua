local var_0_0 = class("TangramGameCluePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.animator = arg_3_0.gameObject_:GetComponent("Animator")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			ChessBoardAction.GoBackFromSmallGame(0, 0)
		else
			local var_6_0 = ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[arg_5_0.stageID][1]

			JumpTools.OpenPageByJump("/tangramGameMainView", {
				chapterID = var_6_0,
				stageID = arg_5_0.stageID,
				playAni = arg_5_0.playAni
			})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.stageID = arg_7_0.params_.stageID
	arg_7_0.playAni = arg_7_0.params_.playAni

	if arg_7_0.playAni then
		arg_7_0.animator:Play("once", -1, 0)
		arg_7_0.animator:Update(0)
	else
		arg_7_0.animator:Play("TangramResultPopUI", -1, 0)
		arg_7_0.animator:Update(0)
	end

	local var_7_0 = ActivityTangramGameStageCfg[arg_7_0.stageID]

	arg_7_0.name.text = var_7_0.name
	arg_7_0.desc.text = var_7_0.desc
	arg_7_0.imgiconImg_.sprite = getSpriteViaConfig("TangramGameStageIcon", arg_7_0.stageID)
	arg_7_0.params_ = nil

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.desc.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.name.transform)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.animator:Update(99999)
	manager.windowBar:HideBar()
	arg_8_0:RemoveAllEventListener()

	arg_8_0.playAni = nil
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
