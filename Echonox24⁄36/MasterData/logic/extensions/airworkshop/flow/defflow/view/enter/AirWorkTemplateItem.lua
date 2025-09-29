-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkTemplateItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkTemplateItem", package.seeall)

local M = class("AirWorkTemplateItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgLevel")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "txtContent")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "btnClick"))

	self:_bindEvents()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:setData(templateCO, idx, sceneId)
	self._templateCO = templateCO
	self._sceneId = sceneId
	self._idx = idx

	self:_updateView()
end

function M:_updateView()
	self._templateLevelId = false

	IconLoader.clearSprite(self._imgIcon)

	self._imgIcon.enabled = true

	if self._templateCO then
		self._nameTxt.text = self._templateCO.name
		self._descTxt.text = self._templateCO.description
		self._templateLevelId = self._templateCO.mapId

		self:_updateSceneImage()
	else
		local sceneCO = AirWorkShopConfig.instance:getSceneCO(self._sceneId)

		IconLoader.setSprite(self._imgIcon, IconType.AirWorkShopTheme, sceneCO.icon)

		self._nameTxt.text = lang("tip_airwork_base_template")
		self._descTxt.text = lang("tip_airwork_empty_template")
	end
end

function M:_onSceneImageUpdate(_, cover)
	local curCover = AirWorkMapModel.instance:getTemplateCover(self._templateLevelId)

	if curCover and cover == curCover then
		self:_updateSceneImage()
	end
end

function M:_updateSceneImage()
	local cover = AirWorkMapModel.instance:getTemplateCover(self._templateLevelId)

	if cover then
		AirWorkShopUtil.loadSceneImage(self._imgIcon, cover, true)
	else
		IconLoader.clearSprite(self._imgIcon)

		self._imgIcon.enabled = true

		IconLoader.setSprite(self._imgIcon, IconType.AirWorkShopTheme, "kqgf_loading_img")
	end
end

function M:setSeleted(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._idx)
	end
end

return M
