local RegressionSignItem = class("RegressionSignItem", ReduxView)

function RegressionSignItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RegressionSignItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionSignItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.commonItem_ = CommonItemView.New(self.m_item)
end

function RegressionSignItem:AddUIListener()
	self:AddBtnListener(self.m_button, nil, function()
		if not RegressionDataNew:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function RegressionSignItem:SetData(arg_6_1, arg_6_2)
	self.index = arg_6_1
	self.m_dayLab.text = arg_6_1

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

function RegressionSignItem:Refresh()
	if RegressionDataNew:IsSignReward(self.index) then
		self.stateController:SetSelectedIndex(2)
	elseif RegressionDataNew:GetSignIndex() >= self.index then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end
end

function RegressionSignItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function RegressionSignItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	RegressionSignItem.super.Dispose(self)
end

return RegressionSignItem
