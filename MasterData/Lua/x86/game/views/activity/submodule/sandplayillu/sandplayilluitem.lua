local SandPlayIlluItem = class("SandPlayIlluItem", ReduxView)

function SandPlayIlluItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SandPlayIlluItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function SandPlayIlluItem:InitUI()
	self:BindCfgUI()
end

function SandPlayIlluItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self:OnSelectBtnClick()
	end)
end

function SandPlayIlluItem:OnSelectBtnClick()
	self.onClick_(self.itemID_, self.index_)
end

function SandPlayIlluItem:SetSelectedState(arg_7_1)
	self.selectController_:SetSelectedState(self.itemID_ == arg_7_1 and "true" or "false")
end

function SandPlayIlluItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.itemID_ = arg_8_2
	self.onClick_ = arg_8_3

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, arg_8_2))
	self:UpdateView()
end

function SandPlayIlluItem:UpdateView()
	if not SandplayIlluCfg[self.itemID_] then
		return
	end

	if SandplayIlluData:IsUnlock(self.itemID_) then
		self.lockController_:SetSelectedState("false")

		self.iconImg_.sprite = getSpriteViaConfig("SandplayIllu", SandplayIlluCfg[self.itemID_].icon)
	else
		self.lockController_:SetSelectedState("true")

		self.iconImg_.sprite = nil
	end
end

function SandPlayIlluItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, self.itemID_))
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	SandPlayIlluItem.super.Dispose(self)
end

return SandPlayIlluItem
