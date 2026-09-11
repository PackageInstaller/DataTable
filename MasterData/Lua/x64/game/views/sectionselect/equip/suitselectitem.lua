local SuitSelectItem = class("SuitSelectItem", ReduxView)

function SuitSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:Init()
end

function SuitSelectItem:RefreshData(arg_2_1, arg_2_2)
	self.info_ = arg_2_2

	self:Render()
end

function SuitSelectItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.itemBtn_, nil, "OnClick")
end

function SuitSelectItem:Render()
	self:RefreshUI(self.info_)
end

function SuitSelectItem:RefreshUI(arg_5_1)
	if arg_5_1 then
		self.iconImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. arg_5_1.id)
	end
end

function SuitSelectItem:TurnToStart()
	self.bgImg_.color = Color.New(1, 1, 1, 1)
	self.iconImg_.color = Color.New(1, 1, 1, 1)
end

function SuitSelectItem:ShowSelect(arg_7_1)
	SetActive(self.selectGo_, arg_7_1)
end

function SuitSelectItem:ShowCurrentUp(arg_8_1)
	SetActive(self.currentGo_, arg_8_1)
end

function SuitSelectItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function SuitSelectItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

function SuitSelectItem:GetItemInfo()
	return self.info_
end

function SuitSelectItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	SuitSelectItem.super.Dispose(self)
end

return SuitSelectItem
