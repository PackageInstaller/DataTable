local AgoraPaveTileView = class("AgoraPaveTileView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function AgoraPaveTileView:GetUIName()
	return "IslandAgoraPaveTileUI"
end

function AgoraPaveTileView:FirstFlush()
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.exitBtn = self._tf:Find("exit")
	self.rotation = self._tf:Find("revert")
	self.confirmBtn = self._tf:Find("confirm")
	self.mode = self._tf:Find("mode")

	setText(self._tf:Find("desc"), i18n("island_agora_pave_tip"))
	self:RegisterEvent()

	return
end

function AgoraPaveTileView:RegisterEvent()
	onButton(self, self.exitBtn, function()
		self:Op("RevertPaveLayer")
		self:GetView():ExitPaveTileMode()

		return
	end, SFX_PANEL)
	onToggle(self, self.mode, function(arg_5_0)
		self:Op("ChangePaveMode", arg_5_0)

		return
	end, true)
	onButton(self, self.rotation, function()
		if self.shapeId == IslandConst.AGORA_TILE_SHAPE_ALL then
			return
		end

		self.shapeId = self.shapeId + 1

		if self.shapeId > self.maxShapeId then
			self.shapeId = self.minShapeId
		end

		self:Op("ChangeSelectedShape", self.shapeId)

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:GetView():ExitPaveTileMode()

		return
	end, SFX_PANEL)

	return
end

function AgoraPaveTileView:Flush(arg_8_1, arg_8_2)
	self.shapeId = arg_8_2
	self.minShapeId = arg_8_2
	self.maxShapeId = self.shapeId + 3
	self.nameTxt.text = arg_8_1:GetName()

	LoadSpriteAsync("island/IslandFurnitureIcon/" .. arg_8_1:GetIcon(), function(arg_9_0)
		self.icon.sprite = arg_9_0

		return
	end)
	triggerToggle(self.mode, false)

	return
end

function AgoraPaveTileView:OnDestroy()
	return
end

return AgoraPaveTileView
