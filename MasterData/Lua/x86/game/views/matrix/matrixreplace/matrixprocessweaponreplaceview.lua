local MatrixProcessWeaponReplaceView = class("MatrixProcessWeaponReplaceView", ReduxView)

function MatrixProcessWeaponReplaceView:UIName()
	return "UI/Matrix/Process/MatrixProcessWeaponReplaceUI"
end

function MatrixProcessWeaponReplaceView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixProcessWeaponReplaceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessWeaponReplaceView:InitUI()
	self:BindCfgUI()

	self.item_l = MatrixProcessRewardItem.New(self.m_item_l)
	self.item_r = MatrixProcessRewardItem.New(self.m_item_r)
end

function MatrixProcessWeaponReplaceView:AddUIListener()
	self:AddBtnListener(self.m_okBtn, nil, function()
		if self.params_.callback then
			self.params_.callback()
		end

		self:Back()
	end)
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
end

function MatrixProcessWeaponReplaceView:OnTop()
	manager.windowBar:SwitchBar({})
end

function MatrixProcessWeaponReplaceView:OnEnter()
	self.heroId = self.params_.heroId

	self.item_r:Refresh((self:GetHeroData(self.heroId):GetWeaponServant()))

	self.weaponId = self.params_.weaponId

	self.item_l:Refresh(self.weaponId)
end

function MatrixProcessWeaponReplaceView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixProcessWeaponReplaceView:Dispose()
	self.item_l:Dispose()
	self.item_r:Dispose()
	MatrixProcessWeaponReplaceView.super.Dispose(self)
end

function MatrixProcessWeaponReplaceView:GetHeroData(arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

return MatrixProcessWeaponReplaceView
