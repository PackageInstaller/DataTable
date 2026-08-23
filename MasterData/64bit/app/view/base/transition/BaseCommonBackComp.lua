local BaseCommonBackComp = class("BaseCommonBackComp", require("app.fairyGUI.base_new.UI_BaseCommonBackComp"))

function BaseCommonBackComp:ctor()
	self:setVisible(false)

	self._spriteNodeList = {}
	self.m_backLayerTransition = self:getSharedTrans("back", "CommonBackAnim")
end

function BaseCommonBackComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION, self.onPlayExitTransition, self)
end

function BaseCommonBackComp:captureNodeTexture(arg_3_1)
	if cc.Director:getInstance().render == nil then
		local var_3_0 = cc.utils:captureNodeCC(arg_3_1)
		local var_3_1 = cc.Texture2D:new()

		var_3_1:initWithImage(var_3_0)
		var_3_0:release()

		return var_3_1, false
	end

	cc.Director:getInstance():setNextDeltaTimeZero(true)

	local var_3_2 = arg_3_1:getContentSize()
	local var_3_3 = cc.RenderTexture:create(var_3_2.width, var_3_2.height, 2, 35056)
	local var_3_4 = cc.p(arg_3_1:getPosition())
	local var_3_5 = cc.p(0, 0)

	if not arg_3_1:isIgnoreAnchorPointForPosition() then
		var_3_5 = cc.p(arg_3_1:getAnchorPoint())
	end

	arg_3_1:setPosition(cc.p(var_3_2.width * var_3_5.x, var_3_2.height * var_3_5.y))
	var_3_3:begin()
	arg_3_1:visit()
	var_3_3:endToLua()
	arg_3_1:setPosition(var_3_4.x, var_3_4.y)
	arg_3_1:setAnchorPoint(var_3_5.x, var_3_5.y)
	cc.Director:getInstance():render()

	return var_3_3:getSprite():getTexture(), true
end

function BaseCommonBackComp:onPlayExitTransition()
	if g.core.utils.Quality.needCloseBackAction() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BACK_COMMON_BACK_TRANSITION)

		return
	end

	local var_4_0, var_4_1 = self:captureNodeTexture(g.core.layer.LayerManager:getRunningScene())

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	for iter_4_0 = 1, 20 do
		local var_4_2 = self._spriteNodeList[iter_4_0]

		if not self._spriteNodeList[iter_4_0] then
			var_4_2 = cc.Sprite:createWithTexture(var_4_0)

			var_4_2:setAnchorPoint(0.5, 0.5)
			var_4_2:setPosition(self["m_frag" .. iter_4_0]:getWidth() / 2, self["m_frag" .. iter_4_0]:getHeight() / 2)
			self["m_frag" .. iter_4_0]:addNode(var_4_2, 0)

			self._spriteNodeList[iter_4_0] = var_4_2
		else
			self._spriteNodeList[iter_4_0]:setTexture(var_4_0)
		end

		var_4_2:setFlippedY(var_4_1)
	end

	self:setVisible(true)
	self.m_backLayerTransition:play(handler(self, self._onPlayEnd))
end

function BaseCommonBackComp:_onPlayEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BACK_COMMON_BACK_TRANSITION)
	self:setVisible(false)
end

return BaseCommonBackComp
