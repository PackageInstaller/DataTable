local IslandCustomerHudPanel = class("IslandCustomerHudPanel", import("Mod.Island.Core.View.IslandBaseHudPanel"))

function IslandCustomerHudPanel:GetUIName()
	return "IslandCustomerHud"
end

function IslandCustomerHudPanel:OnInit()
	self.hudImage = self._tf:Find("hudImage")
	self.unitPosition = pg.island_world_objects[self.unitId].param.position
	self.images = pg.island_set.island_manage_bubble_resource.key_value_varchar
	self.durations = pg.island_set.island_manage_bubble_duration.key_value_varchar
	self.cds = pg.island_set.island_manage_bubble_cd.key_value_varchar

	GetImageSpriteFromAtlasAsync(self.images[math.random(#self.images)], "", self.hudImage)

	self.timer = Timer.New(function()
		self.active = not self.active

		if self.active then
			GetImageSpriteFromAtlasAsync(self.images[math.random(#self.images)], "", self.hudImage)

			self.timer.duration = math.random(self.durations[1], self.durations[2])
		else
			self.timer.duration = math.random(self.cds[1], self.cds[2])
		end

		return
	end, math.random(self.durations[1], self.durations[2]), -1)

	self.timer:Start()

	return
end

function IslandCustomerHudPanel:OnDispose()
	self.timer:Stop()

	self.timer = nil

	IslandCustomerHudPanel.super.OnDispose(self)

	return
end

return IslandCustomerHudPanel
