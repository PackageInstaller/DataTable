-- chunkname: @IQIGame\\UI\\MazeActivityUI.lua

local MazeActivityUI = {}

MazeActivityUI = Base:Extend("MazeActivityUI", "IQIGame.Onigao.UI.MazeActivityUI", MazeActivityUI)

local shopViewClass = require("IQIGame/UI/Maze/MazeActivityShopView")
local collectionViewClass = require("IQIGame/UI/Maze/MazeActivityCollectionView")

function MazeActivityUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function MazeActivityUI:InitComponent()
	self.shopView = shopViewClass.New(self.shopRoot, self)

	self.shopView:Hide()

	self.collectionView = collectionViewClass.New(self.collectionRoot, self)

	self.collectionView:Hide()
end

function MazeActivityUI:InitDelegate()
	function self.delegateOnClickButtonShop()
		self.shopView:Show()
		self.shopView:Refresh()
	end

	function self.delegateOnClickButtonCollection()
		self.collectionView:Show()
		self.collectionView:Refresh()
	end

	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)
	end
end

function MazeActivityUI:OnAddListeners()
	self.buttonShop:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonShop)
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	self.buttonCollection:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonCollection)
end

function MazeActivityUI:OnRemoveListeners()
	self.buttonShop:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonShop)
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	self.buttonCollection:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonCollection)
end

function MazeActivityUI:OnOpen(userData)
	return
end

function MazeActivityUI:OnClose(userData)
	return
end

function MazeActivityUI:GetPreloadAssetPaths()
	return nil
end

function MazeActivityUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeActivityUI:IsManualShowOnOpen(userData)
	return false
end

function MazeActivityUI:GetBGM(userData)
	return nil
end

function MazeActivityUI:OnPause()
	return
end

function MazeActivityUI:OnResume()
	return
end

function MazeActivityUI:OnCover()
	return
end

function MazeActivityUI:OnReveal()
	return
end

function MazeActivityUI:OnRefocus(userData)
	return
end

function MazeActivityUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeActivityUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeActivityUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeActivityUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeActivityUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return MazeActivityUI
