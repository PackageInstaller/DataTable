local AutoChessLevelPopItemView = class("AutoChessLevelPopItemView", ReduxView)

function AutoChessLevelPopItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessLevelPopItemView:Init()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.arrwoController_ = self.controllerEx_:GetController("arrow")
	self.topController_ = self.controllerEx_:GetController("top")
end

function AutoChessLevelPopItemView:SetData(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = AutoChessTools.GetRankLevelCfg(arg_3_3)
	local var_3_1 = AutoChessRankCfg[arg_3_1[1]]
	local var_3_2 = {}
	local var_3_3 = ""
	local var_3_4 = AutoChessRankCfg[arg_3_1[1]].baseline
	local var_3_5 = AutoChessRankCfg[(arg_3_2 or nil) and (arg_3_2[1] or arg_3_1[#arg_3_1])].baseline

	self.levelImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_3_1.icon)

	if var_3_4 < arg_3_3 and arg_3_3 < var_3_5 then
		self.levelText_.text = var_3_0.name or var_3_1.name
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_3_2, AutoChessRankCfg[iter_3_1].baseline)
	end

	self.scoreText_1.text = var_3_2[1] or "--"
	self.scoreText_2.text = var_3_2[2] or "--"
	self.scoreText_3.text = var_3_2[3] or "--"

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

	self.stateController_:SetSelectedState(var_3_3)
	self.arrwoController_:SetSelectedState(tostring(arg_3_2 == nil))
	self.topController_:SetSelectedState(tostring(arg_3_2 == nil))

	if arg_3_2 == nil then
		self.totalScoreText_.text = var_3_2[1]
	end
end

return AutoChessLevelPopItemView
