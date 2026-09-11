local MythicFinalRankHeroItem = class("MythicFinalRankHeroItem", ReduxView)

function MythicFinalRankHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListeners()
end

function MythicFinalRankHeroItem:AddUIListeners()
	for iter_2_0 = 1, 3 do
		self:AddBtnListener(self["heroBtn_" .. iter_2_0], nil, function()
			ForeignInfoAction:TryToCheckForeignHeroInfo(self.userID_, _, 3, function()
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					notShowBar = true,
					hid = self.herolist_[iter_2_0].id,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end)
	end
end

function MythicFinalRankHeroItem:initUI()
	self:BindCfgUI()

	self.countcontroller_ = self.conExCollection_:GetController("heroCount")
end

function MythicFinalRankHeroItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.userID_ = arg_6_3
	self.herolist_ = arg_6_2
	self.teamText_.text = GetTips("TEAM_" .. arg_6_1)

	self.countcontroller_:SetSelectedState(#arg_6_2)

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		self["heroImg_" .. iter_6_0].sprite = ItemTools.getItemSprite((iter_6_1.skin_id == 0 or nil) and iter_6_1.id)
	end
end

return MythicFinalRankHeroItem
