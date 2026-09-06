-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/CallHeroDrawView.lua

module("logic.extensions.callhero.view.CallHeroDrawView", package.seeall)

local CallHeroDrawView = class("CallHeroDrawView", ViewComponent)

function CallHeroDrawView:ctor()
	CallHeroDrawView.super.ctor(self)

	self._dragLimit = 45
end

function CallHeroDrawView:buildUI()
	self._drawCam = self:getGo("Camera"):GetComponent("Camera")

	local drawObj = self:getGo("callherodrawobj")
	local parent = self:getGo("drawManager")

	self._btnReset = self:getBtn("Button")
	self._btnClose = self:getBtn("btn_close")
	self._manager = CallHeroDrawManager.New(parent, drawObj, 45, 300)

	self._manager:genDrawObj()
	drawObj:SetActive(false)

	self._centerPosition = parent:GetComponent(typeof(UnityEngine.Transform)).position
	self.effectCam = self:getGo("effectCamera"):GetComponent("Camera")
end

function CallHeroDrawView:onEnter()
	self._draging = false

	self._manager:hide()
	self:_onResetDraw()
end

function CallHeroDrawView:bindEvents()
	local transs = self._manager:getTranss()

	for i = 1, #transs / 2 do
		local obj = transs[i].gameObject
		local dragTrigger = Framework.UIDragTrigger.Get(obj)

		dragTrigger:AddBeginDragListener(self._onObjBeginDrag, self, transs[i])
		dragTrigger:AddDragListener(self._onDrag, self, transs[i])
		dragTrigger:AddEndDragListener(self._onEndDrag, self, transs[i])

		local clickTrigger = Framework.UIClickTrigger.Get(obj)

		clickTrigger:AddClickDownListener(self._onObjClickDown, self, transs[i])
		clickTrigger:AddClickUpListener(self._onObjClickUp, self, transs[i])
	end

	self._btnReset:AddClickListener(self._onResetDraw, self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
end

function CallHeroDrawView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()

	local transs = self._manager:getTranss()

	for i = 1, #transs do
		local obj = transs[i].gameObject
		local dragTrigger = Framework.UIDragTrigger.Get(obj)

		dragTrigger:RemoveBeginDragListener()
		dragTrigger:RemoveDragListener()
		dragTrigger:RemoveEndDragListener()

		local clickTrigger = Framework.UIClickTrigger.Get(obj)

		clickTrigger:RemoveClickDownListener()
		clickTrigger:RemoveClickUpListener()
	end
end

function CallHeroDrawView:_onObjClickDown(pointerEvent, trans)
	if not self:_checkSelected() then
		self._manager:setSelectIndex(tonumber(trans.name))
	end
end

function CallHeroDrawView:_onObjClickUp(pointerEvent, trans)
	if self._draging or not self:_checkSelectIndex(tonumber(trans.name)) then
		return
	end
end

function CallHeroDrawView:_onObjBeginDrag(pointerEvent, trans)
	if self:_checkSelectIndex(tonumber(trans.name)) then
		self._draging = true
	end
end

function CallHeroDrawView:_onDrag(pointerEvent, trans)
	if self:_checkSelectIndex(tonumber(trans.name)) then
		local worldPosition = Framework.GeometryUtil.ScreenTo3DWorldPoint(pointerEvent.position, self._drawCam, trans.position)

		if self:_checkDistance(worldPosition) then
			trans.position = worldPosition

			if self._manager then
				self._manager:dispatchPos(trans.localPosition)
			end

			self:_dispatchPosToScene()
		end
	end
end

function CallHeroDrawView:_dispatchPosToScene()
	local transs = self._manager:getTranss()

	for i = 1, #transs do
		-- block empty
	end
end

function CallHeroDrawView:_onEndDrag(pointerEvent, trans)
	if trans and self:_checkSelectIndex(tonumber(trans.name)) then
		self._draging = false

		self:_onDrawFinish()
	end
end

function CallHeroDrawView:_onApplicationPause(isFront)
	if self._draging and isFront then
		self:_onEndDrag(nil, self._manager:getSeletedTrans())
	end
end

function CallHeroDrawView:_onEnterDrawFinish()
	self._manager:show()
end

function CallHeroDrawView:_onDrawFinish()
	self._manager:setSelectIndex(nil)
	self._manager:hide()

	local need = LotteryController.instance:GetRecordNeedCount()

	LotteryController.instance:CSRequestLuckDraw(need)
end

function CallHeroDrawView:PlayFirstEffect(need)
	local effect_path = need == 1 and "fx_ui_chouka_10_linshi/fx_chouka_1_linshi.prefab" or "fx_ui_chouka_10_linshi/fx_chouka_10_linshi.prefab"

	self.draw_effect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		self.draw_effect:setLayer(SceneLayer.SkillEffects_Value)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 460)

		local kapai_glow_go = goutil.findChild(eff.effGo, "chouka_all/kapai1_all/kapai/kapai_glow")
		local kapai_glow_mat = kapai_glow_go:GetComponent(typeof(UnityEngine.MeshRenderer)).material

		GoUtil.SetMatColor(kapai_glow_mat, "_TintColor", 2.22, 1.39, 0.5, 0.5)
	end)

	self.draw_effect:setParent(self.mainGO:GetComponent("RectTransform"))
	self.draw_effect:setScale(30)
	settimer(10, self._playFirstEffectDone, self, false)
end

function CallHeroDrawView:_playFirstEffectDone()
	if self.draw_effect then
		UIEffectManager.instance:stopEffect(self.draw_effect)

		self.draw_effect = nil
	end

	LotteryController.instance:SetRecordNeedCount(nil)
	PetDisplayController.instance:checkAndOpenDisplay(true)
end

function CallHeroDrawView:_checkDistance(pos)
	local d = Vector3.Distance(self._centerPosition, pos)

	return d < self._dragLimit
end

function CallHeroDrawView:_checkSelected()
	return self._manager:getSelectIndex() ~= nil
end

function CallHeroDrawView:_checkSelectIndex(index)
	local selectIndex = self._manager:getSelectIndex()

	return selectIndex ~= nil and selectIndex == index
end

function CallHeroDrawView:resetPosition()
	self._manager:resetPosition()
	self:_dispatchPosToScene()
end

function CallHeroDrawView:destroyUI()
	self._manager:onDestroy()

	self._manager = nil

	removetimer(self._playFirstEffectDone, self)
end

function CallHeroDrawView:_onResetDraw()
	self._manager:show()
	self:resetPosition()
end

return CallHeroDrawView
