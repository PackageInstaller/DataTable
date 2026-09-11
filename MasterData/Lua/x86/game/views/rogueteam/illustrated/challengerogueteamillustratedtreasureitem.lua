local ChallengeRogueTeamIllustratedTreasureItem = class("ChallengeRogueTeamIllustratedTreasureItem", ReduxView)

function ChallengeRogueTeamIllustratedTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.bgController_ = self.controllerEx_:GetController("treasure")
	self.ownController_ = self.controllerEx_:GetController("lock")
	self.selectController_ = self.controllerEx_:GetController("select")

	self:AddUIListener()
end

function ChallengeRogueTeamIllustratedTreasureItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.index_)
		end
	end)
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function ChallengeRogueTeamIllustratedTreasureItem:Dispose()
	ChallengeRogueTeamIllustratedTreasureItem.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedTreasureItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
	self.cfg_ = RogueTeamItemCfg[self.id_]
	self.nameText_.text = self.cfg_.name

	local var_5_0 = AffixTypeCfg[ChallengeRogueTeamTools.GetTreasureAffix(self.id_)[1]].description[1]

	self.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_2))

	self.ownController_:SetSelectedState(tostring(arg_5_3 == true))

	local var_5_1 = ""

	if self.cfg_.sub_type == 1 and #self.cfg_.camp <= 1 then
		self.bgController_:SetSelectedState("treasure05")

		var_5_1 = GetCfgDescription(var_5_0, level, 1, 3, true)
	else
		self.bgController_:SetSelectedState("treasure01")

		var_5_1 = GetCfgDescription(var_5_0, level, 1, 1, true)
	end

	self.descText_.text = string.gsub(var_5_1, "#5C5D60", (string.format("#%s", ColorToHex(self.descText_.color))))
end

function ChallengeRogueTeamIllustratedTreasureItem:RefreshSelect(arg_6_1)
	self.selectController_:SetSelectedState(tostring(self.index_ == arg_6_1))
end

function ChallengeRogueTeamIllustratedTreasureItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

return ChallengeRogueTeamIllustratedTreasureItem
