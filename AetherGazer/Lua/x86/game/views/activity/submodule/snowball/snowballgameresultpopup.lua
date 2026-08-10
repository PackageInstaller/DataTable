local var_0_0 = class("SnowballGameResultPopup", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.modeController = ControllerUtil.GetController(arg_3_0.transform_, "mode")
	arg_3_0.rewardController = ControllerUtil.GetController(arg_3_0.transform_, "reward")

	arg_3_0:AddBtnListener(arg_3_0.okBtn_, nil, function()
		JumpTools.Back()

		if arg_3_0.OkCallback then
			arg_3_0.OkCallback()
		end
	end)
end

local var_0_1 = {
	"normal",
	"hard",
	"infinite"
}

local function var_0_2(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = arg_5_1.level_reward[#arg_5_1.level_score]

	for iter_5_0 = 1, #arg_5_1.level_score + 1 do
		local var_5_2 = arg_5_1.level_score[iter_5_0] or math.huge
		local var_5_3 = arg_5_1.level_reward[iter_5_0] or var_5_1

		if arg_5_0 <= var_5_2 then
			return var_5_3
		end
	end
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = arg_6_0.params_.level
	local var_6_1 = SnowballGameCfg[var_6_0]
	local var_6_2 = arg_6_0.params_.hitGuestCount or 0

	arg_6_0.modeController:SetSelectedState(var_0_1[var_6_1.level_mode])

	arg_6_0.OkCallback = arg_6_0.params_.OkCallback

	local var_6_3 = GameSetting.activity_snowball_score_difficulty_factor.value[var_6_1.level_mode] or 1
	local var_6_4 = math.ceil(arg_6_0.params_.extraTime)
	local var_6_5 = math.floor(var_6_4 * GameSetting.activity_snowball_score_countdown_bonus.value[1])
	local var_6_6 = arg_6_0.params_.score + var_6_5
	local var_6_7 = math.ceil(var_6_6 * var_6_3)

	arg_6_0.score_.text = var_6_6

	if var_6_3 == 1 then
		arg_6_0.scale_.gameObject:SetActive(false)
	else
		arg_6_0.scale_.gameObject:SetActive(true)

		arg_6_0.scale_.text = "x" .. var_6_3

		if arg_6_0.textAni then
			LeanTween.cancel(arg_6_0.textAni.id)
		end

		local var_6_8 = LeanTween.value(var_6_6, var_6_7, 2):setEase(LeanTweenType.easeInOutQuad):setDelay(1.5)

		var_6_8:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
			arg_6_0.score_.text = math.floor(arg_7_0)
		end))
		var_6_8:setOnComplete(System.Action(function()
			arg_6_0.score_.text = var_6_7
			arg_6_0.textAni = nil
		end))

		arg_6_0.textAni = var_6_8
	end

	arg_6_0.time_.text = manager.time:DescCDTime(var_6_1.time_limit - var_6_4)

	local var_6_9 = var_0_2(var_6_7, var_6_1)

	arg_6_0.rewardController:SetSelectedState(var_6_9 ~= nil and "show" or "hide")

	if var_6_9 then
		arg_6_0.rewardIcon_.sprite = ItemTools.getItemLittleSprite(var_6_9[1])
		arg_6_0.reward_.text = string.format("+%d", var_6_9[2])
	end

	local var_6_10 = {}
	local var_6_11 = 1

	for iter_6_0, iter_6_1 in pairs(arg_6_0.params_.enemyList) do
		var_6_10[var_6_11] = {
			id = iter_6_0,
			count = iter_6_1
		}
		var_6_11 = var_6_11 + 1
	end

	local var_6_12 = SnowballGameMgr.GetInstance()

	var_6_10[var_6_11] = {
		count = var_6_2,
		id = var_6_12:GetGuestCfgID()
	}

	local var_6_13 = {
		level = var_6_0,
		score = var_6_7,
		seconds = var_6_1.time_limit - var_6_4,
		heroId = SnowballGameMgr.GetInstance():GetPlayerCfgID(),
		enemy_list = var_6_10
	}

	SnowballGameAction.LevelClearAction(var_6_13)
end

function var_0_0.OnExit(arg_9_0)
	if arg_9_0.textAni then
		LeanTween.cancel(arg_9_0.textAni.id)

		arg_9_0.textAni = nil
	end
end

return var_0_0
