local var_0_0 = class("IslandTowerClimbingGameView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTowerClimbingUI"
end

function var_0_0.GetMGData(arg_2_0)
	return getProxy(MiniGameProxy):GetMiniGameData(arg_2_0.contextData.miniGameId):clone()
end

function var_0_0.GetMGHubData(arg_3_0)
	return getProxy(MiniGameProxy):GetHubByGameId(arg_3_0.contextData.miniGameId)
end

function var_0_0.didEnter(arg_4_0)
	if not Physics2D.autoSimulation then
		Physics2D.autoSimulation = true
		arg_4_0.isChangeAutoSimulation = true
	end

	arg_4_0:Start()

	arg_4_0.backBtn = findTF(arg_4_0._tf, "overview/back")

	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, findTF(arg_4_0._tf, "overview/item"), function()
		arg_4_0:emit(BaseMiniGameMediator.OPEN_SUB_LAYER, {
			mediator = IslandGameLimitMediator,
			viewComponent = IslandGameLimitLayer,
			data = {
				type = IslandGameLimitLayer.limit_type_jiujiu
			}
		})

		return
	end, SFX_CANCEL)

	arg_4_0.itemConfig = Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id)

	LoadImageSpriteAsync(arg_4_0.itemConfig.icon, findTF(arg_4_0._tf, "overview/item/img"), true)

	arg_4_0.hub_id = pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_id

	local var_4_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_4_0.hub_id).count

	var_4_0 = var_4_0 or 0
	arg_4_0.itemNums = var_4_0

	setText(findTF(arg_4_0._tf, "overview/item/num"), arg_4_0.itemNums)

	return
end

function var_0_0.Start(arg_7_0)
	arg_7_0.controller = TowerClimbingController.New()

	arg_7_0.controller.view:SetUI(arg_7_0._go)
	arg_7_0.controller:SetCallBack(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_7_0:GetMGData():GetRuntimeData("elements")

		var_8_0 = var_8_0 or {}

		for iter_8_0 = 1, arg_8_3 do
			if iter_8_0 > #var_8_0 then
				table.insert(var_8_0, 0)
			end
		end

		if arg_8_0 >= var_8_0[arg_8_3] then
			var_8_0[arg_8_3] = arg_8_0

			arg_7_0:StoreDataToServer(var_8_0)
			arg_7_0:updateHighScore()
		end

		if arg_7_0:getGameTimes() and arg_7_0:getGameTimes() > 0 then
			arg_7_0.sendSuccessFlag = true

			arg_7_0:SendSuccess(0)
		end

		return
	end, function(arg_9_0, arg_9_1)
		return
	end)
	arg_7_0.controller:SetUp((arg_7_0:PackData()))

	return
end

function var_0_0.updateHighScore(arg_10_0)
	local var_10_0 = arg_10_0:GetMGData():GetRuntimeData("elements")

	var_10_0 = var_10_0 or {}

	if arg_10_0.controller then
		-- block empty
	end

	arg_10_0.controller:updateHighScore(var_10_0)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_11_0.hub_id).count

	var_11_0 = var_11_0 or 0
	arg_11_0.itemNums = var_11_0

	setText(findTF(arg_11_0._tf, "overview/item/num"), arg_11_0.itemNums)
	arg_11_0:updateHighScore()

	return
end

function var_0_0.getGameTimes(arg_12_0)
	return arg_12_0:GetMGHubData().count
end

function var_0_0.GetTowerClimbingPageAndScore(arg_13_0)
	return 0, 1, {
		0,
		0,
		0
	}
end

function var_0_0.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_15_0)
		return arg_15_0[1]
	end))
end

function var_0_0.PackData(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = var_0_0.GetTowerClimbingPageAndScore((arg_16_0:GetMGData():GetRuntimeData("elements")))

	print(var_16_0, "-", var_16_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = arg_16_0._tf.rect.width,
		screenHeight = arg_16_0._tf.rect.height,
		higestscore = var_16_0,
		pageIndex = var_16_1,
		mapScores = var_16_2,
		awards = var_0_0.GetAwardScores()
	}
end

function var_0_0.onBackPressed(arg_17_0)
	if arg_17_0.controller and arg_17_0.controller:onBackPressed() then
		return
	end

	arg_17_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_18_0)
	if arg_18_0.controller then
		arg_18_0.controller:Dispose()
	end

	if arg_18_0.isChangeAutoSimulation then
		Physics2D.autoSimulation = false
		arg_18_0.isChangeAutoSimulation = nil
	end

	return
end

return var_0_0
