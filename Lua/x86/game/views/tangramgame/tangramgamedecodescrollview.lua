local var_0_0 = class("TangramGameDecodeScrollView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID = arg_1_2
	arg_1_0.stageID = ActivityTangramGameChapterCfg[arg_1_2].inference_stage_list[1]
	arg_1_0.mainPage = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.stageItemList = {}

	local var_2_0 = #ActivityTangramGameStageCfg[arg_2_0.stageID].ori_pos
	local var_2_1 = ActivityTangramGameStageCfg[arg_2_0.stageID].ori_pos

	for iter_2_0 = 1, var_2_0 do
		arg_2_0.stageItemList[iter_2_0] = TangramGameBigStageItem.New(arg_2_0["stageitem" .. iter_2_0 .. "Go_"], var_2_1[iter_2_0], arg_2_0.stageID, arg_2_0.mainPage)
	end
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshView(arg_4_0, arg_4_1)
	if arg_4_0.stageItemList then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.stageItemList) do
			iter_4_1:RefreshView(arg_4_1)
		end
	end
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.stageItemList) do
		iter_5_1:Dispose()
	end

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
