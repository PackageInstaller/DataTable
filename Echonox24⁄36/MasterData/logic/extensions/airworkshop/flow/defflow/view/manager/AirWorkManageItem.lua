-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/manager/AirWorkManageItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.manager.AirWorkManageItem", package.seeall)

local M = class("AirWorkManageItem")

function M:ctor(container)
	self._go = container.gameObject
	self._normalGo = goutil.findChild(self._go, "stateNormal")
	self._noneGo = goutil.findChild(self._go, "stateNull")
	self._lockGo = goutil.findChild(self._go, "stateLock")
	self._selectGo = goutil.findChild(self._go, "stateNormal/imgSelect")
	self._passTestGo = goutil.findChild(self._go, "stateNormal/imgPass")
	self._putOnGo = goutil.findChild(self._go, "stateNormal/imgPut")
	self._img = goutil.findChildImageComponent(self._go, "stateNormal/imgLevel")
	self._txtID = goutil.findChildTextComponent(self._go, "stateNormal/txtID")
	self._goRedPoint = goutil.findChild(self._go, "stateNormal/red_point")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnClick"))

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

function M:updateData(mo)
	self._mo = mo
	self._cover = false

	goutil.setActive(self._normalGo, self._mo.created)
	goutil.setActive(self._noneGo, not self._mo.created and self._mo.unLock)
	goutil.setActive(self._lockGo, not self._mo.unLock)

	if self._mo.created then
		goutil.setActive(self._passTestGo, self._mo.data:getPassTest())
		goutil.setActive(self._putOnGo, self._mo.data:getOnlineStatus())
		self:_updateSceneImage(self._mo.data:getCover())

		self._txtID.text = string.format("ID：%s", self._mo.data:getId())
		self._cover = self._mo.data:getCover()
	end

	self:refreshRedDot()
end

function M:_onSceneImageUpdate(_, cover)
	if self._cover == cover then
		self:_updateSceneImage(cover)
	end
end

function M:_updateSceneImage(cover)
	AirWorkShopUtil.loadSceneImage(self._img, cover)
end

function M:setSeleted(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:selectClick(lastMo)
	if self._mo.created and self._mo.data:getId() == lastMo:getId() then
		self:_onClick()
	end
end

function M:_onClick()
	if self._mo.created then
		-- block empty
	elseif self._mo.unLock then
		AirWorkShopDefSceneModel.instance:setSaveIndex(self._mo.itemIndex)
		AirWorkShopDefMgr.instance:createMapAndEnter()
	else
		local limtCo = AirWorkMapModel.instance:getPlanUnlockCoByCount(self._mo.itemIndex)

		if limtCo then
			FloatWordMgr.instance:show(string.format(lang("达到创造等级%s，可解锁新的关卡位置"), limtCo.condition[1].value))
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_RIGHT_UPDATE, self._mo)
end

function M:refreshRedDot()
	local isActive = false
	local mapId

	if self._mo and self._mo.data then
		mapId = self._mo.data:getId()
	end

	if mapId then
		local redPointLstFromServer = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.AirMapComment) or {}

		for _, idStr in ipairs(redPointLstFromServer) do
			if not isActive and tonumber(idStr) == tonumber(mapId) then
				isActive = true
			end
		end
	end

	goutil.setActive(self._goRedPoint, isActive)
end

return M
