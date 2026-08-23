local var_0_0 = g.core.config.pet_info
local var_0_1 = g.core.config.pet_base_info
local var_0_2 = g.core.const.ConstMgr.SpineConst
local SpineBase = require("app.view.common.SpineBase")
local var_0_4 = g.core.common.Path
local DrawPet = class("DrawPet", function()
	return fgui.GComponent:create()
end)

function DrawPet:ctor(arg_2_1)
	self._advId = arg_2_1.advId or 0

	assert(self._advId > 0, "---------         DrawUniteToken:ctor  advId is invalid       ---------------")

	self._scale = arg_2_1.scale or 1
	self._loop = arg_2_1.loop ~= false
	self._autoIdle = arg_2_1.autoIdle ~= false
	self._aniName = arg_2_1.anim or var_0_2.UniteTokenAni.IDLE
	self._spineEventEnable = true
	self._listener = arg_2_1.listener
	self._info = var_0_0.get(self._advId)
	self._spineNode = self:_createSpineNode()

	self:addNode(self._spineNode)
	self:setScale(self._scale)
	self:setName("DrawPet")
end

function DrawPet:onLoad()
	self._spineEventEnable = true
end

function DrawPet:onUnload()
	self._spineEventEnable = false
end

function DrawPet:getSpineBase()
	return self._spineNode
end

function DrawPet:getAdvId()
	return self._advId
end

function DrawPet:_createSpineNode()
	local var_7_0 = SpineBase.new({
		resId = self._info.resource,
		path = var_0_4:getPetSpinePath(self._info.resource),
		anim = self._aniName,
		isLoop = self._loop,
		listener = handler(self, self._onSpineEvent)
	})
	local var_7_1 = var_0_1.get(self._info.resource)

	var_7_0:setPosition(var_7_1.pos_x, var_7_1.pos_y)
	var_7_0:setScale(var_7_1.scale / 100)

	return var_7_0
end

function DrawPet:playAnimation(arg_8_1, arg_8_2)
	self._loop = arg_8_2 ~= false

	self._spineNode:setAnimation(0, arg_8_1, self._loop)
end

function DrawPet:_onSpineEvent(arg_9_1)
	if not self._spineEventEnable then
		return
	end

	if arg_9_1.type == var_0_2.SPINE_EVENT.COMPLETE then
		if tolua.isnull(self) then
			g.core.log:error("-------   Error! DrawUniteToken:_onSpineEvent     self is invalid     ---------")
		elseif not self._loop then
			if self._autoIdle then
				self:playAnimation(var_0_2.UniteTokenAni.IDLE, true)
			end

			if self._listener then
				self._listener(var_0_2.SPINE_EVENT.COMPLETE)
			end
		end
	end
end

return DrawPet
