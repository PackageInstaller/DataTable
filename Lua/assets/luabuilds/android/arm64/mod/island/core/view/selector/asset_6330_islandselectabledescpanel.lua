local IslandSelectableDescPanel = class("IslandSelectableDescPanel")

function IslandSelectableDescPanel:Ctor(arg_1_1, arg_1_2)
	self.isShowItemCount = arg_1_2
	self.tr = arg_1_1
	self.countBg = self.tr:Find("bg/item/icon_bg/count_bg")
	self.itemCntTxt = self.tr:Find("bg/item/icon_bg/count_bg/count"):GetComponent(typeof(Text))
	self.iconTr = self.tr:Find("bg/item/icon_bg/icon")
	self.detaltipsTf = self.tr:Find("bg/detaiView/Viewport/detaiViewText"):GetComponent(typeof(Text))
	self.nameTxt = self.tr:Find("bg/seedName"):GetComponent(typeof(Text))

	return
end

function IslandSelectableDescPanel:Show(arg_2_1, arg_2_2)
	self.tr.position = arg_2_1
	self.itemCntTxt.text = arg_2_2:GetCount()

	setActive(self.countBg, self.isShowItemCount)
	GetImageSpriteFromAtlasAsync("island/" .. arg_2_2:GetIcon(), "", self.iconTr)

	self.detaltipsTf.text = arg_2_2:GetDesc()
	self.nameTxt.text = arg_2_2:GetName()

	setActive(self.tr, true)

	return
end

function IslandSelectableDescPanel:IsShowing()
	return isActive(self.tr)
end

function IslandSelectableDescPanel:Hide()
	setActive(self.tr, false)

	return
end

function IslandSelectableDescPanel:Dispose()
	if self:IsShowing() then
		self:Hide()
	end

	return
end

return IslandSelectableDescPanel
