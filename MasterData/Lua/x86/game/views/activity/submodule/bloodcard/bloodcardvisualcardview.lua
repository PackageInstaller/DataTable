local BloodVisualCardView = class("BloodVisualCardView", ReduxView)

function BloodVisualCardView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BloodVisualCardView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.selectController_ = self.controller_:GetController("select")
	self.needPointController_ = self.controller_:GetController("needPoint")
	self.useController_ = self.controller_:GetController("used")
	self.stateController_ = self.controller_:GetController("card")
	self.skillController_ = self.controller_:GetController("skill")
	self.useFramController_ = self.useExController_:GetController("used")
	self.grayController_ = self.useExController_:GetController("deplete")
	self.tipsController_ = self.controller_:GetController("tips")
	self.lockController_ = self.controller_:GetController("lock")
	self.noneController_ = self.controller_:GetController("none")
	self.useNumController_ = self.controller_:GetController("useNum")
	self.cardCellControllerList_ = self.cellContent_:GetComponentsInChildren(typeof(ControllerExSpace.ControllerExCollection)):ToTable()
end

function BloodVisualCardView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack then
			self.clickCallBack(self.id_, self.index_)
		end

		manager.notify:Invoke(BLOOD_CARD_BUILD_SELECTED, self.id_, self)
	end)
end

function BloodVisualCardView:RefreshUI()
	self.powerText_.text = self.cfg_.power
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_Com/CORGUI_3_10_BloodCardUI/" .. self.cfg_.illustration)

	self.needPointController_:SetSelectedState(self.cfg_.need_point)

	if self.cfg_.kind == 99 then
		if self.isEnemy_ then
			self.stateController_:SetSelectedState("redGold")
		else
			self.stateController_:SetSelectedState("blueGold")
		end

		self.useFramController_:SetSelectedState("gold")
	else
		if self.isEnemy_ then
			self.stateController_:SetSelectedState("red")
		else
			self.stateController_:SetSelectedState("blue")
		end

		self.useFramController_:SetSelectedState("normal")
	end

	if #self.cfg_.effect_list > 0 then
		self.skillController_:SetSelectedState("true")
	else
		self.skillController_:SetSelectedState("false")
	end

	self:RefreshUIEffetContent()
end

function BloodVisualCardView:SetState(arg_6_1)
	self.stateController_:SetSelectedState(arg_6_1)
end

function BloodVisualCardView:RefreshUIEffetContent()
	for iter_7_0, iter_7_1 in ipairs(self.cardCellControllerList_) do
		iter_7_1:GetController("middle"):SetSelectedState("false")
		iter_7_1:GetController("grid"):SetSelectedState("false")
		iter_7_1:GetController("skill"):SetSelectedState("false")
	end

	self.cardCellControllerList_[13]:GetController("middle"):SetSelectedState("true")

	for iter_7_2, iter_7_3 in ipairs(self.cfg_.c_grid_list) do
		highlightIndex = self:ConverPosToIndex(13, iter_7_3[2], iter_7_3[1], 5, 5)

		if highlightIndex ~= -1 then
			self.cardCellControllerList_[highlightIndex]:GetController("grid"):SetSelectedState("true")
		end
	end

	if self.cfg_.s_grid_list ~= "" then
		for iter_7_4, iter_7_5 in ipairs(self.cfg_.s_grid_list) do
			highlightIndex = self:ConverPosToIndex(13, iter_7_5[2], iter_7_5[1], 5, 5)

			if highlightIndex ~= -1 then
				self.cardCellControllerList_[highlightIndex]:GetController("skill"):SetSelectedState("true")
			end
		end
	end
end

function BloodVisualCardView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.id_ = arg_8_2
	self.index_ = arg_8_1
	self.cfg_ = BloodCardGameCardCfg[self.id_]
	self.isEnemy_ = arg_8_3

	self.tipsController_:SetSelectedState("false")
	self:RefreshUI()
end

function BloodVisualCardView:SetNone(arg_9_1)
	self.noneController_:SetSelectedState(tostring(arg_9_1))
end

function BloodVisualCardView:SetUsed(arg_10_1)
	self.useController_:SetSelectedState(tostring(arg_10_1))
end

function BloodVisualCardView:SetGray(arg_11_1)
	self.grayController_:SetSelectedState(tostring(arg_11_1))
	self.lockController_:SetSelectedState(tostring(arg_11_1))
end

function BloodVisualCardView:SetClickCallBack(arg_12_1)
	self.clickCallBack = arg_12_1
end

function BloodVisualCardView:SetUseNum(arg_13_1)
	self.useNumController_:SetSelectedState(tostring(arg_13_1))
end

function BloodVisualCardView:SelectCard(arg_14_1)
	self.selectController_:SetSelectedState(tostring(arg_14_1 == self.id_))
end

function BloodVisualCardView:SetOwnNum(arg_15_1)
	self.ownNumText_.text = "x" .. arg_15_1
end

function BloodVisualCardView:ShowDescTips(arg_16_1, arg_16_2)
	self.tipsTitle_.text = self.cfg_.name
	self.tipsDesc_.text = self.cfg_.desc

	self.tipsController_:SetSelectedState(tostring(arg_16_1 == self.id_ and self.index_ == arg_16_2))
end

function BloodVisualCardView:Dispose()
	BloodVisualCardView.super.Dispose(self)
end

function BloodVisualCardView:PlayAni(arg_18_1)
	self.animator_:Play(arg_18_1)
	self.animator_:Update(0)
end

function BloodVisualCardView:ConverPosToIndex(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	row = math.ceil(arg_19_1 / arg_19_5)
	col = arg_19_1 % arg_19_5
	newCol = col + arg_19_3 * (self.isEnemy_ and -1 or 1)
	newRow = row + arg_19_2 * (self.isEnemy_ and -1 or 1)

	if newRow >= 1 and arg_19_4 >= newRow and newCol >= 1 and arg_19_5 >= newCol then
		return (newRow - 1) * arg_19_5 + newCol
	else
		return -1
	end
end

return BloodVisualCardView
