-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogDarken.lua

local m = {
	SuccessCount = 0,
	Started = false,
	DEFAULT_COLOR_DARK = Color(0.19607843137254902, 0.19607843137254902, 0.19607843137254902, 1)
}

function m.New(userData)
	local obj = Clone(m)

	obj.NpcPortrait = userData.npcPortrait

	return obj
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.Started = true
	self.DarkColor = m.DEFAULT_COLOR_DARK

	if params ~= nil and #params > 0 then
		self.DarkColor = hexStringToColor("#" .. params[1])
	end

	self:SetGameObjectColor(self.DarkColor)
end

function m:Stop()
	if self.Started then
		self:SetGameObjectColor(Color.white)
		self:DarkenComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	local success = self:SetGameObjectColor(self.DarkColor)

	self.SuccessCount = self.SuccessCount + (success and 1 or 0)

	if self.SuccessCount > 2 then
		self:DarkenComplete()
	end
end

function m:SetGameObjectColor(color)
	if self.NpcPortrait ~= nil and self.NpcPortrait.LoadingAsset then
		return false
	end

	return m.StaticSetGameObjectColor(self.gameObject, color)
end

function m.StaticSetGameObjectColor(obj, color)
	local graphics = obj:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)
	local renderers = obj:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, graphics.Length - 1 do
		local graphic = graphics[i]

		graphic.color = color
	end

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		for j = 0, renderer.materials.Length - 1 do
			local material = renderer.materials[j]

			material:SetColor("_Color", color)
		end
	end

	return graphics.Length > 0 or renderers.Length > 0
end

function m:DarkenComplete()
	self.PerformanceData.Completed = true

	self:Clear()
end

function m.ResetHost(obj)
	m.StaticSetGameObjectColor(obj, Color.white)
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.Started = false
	self.SuccessCount = 0
	self.DarkColor = nil
end

return m
