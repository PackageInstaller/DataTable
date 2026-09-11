local EquipDisc = class("EquipDisc", ReduxView)

function EquipDisc:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipDisc:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipDisc:InitUI()
	self:BindCfgUI()

	self.equipItem_ = {}

	for iter_3_0 = 1, 6 do
		self.equipItem_[iter_3_0] = EquipItem.New(self["equipItem_" .. iter_3_0])

		self.equipItem_[iter_3_0]:RegistCallBack(function(arg_4_0, arg_4_1)
			if self.itemClickCallBack then
				self.itemClickCallBack(arg_4_0, iter_3_0)

				if self.lastSelectItem_ then
					self.lastSelectItem_:ShowSelect(false)
				end

				arg_4_1:ShowSelect(true)

				self.lastSelectItem_ = arg_4_1
			end
		end)
	end

	self.ringController_ = self.discCon_:GetController("ring")
	self.itemController_ = self.itemCon_:GetController("default0")
end

function EquipDisc:AddUIListener()
	return
end

function EquipDisc:OnEnter(arg_6_1)
	self.isShowDetail_ = arg_6_1 and arg_6_1.isShowDetail

	local var_6_0 = self.isShowDetail_

	self.ringController_:SetSelectedState(self.isShowDetail_ and "B" or "A")
	self.ringAAni_:Play(var_6_0 and "UI_ringA" or "UI_ringB")
	self.ringAAni_:Update(0)
	self.itemController_:SetSelectedState(var_6_0 and "open" or "close")
end

function EquipDisc:Rotate(arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_2 then
		self:ResetAngle()

		if arg_7_1 == arg_7_2 then
			self.rotateServant_.transform.localEulerAngles = Vector3.New(0, 0, -120 - (arg_7_2 - 1) * 60)

			self:HideItems()
		else
			self:RotateServant(arg_7_1, arg_7_2)
		end
	end
end

function EquipDisc:RefreshItem(arg_8_1)
	for iter_8_0 = 1, 6 do
		self.equipItem_[iter_8_0]:RefreshData(arg_8_1[iter_8_0], self.isShowDetail_)
	end
end

function EquipDisc:Reset()
	for iter_9_0 = 1, 6 do
		self.equipItem_[iter_9_0]:ShowSelect(false)
	end
end

function EquipDisc:PlayAnim(arg_10_1)
	if arg_10_1 then
		self.servantAnim_:Play("Fx_servant_cx")
	else
		self.servantAnim_:Play("Fx_servant_cx")
	end
end

function EquipDisc:RotateServant(arg_11_1, arg_11_2)
	self.index_ = arg_11_2

	local var_11_0 = self:GetAngle(arg_11_1, arg_11_2)

	if var_11_0 ~= 0 then
		self.rotateLeanTween_ = LeanTween.rotateAroundLocal(self.rotateServant_, Vector3.New(0, 0, 1), var_11_0, 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function EquipDisc:GetAngle(arg_12_1, arg_12_2)
	local var_12_0 = (arg_12_1 - arg_12_2) * 60

	if math.abs((arg_12_1 - arg_12_2) * 60) > 180 then
		var_12_0 = var_12_0 > 0 and var_12_0 - 360 or var_12_0 + 360
	end

	return var_12_0
end

function EquipDisc:HideItems()
	for iter_13_0, iter_13_1 in ipairs(self.equipItem_) do
		iter_13_1:Hide()
	end
end

function EquipDisc:RegistItemButton(arg_14_1)
	self.itemClickCallBack = arg_14_1
end

function EquipDisc:ShowAnim(arg_15_1)
	self.equipItem_[arg_15_1]:ShowAnim()
end

function EquipDisc:RefreshItemByIndex(arg_16_1, arg_16_2)
	self.equipItem_[arg_16_1]:RefreshData(arg_16_2)
end

function EquipDisc:ResetAngle()
	self.rotateServant_.transform.rotation = Vector3.zero
end

function EquipDisc:OnExit()
	return
end

function EquipDisc:Dispose()
	for iter_19_0, iter_19_1 in pairs(self.equipItem_) do
		iter_19_1:Dispose()
	end

	self.equipItem_ = nil

	EquipDisc.super.Dispose(self)
end

return EquipDisc
