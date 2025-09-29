-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/utils/StoryLogicUtil.lua

module("logic.extensions.story.core.utils.StoryLogicUtil", package.seeall)

function GetCurStoryStagePosition(name)
	local curEntry = StoryController.instance:getCurStoryEntry()

	return StoryLogicUtil.GetStagePosition(curEntry.stage, name)
end

function GetStagePosition(target, name)
	if goutil.isNil(target) then
		printWarn("找不到剧情模板配置")

		return Vector3.zero
	end

	local childPos = target.transform:Find("positions")

	if goutil.isNil(childPos) then
		return Vector3.zero
	end

	local posTf = childPos:Find(tostring(name))

	if goutil.isNil(posTf) then
		printWarn("找不到剧情模板中的固定点位置:", name)

		return Vector3.zero
	end

	return posTf.localPosition
end

function GetCurStoryStateRotion(name)
	local curEntry = StoryController.instance:getCurStoryEntry()

	return StoryLogicUtil.GetStateRotation(curEntry.stage, name)
end

function GetStateRotation(target, name)
	if goutil.isNil(target) then
		printWarn("找不到剧情模板配置")

		return Quaternion.identity
	end

	local childPos = target.transform:Find("positions")

	if goutil.isNil(childPos) then
		return Quaternion.identity
	end

	local posTf = childPos:Find(tostring(name))

	if goutil.isNil(posTf) then
		printWarn("找不到剧情模板中的固定点位置:", name)

		return Quaternion.identity
	end

	return posTf.localRotation
end

function GetFirstAnimator(bindTarget)
	if goutil.isNil(bindTarget) then
		return nil
	end

	local tempGo = bindTarget.gameObject

	if goutil.isNil(tempGo) then
		return nil
	end

	local modelAnimator = tempGo:GetComponentInChildren(ComponentType.Animator)

	return modelAnimator
end

function GetFirstAnimatorAdapter(bindTarget)
	if goutil.isNil(bindTarget) then
		return nil
	end

	local tempGo = bindTarget.gameObject

	if goutil.isNil(tempGo) then
		return nil
	end

	local modelAnimator = tempGo:GetComponentInChildren(ComponentType.StoryAnimationPlayer)

	return modelAnimator
end

function GetFirstAnimationPlayer(bindTarget)
	if goutil.isNil(bindTarget) then
		return nil
	end

	local tempGo = bindTarget.gameObject

	if goutil.isNil(tempGo) then
		return nil
	end

	local modelAnimator = tempGo:GetComponentInChildren(ComponentType.AnimationPlayer)

	return modelAnimator
end

function SetAnimationClip(animation, clip)
	if goutil.isNil(animation) or goutil.isNil(clip) then
		return
	end

	local tempClip = animation:GetClip(clip.name)

	if goutil.isNil(tempClip) then
		animation:AddClip(clip, clip.name)
	end

	animation.clip = clip
end

function PlayFaceAnimation(animation, clip)
	if goutil.isNil(animation) or goutil.isNil(clip) then
		return
	end

	SetAnimationClip(animation, clip)
	animation:Play()
end

function GetFirstFaceAnimation(go)
	if goutil.isNil(go) then
		return nil
	end

	local faceChild
	local trf = go.transform
	local count = trf.childCount

	for i = 0, count - 1 do
		local temp = trf:GetChild(i)

		if string.ends(temp.name, "@face") then
			faceChild = temp.gameObject

			break
		end

		local tempAnimation = StoryLogicUtil.GetFirstFaceAnimation(temp.gameObject)

		if not goutil.isNil(tempAnimation) then
			return tempAnimation
		end
	end

	if not goutil.isNil(faceChild) then
		local animation = faceChild:GetComponent(ComponentType.Animation)

		if goutil.isNil(animation) then
			animation = faceChild:AddComponent(ComponentType.Animation)
		end

		animation.playAutomatically = false

		return animation
	end

	return nil
end
