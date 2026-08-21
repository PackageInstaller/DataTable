-- chunkname: @IQIGame\\UI\\Main\\BannerItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnJumpBtnClick()
		self:OnJumpBtnClick()
	end

	function self.OnDelegateByItemResult()
		self:RefreshRedDot()
	end

	LuaUtility.SetGameObjectShow(self.RedDot, false)
	self:AddListeners()
end

function m:AddListeners()
	self.detailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnJumpBtnClick)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.OnDelegateByItemResult)
end

function m:RemoveListeners()
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnJumpBtnClick)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.OnDelegateByItemResult)
end

function m:SetData(bannerCfg)
	self.bannerCfg = bannerCfg

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.bannerCfg.Path), self.bannerImg:GetComponent("Image"))
end

function m:RefreshRedDot()
	return
end

function m:OnJumpBtnClick()
	if self.bannerCfg.Skip == 0 then
		return
	end

	JumpModule.Jump(self.bannerCfg.Skip)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
