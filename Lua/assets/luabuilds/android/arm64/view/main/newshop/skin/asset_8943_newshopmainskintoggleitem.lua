local NewShopMainSkinToggleItem = class("NewShopMainSkinToggleItem", import("view.base.BasePanel"))

function NewShopMainSkinToggleItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	NewShopMainSkinToggleItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function NewShopMainSkinToggleItem:Init()
	onToggle(self, self.uiToggle, function(arg_3_0)
		if arg_3_0 then
			self:emit(NewShopMainScene.ON_CLICK_SKIN_SHOP, self.skinShopID)
		end

		return
	end, SFX_PANEL)

	return
end

function NewShopMainSkinToggleItem:didEnter(arg_4_1)
	self.skinShopID = arg_4_1

	setText(self.uiNameText, pg.shop_skin_subsheet[arg_4_1].site_tag_text)
	setText(self.uiNameText2, pg.shop_skin_subsheet[arg_4_1].site_tag_text)

	return
end

function NewShopMainSkinToggleItem:TriggerToggle()
	triggerToggle(self.uiToggle, true)

	return
end

function NewShopMainSkinToggleItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._tf = nil
	self._go = nil

	return
end

return NewShopMainSkinToggleItem
