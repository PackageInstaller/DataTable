local WeaponServantStoryModule = class("WeaponServantStoryModule", ReduxView)

function WeaponServantStoryModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function WeaponServantStoryModule:Dispose()
	self:RemoveAllListeners()
	WeaponServantStoryModule.super.Dispose(self)
end

function WeaponServantStoryModule:OnRenderModule(arg_3_1)
	self.storyText_.text = WeaponServantCfg[arg_3_1.servantData.id].story
end

return WeaponServantStoryModule
