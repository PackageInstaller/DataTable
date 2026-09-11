local SevenDaySkinItem_3_6 = class("SevenDaySkinItem_3_6", ReduxView)

function SevenDaySkinItem_3_6:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.id = arg_1_2
	self.index = arg_1_3

	self:Init()
end

function SevenDaySkinItem_3_6:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinItem_3_6:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("receive")
	self.poCon_ = self.pointCon_:GetController("default0")
	self.itemGo = CommonItemView.New(self.item_, true)
end

function SevenDaySkinItem_3_6:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.state_ == 1 or self.isResign_ then
			if self.receiveFunc_ then
				self.receiveFunc_(self.id, self.isResign_)
			end
		else
			ShowPopItem(POP_ITEM, self.itemdata_)
		end
	end)
end

function SevenDaySkinItem_3_6:RefreshView(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.stateCon_:SetSelectedIndex(arg_6_2)

	self.state_ = arg_6_2

	if arg_6_4 >= self.index then
		self.poCon_:SetSelectedIndex(1)
	else
		self.poCon_:SetSelectedIndex(0)
	end

	self.isResign_ = arg_6_3

	SetActive(self.redGo_, self.state_ == 1 and not self.isResign_)

	if arg_6_3 then
		self.stateCon_:SetSelectedIndex(4)
	end

	self.itemdata_ = arg_6_1

	local var_6_0 = clone(ItemTemplateData)

	var_6_0.id = arg_6_1[1]
	var_6_0.number = arg_6_1[2]

	self.itemGo:SetData(var_6_0)
end

function SevenDaySkinItem_3_6:RefreshGet(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1 == self.id then
			self.stateCon_:SetSelectedIndex(2)

			self.state_ = 2

			SetActive(self.redGo_, self.state_ == 1 and not self.isResign_)
		end
	end
end

function SevenDaySkinItem_3_6:RegisterClickFunc(arg_8_1)
	self.receiveFunc_ = arg_8_1
end

function SevenDaySkinItem_3_6:OnExit()
	return
end

function SevenDaySkinItem_3_6:Dispose()
	self:RemoveAllListeners()
	SevenDaySkinItem_3_6.super.Dispose(self)
end

return SevenDaySkinItem_3_6
