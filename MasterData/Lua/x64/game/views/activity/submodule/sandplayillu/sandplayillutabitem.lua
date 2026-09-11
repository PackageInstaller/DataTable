local SandPlayIlluTabItem = class("SandPlayIlluTabItem", ReduxView)

function SandPlayIlluTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SandPlayIlluTabItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function SandPlayIlluTabItem:InitUI()
	self:BindCfgUI()
end

function SandPlayIlluTabItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self:OnSelectBtnClick()
	end)
end

function SandPlayIlluTabItem:OnSelectBtnClick()
	self.onClick_(self.index_)
end

function SandPlayIlluTabItem:SetSelectedState(arg_7_1)
	self.selectController_:SetSelectedState(self.index_ == arg_7_1 and "true" or "false")
end

function SandPlayIlluTabItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.groupID_ = arg_8_2
	self.onClick_ = arg_8_3

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_GROUP, arg_8_2))
	self:UpdateView()
end

function SandPlayIlluTabItem:UpdateView()
	if not SandplayIlluGroupCfg[self.groupID_] then
		return
	end

	self.iconImg_.sprite = getSpriteViaConfig("SandplayIllu", SandplayIlluGroupCfg[self.groupID_].icon)
end

function SandPlayIlluTabItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function SandPlayIlluTabItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_GROUP, self.groupID_))
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	SandPlayIlluTabItem.super.Dispose(self)
end

return SandPlayIlluTabItem
