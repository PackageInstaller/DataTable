AssetPendSettingBaseItem = import("game.views.setting.assetPend.AssetPendSettingBaseItem")

local AssetPendPopItem = class("AssetPendPopItem", AssetPendSettingBaseItem)

function AssetPendPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	self:AddUIListener()
end

function AssetPendPopItem:Dispose()
	AssetPendPopItem.super.Dispose(self)
end

return AssetPendPopItem
