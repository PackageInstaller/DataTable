local SevenDaySkinItem_4_0 = class("SevenDaySkinItem_4_0", ReduxView)

function SevenDaySkinItem_4_0:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.id = arg_1_2
	self.index = arg_1_3

	self:Init()
end

function SevenDaySkinItem_4_0:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinItem_4_0:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllerEx_:GetController("state")
	self.hightValueCon_ = self.controllerEx_:GetController("hightValue")
	self.showNameCon_ = self.controllerEx_:GetController("showName")
end

function SevenDaySkinItem_4_0:AddUIListeners()
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

function SevenDaySkinItem_4_0:RefreshView(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.stateCon_:SetSelectedIndex(arg_6_2)

	self.state_ = arg_6_2
	self.isResign_ = arg_6_3

	SetActive(self.redGo_, self.state_ == 1 and not self.isResign_)

	if arg_6_3 then
		self.stateCon_:SetSelectedIndex(4)
	end

	self.itemdata_ = arg_6_1

	if self.icon_ then
		self.icon_.sprite = ItemTools.getItemSprite(self.itemdata_[1])
	end

	if self.numTxt_ then
		self.numTxt_.text = self.itemdata_[2]
	end
end

function SevenDaySkinItem_4_0:RefreshGet(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1 == self.id then
			self.stateCon_:SetSelectedIndex(2)

			self.state_ = 2

			SetActive(self.redGo_, self.state_ == 1 and not self.isResign_)
		end
	end
end

function SevenDaySkinItem_4_0:RegisterClickFunc(arg_8_1)
	self.receiveFunc_ = arg_8_1
end

function SevenDaySkinItem_4_0:OnExit()
	return
end

function SevenDaySkinItem_4_0:Dispose()
	self:RemoveAllListeners()
	SevenDaySkinItem_4_0.super.Dispose(self)
end

return SevenDaySkinItem_4_0
