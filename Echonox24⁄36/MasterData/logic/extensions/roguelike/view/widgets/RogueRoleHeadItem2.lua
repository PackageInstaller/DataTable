-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleHeadItem2.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleHeadItem2", package.seeall)

local M = class("RogueRoleHeadItem2")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._viewElementsRegistry = ViewElementsRegistry.New(go)

	self:onInit()
end

function M:getGo()
	return self._go
end

function M:getPosition()
	return self._go.transform.position
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._goCaptain = registry:findUIElement("hero_head_-1264203424")
	self._txtHp = registry:findUIElement("hero_head_-1191601991", UIComponentType.Text)
	self._txtSan = registry:findUIElement("hero_head_-673328315", UIComponentType.Text)
	self._txtIndex = registry:findUIElement("hero_head_-24029098", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("hero_head_1022647095"))
	self._heroIcon = registry:findUIElement("hero_head_-1075977362", UIComponentType.Image)
	self._goStateChange = registry:findUIElement("hero_head_842924011")

	self._btnClick:AddClickListener(self._clickHeroNormal, self)

	self._btnDrag = UIPassableDragTrigger.Get(self._btnClick.gameObject)

	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	local longClickTriggerTime = 0.5

	self._btnLong = OnceLongPressTrigger.Get(self._btnClick.gameObject)

	self._btnLong:SetTriggerTime(longClickTriggerTime)
	self._btnLong:AddLongPressListener(self._onLongPress, self)
	self._btnLong:AddLongPressExitListener(self._onLongPressExit, self)
end

function M:_onBeginDrag(eventData)
	if self._beginDragCallback ~= nil then
		self._beginDragCallback(eventData)
	end

	return true
end

function M:_onDrag(eventData)
	if self._dragCallback ~= nil then
		self._dragCallback(eventData)
	end

	return true
end

function M:_onEndDrag(eventData)
	if self._endDragCallback ~= nil then
		self._endDragCallback(eventData)
	end

	return true
end

function M:_onLongPress(isLongPressOn)
	if self._longPressCallback ~= nil then
		self._longPressCallback(isLongPressOn)
	end
end

function M:_onLongPressExit(isExit)
	if self._longPressExitCallback ~= nil then
		self._longPressExitCallback(isExit)
	end
end

function M:_clickHeroNormal()
	if self._callback then
		self._callback()
	end
end

function M:getRoleId()
	return self._roleId
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goStateChange, isSelect)
end

function M:showHintAni(data)
	goutil.setActive(self._goStateChange, true)
	settimer(1.5, self._hideHint, self, false)
end

function M:_hideHint()
	goutil.setActive(self._goStateChange, false)
end

function M:updateData(data)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(data.roleId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(data.roleId)
	local hp = RoguelikeModel.instance:getRoleHp(data.roleId)
	local hpMax = RoguelikeModel.instance:getRoleHpMax(data.roleId)
	local san = RoguelikeModel.instance:getRoleSan(data.roleId)

	self._longPressCallback = data.longPressCallback
	self._longPressExitCallback = data.longPressExitCallback
	self._dragCallback = data.dragCallback
	self._beginDragCallback = data.beginDragCallback
	self._endDragCallback = data.endDragCallback
	self._roleId = data.roleId
	self._txtHp.text = hp
	self._txtSan.text = data.card
	self._txtIndex.text = data.index
	self._callback = data.callback

	goutil.setActive(self._goCaptain, data.index == data.captainIndex)

	if characterCO then
		self._modelID = characterCO.modelId

		local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

		IconLoader.setSprite(self._heroIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	local sanIndex = 2

	if san <= 3 then
		sanIndex = 3

		if san <= 0 then
			sanIndex = 1
		end
	end

	if hp <= 0 or san <= -5 then
		local grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)

		self._heroIcon.material = grayMat
	else
		self._heroIcon.material = nil
	end

	self:setActive(true)
end

function M:OnDestroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
		self._btnDrag:RemoveBeginDragListener()
		self._btnDrag:RemoveDragListener()
		self._btnDrag:RemoveEndDragListener()
		self._btnDrag:SetPassToGameObject(nil)
		self._btnLong:RemoveLongPressListener()
		self._btnLong:RemoveLongPressExitListener()
	end

	self._selectCallback = nil
	self._useCallback = nil
	self._longPressCallback = nil
	self._longPressExitCallback = nil
	self._dragCallback = nil
	self._beginDragCallback = nil
	self._txtHp = nil
	self._txtSan = nil
	self._btnClick = nil
	self._heroIcon = nil

	removetimer(self._hideHint, self)
end

return M
