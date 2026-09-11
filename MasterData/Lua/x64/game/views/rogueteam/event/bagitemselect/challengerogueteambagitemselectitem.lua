local ChallengeRogueTeamBagItemSelectItem = class("ChallengeRogueTeamBagItemSelectItem", ReduxView)

function ChallengeRogueTeamBagItemSelectItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.rareController_ = self.controllerEx_:GetController("quality")
end

function ChallengeRogueTeamBagItemSelectItem:Dispose()
	ChallengeRogueTeamBagItemSelectItem.super.Dispose(self)
end

function ChallengeRogueTeamBagItemSelectItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_ITEM, self.itemData_)
	end)
end

function ChallengeRogueTeamBagItemSelectItem:SetData(arg_5_1)
	self.itemData_ = arg_5_1
	self.nameText_.text = RogueTeamItemCfg[arg_5_1.id].name
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_1.id))

	self:RefreshSelectState(arg_5_1.isSelect)

	if RogueTeamItemCfg[arg_5_1.id].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		local var_5_0 = ChallengeRogueTeamTools.GetItemRare(arg_5_1.id, arg_5_1.rare)

		if RogueTeamItemCfg[arg_5_1.id].sub_type == 2 or #RogueTeamItemCfg[arg_5_1.id].camp > 1 then
			self.rareController_:SetSelectedState("orange")
		elseif var_5_0 == 1 then
			self.rareController_:SetSelectedState("green")
		elseif var_5_0 == 2 then
			self.rareController_:SetSelectedState("blue")
		elseif var_5_0 == 3 then
			self.rareController_:SetSelectedState("purple")
		end
	else
		self.rareController_:SetSelectedState("relic")
	end
end

function ChallengeRogueTeamBagItemSelectItem:RefreshSelectState(arg_6_1)
	if arg_6_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

return ChallengeRogueTeamBagItemSelectItem
