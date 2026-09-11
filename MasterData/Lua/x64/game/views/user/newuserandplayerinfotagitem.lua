local NewUserAndPlayerInfoTagItem = class("NewUserAndPlayerInfoTagItem", ReduxView)
local var_0_1 = 288

function NewUserAndPlayerInfoTagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewUserAndPlayerInfoTagItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function NewUserAndPlayerInfoTagItem:InitUI()
	self:BindCfgUI()

	self.textContentFitter_ = self.desc_.transform:GetComponent("ContentSizeFitter")
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function NewUserAndPlayerInfoTagItem:AddUIListeners()
	return
end

function NewUserAndPlayerInfoTagItem:OnEnter()
	return
end

function NewUserAndPlayerInfoTagItem:SetData(arg_6_1)
	SetActive(self.gameObject_, true)

	self.id_ = arg_6_1
	self.cfg_ = ProfileLabelCfg[self.id_]
	self.desc_.text = self.cfg_.name

	self.typeCon_:SetSelectedState(self.cfg_.type)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)

	if self.desc_.transform.rect.width < var_0_1 then
		self.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	else
		self.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		self.descRect_.sizeDelta = Vector2(var_0_1, self.descRect_.sizeDelta.y)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function NewUserAndPlayerInfoTagItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function NewUserAndPlayerInfoTagItem:OnExit()
	return
end

function NewUserAndPlayerInfoTagItem:Dispose()
	self:RemoveAllEventListener()
	NewUserAndPlayerInfoTagItem.super.Dispose(self)
end

return NewUserAndPlayerInfoTagItem
