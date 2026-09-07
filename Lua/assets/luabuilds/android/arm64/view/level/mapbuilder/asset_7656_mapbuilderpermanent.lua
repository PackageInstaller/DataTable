local MapBuilderPermanent = class("MapBuilderPermanent", import(".MapBuilder"))

function MapBuilderPermanent:OnLoaded()
	setParent(self._tf, self.float)

	return
end

function MapBuilderPermanent:OnShow()
	MapBuilderPermanent.super.OnShow(self)
	setActive(self.sceneParent.float, true)

	return
end

function MapBuilderPermanent:OnHide()
	self.sceneParent:HideBtns()
	setActive(self.sceneParent.float, false)
	MapBuilderPermanent.super.OnHide(self)

	return
end

function MapBuilderPermanent:UpdateButtons()
	self.sceneParent:updateDifficultyBtns()
	self.sceneParent:updateActivityBtns()
	self.sceneParent:UpdateSwitchMapButton()

	return
end

function MapBuilderPermanent:UpdateMapItems()
	MapBuilderPermanent.super.UpdateMapItems(self)

	local var_5_0 = self.contextData.map
	local var_5_1 = self.contextData.map:getConfig("cloud_suffix")

	if var_5_1 == "" then
		setActive(self.sceneParent.clouds, false)
	else
		setActive(self.sceneParent.clouds, true)

		for iter_5_0, iter_5_1 in ipairs(self.contextData.map:getConfig("clouds_pos")) do
			local var_5_2 = self.sceneParent.cloudRTFs[iter_5_0]
			local var_5_3 = self.sceneParent.cloudRTFs[iter_5_0]:GetComponent(typeof(Image))

			var_5_3.enabled = false

			GetSpriteFromAtlasAsync("clouds/cloud_" .. iter_5_0 .. "_" .. var_5_1, "", function(arg_6_0)
				if self:CheckState(MapBuilderPermanent.STATES.DESTROY) then
					return
				end

				if not IsNil(var_5_3) and var_5_0 == self.contextData.map then
					var_5_3.enabled = true
					var_5_3.sprite = arg_6_0

					var_5_3:SetNativeSize()

					self.sceneParent.cloudRects[iter_5_0] = var_5_2.rect.width
				end

				return
			end)
		end
	end

	return
end

return MapBuilderPermanent
