local ChallengeRogueTeamSelectAffixItem = class("ChallengeRogueTeamSelectAffixItem", ReduxView)

function ChallengeRogueTeamSelectAffixItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_1_0, self["affixItem_" .. iter_1_0])

		var_1_0.gameObject_ = self["affixItem_" .. iter_1_0]
		var_1_0.index = iter_1_0
		var_1_0.selectController_ = var_1_0.controllerEx_:GetController("select")
		var_1_0.stateController_ = var_1_0.controllerEx_:GetController("state")

		var_1_0.selectController_:SetSelectedState("off")
		self:AddBtnListener(var_1_0.btn_, nil, function()
			self:OnClickAffix(var_1_0, iter_1_0)
		end)

		self.itemList_[iter_1_0] = var_1_0
	end
end

function ChallengeRogueTeamSelectAffixItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.selectCb_ then
			self.selectCb_(self.index_)
		end
	end)
end

function ChallengeRogueTeamSelectAffixItem:OnClickAffix(arg_5_1, arg_5_2)
	if self.clickAffixCb_ then
		self.clickAffixCb_(self.info_.group, self.info_.affixList[arg_5_2], arg_5_1)
	end

	if self.selectedItem then
		self.selectedItem.selectController_:SetSelectedState("off")

		if self.selectedItem.index == arg_5_2 then
			self.selectedItem = nil

			return
		end
	end

	self.selectedItem = arg_5_1

	self.selectedItem.selectController_:SetSelectedState("on")
end

function ChallengeRogueTeamSelectAffixItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	self.info_ = arg_6_1
	self.index_ = arg_6_2
	self.selectCb_ = arg_6_4
	self.clickAffixCb_ = arg_6_5
	self.selectedItem = nil

	for iter_6_0 = 1, 4 do
		if self.info_.affixList[iter_6_0] then
			local var_6_0 = self.itemList_[iter_6_0]
			local var_6_1 = ActivityAffixPoolCfg[self.info_.affixList[iter_6_0]]
			local var_6_2 = arg_6_3 and arg_6_3 == self.info_.affixList[iter_6_0]

			self.itemList_[iter_6_0].iconImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.info_.affixList[iter_6_0]].affix)
			var_6_0.numText_.text = var_6_1.point

			var_6_0.stateController_:SetSelectedState(var_6_1.point > 0 and "red" or "blue")
			var_6_0.selectController_:SetSelectedState(var_6_2 and "on" or "off")

			if var_6_2 then
				self.selectedItem = var_6_0
			end

			SetActive(var_6_0.gameObject_, true)
		else
			SetActive(self.itemList_[iter_6_0].gameObject_, false)
		end
	end

	self.nameText_.text = AffixTypeCfg[self.info_.group].name
end

function ChallengeRogueTeamSelectAffixItem:GetGroup()
	return self.info_.group
end

function ChallengeRogueTeamSelectAffixItem:GetItemByAffixId(arg_8_1)
	for iter_8_0 = 1, 4 do
		if self.info_.affixList[iter_8_0] == arg_8_1 then
			return self.itemList_[iter_8_0]
		end
	end

	return nil
end

function ChallengeRogueTeamSelectAffixItem:GetLocalPosition()
	return self.transform_.localPosition
end

function ChallengeRogueTeamSelectAffixItem:SetChildrenTransform(arg_10_1, arg_10_2, arg_10_3)
	self.childrenTf_.localPosition.x = arg_10_1
	self.childrenTf_.localPosition = self.childrenTf_.localPosition
	self.childrenTf_.localEulerAngles.x = arg_10_3
	self.childrenTf_.localEulerAngles = self.childrenTf_.localEulerAngles
	self.childrenTf_.localScale.x = arg_10_2
	self.childrenTf_.localScale.y = arg_10_2
	self.childrenTf_.localScale = self.childrenTf_.localScale
end

return ChallengeRogueTeamSelectAffixItem
