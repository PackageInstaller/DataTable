local ChessHome = class("ChessHome", ReduxView)

function ChessHome:UIName()
	return "UI/IllustratedHandbook/IlluInformation"
end

function ChessHome:UIParent()
	return manager.ui.uiMain.transform
end

function ChessHome:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessHome:InitUI()
	return
end

function ChessHome:AddUIListener()
	return
end

function ChessHome:OnEnter()
	self:ShowDefaultBar()
end

function ChessHome:OnExit()
	manager.windowBar:HideBar()
end

function ChessHome:Dispose()
	ChessHome.super.Dispose(self)
end

return ChessHome
