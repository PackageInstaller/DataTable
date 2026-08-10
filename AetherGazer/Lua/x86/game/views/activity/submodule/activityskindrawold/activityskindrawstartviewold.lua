local var_0_0 = class("ActivitySkinDrawStartViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetDrawStartUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.soundEffect_ = {
		"search_scene_02_blue",
		"search_scene_02_purple",
		"search_scene_02_gold",
		special = "search_scene_02_special"
	}
	arg_4_0.typeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		if arg_5_0.isPlaying_ then
			-- block empty
		else
			arg_5_0:SkipFunc()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.drawInteractBtn_, nil, function()
		if arg_5_0.isPlaying_ then
			return
		end

		arg_5_0.isPlaying_ = true

		manager.audio:PlayEffect("ui_system_search", arg_5_0.effect_, "")

		if arg_5_0.animator_ then
			AnimatorTools.PlayAnimatorWithCallback(arg_5_0.animator_, "Demo_root", function()
				arg_5_0:AfterTimeline(arg_5_0.list_)
			end, false)
		else
			arg_5_0:AfterTimeline(arg_5_0.list_)
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.isPlaying_ = false

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshReward()
	arg_10_0:RefreshAni()
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = arg_11_0.params_.draw_list or {}

	arg_11_0.list_ = {}
	arg_11_0.maxRare_ = 0
	arg_11_0.isSkin_ = false
	arg_11_0.isScene_ = false

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = ActivityLimitedDrawPoolCfg[iter_11_1].reward[1]
		local var_11_3 = var_11_2[1]
		local var_11_4 = ItemCfg[var_11_3]
		local var_11_5 = var_11_4.type

		if var_11_5 == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_11_0.isSkin_ = true
			arg_11_0.skinDropID_ = iter_11_1
		elseif var_11_5 == ItemConst.ITEM_TYPE.SCENE then
			arg_11_0.isScene_ = true
		end

		table.insert(arg_11_0.list_, iter_11_1)
		table.insert(var_11_1, var_11_2)

		local var_11_6 = 1
		local var_11_7 = var_11_4.rare >= 5 and 3 or var_11_4.rare == 4 and 2 or 1

		arg_11_0.maxRare_ = var_11_7 < arg_11_0.maxRare_ and arg_11_0.maxRare_ or var_11_7
	end
end

function var_0_0.RefreshAni(arg_12_0)
	if arg_12_0.isSkin_ or arg_12_0.isScene_ then
		arg_12_0.typeCon_:SetSelectedState("special")

		arg_12_0.animator_ = arg_12_0.animator_special
		arg_12_0.effect_ = arg_12_0.soundEffect_.special
	else
		arg_12_0.typeCon_:SetSelectedState(arg_12_0.maxRare_)

		arg_12_0.animator_ = arg_12_0["animator_" .. arg_12_0.maxRare_]
		arg_12_0.effect_ = arg_12_0.soundEffect_[arg_12_0.maxRare_]
	end
end

function var_0_0.SkipFunc(arg_13_0)
	if #arg_13_0.list_ > 1 then
		if arg_13_0.isSkin_ then
			arg_13_0:AfterTimeline({
				arg_13_0.skinDropID_
			})
		else
			local var_13_0 = {
				list = arg_13_0.list_,
				replaceList = arg_13_0.params_.replaceList,
				activityID = arg_13_0.params_.poolActivityID,
				mainActivityID = arg_13_0.params_.mainActivityID
			}

			JumpTools.OpenPageByJump("/activitySkinResultRewardOld", var_13_0)
		end
	else
		arg_13_0:AfterTimeline(arg_13_0.list_)
	end
end

function var_0_0.AfterTimeline(arg_14_0, arg_14_1)
	arg_14_0.isPlaying_ = false

	local var_14_0 = {
		showList = arg_14_1,
		list = arg_14_0.list_,
		replaceList = arg_14_0.params_.replaceList,
		activityID = arg_14_0.params_.poolActivityID,
		mainActivityID = arg_14_0.params_.mainActivityID
	}

	JumpTools.OpenPageByJump("/activitySkinDrawRewardOld", var_14_0)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_16_0)
	AnimatorTools.Stop()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.super.Dispose(arg_17_0)
end

return var_0_0
