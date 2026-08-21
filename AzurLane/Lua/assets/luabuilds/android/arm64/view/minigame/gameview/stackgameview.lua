local var_0_0 = class("StackGameView", import("..BaseMiniGameView"))

var_0_0.MINIGAME_HUB_ID = 39
var_0_0.MINIGAME_ID = 47

function var_0_0.getUIName(arg_1_0)
	return "PileGameUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("overview/back")
	arg_2_0.scrollrect = arg_2_0._tf:Find("overview/levels"):GetComponent(typeof(ScrollRect))
	arg_2_0.levelUIlist = UIItemList.New(arg_2_0._tf:Find("overview/levels/mask/content"), arg_2_0._tf:Find("overview/levels/mask/content/1"))
	arg_2_0.topArrBtn = arg_2_0._tf:Find("overview/levels/top")
	arg_2_0.bottomArrBtn = arg_2_0._tf:Find("overview/levels/bottom")

	return
end

local var_0_1 = 7

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.topArrBtn, function()
		local var_5_0 = arg_3_0.scrollrect.normalizedPosition.y + 1 / (var_0_1 - 4)

		if arg_3_0.scrollrect.normalizedPosition.y + 1 / (var_0_1 - 4) > 1 then
			var_5_0 = 1
		end

		scrollTo(arg_3_0.scrollrect, 0, var_5_0)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.bottomArrBtn, function()
		local var_6_0 = arg_3_0.scrollrect.normalizedPosition.y - 1 / (var_0_1 - 4)

		if arg_3_0.scrollrect.normalizedPosition.y - 1 / (var_0_1 - 4) < 0 then
			var_6_0 = 0
		end

		scrollTo(arg_3_0.scrollrect, 0, var_6_0)

		return
	end, SFX_PANEL)
	arg_3_0.levelUIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateLevelTr(arg_7_1 + 1, arg_7_2)
		end

		return
	end)
	arg_3_0.levelUIlist:align(var_0_1)

	arg_3_0.controller = PileGameController.New()

	arg_3_0.controller.view:SetUI(arg_3_0._go)
	arg_3_0.controller:SetUp(arg_3_0:PackData(), function(arg_8_0, arg_8_1)
		if arg_8_1 < arg_8_0 then
			arg_3_0:StoreDataToServer({
				arg_8_0
			})
		end

		local var_8_0 = arg_3_0:GetMGHubData().count

		if var_8_0 > 0 then
			arg_3_0:SendSuccess(0)
		end

		return
	end)

	return
end

function var_0_0.UpdateLevelTr(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0_0.MINIGAME_HUB_ID)
	local var_9_1 = arg_9_2:Find("unopen")
	local var_9_2 = arg_9_2:Find("award")

	setActive(arg_9_2:Find("clear"), arg_9_1 <= var_9_0.usedtime)

	local var_9_3 = arg_9_1 > var_9_0.count + var_9_0.usedtime

	setActive(var_9_1, arg_9_1 > var_9_0.count + var_9_0.usedtime)
	setActive(var_9_2, not var_9_3)

	if not var_9_3 then
		updateDrop(var_9_2, {
			type = pg.mini_game[var_0_0.MINIGAME_ID].simple_config_data.drop[arg_9_1][1],
			id = pg.mini_game[var_0_0.MINIGAME_ID].simple_config_data.drop[arg_9_1][2],
			count = pg.mini_game[var_0_0.MINIGAME_ID].simple_config_data.drop[arg_9_1][3]
		})
		onButton(arg_9_0, var_9_2, function()
			arg_9_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	local var_9_4 = arg_9_2:Find("Text")

	var_9_4:GetComponent(typeof(Image)).sprite = LoadSprite("ui/minigameui/pile_atlas", "level" .. arg_9_1)

	return
end

function var_0_0.PackData(arg_11_0)
	local var_11_0 = arg_11_0:GetMGData():GetRuntimeData("elements")

	if var_11_0 then
		local var_11_1 = var_11_0[1] or 0

		return {
			highestScore = var_11_1,
			screen = Vector2(arg_11_0._tf.rect.width, arg_11_0._tf.rect.height)
		}
	end
end

function var_0_0.OnGetAwardDone(arg_12_0, arg_12_1)
	arg_12_0.levelUIlist:align(var_0_1)

	return
end

function var_0_0.onBackPressed(arg_13_0)
	if arg_13_0.controller:onBackPressed() then
		return
	end

	arg_13_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0.controller:Dispose()

	return
end

return var_0_0
