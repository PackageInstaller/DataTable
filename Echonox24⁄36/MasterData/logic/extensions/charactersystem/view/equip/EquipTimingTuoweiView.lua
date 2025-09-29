-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingTuoweiView.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingTuoweiView", package.seeall)

local M = class("EquipTimingTuoweiView", ViewComponent)

function M:buildUI()
	local imgMask1Go = goutil.findChild(self.mainGO, "imgMask1")

	goutil.addComponentOnce(imgMask1Go, goutil.Type_UIButton)

	self._btnImgMask = UIComponentType.ButtonAdapter(imgMask1Go)

	local tuoweiGo = self:getGo("euip_tuowei_-821655846")

	self._tuoweiTransfrom = tuoweiGo.transform
	self._xInit = self._tuoweiTransfrom.localPosition.x
	self._yInit = self._tuoweiTransfrom.localPosition.y
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnImgMask:AddClickListener(self._onClickImgMask, self)
end

function M:unbindEvents()
	self._btnImgMask:RemoveClickListener()
end

function M:onEnter()
	local param = self:getFirstParam()
	local uiLocalPos = self._tuoweiTransfrom.parent:InverseTransformPoint(param.pos)

	self._event = param.event

	self._tuoweiTransfrom:DOLocalMove(uiLocalPos, 1):OnComplete(self.onMoveFinish, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:onMoveFinish()
	if self._event then
		GlobalDispatcher:dispatchEvent(self._event)

		self._event = nil
	end

	self:close()
end

function M:_onClickImgMask()
	if self._event then
		GlobalDispatcher:dispatchEvent(self._event)

		self._event = nil
	end

	self:close()
end

function M:onExit()
	TransformUtils.SetLocalPosition(self._tuoweiTransfrom, self._xInit, self._yInit, 0)
end

return M
