local WeaponModuleStoryView = class("WeaponModuleStoryView", ReduxView)

function WeaponModuleStoryView:UIName()
	return "Widget/System/Hero_module/HeroModuleStoryPopUI"
end

function WeaponModuleStoryView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponModuleStoryView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleStoryView:InitUI()
	self:BindCfgUI()
end

function WeaponModuleStoryView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function WeaponModuleStoryView:OnEnter()
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].name)
	self.storyText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].story)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.contentTrans_.localPosition = Vector3.New(0, 0, 0)
	self.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. self.params_.heroID)
end

function WeaponModuleStoryView:Dispose()
	WeaponModuleStoryView.super.Dispose(self)
end

return WeaponModuleStoryView
