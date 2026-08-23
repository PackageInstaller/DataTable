local NewSlgS2NoticeComp = class("NewSlgS2NoticeComp")
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum

function NewSlgS2NoticeComp:ctor()
	self._txtBubble = self:getChild("Txt_bubble")
	self._left = self:getChild("Img_bubbleBg2")
	self._right = self:getChild("Img_bubbleBg")

	self:setVisible(false)
end

function NewSlgS2NoticeComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NEW_SLG_S2_UPDATE_NOTICE_BUBBLE, handler(self, self._onUpdateNoticeBubble), self)
	var_0_1:addEventListener(var_0_2.EVENT_NEW_SLG_S2_UPDATE_NOTICE_BUBBLE_POS, handler(self, self._updatePos), self)
end

function NewSlgS2NoticeComp:_onUpdateNoticeBubble(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_3 then
		self:setVisible(false)

		return
	end

	self._data = arg_3_3.data
	self._mapNode = arg_3_3.mapNode
	self._objectData = self._data.objectData
	self._cityId = self._objectData.value

	local var_3_0 = g.core.model.User.newSlgData:getCityDeclaration(self._cityId)

	if var_3_0 ~= "" then
		self:setVisible(true)
		self._txtBubble:setText(var_3_0)
		self:_updatePos()
	else
		self:setVisible(false)
	end
end

function NewSlgS2NoticeComp:_updatePos()
	if self:isVisible() and self._objectData and self._mapNode then
		local var_4_0, var_4_1 = g.utils.ToolUtils.tileMapFunc.rc2p(self._objectData.centerRC.x, self._objectData.centerRC.y)
		local var_4_2 = self._mapNode:getWindowPos(cc.p(var_4_0, var_4_1))

		var_4_2.y = display.height - var_4_2.y - 60

		if var_4_2.x > display.width / 2 then
			var_4_2.x = var_4_2.x + 140

			self._left:setVisible(true)
			self._right:setVisible(false)
		else
			var_4_2.x = var_4_2.x - 140

			self._right:setVisible(true)
			self._left:setVisible(false)
		end

		self:setX(var_4_2.x)
		self:setY(var_4_2.y)
	end
end

return NewSlgS2NoticeComp
