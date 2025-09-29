-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HackOptimiseView.lua

module("logic.extensions.hacktool.view.HackOptimiseView", package.seeall)

local LocalItemData = class("LocalItemData")

function LocalItemData:ctor()
	self.index = 1
	self.name = ""
	self.isOn = false
end

local LocalItemView = class("LocalItemView")

function LocalItemView:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._text = goutil.findChildComponent(self.mainGO, "TextName", UIComponentType.Text)
	self._toggle = goutil.findChildComponent(self.mainGO, "Toggle", UIComponentType.SpaceXToggle)
	self._goSelect = goutil.findChild(self.mainGO, "ImageSelect")
	self._btn = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "Button"))

	goutil.setActive(self._goSelect, false)
end

function LocalItemView:updateData(LocalItemData, toggleBC, btnBC, toggleBCHolder)
	self._toggleBC = false
	self._text.text = LocalItemData.name
	self._toggle.IsOn = LocalItemData.isOn
	self._data = LocalItemData
	self._toggleBC = toggleBC
	self._btnBC = btnBC
	self._toggleBCHolder = toggleBCHolder
end

function LocalItemView:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function LocalItemView:Awake()
	self._toggle:AddListener(self._onToggleChange, self)
	self._btn:AddClickListener(self.onButton, self)
end

function LocalItemView:OnDestroy()
	self._toggle:RemoveListener()
	self._btn:RemoveClickListener()
end

function LocalItemView:_onToggleChange(toggle, isOn)
	if self._toggleBC then
		self._toggleBC(self._toggleBCHolder, isOn, self._data.index)
	end
end

function LocalItemView:onButton()
	if self._btnBC then
		self._btnBC(self._toggleBCHolder, self._data.index)
	end
end

local ShaderQualityKey = "HackOptimisiShaderQuality"
local M = class("HackOptimiseView", ViewComponent)

function M:buildUI()
	self._panelGo = self:getGo("optimise_view_341004681")
	self._btnHide = self:getBtn("optimise_view_1052970835")
	self._btnShow = self:getBtn("optimise_view_1085048230")
	self._btnCharacter = self:getBtn("optimise_view_2049213980")
	self._btnFeature = self:getBtn("optimise_view_1916161075")
	self._btnVolumn = self:getBtn("optimise_view_1941873359")
	self._btnPipeline = self:getBtn("optimise_view_-422088324")
	self._btnScene = self:getBtn("optimise_view_-302663492")
	self._btnOnekey = self:getBtn("optimise_view_1347522936")
	self._btnQuality = self:getBtn("optimise_view_-856700787")
	self._goCharcterContent = self:getGo("optimise_view_-373904883")
	self._btnCharacterHide = self:getBtn("optimise_view_1208178999")
	self._btnCharacterShow = self:getBtn("optimise_view_1056450802")
	self._btnCharacterListShow = self:getBtn("optimise_view_1487877330")
	self._btnCharacterListHide = self:getBtn("optimise_view_1569659825")
	self._goCharacterList = self:getGo("optimise_view_1413604579")
	self._listCharacter = LoopListHelper.New(self._goCharacterList)

	self._listCharacter:InitListView(0, self._onCharacterCellUpdate, self)

	self._goFeatureContent = self:getGo("optimise_view_576808658")
	self._goFeatureList = self:getGo("optimise_view_-1943359636")
	self._listFeature = LoopListHelper.New(self._goFeatureList)

	self._listFeature:InitListView(0, self._onFeatureCellUpdate, self)

	self._goVolumnContent = self:getGo("optimise_view_1616435366")
	self._goVolumnsList = self:getGo("optimise_view_-1752287257")
	self._listVolumns = LoopListHelper.New(self._goVolumnsList)

	self._listVolumns:InitListView(0, self._onVolumnsCellUpdate, self)

	self._goOnekeyContent = self:getGo("optimise_view_913058669")
	self._toggleSkinnedMesh = self:getUIComponent("optimise_view_-1304197723", UIComponentType.SpaceXToggle)
	self._togglePaticle = self:getUIComponent("optimise_view_1282974073", UIComponentType.SpaceXToggle)
	self._btnLightRefresh = self:getBtn("optimise_view_-839432313")
	self._btnLightsToggle = self:getBtn("optimise_view_-2054032352")
	self._toggleLights = self:getUIComponent("optimise_view_108007882", UIComponentType.SpaceXToggle)
	self._listLights = LoopListHelper.New(self:getGo("optimise_view_-750713479"))

	self._listLights:InitListView(0, self._onLightsCellUpdate, self)

	self._goDetail = goutil.findChild(self:getGo("optimise_view_787218603"), "RuntimeInspector")
	self._goSceneDetail = self:getGo("optimise_view_918071496")
	self._goQualityDetail = self:getGo("optimise_view_-1447602380")
	self._toggleGroupQuality = self:getUIComponent("optimise_view_-1642306273", UIComponentType.SpaceXToggleGroup)
	self._toggleCompList = {}

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("optimise_view_-1642306273"))

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
	end

	self._toggleFog = self:getUIComponent("optimise_view_-1285496914", UIComponentType.SpaceXToggle)
	self._toggleBloom = self:getUIComponent("optimise_view_-1681173370", UIComponentType.SpaceXToggle)
	self._sliderPipelineRenderScale = self:getSlider("optimise_view_1165688345")
	self._btnPipelineRenderScale = self:getBtn("optimise_view_317357241")
	self._sliderMainCameraRenderScale = self:getSlider("optimise_view_-1419210890")
	self._btnMainCameraRenderScale = self:getBtn("optimise_view_-1008936743")
	self._toggleMainCameraRenderScale = self:getUIComponent("optimise_view_1559445518", UIComponentType.SpaceXToggle)
	self._sliderUICameraRenderScale = self:getSlider("optimise_view_-1294980996")
	self._btnUICameraRenderScale = self:getBtn("optimise_view_-1749328645")
	self._toggleUICameraRenderScale = self:getUIComponent("optimise_view_-728452032", UIComponentType.SpaceXToggle)
	self._btnScreenRate = self:getBtn("optimise_view_-481294347")
	self._inputScreenWid = self:getUIComponent("optimise_view_-712035365", UIComponentType.InputFieldAdapter)
	self._inputScreenHei = self:getUIComponent("optimise_view_-559866867", UIComponentType.InputFieldAdapter)
	self._txtScreenRate = self:getText("optimise_view_221384027")
	self._txtPipelineRenderScale = self:getText("optimise_view_-905499854")
	self._txtMainCameraRenderScale = self:getText("optimise_view_1524371720")
	self._txtUICameraRenderScale = self:getText("optimise_view_-855022822")
	self._btnParticle = self:getBtn("optimise_view_-1479522986")
end

function M:onEnter()
	self:initData()
	HackOptimiseUtils.RemoveCameraOptimizer()
end

function M:onExit()
	HackOptimiseUtils.ResetCameraOptimizer()
end

function M:initData()
	self._featrues = {}
	self._volumns = {}
	self._characters = {}
	self._cameraAddDatas = {}
end

function M:bindEvents()
	self._btnHide:AddClickListener(self._onClickClose, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnCharacter:AddClickListener(self._onClickCharacter, self)
	self._btnFeature:AddClickListener(self._onClickFeature, self)
	self._btnVolumn:AddClickListener(self._onClickVolumn, self)
	self._btnPipeline:AddClickListener(self._onClickPipeline, self)
	self._btnScene:AddClickListener(self._onClickScene, self)
	self._btnOnekey:AddClickListener(self._onClickOnekey, self)
	self._btnQuality:AddClickListener(self._onClickQuality, self)
	self._toggleSkinnedMesh:AddListener(self._onSkinnedMeshToggleChange, self)
	self._togglePaticle:AddListener(self._onPaticleChange, self)
	self._toggleFog:AddListener(self._onFogChange, self)
	self._toggleBloom:AddListener(self._onBloomChange, self)
	self._btnCharacterHide:AddClickListener(self._onClickCharacterHide, self)
	self._btnCharacterShow:AddClickListener(self._onClickCharacterShow, self)
	self._btnCharacterListShow:AddClickListener(self._onClickCharacterListShow, self)
	self._btnCharacterListHide:AddClickListener(self._onClickCharacterListHide, self)
	self._btnParticle:AddClickListener(self._onClickBtnParticle, self)
	self._btnLightRefresh:AddClickListener(self._onClickBtnLight, self)
	self._btnLightsToggle:AddClickListener(self._onClickBtnLightToggle, self)
	self._btnPipelineRenderScale:AddClickListener(self._onClickPipelineRenderScale, self)
	self._btnMainCameraRenderScale:AddClickListener(self._onClickMainCameraRenderScale, self)
	self._btnUICameraRenderScale:AddClickListener(self._onClickUICameraRenderScale, self)
	self._btnScreenRate:AddClickListener(self._onClickScreenRate, self)
	self._toggleMainCameraRenderScale:AddListener(self._onToggleMainCameraRenderScaleChange, self)
	self._toggleUICameraRenderScale:AddListener(self._onToggleUICameraRenderScaleChange, self)
	self._sliderPipelineRenderScale:AddOnValueChanged(self._onPipelineRenderScaleSliderValueChanged, self)
	self._sliderMainCameraRenderScale:AddOnValueChanged(self._onMainCameraRenderScaleSliderValueChanged, self)
	self._sliderUICameraRenderScale:AddOnValueChanged(self._onUICameraRenderScaleSliderValueChanged, self)

	for k, v in pairs(self._toggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealBarClick(k, isOn)
		end, nil)
	end

	HackOptimiseUtils.InspectChangeCall(self._goDetail, self.OnItemInspectorChanged, self)
	HackOptimiseUtils.InitOneKeyHideMeshParticel(self._toggleSkinnedMesh.IsOn, self._togglePaticle.IsOn)
end

function M:unbindEvents()
	self._btnHide:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnCharacter:RemoveClickListener()
	self._btnFeature:RemoveClickListener()
	self._btnVolumn:RemoveClickListener()
	self._btnPipeline:RemoveClickListener()
	self._btnCharacterHide:RemoveClickListener()
	self._btnCharacterShow:RemoveClickListener()
	self._btnCharacterListShow:RemoveClickListener()
	self._btnCharacterListHide:RemoveClickListener()
	self._btnScene:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
	self._btnQuality:RemoveClickListener()
	self._toggleSkinnedMesh:RemoveListener()
	self._togglePaticle:RemoveListener()
	self._toggleFog:RemoveListener()
	self._toggleBloom:RemoveListener()
	self._btnParticle:RemoveClickListener()
	self._btnLightRefresh:RemoveClickListener()
	self._btnLightsToggle:RemoveClickListener()
	self._btnPipelineRenderScale:RemoveClickListener()
	self._btnMainCameraRenderScale:RemoveClickListener()
	self._btnUICameraRenderScale:RemoveClickListener()
	self._btnScreenRate:RemoveClickListener()
	self._toggleMainCameraRenderScale:RemoveListener()
	self._toggleUICameraRenderScale:RemoveListener()
	self._sliderPipelineRenderScale:RemoveOnValueChanged()
	self._sliderMainCameraRenderScale:RemoveOnValueChanged()
	self._sliderUICameraRenderScale:RemoveOnValueChanged()

	for k, v in ipairs(self._toggleCompList) do
		v:RemoveListener()
	end

	HackOptimiseUtils.InspectChangeCallClear(self._goDetail)
	HackOptimiseUtils.RemoveOnekeyHideMeshParticel()
end

function M:_onPipelineRenderScaleSliderValueChanged(value)
	self._txtPipelineRenderScale.text = tostring(value)
end

function M:_onMainCameraRenderScaleSliderValueChanged(value)
	self._txtMainCameraRenderScale.text = tostring(value)
end

function M:_onUICameraRenderScaleSliderValueChanged(value)
	self._txtUICameraRenderScale.text = tostring(value)
end

function M:_dealBarClick(index, isOn)
	index = index - 1

	if isOn then
		Astral.LocalStorage.Instance:SetInt(ShaderQualityKey, index)
		Gfx.instance:_applyShaderQualitySettings(index)

		self._shaderQuality = index
	end
end

function M:_onSkinnedMeshToggleChange(toggle, isOn)
	HackOptimiseUtils.OnekeyHideSkinnedMesh(isOn)
end

function M:_onToggleMainCameraRenderScaleChange(toggle, isOn)
	local renderScalet = self._sliderMainCameraRenderScale:GetValue()

	if isOn and renderScalet < 1 then
		CameraTargetMgr.instance:setRenderScaleByTarget(CameraTargetMgr.instance:getMainCameraTarget(), renderScalet)
	else
		CameraTargetMgr.instance:closeRenderScaleByTarget(CameraTargetMgr.instance:getMainCameraTarget())
	end
end

function M:_onToggleUICameraRenderScaleChange(toggle, isOn)
	local renderScalet = self._sliderUICameraRenderScale:GetValue()

	if isOn and renderScalet < 1 then
		CameraTargetMgr.instance:setRenderScaleByTarget(CameraTargetMgr.instance:getUICameraTarget(), renderScalet)
	else
		CameraTargetMgr.instance:closeRenderScaleByTarget(CameraTargetMgr.instance:getUICameraTarget())
	end
end

function M:_onPaticleChange(toggle, isOn)
	HackOptimiseUtils.OnekeyHideParticleSystem(isOn)
end

function M:_onFogChange(toggle, isOn)
	HackOptimiseUtils.SetFog(isOn)
end

function M:_onBloomChange(toggle, isOn)
	HackOptimiseUtils.SetSpiltBloom(isOn)
end

function M:_onClickPipelineRenderScale()
	local renderScale = self._sliderPipelineRenderScale:GetValue()

	HackOptimiseUtils.SetPipelineAssetRenderScale(renderScale)
end

function M:_onClickMainCameraRenderScale()
	if self._toggleMainCameraRenderScale.IsOn then
		local renderScale = self._sliderMainCameraRenderScale:GetValue()

		CameraTargetMgr.instance:setRenderScaleByTarget(CameraTargetMgr.instance:getMainCameraTarget(), renderScale)
	end
end

function M:_onClickScreenRate()
	local wid = tonumber(self._inputScreenWid:GetText())
	local hei = tonumber(self._inputScreenHei:GetText())

	HackOptimiseUtils.SetResolutionWH(wid, hei)

	local widNow, heiNow = HackOptimiseUtils.GetScreenRate(0, 0)

	self._txtScreenRate.text = "当前分辨率：" .. widNow .. " X " .. heiNow
end

function M:_onClickUICameraRenderScale()
	if self._toggleUICameraRenderScale.IsOn then
		local renderScale = self._sliderUICameraRenderScale:GetValue()

		CameraTargetMgr.instance:setRenderScaleByTarget(CameraTargetMgr.instance:getUICameraTarget(), renderScale)
	end
end

function M:_onClickClose()
	goutil.setActive(self._panelGo, false)
	goutil.setActive(self._btnShow.gameObject, true)
end

function M:_onClickShow()
	goutil.setActive(self._btnShow.gameObject, false)
	goutil.setActive(self._panelGo, true)
	goutil.setActive(self._goCharcterContent, false)
	goutil.setActive(self._goVolumnContent, false)
	goutil.setActive(self._goOnekeyContent, false)
	goutil.setActive(self._goQualityDetail, false)
	goutil.setActive(self._goDetail, false)
end

function M:_onClickCharacter()
	self._curIndex = 0

	local isShow = self._goCharcterContent.activeSelf

	goutil.setActive(self._goCharcterContent, not isShow)
	goutil.setActive(self._goQualityDetail, false)
	goutil.setActive(self._goFeatureContent, false)
	goutil.setActive(self._goVolumnContent, false)
	goutil.setActive(self._goOnekeyContent, false)
	goutil.setActive(self._goDetail, false)
end

function M:_onClickQuality()
	self._curIndex = 0

	local isShow = not self._goQualityDetail.activeSelf

	goutil.setActive(self._goQualityDetail, isShow)

	if isShow then
		self._shaderQuality = Astral.LocalStorage.Instance:GetInt(ShaderQualityKey, -1)

		if self._shaderQuality == -1 then
			self._shaderQuality = Gfx.instance:getShaderQualitySettings()
		end

		local toggleIndex = self._shaderQuality + 1

		if not self._toggleCompList[toggleIndex].IsOn then
			self._toggleCompList[toggleIndex].IsOn = true
		end

		local isFogOpen = HackOptimiseUtils.GetFog(false)

		self._toggleFog.IsOn = isFogOpen

		local isSplit = HackOptimiseUtils.GetSpiltBloom(false)

		self._toggleBloom.IsOn = isSplit

		local curRenderScale = HackOptimiseUtils.GetPipelineAssetRenderScale(0)

		self._sliderPipelineRenderScale:SetValue(curRenderScale)

		self._txtPipelineRenderScale.text = tostring(curRenderScale)

		local widNow, heiNow = HackOptimiseUtils.GetScreenRate(0, 0)

		self._txtScreenRate.text = "当前分辨率：" .. widNow .. " X " .. heiNow

		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
		local mainCameraData = mainCamera:getCameraData()

		self._toggleMainCameraRenderScale.IsOn = mainCameraData.isUseCustomRenderScale

		self._sliderMainCameraRenderScale:SetValue(mainCameraData.customRenderScale)

		self._txtMainCameraRenderScale.text = tostring(mainCameraData.customRenderScale)

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget()
		local uiCameraData = uiCamera:getCameraData()

		self._toggleUICameraRenderScale.IsOn = uiCameraData.isUseCustomRenderScale

		self._sliderUICameraRenderScale:SetValue(uiCameraData.customRenderScale)

		self._txtUICameraRenderScale.text = tostring(uiCameraData.customRenderScale)

		goutil.setActive(self._goCharcterContent, false)
		goutil.setActive(self._goFeatureContent, false)
		goutil.setActive(self._goVolumnContent, false)
		goutil.setActive(self._goOnekeyContent, false)
		goutil.setActive(self._goDetail, false)
	end
end

function M:_onClickFeature()
	self._curIndex = 0

	local isShow = not self._goFeatureContent.activeSelf

	goutil.setActive(self._goFeatureContent, isShow)

	if isShow then
		table.clear(self._featrues)
		HackOptimiseUtils.GetFeatures(self._featrues)
		goutil.setActive(self._goCharcterContent, false)
		goutil.setActive(self._goVolumnContent, false)
		goutil.setActive(self._goOnekeyContent, false)
		goutil.setActive(self._goQualityDetail, false)
		goutil.setActive(self._goDetail, false)
		self._listFeature:SetListItemCount(#self._featrues)
		self._listFeature:RefreshAllShownItem()
	end
end

function M:_onClickVolumn()
	self._curIndex = 0

	local isShow = not self._goVolumnContent.activeSelf

	goutil.setActive(self._goVolumnContent, isShow)

	if isShow then
		table.clear(self._volumns)
		HackOptimiseUtils.GetVolumns(self._volumns)
		goutil.setActive(self._goCharcterContent, false)
		goutil.setActive(self._goFeatureContent, false)
		goutil.setActive(self._goQualityDetail, false)
		goutil.setActive(self._goDetail, false)
		goutil.setActive(self._goOnekeyContent, false)
		self._listVolumns:SetListItemCount(#self._volumns)
		self._listVolumns:RefreshAllShownItem()
	end
end

function M:_onClickOnekey()
	local isShow = not self._goOnekeyContent.activeSelf

	goutil.setActive(self._goOnekeyContent, isShow)

	if isShow then
		self:_onClickBtnLight()
		goutil.setActive(self._goVolumnContent, false)
		goutil.setActive(self._goCharcterContent, false)
		goutil.setActive(self._goFeatureContent, false)
		goutil.setActive(self._goQualityDetail, false)
		goutil.setActive(self._goDetail, false)
	end
end

function M:_onClickPipeline()
	local isLeftShow = self._goCharcterContent.activeSelf or self._goFeatureContent.activeSelf or self._goVolumnContent.activeSelf

	if isLeftShow then
		self._pipeline = HackOptimiseUtils.GetPipelineAsset()

		goutil.setActive(self._goCharcterContent, false)
		goutil.setActive(self._goFeatureContent, false)
		goutil.setActive(self._goVolumnContent, false)
		goutil.setActive(self._goQualityDetail, false)
		goutil.setActive(self._goOnekeyContent, false)
		goutil.setActive(self._goDetail, true)
		HackOptimiseUtils.Inspect(self._goDetail, self._pipeline)
	else
		local isShow = not self._goDetail.activeSelf

		goutil.setActive(self._goDetail, isShow)

		if isShow then
			self._pipeline = HackOptimiseUtils.GetPipelineAsset()

			goutil.setActive(self._goCharcterContent, false)
			goutil.setActive(self._goFeatureContent, false)
			goutil.setActive(self._goVolumnContent, false)
			goutil.setActive(self._goQualityDetail, false)
			goutil.setActive(self._goOnekeyContent, false)
			HackOptimiseUtils.Inspect(self._goDetail, self._pipeline)
		end
	end
end

function M:_onClickScene()
	local isShow = not self._goSceneDetail.activeSelf

	goutil.setActive(self._goSceneDetail, isShow)
end

function M:_onClickCharacterHide()
	goutil.setActive(self._btnCharacterHide.gameObject, false)
	goutil.setActive(self._btnCharacterShow.gameObject, true)

	for i = 1, #self._characters do
		goutil.setActive(self._characters[i], false)
	end
end

function M:_onClickCharacterShow()
	goutil.setActive(self._btnCharacterHide.gameObject, true)
	goutil.setActive(self._btnCharacterShow.gameObject, false)

	for i = 1, #self._characters do
		goutil.setActive(self._characters[i], true)
	end
end

function M:_onClickCharacterListShow()
	goutil.setActive(self._goCharacterList, true)
	goutil.setActive(self._btnCharacterListShow.gameObject, false)
	goutil.setActive(self._btnCharacterListHide.gameObject, true)
	self._listCharacter:SetListItemCount(#self._characters)
	self._listCharacter:RefreshAllShownItem()
end

function M:_onClickCharacterListHide()
	goutil.setActive(self._goCharacterList, false)
	goutil.setActive(self._btnCharacterListShow.gameObject, true)
	goutil.setActive(self._btnCharacterListHide.gameObject, false)
end

function M:_onClickBtnParticle()
	local allParticle

	if self._allParticleIsActive == false then
		allParticle = self._cacheAllParticle
	else
		allParticle = UnityEngine.Object.FindObjectsOfType(typeof(UnityEngine.ParticleSystem)):ToTable()
	end

	if self._allParticleIsActive == nil then
		self._allParticleIsActive = true
	end

	self._allParticleIsActive = not self._allParticleIsActive

	goutil.setActive(UnityEngine.GameObject.Find("sx-s109_factoryscrap_b_01/otherResources/s-effect/time_trans_loop"), self._allParticleIsActive)

	for k, v in pairs(allParticle) do
		goutil.setActive(v.gameObject, self._allParticleIsActive)
	end

	self._cacheAllParticle = allParticle
end

function M:_onClickBtnLight()
	self._allLight = UnityEngine.Object.FindObjectsOfType(typeof(UnityEngine.Light)):ToTable()

	local isInOpen = false

	for k, v in pairs(self._allLight) do
		if v.enabled then
			isInOpen = true

			break
		end
	end

	self._toggleLights.IsOn = isInOpen

	self._listLights:SetListItemCount(#self._allLight)
	self._listLights:RefreshAllShownItem()
end

function M:_onClickBtnLightToggle()
	if not self._allLight then
		return
	end

	local newSetting = not self._toggleLights.IsOn

	self._toggleLights.IsOn = newSetting

	for k, v in pairs(self._allLight) do
		v.enabled = newSetting
	end

	self._listLights:SetListItemCount(#self._allLight)
	self._listLights:RefreshAllShownItem()
end

function M:_onCharacterCellUpdate(curIndex)
	local data = LocalItemData.New()

	data.index = curIndex + 1

	local cha = self._characters[data.index]

	data.name = cha.name
	data.isOn = cha.activeSelf

	local item = self._listCharacter:NewListViewItem("ItemPrefab")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LocalItemView)

	shower:updateData(data, self.onCharacterToggleChanged, self.onCharacterItemBtn, self)
	shower:setSelect(data.index == self._curIndex)

	return item
end

function M:_onFeatureCellUpdate(curIndex)
	local data = LocalItemData.New()

	data.index = curIndex + 1
	data.name, data.isOn = HackOptimiseUtils.GetFeatureItemData(self._featrues[data.index], "", false)

	local item = self._listFeature:NewListViewItem("ItemPrefab")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LocalItemView)

	shower:updateData(data, self.onFeatureToggleChanged, self.onFeatureItemBtn, self)
	shower:setSelect(data.index == self._curIndex)

	return item
end

function M:_onVolumnsCellUpdate(curIndex)
	local data = LocalItemData.New()

	data.index = curIndex + 1
	data.name, data.isOn = HackOptimiseUtils.GetVolumeItemData(self._volumns[data.index], "", false)

	local item = self._listVolumns:NewListViewItem("ItemPrefab")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LocalItemView)

	shower:updateData(data, self.onVolumnToggleChanged, self.onVolumnItemBtn, self)
	shower:setSelect(data.index == self._curIndex)

	return item
end

function M:_onRenderScaleCellUpdate(curIndex)
	local data = LocalItemData.New()

	data.index = curIndex + 1
	data.name, data.isOn = HackOptimiseUtils.GetRenderScaleItemData(self._cameraAddDatas[data.index], "", false)

	local item = self._listRenderScale:NewListViewItem("ItemPrefab")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LocalItemView)

	shower:updateData(data, self.onRenderScaleToggleChanged, nil, self)
	shower:setSelect(false)

	return item
end

function M:_onLightsCellUpdate(curIndex)
	local data = self._allLight[curIndex + 1]
	local item = self._listLights:NewListViewItem("ItemPrefab")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HackOptimiseLightItem)

	shower:updateData(data)
	shower:setClickBC(self.onLightToggleChanged, self)

	return item
end

function M:onCharacterItemBtn(index)
	self._curIndex = index

	self._listCharacter:RefreshAllShownItem()
	goutil.setActive(self._goDetail, true)
	HackOptimiseUtils.Inspect(self._goDetail, self._characters[index])
end

function M:onVolumnItemBtn(index)
	self._curIndex = index

	self._listVolumns:RefreshAllShownItem()
	goutil.setActive(self._goDetail, true)
	HackOptimiseUtils.Inspect(self._goDetail, self._volumns[index])
end

function M:onFeatureItemBtn(index)
	self._curIndex = index

	self._listFeature:RefreshAllShownItem()
	goutil.setActive(self._goDetail, true)
	HackOptimiseUtils.Inspect(self._goDetail, self._featrues[index])
end

function M:onCharacterToggleChanged(isOn, index)
	local data = self._characters[index]

	if data then
		goutil.setActive(data, isOn)
	end
end

function M:onFeatureToggleChanged(isOn, index)
	local feature = self._featrues[index]

	if feature then
		HackOptimiseUtils.SetFeature(feature, isOn)
		self._listFeature:RefreshAllShownItem()
	end
end

function M:onVolumnToggleChanged(isOn, index)
	local vol = self._volumns[index]

	if vol then
		HackOptimiseUtils.SetVolume(vol, isOn)
		self._listVolumns:RefreshAllShownItem()
	end
end

function M:onRenderScaleToggleChanged(isOn, index)
	local vol = self._cameraAddDatas[index]

	if vol then
		HackOptimiseUtils.SetCameraRenderScale(vol, isOn)
		self._listRenderScale:RefreshAllShownItem()
	end
end

function M:onLightToggleChanged(isOn)
	local isInOpen = false

	for k, v in pairs(self._allLight) do
		if v.enabled then
			isInOpen = true

			break
		end
	end

	self._toggleLights.IsOn = isInOpen
end

function M:OnItemInspectorChanged()
	if self._goFeatureContent.activeSelf then
		self._listFeature:RefreshAllShownItem()
	end

	if self._goVolumnContent.activeSelf then
		self._listVolumns:RefreshAllShownItem()
	end
end

return M
