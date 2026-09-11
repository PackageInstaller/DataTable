local MythicFinalRankItem = class("MythicFinalRankItem", ReduxView)

function MythicFinalRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
end

function MythicFinalRankItem:initUI()
	self:BindCfgUI()

	self.rankController_ = self.conExCollection_:GetController("rank")
end

function MythicFinalRankItem:AddListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("mythicFinalRankHeroView", {
			herolist = self.team_list_,
			name = self.name_,
			userID = self.user_id
		})
	end)
end

function MythicFinalRankItem:Refresh(arg_5_1)
	self.user_id = arg_5_1.user_id
	self.rankText_.text = arg_5_1.rank
	self.scoreText_.text = arg_5_1.score
	self.layerText_.text = arg_5_1.difficulty

	if arg_5_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.name_ = arg_5_1.nick
	self.nickText_.text = arg_5_1.nick

	self.commonPortrait_:RenderHead(arg_5_1.portrait)
	self.commonPortrait_:RenderFrame(arg_5_1.frame)

	self.team_list_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.stage_team_list[0]) do
		self.team_list_[iter_5_0] = {}

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			table.insert(self.team_list_[iter_5_0], {
				id = iter_5_3.hero_id,
				skin_id = iter_5_3.skin_id
			})
		end
	end
end

function firstLargeSize(arg_6_0, arg_6_1)
	if #arg_6_0 <= 0 then
		return arg_6_0
	end

	local var_6_0, var_6_1, var_6_2, var_6_3 = string.find(arg_6_0, "<(.-)>(.+)")

	var_6_3 = var_6_3 or arg_6_0

	local var_6_4 = {
		"“",
		"《"
	}
	local var_6_5 = 0
	local var_6_6

	for iter_6_0 = 1, var_6_3:getWCharCount() do
		local var_6_7 = var_6_3:getWChar(iter_6_0)

		if table.indexOf(var_6_4, var_6_7) == -1 then
			var_6_5 = var_6_5 + string.len(var_6_7)
			var_6_6 = string.format("%s<size=%d>%s</size>%s", string.sub(var_6_3, 1, var_6_5), arg_6_1, var_6_7, (string.sub(var_6_3, var_6_5 + 1, -1)))

			break
		else
			var_6_5 = var_6_5 + string.len(var_6_7)
		end
	end

	if not var_6_6 then
		return arg_6_0
	end

	if var_6_2 then
		var_6_6 = string.format("<%s>%s", var_6_2, var_6_6)
	end

	return var_6_6
end

function MythicFinalRankItem:Dispose()
	self.commonPortrait_:Dispose()
	MythicFinalRankItem.super.Dispose(self)
end

return MythicFinalRankItem
