local var_0_0 = class("SnowballGameChangePlayerUI", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballCharacterChangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local function var_0_1()
	gameContext:Go("/snowballGameLevelUI", nil, true, false)
end

local var_0_2 = Dorm.DormEntityManager.PutEntityAt

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AdaptScreen()
	arg_4_0:InitHeroHeadIcons()

	arg_4_0.changeController = ControllerUtil.GetController(arg_4_0.transform_, "change")

	arg_4_0:AddBtnListener(arg_4_0.changeBtn_, nil, function()
		SnowballGameData:SetLastSelectedPlayer(arg_4_0.select)

		local var_5_0 = SnowballGameMgr.GetInstance()

		var_0_2(var_5_0:GetPlayerEID(), arg_4_0.originalPos)
		var_0_1()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = SnowballGameMgr.GetInstance()

	arg_6_0.currentPlayer = var_6_0:GetPlayerCfgID()
	arg_6_0.select = arg_6_0.currentPlayer
	arg_6_0.playerPos = Dorm.storage:PickData("snowball.pos.changePlayer").transform
	arg_6_0.originalPos = var_6_0.playerSpawnPos

	var_0_2(var_6_0:GetPlayerEID(), arg_6_0.playerPos)
	arg_6_0:RefreshUI()
	arg_6_0:StartTimer()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	arg_7_0:StopTimer()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		local var_9_0 = SnowballGameMgr.GetInstance()

		if arg_8_0.currentPlayer ~= arg_8_0.select then
			var_9_0:SetPlayer(arg_8_0.currentPlayer)
		else
			var_0_2(var_9_0:GetPlayerEID(), arg_8_0.originalPos)
		end

		var_0_1()
	end)
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.InitHeroHeadIcons(arg_11_0)
	local var_11_0 = arg_11_0.headIconPrefab_
	local var_11_1 = SnowballGameUnitCfg.get_id_list_by_unit_type[0]

	arg_11_0.heroBtnList = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = GameObject.Instantiate(var_11_0, arg_11_0.headIconRoot_)
		local var_11_3 = {
			gameObject_ = var_11_2
		}

		arg_11_0:BindCfgUI(var_11_2, var_11_3)

		var_11_3.id = iter_11_1
		var_11_3.modeController = ControllerUtil.GetController(var_11_2.transform, "mode")

		arg_11_0:AddBtnListener(var_11_3.btn_, nil, function()
			if arg_11_0.select == iter_11_1 then
				return
			end

			arg_11_0.select = iter_11_1

			arg_11_0:SetPlayer()
		end)
		table.insert(arg_11_0.heroBtnList, var_11_3)
	end
end

function var_0_0.RefreshUI(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroBtnList) do
		if iter_13_1.id == arg_13_0.select then
			iter_13_1.modeController:SetSelectedState("select")
		elseif iter_13_1.id == arg_13_0.currentPlayer then
			iter_13_1.modeController:SetSelectedState("current")
		else
			iter_13_1.modeController:SetSelectedState("normal")
		end

		local var_13_0 = SnowballGameUnitCfg[iter_13_1.id]

		iter_13_1.icon_.sprite = pureGetSpriteWithoutAtlas(var_13_0.head_image)
	end

	local var_13_1 = arg_13_0.select and arg_13_0.select ~= arg_13_0.currentPlayer

	arg_13_0.changeController:SetSelectedState(var_13_1 and "enable" or "disable")
	arg_13_0:SetHeroInfo(arg_13_0.select)
	arg_13_0:RefreshTimeText()
end

function var_0_0.SetHeroInfo(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return
	end

	local var_14_0 = SnowballGameUnitCfg[arg_14_1]

	arg_14_0.name_.text = var_14_0.name

	local var_14_1 = SnowballGameUnitCfg[arg_14_1]

	arg_14_0.powerBar_.fillAmount = var_14_1.ready_show
	arg_14_0.speedBar_.fillAmount = var_14_1.speed_show
	arg_14_0.reloadBar_.fillAmount = var_14_1.cd_show
	arg_14_0.accBar_.fillAmount = var_14_1.hit_show
end

function var_0_0.SetPlayer(arg_15_0)
	local var_15_0 = SnowballGameMgr.GetInstance()

	var_15_0:SetPlayer(arg_15_0.select)
	var_0_2(var_15_0:GetPlayerEID(), arg_15_0.playerPos)
	arg_15_0:RefreshUI()
end

function var_0_0.RefreshTimeText(arg_16_0)
	arg_16_0.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)
end

function var_0_0.StartTimer(arg_17_0)
	arg_17_0:StopTimer()

	arg_17_0.timer = Timer.New(function()
		arg_17_0:RefreshTimeText()
	end, 1, -1)

	arg_17_0.timer:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer then
		arg_19_0.timer:Stop()

		arg_19_0.timer = nil
	end
end

return var_0_0
