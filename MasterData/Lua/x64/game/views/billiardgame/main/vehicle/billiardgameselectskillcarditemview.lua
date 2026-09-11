local BilliardGameSelectSkillCardItemView = class("BilliardGameSelectSkillCardItemView", ReduxView)

function BilliardGameSelectSkillCardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameSelectSkillCardItemView:Init()
	self:InitUI()
end

function BilliardGameSelectSkillCardItemView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.typeController_ = self.transCon_:GetController("type")
	self.tagController_ = self.transCon_:GetController("buffTag")
	self.connectController_ = self.transCon_:GetController("connect")
	self.smallBuffItem_ = BilliardGameSmallSkillItemView.New(self.skillItemGo_)
	self.connectSkillBuffList_ = {}

	for iter_3_0 = 1, 4 do
		self.connectSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(self["connectItemGo_" .. iter_3_0])
	end
end

function BilliardGameSelectSkillCardItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback_ then
			self.clickCallback_(self.buffId_)
		end
	end)
end

function BilliardGameSelectSkillCardItemView:SetData(arg_6_1)
	self.buffId_ = arg_6_1

	local var_6_0 = MergeBallBuffCfg[arg_6_1]

	self.smallBuffItem_:SetBuffData(arg_6_1, true)
	self:RefreshTrackState()

	local var_6_1 = BilliardGameMgr:GetSkillByMainBuffId(arg_6_1)
	local var_6_2

	if var_6_1 then
		var_6_2 = var_6_1.level + 1 or 1
	end

	self.smallBuffItem_:ForceShowStar(var_6_2)

	if var_6_1 and not var_6_1.isCombine_ then
		self.smallBuffItem_:ShowStarBreathAnim(var_6_2, true)
	end

	self:RefreshType(var_6_0)
	self:RefreshConnectSkillBuff(var_6_0.relate)

	self.nameText_.text = var_6_0.name
	self.descText_.text = string.format(var_6_0.desc, unpack(var_6_0.param_level[var_6_2]))

	if var_6_0.tag[1] then
		self.tagController_:SetSelectedState("show")

		self.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_6_0.tag[1])
	else
		self.tagController_:SetSelectedState("hide")
	end
end

function BilliardGameSelectSkillCardItemView:RefreshType(arg_7_1)
	if arg_7_1.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
		self.typeController_:SetSelectedState("passive")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_PASSIVE")
	elseif arg_7_1.type == BilliardGameConst.MergeBallBuffType.BASIC then
		self.typeController_:SetSelectedState("activity_basic")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_BASIC")
	elseif arg_7_1.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.typeController_:SetSelectedState("activity_advanced")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_ADVANCE")
	elseif arg_7_1.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.typeController_:SetSelectedState("activity_ultimate")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_ULT")
	elseif arg_7_1.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		self.typeController_:SetSelectedState("effect")

		self.tittleText_.text = GetTips("MERGE_BALL_MERGE_EFFECT")
		self.effectIconImg_.sprite = pureGetSpriteWithoutAtlas(arg_7_1.icon)
	end
end

function BilliardGameSelectSkillCardItemView:RefreshConnectSkillBuff(arg_8_1)
	if arg_8_1 and #arg_8_1 > 0 then
		self.connectController_:SetSelectedState("show")

		for iter_8_0 = 1, #arg_8_1 do
			SetActive(self.connectSkillBuffList_[iter_8_0].gameObject_, true)
			self.connectSkillBuffList_[iter_8_0]:SetBuffData(arg_8_1[iter_8_0])
			self.connectSkillBuffList_[iter_8_0]:ShowBuffIsGet(BilliardGameMgr:GetIsSelectedBuff(arg_8_1[iter_8_0]))
			self.connectSkillBuffList_[iter_8_0]:RegisterClick(function()
				manager.notify:Invoke(BilliardGameEvent.SET_CLICK_SKILL_ITEM, self.connectSkillBuffList_[iter_8_0])
			end)
		end

		for iter_8_1 = #arg_8_1 + 1, 4 do
			SetActive(self.connectSkillBuffList_[iter_8_1].gameObject_, false)
		end
	else
		self.connectController_:SetSelectedState("hide")
	end
end

function BilliardGameSelectSkillCardItemView:RefreshTrackState()
	self.smallBuffItem_:CheckTrackState(self.buffId_)
end

function BilliardGameSelectSkillCardItemView:RegisterClickListener(arg_11_1)
	self.clickCallback_ = arg_11_1
end

function BilliardGameSelectSkillCardItemView:Dispose()
	self.smallBuffItem_:Dispose()

	for iter_12_0 = 1, #self.connectSkillBuffList_ do
		self.connectSkillBuffList_[iter_12_0]:Dispose()
	end

	BilliardGameSelectSkillCardItemView.super.Dispose(self)
end

return BilliardGameSelectSkillCardItemView
