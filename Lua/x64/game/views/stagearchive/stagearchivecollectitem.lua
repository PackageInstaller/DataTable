local var_0_0 = class("StageArchiveCollectGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		StageTools.OpenStageArchiveInfo(arg_4_0.archiveID_)

		if StageTools.IsHaveRedStageArchive(arg_4_0.archiveID_) then
			BattleStageData:SetStageArchiveRedState(arg_4_0.archiveID_)
			BattleStageAction.SetStageArchiveRead(arg_4_0.archiveID_)
			manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
			manager.notify:Invoke(STAGE_ARCHIVE_RED_UPDATE)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.archiveID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.titleText_.text = StageArchivesCollectCfg[arg_7_0.archiveID_].name

	manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, StageTools.IsHaveRedStageArchive(arg_7_0.archiveID_))
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
