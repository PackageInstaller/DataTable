local var_0_0 = class("QWorldStageInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ChapterSectionInfoUI"
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
	arg_4_0:InitRewardList()
end

function var_0_0.InitRewardList(arg_5_0)
	arg_5_0.rewardItemList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexRewardItem), arg_5_0.rewardListGo_, CommonItemView)
	arg_5_0.itemDataList_ = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBattle_, nil, handler(arg_6_0, arg_6_0.OnClickStartBattle))
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, handler(arg_6_0, arg_6_0.OnClickBackBtn))
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()
end

function var_0_0.OnBehind(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateBar()
	arg_10_0:InitParams()
	arg_10_0:RefreshUI()
end

function var_0_0.InitParams(arg_11_0)
	arg_11_0.stageType_ = arg_11_0.params_.stageType
	arg_11_0.stageID_ = arg_11_0.params_.stageID
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshStageInfo()
	arg_12_0:RefreshReward()
end

function var_0_0.RefreshStageInfo(arg_13_0)
	arg_13_0:RefreshTitle()
	arg_13_0:RefreshDesc()
end

function var_0_0.RefreshTitle(arg_14_0)
	arg_14_0.title_.text = arg_14_0:GetStageTitle()
end

function var_0_0.GetStageTitle(arg_15_0)
	return BattleStageTools.GetStageCfg(arg_15_0.stageType_, arg_15_0.stageID_).name
end

function var_0_0.RefreshDesc(arg_16_0)
	arg_16_0.desc_.text = arg_16_0:GetStageDesc()
end

function var_0_0.GetStageDesc(arg_17_0)
	return BattleStageTools.GetStageCfg(arg_17_0.stageType_, arg_17_0.stageID_).tips
end

function var_0_0.RefreshReward(arg_18_0)
	arg_18_0.rewardCfgList_ = arg_18_0:GetRewardCfgList()

	arg_18_0.rewardItemList_:StartScroll(#arg_18_0.rewardCfgList_)
end

function var_0_0.GetRewardCfgList(arg_19_0)
	return {}
end

function var_0_0.IndexRewardItem(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.itemDataList_[arg_20_1] then
		arg_20_0.itemDataList_[arg_20_1] = clone(ItemTemplateData)
		arg_20_0.itemDataList_[arg_20_1].clickFun = function(arg_21_0)
			ShowPopItem(POP_ITEM, {
				arg_21_0.id,
				arg_21_0.number
			})
		end
	end

	local var_20_0 = arg_20_0.rewardCfgList_[arg_20_1]

	arg_20_0.itemDataList_[arg_20_1].id = var_20_0.id
	arg_20_0.itemDataList_[arg_20_1].number = var_20_0.num

	arg_20_2:SetData(arg_20_0.itemDataList_[arg_20_1])
end

function var_0_0.OnClickStartBattle(arg_22_0)
	arg_22_0:LaunchBattle()
end

function var_0_0.LaunchBattle(arg_23_0)
	local var_23_0 = arg_23_0:GetStageData()

	BattleController.GetInstance():LaunchBattle(var_23_0)
end

function var_0_0.GetStageData(arg_24_0)
	return (BattleStageFactory.Produce(arg_24_0.stageType_, arg_24_0.stageID_))
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.rewardItemList_:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

function var_0_0.OnClickBackBtn(arg_26_0)
	arg_26_0:Back()
end

return var_0_0
