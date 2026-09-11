local BilliardGameBigBuffItemView = class("BilliardGameBigBuffItemView", ReduxView)

function BilliardGameBigBuffItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameBigBuffItemView:Init()
	self:InitUI()
end

function BilliardGameBigBuffItemView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.connectController_ = self.skillCon_:GetController("buffConnect")
	self.nameController_ = self.skillCon_:GetController("skillName")
	self.connectSkillBuffList_ = {}

	for iter_3_0 = 1, 4 do
		self.connectSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(self["containSkillGo_" .. iter_3_0])
	end
end

function BilliardGameBigBuffItemView:AddUIListener()
	return
end

function BilliardGameBigBuffItemView:SetData(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = MergeBallBuffCfg[arg_5_1]
	local var_5_1 = VehicleBallData:IsBuffUnlocked(arg_5_1)

	if var_5_1 then
		self.nameText_.text = var_5_0.name or "???"
	end

	self.descText_.text = var_5_1 and string.format(var_5_0.desc, unpack(var_5_0.param_level[arg_5_2])) or "???"

	if not arg_5_3 and var_5_0.relate and #var_5_0.relate > 0 then
		self.connectController_:SetSelectedState("show")

		for iter_5_0, iter_5_1 in ipairs(var_5_0.relate) do
			SetActive(self.connectSkillBuffList_[iter_5_0].gameObject_, true)
			self.connectSkillBuffList_[iter_5_0]:SetBuffData(iter_5_1)
		end

		for iter_5_2 = #var_5_0.relate + 1, 4 do
			SetActive(self.connectSkillBuffList_[iter_5_2].gameObject_, false)
		end
	else
		self.connectController_:SetSelectedState("hide")
	end
end

function BilliardGameBigBuffItemView:IsShowName(arg_6_1)
	SetActive(self.nameText_.gameObject, arg_6_1)
end

function BilliardGameBigBuffItemView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.connectSkillBuffList_) do
		iter_7_1:Dispose()
	end

	BilliardGameBigBuffItemView.super.Dispose(self)
end

return BilliardGameBigBuffItemView
