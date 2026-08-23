local var_0_0 = g.core.config.unite_token_info
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.utils.Quality
local SpineBase = require("app.view.common.SpineBase")
local var_0_4 = g.core.common.Path
local DrawUniteToken = class("DrawUniteToken", function()
	return fgui.GComponent:create()
end)

function DrawUniteToken:ctor(arg_2_1)
	self._advId = arg_2_1.advId or 0

	if self._advId == 0 then
		g.core.log:error("---------         DrawUniteToken:ctor  advId is invalid       ---------------")

		return
	end

	self._scale = arg_2_1.scale or 1
	self._loop = arg_2_1.loop ~= false
	self._autoIdle = arg_2_1.autoIdle ~= false
	self._aniName = arg_2_1.anim or var_0_1.UniteTokenAni.IDLE
	self._spineEventEnable = true
	self._listener = arg_2_1.listener
	self._info = var_0_0.get(self._advId)
	self._spineNode = self:_createSpineNode()

	self:addNode(self._spineNode)
	self:setScale(self._scale)
	self:setName("DrawUniteToken")
end

function DrawUniteToken:onLoad()
	self._spineEventEnable = true
end

function DrawUniteToken:onUnload()
	self._spineEventEnable = false
end

function DrawUniteToken:_createSpineNode()
	return SpineBase.new({
		resId = self._info.res_id,
		path = var_0_4:getUniteTokenSpinePath(self._info.res_id),
		anim = self._aniName,
		isLoop = self._loop,
		listener = handler(self, self._onSpineEvent)
	})
end

function DrawUniteToken:isSpineFileExist(arg_6_1)
	if arg_6_1 and arg_6_1 > 0 then
		local var_6_0 = var_0_0.get(arg_6_1)

		if var_6_0 then
			return cc.FileUtils:getInstance():isDirectoryExist((var_0_4:getUniteTokenSpineFolderPath(var_6_0.res_id)))
		end
	end

	return false
end

function DrawUniteToken:showSpineEnable(arg_7_1)
	if not var_0_2.needStopUniteTokenSpine() then
		return self:isSpineFileExist(arg_7_1)
	end
end

function DrawUniteToken:getSpineBase()
	return self._spineNode
end

function DrawUniteToken:playAnimation(arg_9_1, arg_9_2)
	self._loop = arg_9_2 ~= false

	self._spineNode:setAnimation(0, arg_9_1, self._loop)
end

function DrawUniteToken:_onCheckDevicePerform()
	if var_0_2.needStopUniteTokenSpine() then
		self._spineNode:stop()
	else
		self._spineNode:restart()
	end
end

function DrawUniteToken:_onSpineEvent(arg_11_1)
	if not self._spineEventEnable then
		return
	end

	if arg_11_1.type == var_0_1.SPINE_EVENT.COMPLETE then
		if tolua.isnull(self) then
			g.core.log:error("-------   Error! DrawUniteToken:_onSpineEvent     self is invalid     ---------")
		elseif not self._loop then
			if self._autoIdle then
				self:playAnimation(var_0_1.UniteTokenAni.IDLE, true)
			end

			if self._listener then
				self._listener(var_0_1.SPINE_EVENT.COMPLETE)
			end
		end
	end
end

return DrawUniteToken
