local SkinDrawInfoItemOld = class("SkinDrawInfoItemOld", ReduxView)

function SkinDrawInfoItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinDrawInfoItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoItemOld:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonItemGo_, true)
end

function SkinDrawInfoItemOld:AddUIListeners()
	return
end

function SkinDrawInfoItemOld:RefreshData(arg_5_1, arg_5_2)
	self:Show(true)

	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_1
	var_5_0.number = arg_5_2
	var_5_0.bottomText = arg_5_2

	function var_5_0:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem_:SetData(var_5_0)
end

function SkinDrawInfoItemOld:SetBottomText(arg_7_1)
	self.text_.text = arg_7_1
end

function SkinDrawInfoItemOld:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function SkinDrawInfoItemOld:OnExit()
	self.commonItem_:OnExit()
end

function SkinDrawInfoItemOld:Dispose()
	self:RemoveAllListeners()
	self.commonItem_:Dispose()
	self.super.Dispose(self)
end

return SkinDrawInfoItemOld
