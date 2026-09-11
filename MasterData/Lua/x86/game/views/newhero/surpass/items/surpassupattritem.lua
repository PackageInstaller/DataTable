local SurpassUpAttrItem = class("SurpassUpAttrItem", ReduxView)

function SurpassUpAttrItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SurpassUpAttrItem:InitUI()
	self:BindCfgUI()
end

function SurpassUpAttrItem:RefreshUi(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = PublicAttrCfg[arg_3_1]

	self.icon01Img_.sprite = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[arg_3_1].icon)
	self.textattack01Text_.text = var_3_0.name
	self.textnum01Text_.text = var_3_0.percent == 1 and string.format("%.2f", (arg_3_3 - arg_3_2) / 10) .. "%" or string.format("%.0f", arg_3_3 - arg_3_2)
	self.textnumup01Text_.text = var_3_0.percent == 1 and string.format("%.2f", arg_3_3 / 10) .. "%" or string.format("%.0f", arg_3_3)

	self:SetActive(true)
end

function SurpassUpAttrItem:SetActive(arg_4_1)
	self.gameObject_:SetActive(arg_4_1)
end

function SurpassUpAttrItem:Dispose()
	SurpassUpAttrItem.super.Dispose(self)
end

return SurpassUpAttrItem
