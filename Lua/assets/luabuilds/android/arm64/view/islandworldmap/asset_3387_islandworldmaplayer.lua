local IslandWorldMapLayer = class("IslandWorldMapLayer", import("view.base.BaseUI"))

function IslandWorldMapLayer:getUIName()
	return "IslandWorldMapUI"
end

function IslandWorldMapLayer:init()
	return
end

function IslandWorldMapLayer:didEnter()
	self.ad = findTF(self._tf, "ad")

	self:initPanel()
	self:initButtonEvent()
	self:initMapTestButton()
	pg.UIMgr.GetInstance():BlurPanel(self.ad)

	return
end

function IslandWorldMapLayer:initPanel()
	self.mapContainer = IslandMapContainer.New(findTF(self.ad, "map"), self)

	self.mapContainer:loadMap()

	self.buildPanel = IslandMapBuildPanel.New(findTF(self.ad, "panel/buildDetailPanel"), self)
	self.missionPanel = IslandMissionPanel.New(findTF(self.ad, "panel/missionPanel"), self)

	self.buildPanel:setActive(false)
	self.missionPanel:setActive(false)

	return
end

function IslandWorldMapLayer:initButtonEvent()
	self.tempIndex = 0

	onButton(self, findTF(self.ad, "ui/btnBuild"), function()
		if self.tempIndex % 2 == 0 then
			self.mapContainer:setScale(2)
		else
			self.mapContainer:setScale(1)
		end

		self.tempIndex = self.tempIndex + 1

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.ad, "ui/btnClose"), function()
		self:closeView()

		return
	end, SFX_CONFIRM)

	return
end

function IslandWorldMapLayer:initMapTestButton()
	self.btnMapTpl = findTF(self.ad, "ui/btnMapGuide")

	setActive(self.btnMapTpl, false)

	for iter_8_0, iter_8_1 in ipairs(pg.island_map.all) do
		local var_8_0 = pg.island_map[iter_8_1]

		if pg.island_map[iter_8_1].sceneName and pg.island_map[iter_8_1].sceneName ~= "" then
			local var_8_1 = tf(instantiate(self.btnMapTpl))

			SetParent(var_8_1, findTF(self.ad, "ui/mapGuide"))
			setActive(var_8_1, true)
			setText(findTF(var_8_1, "text"), "跳转地图: " .. pg.island_map[iter_8_1].name)
			onButton(self, var_8_1, function()
				self:emit(IslandWorldMapMediator.GO_ISLAND, var_8_0.id)
				self:closeView()

				return
			end, SFX_CONFIRM)
		end
	end

	return
end

function IslandWorldMapLayer:onBackPressed()
	self:closeView()

	return
end

function IslandWorldMapLayer:willExit()
	self.mapContainer:dispose()
	self.buildPanel:dispose()
	self.missionPanel:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.ad, self._tf)

	return
end

return IslandWorldMapLayer
