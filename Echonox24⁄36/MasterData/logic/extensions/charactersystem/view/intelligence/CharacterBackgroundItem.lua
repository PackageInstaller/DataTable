-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/intelligence/CharacterBackgroundItem.lua

module("logic.extensions.charactersystem.view.intelligence.CharacterBackgroundItem", package.seeall)

local M = class("CharacterBackgroundItem", CellBaseComponent)
local posY1 = 124
local posY2 = 155

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._viewAnim = self._go:GetComponent(typeof(Astral.GUITimelineAniLua))

	local registry = self._viewElementsRegistry

	self._imgBgIcon = registry:findUIElement("background_item_25650316", UIComponentType.Image)
	self._imgMaskGo = registry:findUIElement("cloth_item_1626305386")
	self._imgSelectGo = registry:findUIElement("cloth_item_345734937")
	self._panelCanvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
	self._btnSelect = registry:findUIElement("background_item_-1187712887", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._leftMask = registry:findUIElement("background_item_1355035233")
	self._rightMask = registry:findUIElement("background_item_331046604")
end

function M:_clickSelect()
	if self._curSelectId == self._data.co.id then
		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._index)
	end
end

function M:getIsSelect()
	return self._isSelect
end

function M:isActive()
	return self._go.activeInHierarchy
end

function M:getContentObj()
	return self._go
end

function M:getIndex()
	return self._index
end

function M:updateData(data, index, maxCount)
	self._index = index
	self._data = data
	self._maxCount = maxCount

	self:_refreshView()
end

function M:_refreshView()
	if self._transformCell and self._curSelectId == self._data.co.id then
		self._transformCell.transform:SetAsLastSibling()

		if self._viewAnim then
			self._viewAnim:StopTimelineAni()
			self._viewAnim:PlayAniByName("select")
		end

		goutil.setActive(self._leftMask, self._index > 1)
		goutil.setActive(self._rightMask, self._index < self._maxCount)
	end

	self._isSelect = self._curUseId == self._data.co.id

	goutil.setActive(self._imgSelectGo, self._isSelect)
	goutil.setActive(self._imgMaskGo.gameObject, not self._data.hasGot)

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._data.co.id)

	if itemCo then
		IconLoader.setSprite(self._imgBgIcon, IconType.Background, itemCo.icon)
	end
end

function M:setUseAndSelectBgId(curUseId, curSelectId)
	self._curUseId = curUseId
	self._curSelectId = curSelectId
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setCellTransform(transformCell)
	self._transformCell = transformCell
end

function M:getPositionX()
	return Astral.TransformUtil.GetLocalPosX(self._transformCell)
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
end

function M:setScale(scale)
	self._imgSelectGo:SetActive(scale >= 1)
	Astral.TransformUtil.SetLocalScale(self._go.transform, scale, scale, 1)
end

function M:setPos(posY)
	Astral.TransformUtil.SetLocalPosY(self._go.transform, posY)
end

function M:setAlpha(alpha)
	self._panelCanvasGroup.alpha = alpha
end

function M:setSelectState(state)
	self._imgSelectGo:SetActive(state)
end

return M
