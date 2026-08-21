local var_0_0 = class("HeroCooperationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/EsotericVideoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.heroItemPoolList = {}
	arg_4_0.poolList = {}
	arg_4_0.list = {}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.btnControllerList = {}

	for iter_5_0 = 1, 7 do
		arg_5_0.btnControllerList[iter_5_0] = ControllerUtil.GetController(arg_5_0[iter_5_0 .. "Btn_"].transform, "state")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, 7 do
		arg_6_0:AddBtnListener(arg_6_0[iter_6_0 .. "Btn_"], nil, function()
			arg_6_0:SelectAndSortData(iter_6_0)

			arg_6_0.scorllRect_.horizontalNormalizedPosition = 0

			arg_6_0:UpdateSkillList()
		end)
	end
end

function var_0_0.PlayCombineSkill(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.entrance_ == ViewConst.SYSTEM_ID.HERO_SKILL then
		OperationRecorder.RecordButtonTouch("video_play_comboskill_heroskill" .. arg_8_3)
	elseif arg_8_0.entrance_ == ViewConst.SYSTEM_ID.ILLUSTRATION then
		OperationRecorder.RecordButtonTouch("video_play_comboskill_illustration" .. arg_8_3)
	end

	local var_8_0
	local var_8_1 = "CooperateUniqueSkillTimeline/" .. arg_8_3
	local var_8_2, var_8_3 = CooperateSkillBridge.PlayCooperateUniqueSkill(arg_8_2, arg_8_3, var_8_0)
	local var_8_4 = arg_8_0.gameObject_.transform.position

	manager.windowBar:SwitchBar({})
	table.insert(arg_8_0.poolList, var_8_2)

	arg_8_0.gameObject_.transform.position = Vector3(1000, 1000, 1000)
	arg_8_0.list = arg_8_1

	table.insert(arg_8_0.list, {
		fromCSharp = true,
		obj = var_8_2,
		path = var_8_1
	})
	manager.audio:StopEffect()
	manager.audio:StopVoice()

	if arg_8_0.timer then
		return
	end

	arg_8_0.timer = TimeTools.StartAfterSeconds(var_8_3, function()
		if arg_8_0.timer == nil then
			return
		end

		arg_8_0.gameObject_.transform.position = var_8_4

		for iter_9_0, iter_9_1 in pairs(arg_8_1) do
			Object.DestroyImmediate(iter_9_1.obj)
			Asset.Unload(iter_9_1.path)
		end

		arg_8_0.list = {}

		arg_8_0.mainAnimator_:Play("EsotericVideoUI", 0, 0)
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})

		arg_8_0.timer = nil
	end, {})
end

function var_0_0.CreateComboSkill(arg_10_0, arg_10_1)
	local var_10_0 = Object.Instantiate(arg_10_0.itemGo_, arg_10_0.contentTrs_)

	arg_10_0.heroItemPoolList[arg_10_1] = HeroCooperationItem.New(var_10_0)

	return arg_10_0.heroItemPoolList[arg_10_1]
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_12_0)
	SetActive(arg_12_0.gameObject_, true)

	arg_12_0.heroId = arg_12_0.params_.heroId
	arg_12_0.entrance_ = arg_12_0.params_.entrance
	arg_12_0.heroSorter_ = HeroSorter.New()

	arg_12_0:UpdateData()
	arg_12_0:UpdateSkillList()

	arg_12_0.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
	arg_12_0.cinemachineBrain.enabled = true

	SetActive(arg_12_0.emptyGo_, false)
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end)
end

function var_0_0.UpdateData(arg_15_0)
	arg_15_0.view = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	local var_15_0 = arg_15_0.view:GetHeroIDList()

	arg_15_0.heroDataList = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0.view:GetHeroData(iter_15_1).tempID or 0

		arg_15_0.heroDataList[iter_15_0] = {
			id = iter_15_1,
			trialID = var_15_1,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT,
			heroViewProxy = arg_15_0.view
		}
	end

	arg_15_0:SelectAndSortData(7)
end

function var_0_0.SelectAndSortData(arg_16_0, arg_16_1)
	for iter_16_0 = 1, 7 do
		arg_16_0.btnControllerList[iter_16_0]:SetSelectedState(arg_16_1 == iter_16_0 and "selected" or "unselected")
	end

	if arg_16_1 == 6 then
		arg_16_1 = 9
	end

	arg_16_0.displayHeroDataList = {}

	if arg_16_1 == 7 then
		for iter_16_1, iter_16_2 in ipairs(arg_16_0.heroDataList) do
			if not HeroTools.GetIsHide(iter_16_2.id) and arg_16_0:DoseHeroHaveCooperation(iter_16_2.id) then
				table.insert(arg_16_0.displayHeroDataList, iter_16_2)
			end
		end
	else
		for iter_16_3, iter_16_4 in ipairs(arg_16_0.heroDataList) do
			if not HeroTools.GetIsHide(iter_16_4.id) and arg_16_0:DoseHeroHaveCooperation(iter_16_4.id) and HeroCfg[iter_16_4.id].race == arg_16_1 then
				table.insert(arg_16_0.displayHeroDataList, iter_16_4)
			end
		end
	end

	local var_16_0 = GameSetting.unlock_hero_need.value

	table.sort(arg_16_0.displayHeroDataList, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0.view:GetHeroData(arg_17_0.id)
		local var_17_1 = arg_16_0.view:GetHeroData(arg_17_1.id)
		local var_17_2 = false
		local var_17_3 = false

		if var_17_0.unlock ~= var_17_1.unlock then
			return var_17_0.unlock > var_17_1.unlock
		end

		if var_17_0.unlock == 0 and var_17_1.unlock == 0 then
			local var_17_4 = var_16_0[HeroCfg[arg_17_0.id].rare]
			local var_17_5 = var_16_0[HeroCfg[arg_17_1.id].rare]
			local var_17_6 = var_17_4 <= var_17_0.piece and 1 or 0
			local var_17_7 = var_17_5 <= var_17_1.piece and 1 or 0

			if var_17_6 ~= var_17_7 then
				return var_17_7 < var_17_6
			end
		end

		if arg_16_0.view.isSelf then
			local var_17_8 = HeroData:IsFavorite(arg_17_0.id)
			local var_17_9 = HeroData:IsFavorite(arg_17_1.id)

			if var_17_8 ~= var_17_9 and (not var_17_8 or not var_17_9) then
				return var_17_8 ~= false
			end
		end

		local var_17_10, var_17_11 = arg_16_0:FightPowerSorter(var_17_0, var_17_1, arg_17_0.heroViewProxy, arg_17_1.heroViewProxy)
		local var_17_12 = var_17_11

		if var_17_10 then
			return var_17_12
		end

		local var_17_13, var_17_14 = arg_16_0:StarSorter(var_17_0, var_17_1)
		local var_17_15 = var_17_14

		if var_17_13 then
			return var_17_15
		end

		local var_17_16, var_17_17 = arg_16_0:RareSorter(var_17_0, var_17_1)
		local var_17_18 = var_17_17

		if var_17_16 then
			return var_17_18
		end

		local var_17_19, var_17_20 = arg_16_0:LevelSorter(var_17_0, var_17_1)
		local var_17_21 = var_17_20

		if var_17_19 then
			return var_17_21
		end

		return arg_17_0.id > arg_17_1.id
	end)

	for iter_16_5, iter_16_6 in ipairs(arg_16_0.displayHeroDataList) do
		if iter_16_6.id == arg_16_0.heroId then
			arg_16_0.index = iter_16_5
		end
	end
end

function var_0_0.DoseHeroHaveCooperation(arg_18_0, arg_18_1)
	local var_18_0 = ComboSkillTools.GetHeroComboSkill(arg_18_1)

	if var_18_0 and #var_18_0 > 0 then
		return true
	end

	return false
end

function var_0_0.UpdateSkillList(arg_19_0)
	if arg_19_0.heroId then
		TimeTools.StartAfterSeconds(0.5, function()
			arg_19_0.contentTrs_.anchoredPosition = Vector2(-1 * math.max(arg_19_0.index - 1, 0) * (arg_19_0.itemRect_.rect.width + arg_19_0.contentLayout_.spacing), arg_19_0.contentTrs_.anchoredPosition.y)
		end, {})
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.heroItemPoolList) do
		SetActive(iter_19_1.gameObject_, false)
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.displayHeroDataList) do
		local var_19_0 = arg_19_0.heroItemPoolList[iter_19_2] or arg_19_0:CreateComboSkill(iter_19_2)

		SetActive(var_19_0.gameObject_, true)
		var_19_0:SetData(iter_19_3, handler(arg_19_0, arg_19_0.PlayCombineSkill), arg_19_0.heroId, handler(arg_19_0, arg_19_0.ClickCallBack), iter_19_2, arg_19_0.emptyGo_)
	end

	arg_19_0.emptyGo_.transform:SetSiblingIndex(#arg_19_0.heroItemPoolList)

	arg_19_0.heroId = nil
end

function var_0_0.ClickCallBack(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.heroItemPoolList) do
		if iter_21_1.gameObject_.activeSelf then
			if iter_21_1.data.id ~= arg_21_1 then
				if iter_21_1.showController:GetSelectedState() == "true" then
					iter_21_1.animator_:Play("EsotericVideo_02")
				end

				iter_21_1.showController:SetSelectedState("false")
			elseif iter_21_1.showController:GetSelectedState() == "false" then
				local var_21_0 = math.abs(arg_21_0.contentTrs_.anchoredPosition.x)
				local var_21_1 = arg_21_0.viewRect_.rect.width
				local var_21_2 = math.max(iter_21_1.index - 1, 0) * (arg_21_0.itemRect_.rect.width + arg_21_0.contentLayout_.spacing)

				if var_21_2 < var_21_0 then
					arg_21_0.contentTrs_.anchoredPosition = Vector2(-1 * var_21_2, arg_21_0.contentTrs_.anchoredPosition.y)
				elseif var_21_2 + arg_21_0.extentRect_.rect.width + arg_21_0.itemRect_.rect.width + arg_21_0.contentLayout_.spacing > var_21_0 + var_21_1 then
					arg_21_0.contentTrs_.anchoredPosition = Vector2(-1 * (iter_21_1.index * (arg_21_0.itemRect_.rect.width + arg_21_0.contentLayout_.spacing) - arg_21_0.contentLayout_.spacing - var_21_1 + arg_21_0.extentRect_.rect.width), arg_21_0.contentTrs_.anchoredPosition.y)
				end
			end
		end
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.ui:ResetMainCamera()

	if arg_22_0.timer then
		arg_22_0.timer:Stop()

		arg_22_0.timer = nil
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.list) do
		Object.DestroyImmediate(iter_22_1.obj)
	end

	arg_22_0.list = {}
	arg_22_0.cinemachineBrain.enabled = false

	for iter_22_2, iter_22_3 in pairs(arg_22_0.poolList) do
		Object.DestroyImmediate(iter_22_3)
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()

	for iter_23_0, iter_23_1 in pairs(arg_23_0.list) do
		Object.DestroyImmediate(iter_23_1.obj)
	end

	if arg_23_0.timer then
		arg_23_0.timer:Stop()

		arg_23_0.timer = nil
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.heroItemPoolList) do
		if iter_23_3 then
			iter_23_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.UnlockSorter(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1.unlock ~= arg_24_2.unlock then
		return true, arg_24_1.unlock > arg_24_2.unlock
	end

	return false, false
end

function var_0_0.IDSorter(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1.id ~= arg_25_2.id then
		return true, arg_25_1.id > arg_25_2.id
	end

	return false, false
end

function var_0_0.RareSorter(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = HeroCfg[arg_26_1.id]
	local var_26_1 = HeroCfg[arg_26_2.id]

	if var_26_0.rare ~= var_26_1.rare then
		return true, var_26_0.rare > var_26_1.rare
	end

	return false, false
end

function var_0_0.LevelSorter(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1.exp ~= arg_27_2.exp then
		return true, arg_27_1.exp > arg_27_2.exp
	end

	return false, false
end

function var_0_0.FightPowerSorter(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0
	local var_28_1

	if arg_28_1.tempID then
		var_28_0 = TempHeroData:GetBattlePower(arg_28_1.tempID)
	else
		var_28_0 = arg_28_0.heroSorter_:GetHeroPower(arg_28_1, handler(arg_28_3, arg_28_3.GetBattlePower))
	end

	if arg_28_2.tempID then
		var_28_1 = TempHeroData:GetBattlePower(arg_28_2.tempID)
	else
		var_28_1 = arg_28_0.heroSorter_:GetHeroPower(arg_28_2, handler(arg_28_4, arg_28_4.GetBattlePower))
	end

	if var_28_0 ~= var_28_1 then
		return true, var_28_1 < var_28_0
	end

	return false, false
end

function var_0_0.StarSorter(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1.star ~= arg_29_2.star then
		return true, arg_29_1.star > arg_29_2.star
	end

	return false, false
end

return var_0_0
