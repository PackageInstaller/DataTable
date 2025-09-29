-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsFixTipsPosComp.lua

module("logic.extensions.tooltips.component.ToolTipsFixTipsPosComp", package.seeall)

local M = class("ToolTipsFixTipsPosComp", ViewComponent)

function M:onEnter()
	local info = self:getFirstParam()
	local bindGo = info.bindGo
	local parent = self.mainGO.transform.parent
	local selfGo = self.mainGO
	local funcGetWidth, funcGetHeight, funcHandler

	if self._viewPresentor and self._viewPresentor.getSelfWidth then
		funcGetWidth = self._viewPresentor.getSelfWidth
		funcHandler = self._viewPresentor
	end

	if self._viewPresentor and self._viewPresentor.getSelfHeight then
		funcGetHeight = self._viewPresentor.getSelfHeight
		funcHandler = self._viewPresentor
	end

	self._infoCacheForFix = self:buildFixInfo(bindGo, parent, selfGo, info, funcGetWidth, funcGetHeight, funcHandler)

	self:tryFixPos(self._infoCacheForFix)
	GlobalDispatcher:dispatchEvent(EventType.TIPS_CHANGE_ENABLE_EVENT, true, self._viewPresentor:getViewName())
end

function M:buildFixInfo(bindGo, parent, selfGo, params, funcGetWidth, funcGetHeight, funcHandler)
	params = params or {}

	local info = {}

	info.limitOffsetX = 0
	info.limitOffsetY = 20
	info.offsetX = params.offsetX or 0
	info.offsetY = params.offsetY or 0
	info.forceTipsAlignVer = params.forceTipsAlignVer
	info.forceAlign = params.forceAlign

	local rectTrSelf = selfGo:GetComponent(UIComponentType.RectTransform)

	RectTransformUtils.ForceRebuildLayoutImmediate(rectTrSelf)

	info.rectTrSelf = rectTrSelf
	info.widthSelf = rectTrSelf.rect.width
	info.heightSelf = rectTrSelf.rect.height

	if funcGetWidth then
		info.widthSelf = funcGetWidth(funcHandler)
	end

	if funcGetHeight then
		info.heightSelf = funcGetHeight(funcHandler)
	end

	local rectTrParent = parent:GetComponent(UIComponentType.RectTransform)

	info.widthParent = rectTrParent.rect.width
	info.heightParent = rectTrParent.rect.height
	info.limitX = info.widthParent * 0.5 - info.widthSelf * 0.5
	info.limitY = info.heightParent * 0.5 - info.heightSelf * 0.5

	local rectTrBindGo = bindGo:GetComponent(UIComponentType.RectTransform)
	local bindGoPivotX, bindGoPivotY = RectTransformUtils.GetPivot(rectTrBindGo, 0.5, 1)

	info.bindGoName = bindGo and bindGo.gameObject.name or "nil"
	info.bindGoInstanceId = rectTrBindGo:GetInstanceID()
	info.bindGoPivotX = bindGoPivotX
	info.bindGoPivotY = bindGoPivotY
	info.widthBindGo = rectTrBindGo.rect.width
	info.heightBindGo = rectTrBindGo.rect.height

	local uiCam = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local screenPos = uiCam:WorldToScreenPoint(Vector3.New(TransformUtils.GetPosition(bindGo.transform, 0, 0, 0)))
	local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(rectTrParent, screenPos.x, screenPos.y, uiCam, 0, 0)

	info.anchorXBindGo = targetX
	info.anchorYBindGo = targetY

	return info
end

function M:tryFixPos(info)
	local pivotX, pivotY = 0.5, 1

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	local alignHor = CommEnum.TipsAlignType.Right
	local anchorX = info.anchorXBindGo
	local limitOffsetX = info.limitOffsetX

	anchorX = anchorX + info.widthBindGo * (1 - info.bindGoPivotX)
	anchorX = anchorX + info.widthSelf * pivotX

	if anchorX > info.limitX - limitOffsetX then
		alignHor = CommEnum.TipsAlignType.Left
		anchorX = info.anchorXBindGo
		anchorX = anchorX - info.widthBindGo * info.bindGoPivotX
		anchorX = anchorX - info.widthSelf * pivotX
		anchorX = anchorX - limitOffsetX

		if anchorX < -info.limitX + limitOffsetX then
			anchorX = -info.limitX + limitOffsetX
		end
	end

	local alignVer = CommEnum.TipsAlignType.Down
	local anchorY = info.anchorYBindGo
	local limitOffsetY = info.limitOffsetY
	local forceTipsAlignVer = info.forceTipsAlignVer

	if forceTipsAlignVer and (forceTipsAlignVer == CommEnum.TipsAlignType.Up or forceTipsAlignVer == CommEnum.TipsAlignType.Down) then
		if forceTipsAlignVer == CommEnum.TipsAlignType.Up then
			alignVer = CommEnum.TipsAlignType.Up
			pivotY = 0
		end

		anchorY = anchorY + (1 - info.bindGoPivotY) * info.heightBindGo
	else
		anchorY = anchorY + (1 - info.bindGoPivotY) * info.heightBindGo

		local limitY = (info.heightParent * 0.5 - info.heightSelf * pivotY) * -1

		if anchorY >= limitY + limitOffsetY then
			-- block empty
		else
			alignVer = CommEnum.TipsAlignType.Up
			pivotY = 0
			anchorY = info.heightParent * -0.5 + limitOffsetY
		end
	end

	local maxHeight = info.heightParent * 0.5

	if pivotY == 0 then
		if anchorY >= 0 then
			maxHeight = maxHeight < maxHeight + limitOffsetY and maxHeight or maxHeight + limitOffsetY
			maxHeight = maxHeight - anchorY
		else
			maxHeight = maxHeight + math.abs(anchorY)
			maxHeight = maxHeight < maxHeight + limitOffsetY and maxHeight or maxHeight + limitOffsetY
		end
	elseif pivotY == 1 then
		maxHeight = maxHeight + anchorY
		maxHeight = maxHeight < maxHeight + limitOffsetY and maxHeight or maxHeight + limitOffsetY
	end

	anchorX = anchorX + info.offsetX
	anchorY = anchorY + info.offsetY

	RectTransformUtils.SetAnchoredPosition(info.rectTrSelf, anchorX, anchorY)
	RectTransformUtils.SetPivot(info.rectTrSelf, pivotX, pivotY)

	local resultData = {
		alignHor = alignHor,
		alignVer = alignVer,
		maxHeight = maxHeight,
		forceAlign = info.forceAlign
	}

	if Astral.OSDef.isEditor then
		TableUtil.dump(resultData)
	end

	if self._viewPresentor then
		self:localNotify(EventType.TIPS_ALIGN_CHANGE_EVENT, resultData)
	end

	return resultData
end

return M
