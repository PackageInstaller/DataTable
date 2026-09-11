local TagItem = class("TagItem", ReduxView)
local var_0_1 = 288

function TagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TagItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TagItem:InitUI()
	self:BindCfgUI()

	self.textContentFitter_ = self.desc_.transform:GetComponent("ContentSizeFitter")
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function TagItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFun_ then
			self.clickFun_(self.id_)
		end
	end)
end

function TagItem:OnEnter()
	return
end

function TagItem:SetData(arg_7_1)
	self.id_ = arg_7_1.id

	self:RefreshUI()
end

function TagItem:RefreshUI()
	manager.redPoint:unbindUIandKey(self.transform_)
	SetActive(self.gameObject_, true)

	self.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
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
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TAG .. "_" .. self.id_)
end

function TagItem:RefreshSelect(arg_9_1)
	self.selectCon_:SetSelectedState(arg_9_1 and "on" or "off")
end

function TagItem:GetID()
	return self.id_
end

function TagItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function TagItem:RegisterClickFunction(arg_12_1)
	self.clickFun_ = arg_12_1
end

function TagItem:OnExit()
	return
end

function TagItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	self:RemoveAllEventListener()
	TagItem.super.Dispose(self)
end

return TagItem
