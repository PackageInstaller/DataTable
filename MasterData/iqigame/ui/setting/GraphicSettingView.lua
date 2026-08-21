-- chunkname: @IQIGame\\UI\\Setting\\GraphicSettingView.lua

local GraphicSettingView = {}

function GraphicSettingView.New(view)
	local obj = Clone(GraphicSettingView)

	obj:Init(view)

	return obj
end

function GraphicSettingView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local renderScale = PlayerPrefsUtil.GetFloat("", "RenderScale", 1)
	local renderScaleText = self.RenderScaleText:GetComponent(typeof(UnityEngine.UI.Text))

	function self.delegateOnRenderScaleValueChanged(renderScale)
		BordlessFramework.URPRendererManager.SetRenderScale(renderScale)

		renderScaleText.text = renderScale

		PlayerPrefsUtil.SetFloat("", "RenderScale", renderScale)
	end

	local renderScaleSlider = self.RenderScaleSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	BordlessFramework.URPRendererManager.SetRenderScale(renderScale)

	renderScaleSlider.value = renderScale
	renderScaleText.text = renderScale

	local lod = PlayerPrefsUtil.GetFloat("", "LOD", 2)
	local lodText = self.LODText:GetComponent(typeof(UnityEngine.UI.Text))

	function self.delegateOnLODValueChanged(lod)
		BordlessFramework.LODCollector.staticLOD = lod
		lodText.text = lod

		PlayerPrefsUtil.SetFloat("", "LOD", lod)
	end

	local lodSlider = self.LODSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	BordlessFramework.LODCollector.staticLOD = lod
	lodSlider.value = lod
	lodText.text = lod

	function self.delegateOnClickCloseButton()
		self:Close()
	end
end

function GraphicSettingView:AddListeners()
	local renderScaleSlider = self.RenderScaleSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	renderScaleSlider.onValueChanged:AddListener(self.delegateOnRenderScaleValueChanged)

	local lodSlider = self.LODSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	lodSlider.onValueChanged:AddListener(self.delegateOnLODValueChanged)

	local closeButton = self.CloseButton:GetComponent(typeof(UnityEngine.UI.Button))

	closeButton.onClick:AddListener(self.delegateOnClickCloseButton)
end

function GraphicSettingView:RemoveListeners()
	local renderScaleSlider = self.RenderScaleSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	renderScaleSlider.onValueChanged:RemoveListener(self.delegateOnRenderScaleValueChanged)

	local lodSlider = self.LODSlider:GetComponent(typeof(UnityEngine.UI.Slider))

	lodSlider.onValueChanged:RemoveListener(self.delegateOnLODValueChanged)

	local closeButton = self.CloseButton:GetComponent(typeof(UnityEngine.UI.Button))

	closeButton.onClick:RemoveListener(self.delegateOnClickCloseButton)
end

function GraphicSettingView:OnOpen()
	self:AddListeners()
end

function GraphicSettingView:OnClose()
	self:RemoveListeners()

	if self.View ~= nil then
		self:Close()
	end
end

function GraphicSettingView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GraphicSettingView:Open()
	self.View.gameObject:SetActive(true)
end

function GraphicSettingView:Close()
	self.View.gameObject:SetActive(false)
end

return GraphicSettingView
