local IchiBanLevelItem = class("IchiBanLevelItem", ReduxView)

function IchiBanLevelItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.levelController_ = self.uiControllerEx_:GetController("color")
	self.isFirstPosController_ = self.uiControllerEx_:GetController("isFirstPos")
	self.isGotController_ = self.uiControllerEx_:GetController("isGot")
	self.commonItem_ = CommonItemView.New(self.uiItem_, true)
end

function IchiBanLevelItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	IchiBanLevelItem.super.Dispose(self)
end

function IchiBanLevelItem:AddListeners()
	return
end

function IchiBanLevelItem:SetData(arg_4_1, arg_4_2)
	self.cfg_ = arg_4_2

	self.levelController_:SetSelectedState(tostring(arg_4_2.level))
	self.isFirstPosController_:SetSelectedState(arg_4_1 % 4 == 1 and "true" or "false")

	local var_4_0 = IchiBanTools.GetLevelPosReward(arg_4_2.id, arg_4_1)

	if var_4_0 == nil then
		self.isGotController_:SetSelectedState("false")

		self.itemData_ = nil

		self.uiAnimator_:Play("New State")
	else
		self.isGotController_:SetSelectedState("true")

		if not self.itemData_ then
			self.itemData_ = clone(ItemTemplateData)

			function self.itemData_:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemData_.id = var_4_0[1]
		self.itemData_.number = var_4_0[2]

		if IchiBanTools.NeedPlayItemAnimator(arg_4_2, arg_4_1) then
			self.uiAnimator_:Play("ticketItem_get", 0, 0)
			self.uiAnimator_:Update(0)
		else
			self.uiAnimator_:Play("ticketItem_get", 0, 1)
		end
	end

	self.commonItem_:SetData(self.itemData_)
end

return IchiBanLevelItem
