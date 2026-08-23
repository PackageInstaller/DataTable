local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local SpineBase = class("SpineBase", function()
	return cc.Node:create()
end)
local var_0_3 = g.core.const.ConstMgr.SpineConst

function SpineBase:ctor(arg_2_1)
	if type(arg_2_1) ~= "table" then
		arg_2_1 = {}
	end

	self._slotList = {}
	self._isRemove = false
	self._timeScale = nil
	self._spine = nil
	self._alpha = 255
	self._spineType = BattleConst.SPINE_TYPE.BASE
	self._jsonData = nil
	self._slotChildTable = {}
	self._ignoreSpine = arg_2_1.ignoreSpine
	self._params = arg_2_1
	self._resId = arg_2_1.resId

	assert(self._resId, "cannot create spine without resId")

	self._isNeedDownloadRes = false
	self._params = arg_2_1
	self._spinePath = arg_2_1.path or BattlePath.getSpineEffectPath(self._resId)

	local var_2_1

	self._spinePath, var_2_1 = self:checkAndFitIsExitSpine()
	self._animName = arg_2_1.anim or BattleConst.SPINE_ACTION_TYPE.PLAY
	self._isLoop = arg_2_1.isLoop or false
	self._isReverse = arg_2_1.isReverse or false
	self._listener = arg_2_1.listener or nil

	if var_2_1 then
		self:onLoadSpineObj(self._params)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_FINISH, handler(self, self.onPackageDownloadFinish), self)
end

function SpineBase:onPackageDownloadFinish()
	if self._isNeedDownloadRes then
		if self._spine then
			self._spine:removeFromParent()

			self._spine = nil
		end

		if self._nodeRoot then
			self._nodeRoot:removeFromParent()

			self._nodeRoot = nil
		end

		self._isNeedDownloadRes = false

		self:onLoadSpineObj(self._params)
	end
end

function SpineBase:onLoadSpineObj(arg_4_1)
	self._spinePath = arg_4_1.path or BattlePath.getSpineEffectPath(self._resId)

	local var_4_1

	self._spinePath, var_4_1 = self:checkAndFitIsExitSpine()

	if not var_4_1 then
		return
	end

	if arg_4_1.isAlphaNode then
		self._nodeRoot1 = cc.AlphaNode:create():addTo(self)
		self._nodeRoot = cc.AlphaNode:create():addTo(self._nodeRoot1)
	else
		self._nodeRoot = cc.Node:create():addTo(self)

		self._nodeRoot:setCascadeOpacityEnabled(true)
		self._nodeRoot:setCascadeColorEnabled(true)
	end

	self:setCascadeOpacityEnabled(true)
	self:setCascadeColorEnabled(true)
	self:_addBaseSpine()
	self:_parsingJsonFile()
	self:_registerSpineEventListener()
	self:resumeUnloadedSlot()
end

function SpineBase:checkAndFitIsExitSpine()
	local var_5_0 = self._spinePath
	local var_5_1 = true
	local var_5_2 = string.match(self._spinePath, "battle/knight_spine/(%d+)/.+")
	local var_5_3 = false

	if not var_5_2 then
		var_5_2 = string.match(var_5_0, "battle/effect_spine/(%d+)_")
		var_5_3 = true
	end

	local var_5_4 = string.match(var_5_0, "knight_spine/(%d+)/.+")

	if var_5_2 then
		if not g.core.battle.BattleProxy:isInBattle() then
			local var_5_5 = g.core.common.PackageRes:checkResIsNeedUpgrade(tonumber(var_5_2), g.core.common.PackageRes.resType.BATTLE, self._ignoreSpine)

			self._isNeedDownloadRes = var_5_5

			local var_5_6 = var_5_2

			if not g.core.battle.BattleProxy:isInBattle() and var_5_5 then
				var_5_6 = 500070

				if var_5_3 then
					var_5_1 = false
				end
			end

			if not var_5_3 then
				var_5_0 = require("app.view.battle.BattlePath").getSpineKnightPath(var_5_6)
			end
		end
	elseif var_5_4 then
		local var_5_7 = g.core.common.PackageRes:checkResIsNeedUpgrade(tonumber(var_5_4), g.core.common.PackageRes.resType.KNIGHT, self._ignoreSpine)

		self._isNeedDownloadRes = var_5_7

		if var_5_7 then
			var_5_1 = false
		end
	end

	return var_5_0, var_5_1
end

function SpineBase:getCurAnimationName()
	return self._animName
end

function SpineBase:_addBaseSpine()
	self._addS = true

	local var_7_0, var_7_1 = BattlePath.getSpineResPath(self._spinePath)

	if not cc.FileUtils:getInstance():isFileExist(var_7_0) then
		assert(false, "NO Spine: " .. tostring(self._spinePath) .. " version: " .. (g.core.utils.Tools.getVersionInfos() .. ":" .. tostring((g.core.utils.Tools.checkSilentFull()))) .. " curModule: " .. g.core.utils.Tools.getCurModuleName())

		return
	end

	local var_7_2, var_7_3 = g.core.utils.Tools.getPngTextureFormat(var_7_0, true)

	if var_7_2 then
		cc.Texture2D:setDefaultAlphaPixelFormat(var_7_3)
	end

	self._spine = sp.SkeletonAnimation:createWithBinaryFile(var_7_0, var_7_1)

	assert(self._spine, "unkown spine knight with name = " .. var_7_0)
	self._spine:setOpacity(self._alpha)

	if device.isWindowsDebug and device.isWindowsDebug() then
		g.core.model.User.homeData:addSpineTime(self._spinePath)
	end

	if self._isReverse then
		self._spine:setScaleX(-1)
	end

	self:setAnimation(0, self._animName, self._isLoop)
	self._nodeRoot:addChild(self._spine)

	self._timeScale = self._spine:getTimeScale()

	if var_7_2 then
		cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
	end
end

function SpineBase:_parsingJsonFile()
	local var_8_0 = json.decodeFileIfExists((BattlePath.getSpineJsonPath(self._spinePath)))

	if not var_8_0 or not var_8_0.name or var_8_0.name ~= tostring(self._resId) then
		return
	end

	self._jsonData = var_8_0
end

function SpineBase:clear()
	if self._isRemove then
		return
	end

	self:removeAllSlotChild()
	self:_removeSpineEventListener()

	if self._spine then
		self._spine:removeFromParent()
	end

	self._spine = nil
	self._isRemove = true
end

function SpineBase:isSpineRemoved()
	return self._isRemove
end

function SpineBase:getSpineType()
	return self._spineType
end

function SpineBase:isSpine()
	return true
end

function SpineBase:getResId()
	return self._resId
end

function SpineBase:removeAllSlotChild()
	for iter_14_0, iter_14_1 in pairs(self._slotChildTable) do
		self:removeChildAtSlot(iter_14_0)
	end

	self._slotChildTable = {}
end

function SpineBase:removeChildAtSlot(arg_15_1)
	if self._slotChildTable[arg_15_1] then
		if self._slotChildTable[arg_15_1].isSpine and self._slotChildTable[arg_15_1]:isSpine() and not self._slotChildTable[arg_15_1]:isSpineRemoved() then
			self._slotChildTable[arg_15_1]:clear()
			self._slotChildTable[arg_15_1]:removeFromParent()
		elseif self._slotChildTable[arg_15_1].isCriSprite and self._slotChildTable[arg_15_1]:isCriSprite() then
			self._slotChildTable[arg_15_1]:dispose()
		elseif self._slotChildTable[arg_15_1].isEffectGroup and self._slotChildTable[arg_15_1]:isEffectGroup() then
			self._slotChildTable[arg_15_1]:clear()
			self._slotChildTable[arg_15_1]:removeFromParent()
		else
			self._slotChildTable[arg_15_1]:removeFromParent()
		end
	end

	self._slotChildTable[arg_15_1] = nil
end

function SpineBase:addSpineEventListener(arg_16_1)
	self._listener = arg_16_1
end

function SpineBase:_registerSpineEventListener()
	if not self._spine then
		return
	end

	self._spine:registerSpineEventHandler(handler(self, self._onSpineEvent), sp.EventType.ANIMATION_EVENT)
	self._spine:registerSpineEventHandler(handler(self, self._onSpineEvent), sp.EventType.ANIMATION_COMPLETE)
	self._spine:registerSpineEventHandler(handler(self, self._onSpineEvent), sp.EventType.ANIMATION_END)
end

function SpineBase:_removeSpineEventListener()
	if not self._spine then
		return
	end

	self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_EVENT)
	self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)
	self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
end

function SpineBase:_onSpineEvent(arg_19_1)
	if self._listener then
		g.core.common.Scheduler:newScheduleOnce(function(arg_20_0)
			if self._listener then
				self._listener(arg_19_1, self._isLoop, self._spine)
			end
		end, 0)
	end
end

function SpineBase:addSpineEffectAtSlot(arg_21_1, arg_21_2)
	self:removeChildAtSlot(arg_21_2)

	function arg_21_1:listener(arg_22_1)
		if not arg_22_1 and self.type == BattleConst.SPINE_EVENT.COMPLETE then
			self:removeChildAtSlot(arg_21_2)
		end
	end

	local var_21_0 = require("app.view.battle.BattleEffect").new(arg_21_1)

	self:getNodeForSlot(arg_21_2):addChild(var_21_0)

	self._slotChildTable[arg_21_2] = var_21_0
end

function SpineBase:addCriSpriteAtSlot(arg_23_1, arg_23_2)
	self:removeChildAtSlot(arg_23_2)

	function arg_23_1.listener(arg_24_0, arg_24_1)
		if not arg_24_1 and arg_24_0 == "complete" then
			g.core.common.Scheduler:newScheduleOnce(function(arg_25_0)
				self:removeChildAtSlot(arg_23_2)
			end, 0)
		end
	end

	local var_23_0 = require("app.view.common.CriSprite").new(arg_23_1)

	self:getNodeForSlot(arg_23_2):addChild(var_23_0)

	self._slotChildTable[arg_23_2] = var_23_0
end

function SpineBase:addNodesAtSlots(arg_26_1)
	arg_26_1 = arg_26_1 or {}

	for iter_26_0 = 1, #arg_26_1 do
		local var_26_0 = arg_26_1[iter_26_0].node

		if not arg_26_1[iter_26_0].node and arg_26_1[iter_26_0].nodeFunc then
			var_26_0 = arg_26_1[iter_26_0].nodeFunc()
		end

		self:removeChildAtSlot(arg_26_1[iter_26_0].slotStr)
		self:getNodeForSlot(arg_26_1[iter_26_0].slotStr):addChild(var_26_0)

		self._slotChildTable[arg_26_1[iter_26_0].slotStr] = var_26_0
	end
end

function SpineBase:changeSkin(arg_27_1)
	local var_27_0 = self:getSkeleton()

	if var_27_0 then
		var_27_0:setSkin(arg_27_1)
		var_27_0:setSlotsToSetupPose()
	end
end

function SpineBase:getBaseSpine()
	return self._spine or self
end

function SpineBase:play(arg_29_1, arg_29_2)
	if not self._spine then
		return
	end

	self._spine:play(arg_29_1, arg_29_2)
end

function SpineBase:pause()
	if not self._spine then
		return
	end

	for iter_30_0, iter_30_1 in pairs(self._slotChildTable) do
		if iter_30_1.isSpine and iter_30_1:isSpine() and not iter_30_1:isSpineRemoved() then
			iter_30_1:pause()
		elseif iter_30_1.isCriSprite and iter_30_1:isCriSprite() then
			iter_30_1:pause(true)
		elseif iter_30_1.isEffectGroup and iter_30_1:isEffectGroup() then
			iter_30_1:stop()
		end
	end

	self._spine:pause()
end

function SpineBase:resume()
	if not self._spine then
		return
	end

	for iter_31_0, iter_31_1 in pairs(self._slotChildTable) do
		if iter_31_1.isSpine and iter_31_1:isSpine() and not iter_31_1:isSpineRemoved() then
			iter_31_1:resume()
		elseif iter_31_1.isCriSprite and iter_31_1:isCriSprite() then
			iter_31_1:pause(false)
		elseif iter_31_1.isEffectGroup and iter_31_1:isEffectGroup() then
			iter_31_1:play()
		end
	end

	self._spine:resume()
end

function SpineBase:stop()
	if self._spine then
		self:pause()
		self._spine:setTimeScale(0)
	end
end

function SpineBase:setTimeScale(arg_33_1)
	if self._spine then
		self._spine:setTimeScale(arg_33_1)
	end
end

function SpineBase:restart()
	if self._spine and self._spine:getTimeScale() == 0 then
		self:resume()
		self._spine:setTimeScale(self._timeScale)
	end
end

function SpineBase:setTimeScale(arg_35_1)
	if self._spine then
		self._spine:setTimeScale(self._timeScale * arg_35_1)
	end
end

function SpineBase:setReverse(arg_36_1)
	if not self._spine then
		return
	end

	if self._isReverse == arg_36_1 then
		return
	end

	self._isReverse = arg_36_1

	if self._isReverse then
		self._spine:setScaleX(-1)
	else
		self._spine:setScaleX(1)
	end
end

function SpineBase:setAnimation(arg_37_1, arg_37_2, arg_37_3)
	if not self._spine then
		return
	end

	self._spine:setAnimation(arg_37_1, arg_37_2, arg_37_3)

	self._animName = arg_37_2
	self._isLoop = arg_37_3
end

function SpineBase:addAnimation(arg_38_1, arg_38_2, arg_38_3)
	if not self._spine then
		return
	end

	self._spine:addAnimation(arg_38_1, arg_38_2, arg_38_3)
end

function SpineBase:getNodeForSlot(arg_39_1)
	if not self._spine then
		local var_39_0 = cc.Node:create()

		self:addChild(var_39_0, -1)

		self._slotList[arg_39_1] = var_39_0

		return var_39_0
	end

	local var_39_1 = self._spine:getNodeForSlot(arg_39_1)

	if not var_39_1 and not self._slotList[arg_39_1] then
		local var_39_2 = cc.Node:create()

		self._spine:addChild(var_39_2, -1)

		self._slotList[arg_39_1] = var_39_2

		g.core.log:error("error------>can't find slotNode at id = " .. arg_39_1 .. " resId = " .. self._resId .. " use create Node replace!!!!!")
	end

	var_39_1 = var_39_1 or self._slotList[arg_39_1]

	return var_39_1
end

function SpineBase:resumeUnloadedSlot()
	for iter_40_0, iter_40_1 in pairs(self._slotList) do
		local var_40_0 = self._spine:getNodeForSlot(iter_40_0)

		if var_40_0 and not tolua.isnull(iter_40_1) then
			iter_40_1:retain()
			iter_40_1:removeFromParent()
			var_40_0:addChild(iter_40_1)
			iter_40_1:release()
		end
	end

	self._slotList = {}
end

function SpineBase:isHaveNodeForSlot(arg_41_1)
	if self._spine then
		return checkbool((self._spine:getNodeForSlot(arg_41_1)))
	else
		return false
	end
end

function SpineBase:getSkeleton()
	if not self._spine then
		return
	end

	return self._spine:getSkeleton()
end

function SpineBase:getSlotNames()
	if not self._spine then
		return
	end

	return (self._spine:getSlotNames())
end

function SpineBase:getAnimationNames()
	if not self._spine then
		return
	end

	return (self._spine:getAnimationNames())
end

function SpineBase:getBoneNames()
	if not self._spine then
		return
	end

	return (self._spine:getBoneNames())
end

function SpineBase:getEventNames()
	if not self._spine then
		return
	end

	return (self._spine:getEventNames())
end

function SpineBase:getAnimationDuration(arg_47_1)
	if not self._spine then
		return 0
	end

	arg_47_1 = arg_47_1 or self._animName

	return (self._spine:getAnimationDuration(arg_47_1))
end

function SpineBase:setAlpha(arg_48_1)
	self._alpha = arg_48_1

	if self._spine then
		self._spine:setOpacity(arg_48_1)
	end
end

function SpineBase:setGray(arg_49_1)
	if self._spine then
		self._spine:setGLProgramState((cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_49_1 and "SHADER_UI_GRAY" or "SHADER_UI_NORMAL")))))
	end
end

function SpineBase:addColor(arg_50_1, arg_50_2)
	if self._spine then
		local var_50_0 = cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_50_1 and "SHADER_ADD_COLOR" or "SHADER_UI_NORMAL")))

		if arg_50_1 then
			var_50_0:setUniformVec3("addColor", arg_50_2)
		end

		self._spine:setGLProgramState(var_50_0)
	end
end

function SpineBase:mulColor(arg_51_1, arg_51_2)
	if self._spine then
		local var_51_0 = cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_51_1 and "SHADER_MUL_COLOR" or "SHADER_UI_NORMAL")))

		if arg_51_1 then
			var_51_0:setUniformVec3("mulColor", arg_51_2)
		end

		self._spine:setGLProgramState(var_51_0)
	end
end

function SpineBase:setAlphaRect(arg_52_1, arg_52_2, arg_52_3)
	if self._nodeRoot == nil or self._nodeRoot1 == nil then
		return
	end

	if arg_52_2 == nil then
		arg_52_2 = var_0_3.MASK_RECT
	end

	if arg_52_3 == nil then
		arg_52_3 = var_0_3.MASK_A_RANGE
	end

	if arg_52_1 == var_0_3.MASK_TYPE.HORIZON then
		self._nodeRoot1:showChangingHoriRect(arg_52_2, arg_52_3)
	elseif arg_52_1 == var_0_3.MASK_TYPE.VERTICAL then
		self._nodeRoot:showChangingVertRect(arg_52_2, arg_52_3)
	elseif arg_52_1 == var_0_3.MASK_TYPE.ALL then
		self._nodeRoot1:showChangingHoriRect(arg_52_2, arg_52_3)
		self._nodeRoot:showChangingVertRect(arg_52_2, arg_52_3)
	else
		self._nodeRoot1:disableChangeing()
		self._nodeRoot:disableChangeing()
	end
end

function SpineBase:dispose()
	if self._spine then
		self._spine:removeFromParent()
	end

	self:removeFromParent()
end

function SpineBase:onExit()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

return SpineBase
