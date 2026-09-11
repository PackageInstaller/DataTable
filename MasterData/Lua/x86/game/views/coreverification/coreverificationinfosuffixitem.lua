local CoreVerificationInfoSuffIxItem = class("CoreVerificationInfoSuffIxItem", ReduxView)

function CoreVerificationInfoSuffIxItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.index = 0
	self.nowID = 0
	self.data = {}
end

function CoreVerificationInfoSuffIxItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationInfoSuffIxItem:InitUI()
	self:BindCfgUI()
end

function CoreVerificationInfoSuffIxItem:AddUIListener()
	self:AddBtnListener(self.btnaddBtn_, nil, function()
		self.index = Mathf.Clamp(self.index + 1, 0, #self.data)

		self:UpdateTxt(self.index, self.index)
		self.callBack(self.itemIndex, self.index)
	end)
	self:AddBtnListener(self.btnsubtractBtn_, nil, function()
		self.index = Mathf.Clamp(self.index - 1, 0, #self.data)

		self:UpdateTxt(self.index)
		self.callBack(self.itemIndex, self.index)
	end)
end

function CoreVerificationInfoSuffIxItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.data = arg_7_1
	self.index = arg_7_2 or 0
	self.itemIndex = arg_7_3

	self:UpdateTxt(self.index)

	self.callBack = arg_7_4
end

function CoreVerificationInfoSuffIxItem:UpdateTxt(arg_8_1)
	self.btnsubtractBtn_.interactable = arg_8_1 > 0
	self.btnaddBtn_.interactable = arg_8_1 < #self.data

	if self.data then
		local var_8_0

		if arg_8_1 == 0 then
			var_8_0 = self.data[1] or self.data[arg_8_1]
		end

		local var_8_1 = ActivityAffixPoolCfg[var_8_0]

		if arg_8_1 ~= 0 and var_8_1 then
			self.nowID = var_8_0
			self.pointText_.text = var_8_1.point
			self.descText_.text = var_8_1.name
		else
			self.nowID = nil
			self.pointText_.text = 0
			self.descText_.text = var_8_1.name
		end
	end

	self.textamountText_.text = arg_8_1
end

function CoreVerificationInfoSuffIxItem:Dispose()
	CoreVerificationInfoSuffIxItem.super.Dispose(self)
end

return CoreVerificationInfoSuffIxItem
