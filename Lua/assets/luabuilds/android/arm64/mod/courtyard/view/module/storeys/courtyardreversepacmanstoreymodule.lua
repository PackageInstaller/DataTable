local CourtYardReversePacmanStoreyModule = class("CourtYardReversePacmanStoreyModule", import(".CourtYardStoreyModule"))

function CourtYardReversePacmanStoreyModule:OnInit()
	CourtYardReversePacmanStoreyModule.super.OnInit(self)

	self.bg.localScale = Vector3(1, 1, 1)

	return
end

function CourtYardReversePacmanStoreyModule:GetDefaultBgm()
	return pg.voice_bgm.ReversePacmanHomeScene.default_bgm
end

function CourtYardReversePacmanStoreyModule:InitPedestalModule()
	self.pedestalModule = CourtYardReversePacmanPedestalModule.New(self.data, self.bg)

	return
end

return CourtYardReversePacmanStoreyModule
