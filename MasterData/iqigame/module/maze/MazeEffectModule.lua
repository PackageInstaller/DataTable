-- chunkname: @IQIGame\\Module\\Maze\\MazeEffectModule.lua

MazeEffectModule = {
	effectsSerialId = {}
}

function MazeEffectModule.Initialize()
	return
end

function MazeEffectModule.Shutdown()
	MazeEffectModule.Clear()
end

function MazeEffectModule.PlayEffect(effectID, mountPoint, mountPointParent, order, destroyRule, params)
	local effect = {
		effectID = effectID,
		mountPoint = mountPoint,
		destroyRule = destroyRule,
		params = params or {},
		mountPointParent = mountPointParent,
		order = order
	}

	MazeEffectModule.__OnPlayEffect(effect)
end

function MazeEffectModule.__OnPlayEffect(effectData)
	local effectSerialID = GameEntry.Effect:PlayUIMountPointEffect(effectData.effectID, effectData.mountPoint, 0, effectData.mountPointParent, effectData.order)

	MazeEffectModule.effectsSerialId[effectSerialID] = effectData
end

function MazeEffectModule.CheckAndDestroy(conditionType, conditionParam)
	ForPairs(MazeEffectModule.effectsSerialId, function(serialId, effectData)
		local shouldDestroy = false

		if effectData.destroyRule == Constant.MazeEffectOrSoundDestoryType.StepEnd then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.StepEnd
		elseif effectData.destroyRule == Constant.MazeEffectOrSoundDestoryType.EventLinkEnd then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.EventLinkEnd
		elseif effectData.destroyRule == Constant.MazeEffectOrSoundDestoryType.ByStep then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.ByStep and conditionParam == effectData.params.step
		elseif effectData.destroyRule == Constant.MazeEffectOrSoundDestoryType.ByEventID then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.ByEventID and conditionParam == effectData.params.eventID
		end

		if shouldDestroy then
			GameEntry.Effect:StopEffect(serialId)

			MazeEffectModule.effectsSerialId[serialId] = nil
		end
	end)
end

function MazeEffectModule.Clear()
	ForPairs(MazeEffectModule.effectsSerialId, function(serialId, effectData)
		GameEntry.Effect:StopEffect(serialId)

		MazeEffectModule.effectsSerialId[serialId] = nil
	end)

	MazeEffectModule.effectsSerialId = {}
end
