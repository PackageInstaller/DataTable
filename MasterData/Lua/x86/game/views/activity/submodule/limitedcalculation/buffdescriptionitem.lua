local BuffDescriptionItem = class("BuffDescriptionItem", ReduxView)

function BuffDescriptionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BuffDescriptionItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BuffDescriptionItem:InitUI()
	self:BindCfgUI()

	self.levelCon_ = ControllerUtil.GetController(self.transform_, "level")
end

function BuffDescriptionItem:AddUIListeners()
	return
end

function BuffDescriptionItem:OnEnter()
	return
end

function BuffDescriptionItem:RefreshUI(arg_6_1)
	self.affix_ = arg_6_1
	self.title_.text = GetI18NText(AffixTypeCfg[self.affix_[1]].name)

	self.levelCon_:SetSelectedState(self.affix_[2])

	self.desc_.text = GetI18NText(getAffixDesc(self.affix_))
end

function BuffDescriptionItem:OnExit()
	return
end

function BuffDescriptionItem:Dispose()
	self:RemoveAllListeners()
	BuffDescriptionItem.super.Dispose(self)
end

return BuffDescriptionItem
