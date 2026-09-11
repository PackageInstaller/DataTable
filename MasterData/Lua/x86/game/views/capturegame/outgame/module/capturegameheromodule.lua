local CaptureGameHeroModule = class("CaptureGameHeroModule", ReduxView)

function CaptureGameHeroModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CaptureGameHeroModule:Init()
	self:InitUI()
end

function CaptureGameHeroModule:InitUI()
	self:BindCfgUI()
end

function CaptureGameHeroModule:RenderView(arg_4_1)
	SetActive(self.emptyObj_, arg_4_1 == -1)
	SetActive(self.headObj_, arg_4_1 ~= -1)

	if arg_4_1 ~= -1 then
		self.headIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. SkinCfg[arg_4_1].picture_id)
	end
end

function CaptureGameHeroModule:Dispose()
	CaptureGameHeroModule.super.Dispose(self)
end

return CaptureGameHeroModule
