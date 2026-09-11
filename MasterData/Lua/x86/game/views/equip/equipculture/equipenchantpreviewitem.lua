local EquipEnchantPreviewItem = class("EquipEnchantPreviewItem", ReduxView)

function EquipEnchantPreviewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipEnchantPreviewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipEnchantPreviewItem:InitUI()
	self:BindCfgUI()
	self:InitEnchant()

	self.stateController_ = self.transCon_:GetController("state")
end

function EquipEnchantPreviewItem:AddUIListener()
	self:AddBtnListener(self.btnChoose_, nil, function()
		self:OnEnchantConfirmClick(true)
	end)
	self:AddBtnListener(self.btnDelete_, nil, function()
		self:OnEnchantConfirmClick(false)
	end)
end

function EquipEnchantPreviewItem:InitEnchant()
	self.skills = {}

	for iter_7_0 = 1, 2 do
		self.skills[iter_7_0] = EnchantSkillItem.New(self["skill_" .. iter_7_0])
		self.skills[iter_7_0].recommendController_ = self.skills[iter_7_0].transCon_:GetController("recommend")
		self.skills[iter_7_0].isShowedAnim = true
	end
end

function EquipEnchantPreviewItem:OnEnchantConfirmClick(arg_8_1)
	EquipAction.QueryEquipEnchantConfirm(self.equipId, self.enchatPos, arg_8_1, self.index)
end

function EquipEnchantPreviewItem:Refresh(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
	self.heroId_ = arg_9_1
	self.equipId = arg_9_4
	self.prefabId = EquipData:GetEquipData(self.equipId).prefab_id
	self.enchatPos = arg_9_5
	self.index = arg_9_6
	self.textIndex_.text = self.index
	self.isEmpty_ = true

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		if var_9_0[iter_9_1.id] then
			var_9_0[iter_9_1.id] = var_9_0[iter_9_1.id] + 1 or 1
		end
	end

	for iter_9_2, iter_9_3 in ipairs(self.skills) do
		local var_9_2
		local var_9_3 = 0

		if arg_9_2[iter_9_2] then
			self.isEmpty_ = false

			local var_9_4 = {
				isEquip = true,
				level = 1,
				id = self.equipId,
				prefab_id = self.prefabId
			}
			local var_9_5 = 1

			if arg_9_3 and arg_9_3[arg_9_2[iter_9_2].id] then
				local var_9_6 = clone(arg_9_3[arg_9_2[iter_9_2].id])

				if not arg_9_7[arg_9_2[iter_9_2].id] then
					var_9_6.num = var_9_6.num + 1
				else
					var_9_5 = var_9_0[arg_9_2[iter_9_2].id] - arg_9_7[arg_9_2[iter_9_2].id]
					var_9_6.num = var_9_6.num + (var_9_0[arg_9_2[iter_9_2].id] - arg_9_7[arg_9_2[iter_9_2].id])
				end

				local var_9_7 = false

				for iter_9_4, iter_9_5 in ipairs(var_9_6.location) do
					if iter_9_5.id == self.equipId then
						iter_9_5.level = iter_9_5.level + var_9_5
						var_9_7 = true

						break
					end
				end

				if not var_9_7 then
					table.insert(var_9_6.location, var_9_4)
				end

				var_9_2 = var_9_6
			else
				var_9_2 = {
					num = 1,
					isShowLocate = true,
					id = arg_9_2[iter_9_2].id,
					location = {
						var_9_4
					}
				}
			end

			var_9_3 = self.heroId_ and var_9_2 and var_9_2.num <= EquipSkillCfg[var_9_2.id].lvmax and HeroData:GetRecommendEquipSkill(self.heroId_, var_9_2.id) or 0

			if arg_9_6 == arg_9_8 then
				self:CheckRecommendAnim(iter_9_3, var_9_3)
			end
		else
			iter_9_3.isShowedAnim = false
		end

		iter_9_3.recommendController_:SetSelectedState(var_9_3)
		iter_9_3:RefreshData(var_9_2)
		iter_9_3:RegistCallBack(function(arg_10_0, arg_10_1)
			if self.skllCallBack then
				self.skllCallBack(arg_10_0, arg_10_1)
			end
		end)
	end

	self.stateController_:SetSelectedState(self.isEmpty_ and "empty" or "notEmpty")
end

function EquipEnchantPreviewItem:RegistSkillClickCallBck(arg_11_1)
	self.skllCallBack = arg_11_1
end

function EquipEnchantPreviewItem:ShowAnim()
	self.glowAnim_:Play("glow_bg", -1, 0)
end

function EquipEnchantPreviewItem:CheckRecommendAnim(arg_13_1, arg_13_2)
	if arg_13_2 >= 3 and not arg_13_1.isShowedAnim then
		arg_13_1.isShowedAnim = true

		if arg_13_1.checkTimer_ then
			arg_13_1.checkTimer_:Stop()

			arg_13_1.checkTimer_ = nil
		end

		arg_13_1.checkTimer_ = Timer.New(function()
			arg_13_1.recommendAnim_:Play("eff_recommend", -1, 0)
		end, 0.1, 0)

		arg_13_1.checkTimer_:Start()
	end
end

function EquipEnchantPreviewItem:Dispose()
	for iter_15_0, iter_15_1 in pairs(self.skills) do
		if iter_15_1.checkTimer_ then
			iter_15_1.checkTimer_:Stop()

			iter_15_1.checkTimer_ = nil
		end

		iter_15_1:Dispose()
	end

	EquipEnchantPreviewItem.super.Dispose(self)
end

return EquipEnchantPreviewItem
