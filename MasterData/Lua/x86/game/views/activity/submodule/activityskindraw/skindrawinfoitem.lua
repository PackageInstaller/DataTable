local SkinDrawInfoItem = class("SkinDrawInfoItem", ReduxView)

function SkinDrawInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinDrawInfoItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonItem, true)
end

function SkinDrawInfoItem:AddUIListeners()
	return
end

function SkinDrawInfoItem:RefreshData(arg_5_1, arg_5_2, arg_5_3)
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

	self.downText_.text = arg_5_3
end

function SkinDrawInfoItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function SkinDrawInfoItem:RefreshOccupyData()
	self:Show(true)

	self.downText_.text = ""
end

function SkinDrawInfoItem:SetLock(arg_9_1)
	self.commonItem_:RefreshLock(arg_9_1)
end

function SkinDrawInfoItem:OnExit()
	self.commonItem_:OnExit()
end

function SkinDrawInfoItem:Dispose()
	self:RemoveAllListeners()
	self.commonItem_:Dispose()
	self.super.Dispose(self)
end

return SkinDrawInfoItem
