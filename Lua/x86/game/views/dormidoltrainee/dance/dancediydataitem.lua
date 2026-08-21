local var_0_0 = class("DanceDIYDataItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController = arg_2_0.controllers_:GetController("select")
	arg_2_0.emptyController = arg_2_0.controllers_:GetController("empty")
	arg_2_0.categoryController = arg_2_0.controllers_:GetController("category")

	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.SetOnClick(arg_5_0, arg_5_1)
	arg_5_0.onClick = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.showShareStatistics = arg_6_2
	arg_6_0.loadData = arg_6_1

	arg_6_0:Refresh()
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	if arg_7_0.selectController then
		arg_7_0.selectController:SetSelectedState(arg_7_1 and "true" or "false")
	end
end

local var_0_1 = "--"

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = IdolTraineeTools.GetDIYDataFromLoadInfo(arg_8_0.loadData)

	if var_8_0 then
		if arg_8_0.emptyController then
			arg_8_0.emptyController:SetSelectedState("false")
		end

		local var_8_1 = var_8_0.scene
		local var_8_2 = IdolStageSceneCfg[var_8_1]

		arg_8_0.sceneIcon_.sprite = getSpriteViaConfig("IdolStageIcon", var_8_2.stage_picture)

		local var_8_3 = var_8_0.music

		arg_8_0.musicName_.text = nullable(IdolStageMusicCfg, var_8_3, "music_name")

		local var_8_4 = IdolTraineeTools.GetMusicDuration(var_8_3)

		arg_8_0.duration_.text = manager.time:DescCDTime4(var_8_4)
		arg_8_0.actionCnt_.text = arg_8_0.loadData.actionCount or IdolTraineeTools.CalculateActionCount(var_8_0.actionList)

		if arg_8_0.categoryController then
			arg_8_0.categoryController:SetSelectedState(arg_8_0.showShareStatistics and "shared" or "own")
		end

		arg_8_0.collectedCnt_.text = var_8_0.collcted or var_0_1
		arg_8_0.viewedCnt_.text = var_8_0.viewCount or var_0_1
		arg_8_0.likedCnt_.text = var_8_0.liked or var_0_1
	elseif arg_8_0.emptyController then
		arg_8_0.emptyController:SetSelectedState("true")
	end
end

function var_0_0.SetDisplayName(arg_9_0, arg_9_1)
	arg_9_0.seqName_.text = arg_9_1
end

function var_0_0.SetShowStatistics(arg_10_0, arg_10_1)
	arg_10_0.showShareStatistics = arg_10_1

	if arg_10_0.categoryController then
		arg_10_0.categoryController:SetSelectedState(arg_10_0.showShareStatistics and "shared" or "own")
	end
end

function var_0_0.OnClick(arg_11_0)
	if arg_11_0.onClick then
		arg_11_0.onClick(arg_11_0.loadData)
	end
end

return var_0_0
