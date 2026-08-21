-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\PersonalityPanel\\RoleDevelopmentPersonalityPanelView.lua

local view = {}

function view:New(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(go, self)

	return self
end

function view:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return view
