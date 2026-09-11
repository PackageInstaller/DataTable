local QWorldMainMenuItemBase = class("QWorldMainMenuItemBase", ReduxView)

function QWorldMainMenuItemBase:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.mainView = arg_1_2
	self.systemId = arg_1_3

	self:Init()
	self:AddListeners()
end

function QWorldMainMenuItemBase:BindRed()
	return
end

function QWorldMainMenuItemBase:UnBindRed()
	return
end

function QWorldMainMenuItemBase:GetIcon()
	return getSpriteWithoutAtlas("TextureConfig/SandPlay/MainIcon/" .. SandPlaySystemCfg[self.systemId].icon)
end

function QWorldMainMenuItemBase:OnBtnClick()
	return
end

function QWorldMainMenuItemBase:Init()
	self:BindCfgUI()
end

function QWorldMainMenuItemBase:AddListeners()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		self:OnBtnClick()
	end)
end

function QWorldMainMenuItemBase:Render()
	self:UnBindRed()
	self:BindRed()

	self.icon_.sprite = self:GetIcon()
end

function QWorldMainMenuItemBase:Dispose()
	self:UnBindRed()
	QWorldMainMenuItemBase.super.Dispose(self)
end

return QWorldMainMenuItemBase
