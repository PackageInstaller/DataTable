local CustomItem = class("CustomItem", ReduxView)

function CustomItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CustomItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
	self.lvCon_ = ControllerUtil.GetController(self.transform_, "lv")
end

function CustomItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.customID_)
		end
	end)
end

function CustomItem:OnEnter()
	return
end

function CustomItem:RefreshUI(arg_7_1, arg_7_2)
	self.customID_ = arg_7_1
	self.isSelect_ = arg_7_2
	self.cfg_ = ActivityAffixPoolCfg[self.customID_]
	self.pointText_.text = self.cfg_.point
	self.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.customID_].affix)

	self.selectCon_:SetSelectedState(arg_7_2 and "true" or "false")
	self.lvCon_:SetSelectedState(self.cfg_.affix[2])
end

function CustomItem:RegisterClickListener(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function CustomItem:OnExit()
	return
end

function CustomItem:Dispose()
	self:RemoveAllListeners()
	CustomItem.super.Dispose(self)
end

return CustomItem
