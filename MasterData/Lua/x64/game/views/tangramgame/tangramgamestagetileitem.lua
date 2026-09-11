local TangramGameStageTileItem = class("TangramGameStageTileItem", ReduxView)

function TangramGameStageTileItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function TangramGameStageTileItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function TangramGameStageTileItem:AddUIListener()
	self:AddPonitListener(self.buttonBtn_.gameObject, function()
		if self.changePositionFunc then
			self:changePositionFunc()
		end
	end, function()
		return
	end)
end

function TangramGameStageTileItem:RefreshUI(arg_6_1)
	self.index = arg_6_1
	self.indexText = self.index
end

function TangramGameStageTileItem:Dispose()
	TangramGameStageTileItem.super.Dispose(self)
end

return TangramGameStageTileItem
