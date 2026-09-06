-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/item/AQAFFloatTextItem.lua

module("logic.extensions.aoqiattackforce.view.item.AQAFFloatTextItem", package.seeall)

local AQAFFloatTextItem = class("AQAFFloatTextItem", AQAFFloatItem)

function AQAFFloatTextItem:getContentText()
	self._contentText = self._contentText or goutil.findChildTextComponent(self._go, "txt")

	return self._contentText
end

function AQAFFloatTextItem:setContent(content)
	local contentText = self:getContentText()

	contentText.text = content

	GameUtil.SetActive(self._contentText.gameObject, not string.nilorempty(content))
end

return AQAFFloatTextItem
