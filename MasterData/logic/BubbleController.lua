-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bubble/controller/BubbleController.lua

module("logic.extensions.bubble.controller.BubbleController", package.seeall)

local BubbleController = class("BubbleController", BaseController)
local bubbleView_MaxWidth = 447
local bubbleView_MinWidth = 149
local bubbleView_XOffset = 150
local bubbleView_YOffset = 13
local bubbleView_ByteWidth = 22
local bubbleView_RowHeight = 26

function BubbleController:ctor()
	self._timer = false
end

function BubbleController:OpenView(...)
	if ViewMgr.instance:isOpen(ViewName.bubble) then
		-- block empty
	else
		ViewMgr.instance:open(ViewName.bubble, ...)
	end
end

function BubbleController:CloseView()
	ViewMgr.instance:close(ViewName.bubble)
end

function BubbleController:getFinalPos(pos, rectOffset)
	pos = pos or Vector3.zero
	rectOffset = rectOffset or Vector2.zero

	return pos + rectOffset
end

function BubbleController:getSuitablelPosByGo(go, word, addOffsetX, addOffsetY)
	addOffsetX = addOffsetX or 0
	addOffsetY = addOffsetY or 0

	if not go then
		return Vector3.zero
	end

	local goPos = go.transform.position

	if GameUtil.isEmptyString(word) then
		return goPos
	end

	local charLength = #word
	local rowCount = 0
	local curWidth = 0

	for i = 1, charLength do
		local byte = string.byte(word, i)

		if byte > 0 and byte <= 127 then
			if curWidth + bubbleView_ByteWidth / 2 >= bubbleView_MaxWidth then
				rowCount = rowCount + 1
				curWidth = 0
			end

			curWidth = curWidth + bubbleView_ByteWidth / 2
		elseif byte >= 192 and byte <= 239 then
			if curWidth + bubbleView_ByteWidth >= bubbleView_MaxWidth then
				rowCount = rowCount + 1
				curWidth = 0
			end

			curWidth = curWidth + bubbleView_ByteWidth
			i = i + 2
		end
	end

	if curWidth > 0 then
		rowCount = rowCount + 1
	end

	curWidth = math.max(curWidth, bubbleView_MinWidth)

	if rowCount > 1 then
		curWidth = bubbleView_MaxWidth
	end

	local offsetX = -(curWidth / 2 - bubbleView_XOffset)
	local offsetY = rowCount * bubbleView_RowHeight + bubbleView_YOffset
	local offset = Vector3.New(offsetX + addOffsetX, offsetY + addOffsetY, 0)
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local screenPos = uiCamera:WorldToScreenPoint(goPos)
	local finalAchorPos = screenPos + offset

	return uiCamera:ScreenToWorldPoint(finalAchorPos)
end

BubbleController.instance = BubbleController.New()

return BubbleController
