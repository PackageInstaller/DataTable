local NewHeroBreakMaterialItem = class("NewHeroBreakMaterialItem", ReduxView)

function NewHeroBreakMaterialItem:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function NewHeroBreakMaterialItem:Init()
	self:InitUI()
end

function NewHeroBreakMaterialItem:InitUI()
	self:BindCfgUI()

	self.enoughController_ = ControllerUtil.GetController(self.gameObject_.transform, "enough")
	self.commonItem_ = CommonItemView.New(self.gameObject_)
end

function NewHeroBreakMaterialItem:SetInfo(arg_4_1, arg_4_2)
	self.materialId_ = arg_4_1
	self.count_ = arg_4_2

	self:UpdateView()
end

function NewHeroBreakMaterialItem:UpdateView()
	local var_5_0 = self.commonItem_:GetData()

	self.data = clone(ItemTemplateData)

	function self.data.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.materialId_,
			self.count_
		})
	end

	self.data.id = self.materialId_
	self.data.number = self.count_

	self.commonItem_:SetData(self.data)
	self.commonItem_:RefreshBottomText({
		ItemTools.getItemNum(self.materialId_),
		self.count_
	})
end

function NewHeroBreakMaterialItem:IsEnough()
	return ItemTools.getItemNum(self.materialId_) >= self.count_
end

function NewHeroBreakMaterialItem:GetMaterialId()
	return self.materialId_
end

function NewHeroBreakMaterialItem:Dispose()
	self:RemoveAllListeners()

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	NewHeroBreakMaterialItem.super.Dispose(self)
end

return NewHeroBreakMaterialItem
