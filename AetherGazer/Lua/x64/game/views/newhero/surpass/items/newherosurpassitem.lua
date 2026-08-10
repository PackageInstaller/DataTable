local var_0_0 = class("NewHeroSurpassItem", ReduxView)
local var_0_1 = {
	lockState = {
		selectLock = "1",
		name = "lock",
		normalLock = "2"
	},
	selectState = {
		name = "select",
		use = "2",
		unUse = "1"
	},
	useLockState = {
		name = "on",
		lock = "2",
		unlock = "1"
	},
	titleState = {
		lock = "2",
		name = "title",
		noTitle = "1",
		unlock = "3"
	},
	upState = {
		name = "up",
		noUp = "state0",
		canUp = "state1"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controllerexcollection_:GetController(var_0_1.lockState.name)
	arg_2_0.selectController = arg_2_0.controllerexcollection_:GetController(var_0_1.selectState.name)
	arg_2_0.useLockController = arg_2_0.controllerexcollection_:GetController(var_0_1.useLockState.name)
	arg_2_0.titleController = arg_2_0.controllerexcollection_:GetController(var_0_1.titleState.name)
	arg_2_0.upController = arg_2_0.controllerexcollection_:GetController(var_0_1.upState.name)

	arg_2_0:AddBtnListener(arg_2_0.btnbigitemBtn_, nil, function()
		if arg_2_0.clickCallBack then
			arg_2_0.clickCallBack()
		end
	end)

	arg_2_0.beginAlpha = arg_2_0:GetAlpha()
	arg_2_0.beginScale = arg_2_0:GetScale()

	arg_2_0:PlayLessenAni()
end

function var_0_0.ChangeLockState(arg_4_0, arg_4_1)
	local var_4_0 = true

	for iter_4_0, iter_4_1 in pairs(arg_4_0.starIdList or {}) do
		if iter_4_1 <= arg_4_1 + 1 then
			var_4_0 = false
		end
	end

	local var_4_1 = arg_4_0.isGrow and var_0_1.lockState.selectLock or var_0_1.lockState.normalLock

	arg_4_0.lockController:SetSelectedState(var_4_1)

	if var_4_0 ~= arg_4_0.isLock then
		local var_4_2 = var_4_0 and var_0_1.useLockState.lock or var_0_1.useLockState.unlock

		arg_4_0.useLockController:SetSelectedState(var_4_2)
	end

	arg_4_0.isLock = var_4_0

	arg_4_0:UpdateTitleState()
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	if not arg_5_0.starStage then
		return
	end

	local var_5_0 = arg_5_1.star

	arg_5_0:ChangeLockState(var_5_0)
	arg_5_0.selectController:SetSelectedState(var_0_1.selectState.unUse)
	SurpassTools.UpdateSliImageFill(arg_5_0.slistateblackImg_, arg_5_0.starStage, var_5_0)

	local var_5_1 = SurpassTools.GetNextSurpassStarID(var_5_0)
	local var_5_2 = HeroStarCfg[var_5_0]
	local var_5_3 = var_0_1.upState.noUp
	local var_5_4 = var_5_2.gold_cost

	if checkGold(var_5_4, false) and arg_5_1.piece >= var_5_2.star_up and var_5_1 == arg_5_0.starIdList[1] then
		var_5_3 = var_0_1.upState.canUp
	end

	arg_5_0.upController:SetSelectedState(var_5_3)

	local var_5_5 = HeroCfg[arg_5_1.id]

	if HeroStarCfg[var_5_5.unlock_star].star == arg_5_0.starStage then
		arg_5_0.isBeginStarStage = true
	end
end

function var_0_0.SetStarStage(arg_6_0, arg_6_1)
	arg_6_0.starStage = arg_6_1
	arg_6_0.starIdList = HeroStarCfg.get_id_list_by_star[arg_6_1]

	SurpassTools.ChangeIconStarSpirte(arg_6_0.iconImg_, arg_6_1)
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack = arg_7_1
end

function var_0_0.GetStarIdList(arg_8_0)
	return arg_8_0.starIdList
end

function var_0_0.GetTransform(arg_9_0)
	return arg_9_0.transform_
end

function var_0_0.GetPosition(arg_10_0)
	return arg_10_0.transform_.anchoredPosition
end

function var_0_0.SetPosition(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.transform_.anchoredPosition = Vector2(arg_11_1, arg_11_2)
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	arg_12_0.gameObject_:SetActive(arg_12_1)
end

function var_0_0.GetStarStage(arg_13_0)
	return arg_13_0.starStage
end

function var_0_0.ChangeAlpha(arg_14_0, arg_14_1)
	arg_14_0.canvasgroup_.alpha = arg_14_1
end

function var_0_0.GetAlpha(arg_15_0)
	return arg_15_0.canvasgroup_.alpha
end

function var_0_0.GetBeginAlpha(arg_16_0)
	return arg_16_0.beginAlpha
end

function var_0_0.GetScale(arg_17_0)
	return arg_17_0.transform_.localScale
end

function var_0_0.SetScale(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_1.x and arg_18_1.x < 1 then
		arg_18_0.animator_.enabled = false
	end

	arg_18_0.transform_.localScale = arg_18_1
end

function var_0_0.GetBeginScale(arg_19_0)
	return arg_19_0.beginScale
end

function var_0_0.PlayLessenAni(arg_20_0)
	arg_20_0.animator_:SetFloat("speed", -1)
	arg_20_0.animator_:Play("Fx_btnbigItem_cx", 0, 0.4)
end

function var_0_0.PlayScaleAni(arg_21_0, arg_21_1)
	arg_21_0.isGrow = arg_21_1

	if arg_21_0:GetScale().x <= 1.1 and not arg_21_1 then
		arg_21_0.animator_.enabled = false
	else
		arg_21_0.animator_.enabled = true
	end

	local var_21_0 = arg_21_1 and 1 or -1

	if var_21_0 == arg_21_0.animator_:GetFloat("speed") then
		return
	end

	arg_21_0.animator_:SetFloat("speed", var_21_0)

	local var_21_1, var_21_2 = arg_21_0:GetClipTimes()

	if arg_21_1 then
		arg_21_0.animator_:Play("Fx_btnbigItem_cx", 0, var_21_2 - var_21_1)
	else
		arg_21_0.animator_:Play("Fx_btnbigItem_cx", 0, var_21_1)
	end

	if not arg_21_1 then
		arg_21_0:PlaySelectAni(false)
	end

	local var_21_3 = arg_21_1 and var_0_1.lockState.selectLock or var_0_1.lockState.normalLock

	arg_21_0.lockController:SetSelectedState(var_21_3)
	arg_21_0:UpdateTitleState()
end

function var_0_0.UpdateTitleState(arg_22_0)
	local var_22_0 = var_0_1.titleState.noTitle

	if arg_22_0.isGrow then
		var_22_0 = arg_22_0.isLock and var_0_1.titleState.lock or var_0_1.titleState.unlock
	end

	arg_22_0.titleController:SetSelectedState(var_22_0)
end

function var_0_0.PlaySelectAni(arg_23_0, arg_23_1)
	if arg_23_0.isBeginStarStage then
		arg_23_0.selectController:SetSelectedState(var_0_1.selectState.unUse)

		return
	end

	if arg_23_1 then
		arg_23_0.selectController:SetSelectedState(var_0_1.selectState.use)
	else
		arg_23_0.selectController:SetSelectedState(var_0_1.selectState.unUse)
	end
end

function var_0_0.GetClipTimes(arg_24_0)
	local var_24_0 = arg_24_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime
	local var_24_1 = arg_24_0.animator_:GetCurrentAnimatorClipInfo(0)

	if arg_24_0.animator_:GetCurrentAnimatorClipInfoCount(0) <= 0 then
		return 0, 0
	end

	local var_24_2 = var_24_1[0].clip.length
	local var_24_3 = var_24_2

	if var_24_0 < 1 and var_24_0 > 0 then
		var_24_3 = var_24_2 * var_24_0
	end

	return var_24_3, var_24_2
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
