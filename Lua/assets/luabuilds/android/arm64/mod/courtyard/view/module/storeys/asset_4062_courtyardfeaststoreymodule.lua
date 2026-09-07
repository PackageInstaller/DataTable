local CourtYardFeastStoreyModule = class("CourtYardFeastStoreyModule", import(".CourtYardStoreyModule"))

function CourtYardFeastStoreyModule:GetDefaultBgm()
	return pg.voice_bgm.FeastScene.default_bgm
end

function CourtYardFeastStoreyModule:InitPedestalModule()
	self.pedestalModule = CourtYardFeastPedestalModule.New(self.data, self.bg)

	return
end

return CourtYardFeastStoreyModule
