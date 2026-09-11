local CultureGravureTransitionItem = class("CultureGravureTransitionItem", ReduxView)

function CultureGravureTransitionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureTransitionItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CultureGravureTransitionItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.transCon_:GetController("state")
	self.indexController_ = self.transCon_:GetController("index")
	self.iconList_ = {}
	self.nameList_ = {}
	self.btnList_ = {}

	for iter_3_0 = 1, 2 do
		self.iconList_[iter_3_0] = self["transitionImg_" .. iter_3_0]
		self.nameList_[iter_3_0] = self["transitionName_" .. iter_3_0]
		self.btnList_[iter_3_0] = self["transitionBtn_" .. iter_3_0]
	end

	self.data_ = {
		{},
		{}
	}
end

function CultureGravureTransitionItem:AddListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		local var_5_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION)

		if var_5_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.TRANSITION, var_5_0))
		else
			JumpTools.OpenPageByJump("/transitionSkill", {
				index = self.index_,
				heroID = self.heroId_,
				type_ = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	end)
	self:AddBtnListener(self.equipBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(self.recommendIdList_) do
			var_6_0[iter_6_0] = {
				skill_level = 3,
				skill_id = iter_6_1
			}
		end

		HeroAction.TryToSaveTransitionSkill(self.heroId_, self.index_, var_6_0)
	end)

	for iter_4_0 = 1, 2 do
		self:AddBtnListener(self.btnList_[iter_4_0], nil, function()
			self.callback_(self.data_[iter_4_0].name, self.data_[iter_4_0].desc, Vector3(self.btnList_[iter_4_0].transform.position.x, self.btnList_[iter_4_0].transform.position.y, self.btnList_[iter_4_0].transform.position.z), self.rightTrans_, true)
		end)
	end
end

function CultureGravureTransitionItem:SetData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.recommendIdList_ = arg_8_1
	self.index_ = arg_8_2
	self.transitionInfo_ = arg_8_3
	self.heroId_ = arg_8_4

	for iter_8_0, iter_8_1 in ipairs(self.recommendIdList_) do
		self.iconList_[iter_8_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[iter_8_1].icon or "")
		self.nameList_[iter_8_0].text = EquipSkillCfg[iter_8_1].name
		self.data_[iter_8_0].name = EquipSkillCfg[iter_8_1].name
		self.data_[iter_8_0].desc = EquipTools.GetSkillDescWithoutNext(iter_8_1, 3, self.heroId_)
	end

	self.indexController_:SetSelectedState(arg_8_2)
	self:RefreshBtnState()
end

function CultureGravureTransitionItem:RefreshBtnState()
	if self.transitionInfo_ and self.transitionInfo_.talent_points >= 6 then
		self.stateController_:SetSelectedState(self:IsSameTransition() and "equiped" or "exchange")
	else
		self.stateController_:SetSelectedState("get")
	end
end

function CultureGravureTransitionItem:IsSameTransition()
	local var_10_0 = true

	for iter_10_0, iter_10_1 in ipairs(self.recommendIdList_) do
		local var_10_1 = false

		for iter_10_2, iter_10_3 in ipairs(self.transitionInfo_.skill_list) do
			if iter_10_3.skill_id == iter_10_1 then
				var_10_1 = true

				break
			end
		end

		var_10_0 = var_10_0 and var_10_1
	end

	return var_10_0
end

function CultureGravureTransitionItem:SetClickCallBack(arg_11_1)
	self.callback_ = arg_11_1
end

function CultureGravureTransitionItem:Dispose()
	CultureGravureTransitionItem.super.Dispose(self)
end

return CultureGravureTransitionItem
