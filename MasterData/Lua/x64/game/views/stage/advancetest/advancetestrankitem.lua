local AdvanceTestRankItem = class("AdvanceTestRankItem", ReduxView)

function AdvanceTestRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddListeners()
end

function AdvanceTestRankItem:initUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.rankController_ = self.conExCollection_:GetController("rank")
	self.heroCountController_ = self.conExCollection_:GetController("heroCount")
end

function AdvanceTestRankItem:AddListeners()
	self:AddBtnListener(self.m_lookBtn, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeTeamCheckView", {
			notCoreCl = true,
			dataList = self.otherInfoData
		})
	end)
end

function AdvanceTestRankItem:Refresh(arg_5_1, arg_5_2)
	self.user_id = arg_5_1.user_id
	self.rankText_.text = arg_5_1.rank
	self.scoreText_.text = arg_5_1.score

	if arg_5_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.name_ = arg_5_1.nick
	self.nickText_.text = arg_5_1.nick

	self.commonPortrait_:RenderHead(arg_5_1.portrait)
	self.commonPortrait_:RenderFrame(arg_5_1.frame)

	if arg_5_2 <= 3 then
		local var_5_0 = arg_5_1:GetSingleSelectHeroList()
		local var_5_1 = math.min(#var_5_0, 3)

		self.heroCountController_:SetSelectedIndex(var_5_1)

		for iter_5_0 = 1, var_5_1 do
			self["heroImg_" .. iter_5_0].sprite = getSpriteViaConfig("HeroItemshead", (var_5_0[iter_5_0].skin_id == 0 or nil) and var_5_0[iter_5_0].hero_id)
		end
	else
		self.heroCountController_:SetSelectedIndex(4)

		local var_5_3 = {}

		if arg_5_1.extraInfo then
			for iter_5_1, iter_5_2 in pairs(arg_5_1.extraInfo) do
				local var_5_4 = {
					id = iter_5_2
				}

				if ActivityAffixPoolCfg[iter_5_2] then
					var_5_4.lv = ActivityAffixPoolCfg[iter_5_2].affix[2] or 0
				end

				table.insert(var_5_3, var_5_4)
			end
		end

		local var_5_5 = {}

		for iter_5_3, iter_5_4 in pairs((arg_5_1:GetSingleSelectHeroList())) do
			table.insert(var_5_5, (iter_5_4.skin_id == 0 or nil) and (skin_id or iter_5_4.hero_id))
		end

		self.otherInfoData = {
			{
				hero_list = var_5_5,
				affix_list = var_5_3
			}
		}
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

function AdvanceTestRankItem:Dispose()
	self.commonPortrait_:Dispose()
	AdvanceTestRankItem.super.Dispose(self)
end

return AdvanceTestRankItem
