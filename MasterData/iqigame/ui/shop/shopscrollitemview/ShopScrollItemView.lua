-- chunkname: @IQIGame\\UI\\Shop\\ShopScrollItemView\\ShopScrollItemView.lua

local monthCardItemView = require("IQIGame.UI.Shop.ShopScrollItemView.MonthCardItemView")
local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.monthCardPanel = monthCardItemView.New(self.MonthCardPrefab, self.mainView)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data, isMonthCard)
	if isMonthCard then
		self.monthCardPanel:Show()
		self.monthCardPanel:SetData(data)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.monthCardPanel:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
