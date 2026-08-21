local var_0_0 = import("game.views.pop.PopFramingBaseView")
local var_0_1 = class("NewHeroSurpassPhaseUpView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_transition/HeroPrintRewardUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attrItemList = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.attrItemList[iter_4_0] = HeroSurpassAttrItem.New(arg_4_0["message" .. iter_4_0 .. "Go_"])
	end
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		arg_5_0:Back(false)
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0.starID = arg_7_0.params_.starID
	arg_7_0.heroID = arg_7_0.params_.heroID

	arg_7_0:Refresh()

	if arg_7_0.starID == 600 then
		HeroTools.PlayTalk(arg_7_0.heroID, "pro3", 1)
	elseif arg_7_0.starID == 500 then
		HeroTools.PlayTalk(arg_7_0.heroID, "pro2", 1)
	else
		HeroTools.PlayTalk(arg_7_0.heroID, "pro1", 1)
	end
end

function var_0_1.Refresh(arg_8_0)
	local var_8_0 = HeroStarCfg[arg_8_0.starID]
	local var_8_1 = HeroCfg[arg_8_0.heroID]

	SurpassTools.ChangeIconStarSpirte(arg_8_0.iconImg_, var_8_0.star - 1)
	SurpassTools.ChangeIconStarSpirte(arg_8_0.icon_changeImg_, var_8_0.star)

	local var_8_2 = var_8_0.star
	local var_8_3 = math.max(var_8_2 - 1, 0)

	arg_8_0.attrItemList[1]:RefreshUI(var_8_1.atk_ratio[var_8_3], var_8_1.atk_ratio[var_8_2], 1, true)
	arg_8_0.attrItemList[2]:RefreshUI(var_8_1.arm_ratio[var_8_3], var_8_1.arm_ratio[var_8_2], 2, true)
	arg_8_0.attrItemList[3]:RefreshUI(var_8_1.sta_ratio[var_8_3], var_8_1.sta_ratio[var_8_2], 3, true)

	local var_8_4, var_8_5 = SurpassTools.GetStarUpAttrShowDesc(var_8_1, arg_8_0.starID)

	arg_8_0.specialtextText_.text = var_8_5

	if var_8_5 ~= "" then
		SetActive(arg_8_0.specialnodeGo_, true)
	else
		SetActive(arg_8_0.specialnodeGo_, false)
	end
end

function var_0_1.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.attrItemList) do
		if iter_9_1 then
			iter_9_1:Dispose()
		end
	end

	var_0_1.super.Dispose(arg_9_0)
end

return var_0_1
