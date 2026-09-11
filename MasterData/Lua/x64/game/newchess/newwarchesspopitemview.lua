local NewWarChessPopItemView = class("NewWarChessPopItemView", ReduxView)

function NewWarChessPopItemView:UIName()
	return "UI/NewWarChess/NewWarChessActionUIPop"
end

function NewWarChessPopItemView:UIParent()
	return manager.ui.uiPop.transform
end

function NewWarChessPopItemView:OnCtor()
	self.allProps = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]
	self.selectNum_ = 0
	self.canUseMaxNum_ = 0
end

function NewWarChessPopItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessPopItemView:InitUI()
	self:BindCfgUI()

	self.btnController_ = ControllerUtil.GetController(self.okBtn_.transform, "enabled")
	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.itemListGo_, CommonItem)
end

function NewWarChessPopItemView:indexItem(arg_6_1, arg_6_2)
	local var_6_0 = ItemTools.getItemNum(self.propsBonds[arg_6_1])

	arg_6_2:RefreshData({
		id = self.propsBonds[arg_6_1],
		number = var_6_0,
		type = ItemCfg[self.propsBonds[arg_6_1]].type
	})
	arg_6_2:SetSelectType("equip")
	arg_6_2:ShowSelect(arg_6_1 == self.selectInex and 1 or 0)
	arg_6_2:RegistCallBack(function(arg_7_0)
		if var_6_0 > 0 then
			self.selectInex = arg_6_1
			self.selectNum_ = 1

			self:RefreshCanUseMaxNum()
			self.scrollHelper:Refresh()
			self:UpdateSliderPositionBySelectNum()
			self:UpdatePreview()
		end
	end)
end

function NewWarChessPopItemView:RefreshCanUseMaxNum()
	self.canUseMaxNum_ = math.max(math.min(math.min(math.floor((NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max - NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")) / ItemCfg[self.propsBonds[self.selectInex]].param[1]), (ItemTools.getItemNum(self.propsBonds[self.selectInex]))), NewChessTools.GetNewWarChessGameSetting("new_warchess_movepoint_usenum_max", NewWarChessData:GetCurrentMainActivity())[1]), 0)

	if self.canUseMaxNum_ <= 0 then
		self.selectNum_ = 0
	end
end

function NewWarChessPopItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectNum_ > 0 then
			CommonAction.TryToUseItem({
				{
					item_info = {
						id = self.propsBonds[self.selectInex],
						num = self.selectNum_
					},
					use_list = {
						NewWarChessData:GetCurrentWarChessMapID()
					}
				}
			})
		end
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		self.selectNum_ = math.floor(self.canUseMaxNum_ * self.useNumSlider_.value + 1e-05)

		if self.canUseMaxNum_ > 0 then
			if self.selectNum_ < 1 then
				self.selectNum_ = 1
			end
		elseif self.canUseMaxNum_ <= 0 then
			self.selectNum_ = 0
		end

		self:UpdateSliderPositionBySelectNum()
		self:UpdatePreview()
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ > 1 then
			self.selectNum_ = self.selectNum_ - 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdatePreview()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ < self.canUseMaxNum_ then
			self.selectNum_ = self.selectNum_ + 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdatePreview()

			return true
		end

		return false
	end)
end

function NewWarChessPopItemView:OnTryToUseItem(arg_15_1, arg_15_2)
	if isSuccess(arg_15_1.result) then
		NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", arg_15_2.use_item_list[1].num * ItemCfg[arg_15_2.use_item_list[1].item_id].param[1])
		JumpTools.Back()
		manager.NewChessManager:CreateTips({
			tipsType = NewChessConst.TIPS_TYPE.NORMAL,
			tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_MOVEPOINT"), arg_15_2.use_item_list[1].num * ItemCfg[arg_15_2.use_item_list[1].item_id].param[1])
		})
	else
		ShowTips(arg_15_1.result)
	end
end

function NewWarChessPopItemView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.propsBonds = {}

	for iter_16_0, iter_16_1 in pairs(self.allProps) do
		if ItemCfg[iter_16_1].time[2][1] == self.mainActivityID_ then
			table.insert(self.propsBonds, iter_16_1)
		end
	end

	self.selectInex = 0
	self.selectNum_ = 0
	self.canUseMaxNum_ = 0

	self:RefreshTexts()

	for iter_16_2, iter_16_3 in ipairs(self.propsBonds) do
		if ItemTools.getItemNum(iter_16_3) > 0 then
			self.selectInex = iter_16_2
			self.selectNum_ = 1

			self:RefreshCanUseMaxNum()
			self:UpdateSliderPositionBySelectNum()
			self:UpdatePreview()

			break
		end
	end

	self.scrollHelper:StartScroll(#self.propsBonds)

	if self.selectInex == 0 then
		self.selectNum_ = 0
		self.canUseMaxNum_ = 0

		self:UpdateSliderPositionBySelectNum()
		self:UpdatePreview()
	end
end

function NewWarChessPopItemView:RefreshTexts()
	self.currencyText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))
end

function NewWarChessPopItemView:UpdateSliderPositionBySelectNum()
	self.useNumSlider_.value = self.canUseMaxNum_ == 0 and 0 or self.selectNum_ / self.canUseMaxNum_
end

function NewWarChessPopItemView:UpdatePreview()
	self.useNumText_.text = self.selectNum_

	if self.selectNum_ == 0 then
		self.getnumText_.text = 0

		self.btnController_:SetSelectedState("false")

		self.okBtn_.interactable = false
	else
		self.getnumText_.text = ItemCfg[self.propsBonds[self.selectInex]].param[1] * self.selectNum_

		self.btnController_:SetSelectedState("true")

		self.okBtn_.interactable = true
	end

	self.delBtn_.interactable = self.selectNum_ > 1
	self.addBtn_.interactable = self.selectNum_ < self.canUseMaxNum_
	self.okBtn_.interactable = self.selectInex > 0
end

function NewWarChessPopItemView:OnExitInput()
	JumpTools.Back()

	return true
end

function NewWarChessPopItemView:Dispose()
	self.scrollHelper:Dispose()
	NewWarChessPopItemView.super.Dispose(self)
end

return NewWarChessPopItemView
