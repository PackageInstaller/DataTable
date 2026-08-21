-- chunkname: @IQIGame\\UI\\Maze\\MazeBattle\\MazeBattleSpineView.lua

local SpineView = {
	uniqueEntityID = 0,
	entityCid = 0
}

function SpineView:_OnCreate(entityCid, parentTrans, callback)
	self.entityCid = entityCid
	self.__completeCallback = callback
	self.uniqueEntityID = EntityUtility.GetUIEntitySpineByCid(self.entityCid, parentTrans, Vector3.zero, function(_entityComponent)
		if _entityComponent.Id ~= self.uniqueEntityID then
			EntityUtility.HideEntity(_entityComponent)

			return
		end

		self.spineEntityGo = _entityComponent.gameObject
		self.skeletonGraphic = self.spineEntityGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

		self.skeletonGraphic:Initialize(true)

		if self.__completeCallback ~= nil then
			self.__completeCallback()
		end
	end)
end

function SpineView:_PlayAnim(animName, isLoop)
	if self.skeletonGraphic == nil then
		return
	end

	if self.skeletonGraphic.AnimationState == nil then
		return
	end

	self.skeletonGraphic.AnimationState:SetAnimation(0, animName, isLoop)
end

function SpineView:_Dispose()
	self.skeletonGraphic = nil

	EntityUtility.HideEntityByEntityID(self.uniqueEntityID)

	self.uniqueEntityID = 0
end

return SpineView
