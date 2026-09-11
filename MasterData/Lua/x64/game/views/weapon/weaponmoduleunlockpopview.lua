local weaponModuleUnlockPopView = class("weaponModuleUnlockPopView", ReduxView)

function weaponModuleUnlockPopView:UIName()
	return "Widget/System/Hero_module/HeroModuleUnlockPopUI"
end

function weaponModuleUnlockPopView:UIParent()
	return manager.ui.uiMain.transform
end

function weaponModuleUnlockPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function weaponModuleUnlockPopView:InitUI()
	self:BindCfgUI()
end

function weaponModuleUnlockPopView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		gameContext:Go("/weaponModuleView", {
			heroID = self.params_.heroID
		})
	end)
end

function weaponModuleUnlockPopView:OnEnter()
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTrans_)

	self.stroyText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].story)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. self.params_.heroID)
end

function weaponModuleUnlockPopView:OnExit()
	manager.windowBar:HideBar()
end

function weaponModuleUnlockPopView:Dispose()
	weaponModuleUnlockPopView.super.Dispose(self)
end

return weaponModuleUnlockPopView
