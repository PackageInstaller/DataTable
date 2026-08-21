-- chunkname: @IQIGame\\UI\\SummerActivityTipsUI.lua

local SummerActivityTipsUI = {}

SummerActivityTipsUI = Base:Extend("SummerActivityTipsUI", "IQIGame.Onigao.UI.SummerActivityTipsUI", SummerActivityTipsUI)

function SummerActivityTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function SummerActivityTipsUI:GetPreloadAssetPaths()
	return nil
end

function SummerActivityTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SummerActivityTipsUI:IsManualShowOnOpen(userData)
	return false
end

function SummerActivityTipsUI:GetBGM(userData)
	return nil
end

function SummerActivityTipsUI:OnOpen(userData)
	return
end

function SummerActivityTipsUI:OnClose(userData)
	return
end

function SummerActivityTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function SummerActivityTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function SummerActivityTipsUI:OnPause()
	return
end

function SummerActivityTipsUI:OnResume()
	return
end

function SummerActivityTipsUI:OnCover()
	return
end

function SummerActivityTipsUI:OnReveal()
	return
end

function SummerActivityTipsUI:OnRefocus(userData)
	return
end

function SummerActivityTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SummerActivityTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SummerActivityTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SummerActivityTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SummerActivityTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SummerActivityTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return SummerActivityTipsUI
