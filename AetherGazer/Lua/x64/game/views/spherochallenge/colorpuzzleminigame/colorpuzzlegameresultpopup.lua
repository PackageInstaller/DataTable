local var_0_0 = class("ColorPuzzleGameResultPopup", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.maskBtn_, nil, function()
		JumpTools.Back()

		if arg_3_0.okCallback then
			arg_3_0.okCallback()
		end
	end)

	arg_3_0.rewardItem = {}

	for iter_3_0 = 1, arg_3_0.reward_.childCount do
		local var_3_0 = arg_3_0.reward_:GetChild(iter_3_0 - 1).gameObject
		local var_3_1 = {
			gameObject = var_3_0
		}

		arg_3_0:BindCfgUI(var_3_0, var_3_1)

		arg_3_0.rewardItem[iter_3_0] = var_3_1
	end
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = arg_5_0.params_.level

	arg_5_0.okCallback = arg_5_0.params_.okCallback

	local var_5_1 = ActivityHeroChallengeColor[var_5_0]

	arg_5_0.levelName_.text = GetI18NText(var_5_1.name)
	arg_5_0.time_.text = manager.time:DescCDTime(arg_5_0.params_.time)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.rewardItem) do
		local var_5_2 = nullable(arg_5_0.params_.rewards, iter_5_0)
		local var_5_3 = nullable(var_5_2, "num") or 0

		if var_5_2 and var_5_3 > 0 then
			SetActive(iter_5_1.gameObject, true)

			iter_5_1.icon_.sprite = ItemTools.getItemLittleSprite(var_5_2.id)
			iter_5_1.count_.text = var_5_3
		else
			SetActive(iter_5_1.gameObject, false)
		end
	end
end

return var_0_0
