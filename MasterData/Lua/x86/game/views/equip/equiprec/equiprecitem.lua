local EquipRecItem = class("EquipRecItem", ReduxView)

function EquipRecItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipRecItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function EquipRecItem:InitUI()
	self:BindCfgUI()

	self.starController_ = ControllerUtil.GetController(self.gameObject_.transform, "star")
end

function EquipRecItem:SetEquipId(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.index_ = arg_4_1
	self.heroId_ = arg_4_2
	self.equipId_ = arg_4_3
	self.equipStruct_ = EquipStruct.New(0, arg_4_3)
	self.isHave_ = arg_4_4

	self:RefreshUI()
end

function EquipRecItem:RefreshUI()
	if self.equipStruct_.star > 0 then
		self.starController_:SetSelectedState(tostring(self.equipStruct_.star))
	end

	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. ItemCfg[self.equipId_].icon)

	SetActive(self.btnGet_.gameObject, not self.isHave_)
	SetActive(self.btnEquip_.gameObject, self.isHave_)
	SetActive(self.hadGo_, false)
end

function EquipRecItem:AddUIListeners()
	self:AddBtnListener(self.btnGet_, nil, function()
		ShowPopItemSource(self.equipId_)
	end)
	self:AddBtnListener(self.btnEquip_, nil, function()
		self:Go("/heroEquipBag", {
			needRefresh = true,
			isClearPos = true,
			isOpenInfo = false,
			heroId = self.heroId_,
			suitPos = self.index_,
			suit = EquipCfg[self.equipId_].suit
		})
	end)
	self:AddBtnListener(nil, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.equipId_
		})
	end)
end

function EquipRecItem:OnEnter()
	return
end

function EquipRecItem:OnExit()
	return
end

function EquipRecItem:Dispose()
	self:RemoveAllListeners()
	EquipRecItem.super.Dispose(self)
end

return EquipRecItem
