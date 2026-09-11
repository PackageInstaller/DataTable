local CustomDesItem = class("CustomDesItem", ReduxView)

function CustomDesItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CustomDesItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomDesItem:InitUI()
	self:BindCfgUI()
end

function CustomDesItem:AddUIListeners()
	return
end

function CustomDesItem:OnEnter()
	return
end

local var_0_1 = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}

function CustomDesItem:RefreshUI(arg_6_1, arg_6_2)
	self.text_.text = (arg_6_2 and string.format("<size=28>%s%s(%s)</size>", GetI18NText(AffixTypeCfg[arg_6_1[1]].name), var_0_1[arg_6_1[2]], GetTips("IS_LOCK")) or string.format("<size=28>%s%s</size>", GetI18NText(AffixTypeCfg[arg_6_1[1]].name), var_0_1[arg_6_1[2]])) .. "\n" .. string.format("<size=22>%s</size>", getAffixDesc(arg_6_1))
	self.icon_.sprite = getAffixSprite(arg_6_1)
end

function CustomDesItem:OnExit()
	return
end

function CustomDesItem:Dispose()
	self:RemoveAllListeners()
	CustomDesItem.super.Dispose(self)
end

return CustomDesItem
