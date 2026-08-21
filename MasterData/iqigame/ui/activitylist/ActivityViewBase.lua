-- chunkname: @IQIGame\\UI\\ActivityList\\ActivityViewBase.lua

local m = {}

function m.New(view, controller)
	local obj = Clone(controller)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:__Init()
	self:AddListeners()
end

function m:AddListeners()
	self:__AddListeners()
end

function m:RemoveListeners()
	self:__RemoveListeners()
end

function m:SetData(activityListCfg)
	self:__SetData(activityListCfg)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self:__Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

function m:__Init()
	return
end

function m:__AddListeners()
	return
end

function m:__RemoveListeners()
	return
end

function m:__SetData(activityListCfg)
	return
end

function m:__Dispose()
	return
end

function m:__OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function m:__OnReveal()
	return
end

function m:__OnCover()
	return
end

return m
