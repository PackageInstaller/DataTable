ChallengeRogueTeamCommonItemData = {
	needShowCampFlag = false,
	selectFlag = false,
	id = 0,
	rare = 1,
	descRaycastFlag = false
}

local ChallengeRogueTeamCommonItemView = class("ChallengeRogueTeamCommonItemView", ReduxView)

function ChallengeRogueTeamCommonItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.info_ = {}
	self.campView_ = {}

	self:InitUI()
end

function ChallengeRogueTeamCommonItemView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.ownController_ = self.controllerEx_:GetController("own")
	self.typeController_ = self.controllerEx_:GetController("type")
	self.rareController_ = self.controllerEx_:GetController("treasure")
	self.campController_ = self.controllerEx_:GetController("numberstate")
	self.campCntController_ = self.campControllerEx_:GetController("state01")
end

function ChallengeRogueTeamCommonItemView:SetData(arg_3_1)
	self.info_ = arg_3_1

	self:RefreshUI()
end

function ChallengeRogueTeamCommonItemView:GetData()
	return self.info_
end

function ChallengeRogueTeamCommonItemView:RefreshUI()
	if self.info_ == nil then
		self.typeController_:SetSelectedState("empty")

		return
	end

	self:RefreshIcon()
	self:RefreshText()
	self:RefreshSelectState(self.info_.selectFlag)
	self:RefreshOwnState(self.info_.ownFlag)
	self:RefreshDescTextRaycast(self.info_.descRaycastFlag)
	self:RefreshCamp()
end

function ChallengeRogueTeamCommonItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.info_.clickFun then
			self.info_:clickFun()
		end
	end)
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function ChallengeRogueTeamCommonItemView:RefreshIcon()
	local var_8_0 = self.info_.id
	local var_8_1 = RogueTeamItemCfg[self.info_.id]

	self.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(self.info_.id))

	if var_8_1.type == ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM then
		self.typeController_:SetSelectedState("Mechanis")
	else
		self.typeController_:SetSelectedState("Normal")
	end

	if var_8_1.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		local var_8_2 = ChallengeRogueTeamTools.GetItemRare(var_8_0, self.info_.rare)

		if var_8_1.sub_type == 2 or #var_8_1.camp > 1 then
			self.rareController_:SetSelectedState("treasure01")
		elseif var_8_2 == 1 then
			self.rareController_:SetSelectedState("treasure04")
		elseif var_8_2 == 2 then
			self.rareController_:SetSelectedState("treasure03")
		elseif var_8_2 == 3 then
			self.rareController_:SetSelectedState("treasure02")
		end
	else
		self.rareController_:SetSelectedState("treasure05")
	end
end

function ChallengeRogueTeamCommonItemView:RefreshText()
	self.nameText_.text = RogueTeamItemCfg[self.info_.id].name
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(self.info_.id, self.info_.rare, self.descText_.color)
end

function ChallengeRogueTeamCommonItemView:RefreshSelectState(arg_10_1)
	if arg_10_1 == true then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end

	self.info_.selectFlag = arg_10_1
end

function ChallengeRogueTeamCommonItemView:RefreshOwnState(arg_11_1)
	if arg_11_1 == true then
		self.ownController_:SetSelectedState("true")
	else
		self.ownController_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamCommonItemView:RefreshCamp()
	if RogueTeamItemCfg[self.info_.id].type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and self.info_.needShowCampFlag then
		self.campController_:SetSelectedState("state1")

		for iter_12_0, iter_12_1 in ipairs(RogueTeamItemCfg[self.info_.id].camp) do
			self.campView_[iter_12_0] = ChallengeRogueTeamTreasureSkillItem.New(self[string.format("campGo%s_", iter_12_0)])

			self.campView_[iter_12_0]:SetData(iter_12_1)
		end

		if #RogueTeamItemCfg[self.info_.id].camp >= 2 then
			self.campCntController_:SetSelectedState("state1")
		else
			self.campCntController_:SetSelectedState("state0")
		end
	else
		self.campController_:SetSelectedState("state0")
	end
end

function ChallengeRogueTeamCommonItemView:RefreshDescTextRaycast(arg_13_1)
	self.descText_.raycastTarget = arg_13_1
end

function ChallengeRogueTeamCommonItemView:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function ChallengeRogueTeamCommonItemView:PlayAnimator()
	self.animator_:Play("UI_SelectItem_cx", -1, 0)
end

function ChallengeRogueTeamCommonItemView:Dispose()
	for iter_16_0, iter_16_1 in ipairs(self.campView_) do
		iter_16_1:Dispose()
	end

	self.campView_ = nil

	ChallengeRogueTeamCommonItemView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return ChallengeRogueTeamCommonItemView
