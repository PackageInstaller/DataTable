local HeroDisplayExpressionItemView = class("HeroDisplayExpressionItemView", ReduxView)

function HeroDisplayExpressionItemView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function HeroDisplayExpressionItemView:AddListeners()
	self:AddToggleListener(self.slider_, function(arg_3_0)
		self.skinMesh_:SetBlendShapeWeight(self.index_, arg_3_0)
		HeroDisplayData:SetCacheExpressionParams(self.index_ + 1, arg_3_0)
	end)
end

function HeroDisplayExpressionItemView:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.skinMesh_ = arg_4_1
	self.index_ = arg_4_2 - 1
	self.textName_.text = GetI18NText(HeroSkinMeshCfg[arg_4_3].name)
	self.textLeft_.text = GetI18NText(HeroSkinMeshCfg[arg_4_3].leftName)
	self.textRight_.text = GetI18NText(HeroSkinMeshCfg[arg_4_3].rightName)

	self:Show(true)
end

function HeroDisplayExpressionItemView:SetValue(arg_5_1)
	self.slider_.value = arg_5_1

	self.skinMesh_:SetBlendShapeWeight(self.index_, arg_5_1)
	HeroDisplayData:SetCacheExpressionParams(self.index_ + 1, arg_5_1)
end

function HeroDisplayExpressionItemView:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function HeroDisplayExpressionItemView:Dispose()
	HeroDisplayExpressionItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return HeroDisplayExpressionItemView
