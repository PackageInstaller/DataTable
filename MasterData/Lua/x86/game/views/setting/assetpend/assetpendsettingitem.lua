AssetPendSettingBaseItem = import("game.views.setting.assetPend.AssetPendSettingBaseItem")

local AssetPendSettingItem = class("AssetPendSettingItem", AssetPendSettingBaseItem)

function AssetPendSettingItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	self:AddUIListener()
end

function AssetPendSettingItem:Dispose()
	AssetPendSettingItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return AssetPendSettingItem
