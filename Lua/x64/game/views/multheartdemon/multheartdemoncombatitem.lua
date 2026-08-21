local var_0_0 = class("MultHeartDemonCombatItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selectBtn_, nil, function()
		if arg_3_0.isPlayer then
			arg_3_0:GoToHeroTeamPage()
		end
	end)

	if arg_3_0.swapBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.swapBtn_, nil, function()
			if arg_3_0.isPlayer then
				arg_3_0.callback(arg_3_0.index)
			end
		end)
	end

	if arg_3_0.swapBtn2_ then
		arg_3_0:AddBtnListener(arg_3_0.swapBtn2_, nil, function()
			if arg_3_0.isPlayer then
				arg_3_0:GoToHeroTeamPage()
			end
		end)
	end

	if arg_3_0.changeBtn1_ then
		arg_3_0:AddBtnListener(arg_3_0.changeBtn1_, nil, function()
			arg_3_0.swapCallback(arg_3_0.index)
		end)
		arg_3_0:AddBtnListener(arg_3_0.changeBtn2_, nil, function()
			arg_3_0.swapCallback(arg_3_0.index)
		end)
	end

	if arg_3_0.tipsBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.tipsBtn_, nil, function()
			arg_3_0:ShowAffixInfo()
		end)
	end
end

function var_0_0.ShowAffixInfo(arg_10_0)
	SetActive(arg_10_0.tipsGo_, true)

	if arg_10_0.countdownTimer_ then
		arg_10_0.countdownTimer_:Stop()

		arg_10_0.countdownTimer_ = nil
	end

	arg_10_0.countdownTimer_ = Timer.New(function()
		arg_10_0:HideAffixInfo()
	end, 3, 1)

	arg_10_0.countdownTimer_:Start()
end

function var_0_0.HideAffixInfo(arg_12_0)
	if arg_12_0.countdownTimer_ then
		arg_12_0.countdownTimer_:Stop()

		arg_12_0.countdownTimer_ = nil
	end

	SetActive(arg_12_0.tipsGo_, false)
end

function var_0_0.GoToHeroTeamPage(arg_13_0)
	JumpTools.GoToSystem("/multHeartDemonHeroTeamInfo", {
		clickIndex = arg_13_0.index,
		difficult = arg_13_0.difficult,
		activityID = arg_13_0.activityID,
		stage_id = arg_13_0.stage_id,
		stageType = BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON,
		isLock = arg_13_0.isLock
	})
end

function var_0_0.InitUI(arg_14_0)
	arg_14_0:BindCfgUI()

	arg_14_0.normalController = arg_14_0.collection:GetController("normal")
	arg_14_0.pressController = arg_14_0.collection:GetController("Press")
	arg_14_0.imgLanController = arg_14_0.collection:GetController("Imglan")
	arg_14_0.powerUpController = arg_14_0.collection:GetController("Selected")
	arg_14_0.HpController = arg_14_0.collection:GetController("bar")
	arg_14_0.deathController = arg_14_0.collection:GetController("disable")
	arg_14_0.handOffController = arg_14_0.collection:GetController("handoff")
	arg_14_0.ImgzzController = arg_14_0.collection:GetController("Imgzz")
	arg_14_0.fgController = arg_14_0.collection:GetController("fg")
	arg_14_0.Imgzz02Controller = arg_14_0.collection:GetController("Imgzz02")
	arg_14_0.affixController = arg_14_0.collection:GetController("affix")
end

function var_0_0.SetData(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9, arg_15_10, arg_15_11)
	arg_15_0.index = arg_15_2
	arg_15_0.data = arg_15_1
	arg_15_0.cfg = arg_15_4
	arg_15_0.isPlayer = arg_15_0.index <= 3
	arg_15_0.selectList = arg_15_3 or {}
	arg_15_0.difficult = arg_15_5
	arg_15_0.activityID = arg_15_6
	arg_15_0.playerIndex = arg_15_7
	arg_15_0.aiIndex = arg_15_8
	arg_15_0.stage_id = arg_15_9
	arg_15_0.callback = arg_15_10
	arg_15_0.swapCallback = arg_15_11
	arg_15_0.isLock = MultHeartDemonData:GetDataByPara("isLock") or false

	if arg_15_0.isLock == false then
		arg_15_0.playerIndex = 1
	end

	arg_15_0:UpdateView()
end

function var_0_0.ShowSwapActiveBtn(arg_16_0, arg_16_1)
	arg_16_0.handOffController:SetSelectedState(arg_16_1 and "state0" or "state1")
end

function var_0_0.RestoreSwapActiveBtn(arg_17_0)
	if arg_17_0:IsEmptySlot() then
		arg_17_0:ShowSwapActiveBtn(next(arg_17_0.selectList))
	else
		arg_17_0:ShowSwapActiveBtn(not arg_17_0.isLock)
	end
end

function var_0_0.SetSwapEnabled(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 and "state0" or "state1"

	if arg_18_0:IsEmptySlot() then
		arg_18_0.Imgzz02Controller:SetSelectedState("state1")
		arg_18_0.ImgzzController:SetSelectedState(var_18_0)
	else
		arg_18_0.Imgzz02Controller:SetSelectedState(var_18_0)
		arg_18_0.ImgzzController:SetSelectedState("state1")
	end

	if arg_18_1 then
		arg_18_0:ShowSwapActiveBtn(false)
	else
		arg_18_0:RestoreSwapActiveBtn()
	end
end

function var_0_0.SetHighlighted(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1 and "state0" or "state1"

	arg_19_0.fgController:SetSelectedState(var_19_0)
end

function var_0_0.IsEmptySlot(arg_20_0)
	return arg_20_0.isPlayer and arg_20_0.selectList[arg_20_0.index] == nil
end

function var_0_0.ColllectImageComsRecursive(arg_21_0)
	arg_21_0.collectedImgs = arg_21_0.gameObject_:GetComponentsInChildren(typeof(Image), true):ToTable()
end

function var_0_0.SetGreyRecursive(arg_22_0, arg_22_1)
	if arg_22_0.collectedImgs == nil then
		arg_22_0:ColllectImageComsRecursive()
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.collectedImgs) do
		manager.effect:SetGrey(iter_22_1, arg_22_1)
	end
end

function var_0_0.SetAffix(arg_23_0)
	local var_23_0 = arg_23_0.cfg.trial_hero
	local var_23_1 = arg_23_0.cfg.hero_attrib

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if arg_23_0.selectList[arg_23_0.index] == iter_23_1 and var_23_1[iter_23_0] and #var_23_1[iter_23_0] > 0 then
			arg_23_0.affixController:SetSelectedIndex(0)

			return
		end
	end

	arg_23_0.affixController:SetSelectedIndex(1)
end

function var_0_0.UpdatePlayer(arg_24_0)
	local var_24_0 = arg_24_0.selectList[arg_24_0.index]

	arg_24_0.normalController:SetSelectedState(var_24_0 and "state0" or "state1")
	arg_24_0:SetSwapEnabled(false)
	arg_24_0:SetHighlighted(false)

	local var_24_1 = false

	if var_24_0 then
		if HeroStandardSystemCfg[var_24_0] then
			arg_24_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. HeroStandardSystemCfg[var_24_0].skin_id)
		else
			local var_24_2 = HeroData:GetHeroUsingSkinInfo(var_24_0).id

			arg_24_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_24_2)
		end

		arg_24_0.pressController:SetSelectedState("state0")

		if arg_24_0.data.heroHPList and arg_24_0.data.heroHPList[var_24_0] then
			local var_24_3 = arg_24_0.data.heroHPList[var_24_0]

			if var_24_3 == 0 then
				arg_24_0.HPSlider_.value = 0
				var_24_1 = true

				arg_24_0.deathController:SetSelectedState("state0")
				arg_24_0.powerUpController:SetSelectedState("state1")
			else
				arg_24_0.HPSlider_.value = var_24_3 / 100

				arg_24_0.deathController:SetSelectedState("state1")
				arg_24_0.powerUpController:SetSelectedState("state0")
			end

			arg_24_0.HPTxt_.text = var_24_3 .. "%"
		else
			arg_24_0.HPSlider_.value = 1

			arg_24_0.deathController:SetSelectedState("state1")

			arg_24_0.HPTxt_.text = "100%"

			arg_24_0.powerUpController:SetSelectedState(arg_24_0.index == arg_24_0.playerIndex and "state0" or "state1")
		end
	else
		arg_24_0.pressController:SetSelectedState("state1")
		arg_24_0.HpController:SetSelectedState("state1")
		arg_24_0.deathController:SetSelectedState("state1")
		arg_24_0.powerUpController:SetSelectedState(arg_24_0.index == arg_24_0.playerIndex and "state0" or "state1")
	end

	arg_24_0:SetGreyRecursive(var_24_1)

	if arg_24_0.isLock == false then
		arg_24_0.powerUpController:SetSelectedState("state1")
	end

	arg_24_0:RestoreSwapActiveBtn()
	SetActive(arg_24_0.tipsGo_, false)
	arg_24_0.affixController:SetSelectedIndex(1)
	arg_24_0:SetAffix()
end

function var_0_0.UpdateAI(arg_25_0)
	arg_25_0.normalController:SetSelectedState("state1")

	arg_25_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_25_0.cfg.heart_damon_id[arg_25_0.index - 3] - 4000)

	arg_25_0.HpController:SetSelectedState("state0")
	arg_25_0.pressController:SetSelectedState("state0")
	arg_25_0.deathController:SetSelectedState("state1")

	local var_25_0 = false

	if arg_25_0.data then
		if arg_25_0.data.heroHPList and arg_25_0.data.heroHPList[arg_25_0.cfg.heart_damon_id[arg_25_0.index - 3]] then
			if arg_25_0.data.heroHPList[arg_25_0.cfg.heart_damon_id[arg_25_0.index - 3]] == 0 then
				arg_25_0.HPSlider_.value = 0
				var_25_0 = true

				arg_25_0.deathController:SetSelectedState("state0")
				arg_25_0.powerUpController:SetSelectedState("state1")
			else
				arg_25_0.HPSlider_.value = arg_25_0.data.heroHPList[arg_25_0.cfg.heart_damon_id[arg_25_0.index - 3]] / 100

				arg_25_0.deathController:SetSelectedState("state1")
				arg_25_0.powerUpController:SetSelectedState("state0")
			end

			arg_25_0.HPTxt_.text = arg_25_0.data.heroHPList[arg_25_0.cfg.heart_damon_id[arg_25_0.index - 3]] .. "%"
		else
			arg_25_0.HPSlider_.value = 1
			arg_25_0.HPTxt_.text = "100%"

			arg_25_0.powerUpController:SetSelectedState(arg_25_0.index - 3 == arg_25_0.aiIndex and "state0" or "state1")
		end
	else
		arg_25_0.HPSlider_.value = 1

		arg_25_0.deathController:SetSelectedState("state1")

		arg_25_0.HPTxt_.text = "100%"

		arg_25_0.powerUpController:SetSelectedState(arg_25_0.index - 3 == arg_25_0.aiIndex and "state0" or "state1")
	end

	arg_25_0:SetGreyRecursive(var_25_0)

	if arg_25_0.isLock == false then
		arg_25_0.powerUpController:SetSelectedState("state1")
	end
end

function var_0_0.UpdateView(arg_26_0)
	if arg_26_0.isPlayer then
		arg_26_0:UpdatePlayer()
	else
		arg_26_0:UpdateAI()
	end
end

function var_0_0.OnEnter(arg_27_0)
	arg_27_0:UpdateView()
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:HideAffixInfo()

	arg_28_0.collectedImgs = nil
end

function var_0_0.Dispose(arg_29_0)
	var_0_0.super.Dispose(arg_29_0)
	Object.Destroy(arg_29_0.gameObject_)
end

return var_0_0
