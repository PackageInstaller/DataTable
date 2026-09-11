local CaptureGameSectionHeroModule = class("CaptureGameSectionHeroModule", ReduxView)

function CaptureGameSectionHeroModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CaptureGameSectionHeroModule:Init()
	self:InitUI()
end

function CaptureGameSectionHeroModule:BuildContext()
	self.slots = {
		{
			entity = CaptureGameHeroModule.New(self.headModule1_)
		},
		{
			entity = CaptureGameHeroModule.New(self.headModule2_)
		},
		{
			entity = CaptureGameHeroModule.New(self.headModule3_)
		},
		{
			entity = CaptureGameHeroModule.New(self.headModule4_)
		}
	}
end

function CaptureGameSectionHeroModule:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function CaptureGameSectionHeroModule:RenderView(arg_5_1)
	local var_5_0 = CaptureGameTools:GetCaptureHeroList(arg_5_1)

	for iter_5_0 = 1, 4 do
		self.slots[iter_5_0].entity:RenderView(var_5_0[iter_5_0] or -1)
	end
end

function CaptureGameSectionHeroModule:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.slots) do
		if iter_6_1.entity then
			iter_6_1.entity:Dispose()

			iter_6_1.entity = nil
		end
	end

	CaptureGameSectionHeroModule.super.Dispose(self)
end

return CaptureGameSectionHeroModule
