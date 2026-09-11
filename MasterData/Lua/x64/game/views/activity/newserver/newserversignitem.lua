local NewServerSignItem = class("NewServerSignItem", ReduxView)

function NewServerSignItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewServerSignItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewServerSignItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.commonItem_ = CommonItemView.New(self.commonItemGo_)
end

function NewServerSignItem:AddUIListener()
	self:AddBtnListener(self.button_, nil, function()
		if self.callback_ then
			self.callback_(self.index_)
		end
	end)
end

function NewServerSignItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.descText_.text = string.format(GetTips("NEW_SERVER_SIGN_DAY"), arg_6_1)

	if SignCfg[arg_6_2] then
		if not self.itemData_ then
			self.itemData_ = clone(ItemTemplateData)

			function self.itemData_:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemData_.id = SignCfg[arg_6_2].reward[1]
		self.itemData_.number = SignCfg[arg_6_2].reward[2]

		self.commonItem_:SetData(self.itemData_)
	end

	self:Refresh()
end

function NewServerSignItem:Refresh()
	if NewServerData:IsSignReward(self.index_) then
		self.stateController_:SetSelectedIndex(2)
	elseif NewServerData:GetSignIndex() >= self.index_ then
		self.stateController_:SetSelectedIndex(1)
	else
		self.stateController_:SetSelectedIndex(0)
	end
end

function NewServerSignItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function NewServerSignItem:OnSign()
	local var_10_0 = self.commonItem_:GetData()

	var_10_0.highLight = not NewServerData:IsSignReward(self.index_) and NewServerData:GetSignIndex() >= self.index_

	self.commonItem_:SetData(var_10_0)
	self:Refresh()
end

function NewServerSignItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	NewServerSignItem.super.Dispose(self)
end

return NewServerSignItem
