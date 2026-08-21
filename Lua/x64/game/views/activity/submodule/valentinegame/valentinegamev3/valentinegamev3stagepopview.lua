local var_0_0 = class("ValentineGameV3StagePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_ValentineUI/Alone_ValentineRewardPopUI"
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

	arg_4_0.preRewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexPreviewItem), arg_4_0.listGo_, CommonItemView)
end

function var_0_0.IndexPreviewItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.preRewards_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		if PlayerData:GetStoryList()[arg_6_0.storyID_] == true then
			manager.story:StartStoryById(arg_6_0.storyID_, function(arg_9_0)
				JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
					mainActivityID = arg_6_0.mainActivityID_,
					subActivityID = arg_6_0.subActivityID_,
					finishStoryID = arg_6_0.storyID_
				})
			end, false)
		else
			manager.story:StartStoryById(arg_6_0.storyID_, function(arg_10_0)
				JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
					mainActivityID = arg_6_0.mainActivityID_,
					subActivityID = arg_6_0.subActivityID_,
					finishStoryID = arg_6_0.storyID_
				})
			end, true)
		end
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.mainActivityID_ = arg_11_0.params_.mainActivityID
	arg_11_0.subActivityID_ = arg_11_0.params_.subActivityID
	arg_11_0.stageIndex_ = arg_11_0.params_.index

	local var_11_0 = ActivityValentineV3StageCfg[arg_11_0.subActivityID_]

	arg_11_0.storyID_ = var_11_0["stage_storyid_and_dorpid_" .. arg_11_0.stageIndex_][1]
	arg_11_0.dropID_ = var_11_0["stage_storyid_and_dorpid_" .. arg_11_0.stageIndex_][2]
	arg_11_0.nameText_.text = var_11_0["stage_name_" .. arg_11_0.stageIndex_]
	arg_11_0.image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_ValentineUI/PhotoValentine/" .. var_11_0["stage_image_" .. arg_11_0.stageIndex_])

	local var_11_1 = false

	if ValentineGameData:GetStoryIDIsGetReward(arg_11_0.storyID_) then
		var_11_1 = true
	end

	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(DropCfg[arg_11_0.dropID_].base_drop) do
		local var_11_3 = clone(ItemTemplateData)

		var_11_3.id = iter_11_1[1]
		var_11_3.number = iter_11_1[2]

		function var_11_3.clickFun(arg_12_0)
			ShowPopItem(POP_ITEM, {
				arg_12_0.id,
				arg_12_0.number
			})
		end

		if var_11_1 then
			var_11_3.completedFlag = true
		else
			var_11_3.completedFlag = false
		end

		table.insert(var_11_2, var_11_3)
	end

	arg_11_0.preRewards_ = var_11_2

	arg_11_0.preRewardList_:StartScroll(#arg_11_0.preRewards_)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.super.Dispose(arg_13_0)

	if arg_13_0.preRewardList_ then
		arg_13_0.preRewardList_:Dispose()

		arg_13_0.preRewardList_ = nil
	end
end

return var_0_0
