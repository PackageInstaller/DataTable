local AdminSkinView = class("AdminSkinView", ReduxView)

function AdminSkinView:UIName()
	return "Widget/System/Administrators/AdministratorsAppearanceUI"
end

function AdminSkinView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminSkinView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemA = AdminSkinItem.New(self.itemLeft_, 100102)
	self.itemB = AdminSkinItem.New(self.itemRight_, 1001)
	self.isLeft = false
	self.isRight = true
	self.curSkinID = 1001
	self.controller = self.controllerEx_:GetController("btn")
end

function AdminSkinView:AddListeners()
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.isLeft then
			self.anim_:Play("AdministratorsAppearanceUI_b", 0, 0)

			self.isLeft = false
			self.isRight = true

			self.itemA:Refresh(false)
			self.itemB:Refresh(true)

			self.curSkinID = 1001

			manager.heroRaiseTrack:SetModelState(self.curSkinID)
			self:RefreshUI()
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.isRight then
			self.anim_:Play("AdministratorsAppearanceUI_a", 0, 0)

			self.isLeft = true
			self.isRight = false

			self.itemA:Refresh(true)
			self.itemB:Refresh(false)

			self.curSkinID = 100102

			manager.heroRaiseTrack:SetModelState(self.curSkinID)
			self:RefreshUI()
		end
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		local var_7_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

		if self.curSkinID ~= var_7_0 and var_7_0 ~= 0 then
			AdminSystemTools.SelectSkin(1001, self.curSkinID)
			manager.heroRaiseTrack:RemainAni("", "Property_Break")
		end
	end)
end

function AdminSkinView:OnSelectSkin(arg_8_1, arg_8_2)
	self:RefreshUI()
end

function AdminSkinView:OnEnter()
	manager.ui:SetMainCamera("admin_sys_skin")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.itemA:Refresh(self.curSkinID ~= 1001)
	self.itemB:Refresh(self.curSkinID == 1001)
	self:RefreshUI()
end

function AdminSkinView:CameraEnter()
	local var_10_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		1
	})
	manager.heroRaiseTrack:SetModelState(var_10_0 == self.curSkinID and var_10_0 or self.curSkinID)
end

function AdminSkinView:RefreshUI()
	SetActive(self.leftBtn_.gameObject, self.isLeft)
	SetActive(self.rightBtn_.gameObject, self.isRight)

	self.titleText_.text = GetI18NText(SkinCfg[self.curSkinID].name)
	self.descText_.text = GetI18NText(SkinCfg[self.curSkinID].desc)

	self.itemA:Refresh(self.curSkinID ~= 1001)
	self.itemB:Refresh(self.curSkinID == 1001)
	self.controller:SetSelectedIndex(self.curSkinID == AdminSystemTools.HeroUsingSkinInfo(1001) and 1 or 0)
end

function AdminSkinView:OnExit()
	manager.windowBar:HideBar()
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
	self.super.OnExit(self)
end

function AdminSkinView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.itemA:Dispose()
	self.itemB:Dispose()

	self.itemA = nil
	self.itemB = nil

	self.super.Dispose(self)
end

return AdminSkinView
