local BaseCommonSceneChange = class("BaseCommonSceneChange", require("app.fairyGUI.base_new.UI_BaseCommonSceneChange"))

function BaseCommonSceneChange:ctor()
	self._spriteNode = nil
	self._customCall = nil
	self._playing = false

	self:setVisible(false)
	self.m_enterTransition:setHook("cut", handler(self, self._onCallFunk))
end

function BaseCommonSceneChange:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_CHANGE_PLAY_TRANSITION, self.onPlayEnterTransition, self)
end

function BaseCommonSceneChange:onPlayEnterTransition(arg_3_1, arg_3_2)
	if self._playing then
		return
	end

	self._playing = true
	self._customCall = arg_3_2.callback
	self._tempCallBackParam = arg_3_2.callbackParams

	local var_3_0 = cc.utils:captureNodeCC(g.core.layer.LayerManager:getRunningScene())
	local var_3_1 = cc.Texture2D:new()

	var_3_1:initWithImage(var_3_0)
	var_3_0:release()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	if not self._spriteNode then
		local var_3_2 = cc.Sprite:createWithTexture(var_3_1)

		var_3_2:setAnchorPoint(0.5, 0.5)
		self.m_imgHolder:addNode(var_3_2)

		self._spriteNode = var_3_2
	else
		self._spriteNode:setTexture(var_3_1)
	end

	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self._onPlayEnd))
end

function BaseCommonSceneChange:_onPlayEnd()
	self:setVisible(false)

	self._playing = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function BaseCommonSceneChange:_onCallFunk()
	if self._customCall then
		self._customCall(self._tempCallBackParam)

		self._customCall = nil
	end
end

return BaseCommonSceneChange
