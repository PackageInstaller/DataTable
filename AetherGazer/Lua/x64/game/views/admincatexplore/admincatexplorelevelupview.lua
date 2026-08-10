local var_0_0 = class("AdminCatExploreLevelUpView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/ExploreUI/ExploreLevelUpPopUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBg_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.curLevel = AdminCatExploreData:GetDataByPara("level")
	arg_7_0.lockRegion = AdminCatExploreData:GetDataByPara("nextLockRegion")[arg_7_0.curLevel]
	arg_7_0.lockAdminCat = AdminCatExploreData:GetDataByPara("nextLockAdminCat")[arg_7_0.curLevel]

	SetActive(arg_7_0.regionGo_, arg_7_0.lockRegion ~= nil)
	SetActive(arg_7_0.adminCatGo_, arg_7_0.lockAdminCat ~= nil)

	arg_7_0.titleImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. arg_7_0.curLevel)

	local var_7_0 = ExploreLevelCfg[arg_7_0.curLevel - 1]
	local var_7_1 = ExploreLevelCfg[arg_7_0.curLevel]

	if arg_7_0.lockRegion then
		local var_7_2 = ExploreAreaCfg[arg_7_0.lockRegion]

		arg_7_0.regionNameTxt_.text = GetI18NText(var_7_2.area_name)
		arg_7_0.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. var_7_2.icon)
	end

	if arg_7_0.lockAdminCat then
		local var_7_3 = ExploreMeowCfg[arg_7_0.lockAdminCat]

		arg_7_0.adminCatNameTxt_.text = GetI18NText(var_7_3.meow_name)

		local var_7_4 = ExploreMeowSkillCfg[var_7_3.skill]
		local var_7_5 = ExploreMeowInbornCfg[var_7_3.inborn]

		arg_7_0.skillImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_7_5.inborn_icon)
		arg_7_0.skillImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_7_4.skill_icon)
		arg_7_0.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_7_3.meow_icon)
	end

	arg_7_0.oldQueueTxt_.text = string.format(GetTips("EXPLORE_QUEUE_AMOUNT"), var_7_0.amount)
	arg_7_0.newQueueTxt.text = string.format(GetTips("EXPLORE_LEVEL_UP"), var_7_1.amount)
	arg_7_0.oldExploreTime_.text = string.format(GetTips("EXPLORE_MAX_TIME"), var_7_0.time)
	arg_7_0.newExploreTime_.text = var_7_1.time .. GetTips("HOUR")
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
