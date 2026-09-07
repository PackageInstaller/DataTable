local IslandItemMsgboxWindow = class("IslandItemMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandItemMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxWithItems"
end

function IslandItemMsgboxWindow:OnLoaded()
	IslandItemMsgboxWindow.super.OnLoaded(self)

	self.uiItemList = UIItemList.New(self._tf:Find("items"), self._tf:Find("items/tpl"))

	return
end

function IslandItemMsgboxWindow:OnShow()
	IslandItemMsgboxWindow.super.OnShow(self)
	self:FlushItems(self.settings)

	return
end

function IslandItemMsgboxWindow:FlushItems(arg_4_1)
	local var_4_0 = arg_4_1.drops

	assert(arg_4_1.drops)
	self.uiItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_5_2, var_4_0[arg_5_1 + 1])
		end

		return
	end)
	self.uiItemList:align(#arg_4_1.drops)

	return
end

return IslandItemMsgboxWindow
