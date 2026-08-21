local var_0_0 = class("AutoChessLevelPopItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllerEx_:GetController("state")
	arg_2_0.arrwoController_ = arg_2_0.controllerEx_:GetController("arrow")
	arg_2_0.topController_ = arg_2_0.controllerEx_:GetController("top")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = AutoChessTools.GetRankLevelCfg(arg_3_3)
	local var_3_1 = AutoChessRankCfg[arg_3_1[1]]
	local var_3_2 = {}
	local var_3_3 = ""
	local var_3_4 = AutoChessRankCfg[arg_3_1[1]].baseline
	local var_3_5 = AutoChessRankCfg[arg_3_2 and arg_3_2[1] or arg_3_1[#arg_3_1]].baseline

	arg_3_0.levelImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_3_1.icon)
	arg_3_0.levelText_.text = var_3_4 < arg_3_3 and arg_3_3 < var_3_5 and var_3_0.name or var_3_1.name

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_6 = AutoChessRankCfg[iter_3_1]

		table.insert(var_3_2, var_3_6.baseline)
	end

	arg_3_0.scoreText_1.text = var_3_2[1] or "--"
	arg_3_0.scoreText_2.text = var_3_2[2] or "--"
	arg_3_0.scoreText_3.text = var_3_2[3] or "--"

	if arg_3_3 < var_3_4 then
		var_3_3 = "empty"
	elseif var_3_5 <= arg_3_3 then
		var_3_3 = "full"
	else
		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			if iter_3_3 <= arg_3_3 then
				var_3_3 = iter_3_2
			end
		end
	end

	arg_3_0.stateController_:SetSelectedState(var_3_3)
	arg_3_0.arrwoController_:SetSelectedState(tostring(arg_3_2 == nil))
	arg_3_0.topController_:SetSelectedState(tostring(arg_3_2 == nil))

	if arg_3_2 == nil then
		arg_3_0.totalScoreText_.text = var_3_2[1]
	end
end

return var_0_0
