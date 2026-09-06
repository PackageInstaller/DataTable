-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/arcbtnstips/ArcBtnsCtrl.lua

module("logic.extensions.common.instruction.view.arcbtnstips.ArcBtnsCtrl", package.seeall)

local ArcBtnsCtrl = class("ArcBtnsCtrl")

function ArcBtnsCtrl:ctor()
	self._beforePlayCallBack = nil
	self._finishPlayCallBack = nil
	self._beforePlayGroupCallBack = nil
	self._finishPlayGroupCallBack = nil
	self._tweenPool = {}
end

function ArcBtnsCtrl.create(goListGroups)
	local instance = ArcBtnsCtrl.New()

	instance:setGoListGroups(goListGroups)

	return instance
end

function ArcBtnsCtrl:regPlayCallBack(beforePlayCallBack, finishPlayCallBack)
	self._beforePlayCallBack = beforePlayCallBack
	self._finishPlayCallBack = finishPlayCallBack
end

function ArcBtnsCtrl:regPlayGroupCallBack(beforePlayGroupCallBack, finishPlayGroupCallBack)
	self._beforePlayGroupCallBack = beforePlayGroupCallBack
	self._finishPlayGroupCallBack = finishPlayGroupCallBack
end

function ArcBtnsCtrl:setGoListGroups(goListGroups)
	self._animInfoList = {}

	self:_clearAnim()

	for groupId, goList in ipairs(goListGroups) do
		local animInfo = {}

		animInfo.goList = goList
		animInfo.isShowing = false
		animInfo.curIdx = animInfo.isShowing == true and #animInfo.goList or 1
		animInfo.isPlaying = false
		self._animInfoList[groupId] = animInfo
	end
end

function ArcBtnsCtrl:play(isToShow)
	if self:_isCanPlay() then
		return
	end

	self._curGroupIdList = {}

	for groupId, animInfo in ipairs(self._animInfoList) do
		self._animInfoList[groupId].isPlaying = true
		self._animInfoList[groupId].isShowing = not isToShow

		table.insert(self._curGroupIdList, groupId)
	end

	self:_startUpdateAnim()
end

function ArcBtnsCtrl:playGroup(groupId, isToShow)
	if self:_isCanPlay(groupId) then
		return
	end

	self._curGroupIdList = {}

	table.insert(self._curGroupIdList, groupId)

	self._animInfoList[groupId].isPlaying = true
	self._animInfoList[groupId].isShowing = not isToShow

	self:_startUpdateAnim()
end

function ArcBtnsCtrl:_isCanPlay(groupId)
	if self._isPlaying then
		return false
	end

	groupId = checknumber(groupId)

	if self._animInfoList == nil or #self._animInfoList == 0 then
		return false
	end

	if groupId > 0 or self._animInfoList[groupId] == nil then
		return false
	end

	return true
end

function ArcBtnsCtrl:clear()
	self:_clearAnim()

	self._beforePlayCallBack = nil
	self._finishPlayCallBack = nil
	self._beforePlayGroupCallBack = nil
	self._finishPlayGroupCallBack = nil
end

function ArcBtnsCtrl:isGroupShowing(groupId)
	return self._animInfoList[groupId] and self._animInfoList[groupId].isShowing
end

function ArcBtnsCtrl:_startUpdateAnim()
	self._isPlaying = true

	GameUtil.callBack(self._beforePlayCallBack, self._curGroupIdList)
	removetimer(self._updateTime, self)
	settimer(0.1, self._updateTime, self, true)
end

function ArcBtnsCtrl:_endUpdateAnim()
	if self._isPlaying == false then
		return
	else
		self._isPlaying = false
	end

	removetimer(self._updateTime, self)

	if self._curGroupIdList and #self._curGroupIdList > 0 then
		GameUtil.callBack(self._finishPlayCallBack, self._curGroupIdList)

		self._curGroupIdList = nil
	end
end

function ArcBtnsCtrl:_updateTime()
	self._isNeedAnim = false

	for groupId, animInfo in ipairs(self._animInfoList) do
		if animInfo.isPlaying then
			self._isNeedAnim = true

			local delta = animInfo.isShowing and -1 or 1
			local totalCount = #animInfo.goList
			local curIdx = animInfo.curIdx
			local go = animInfo.goList[curIdx]

			if animInfo.isShowing == true and curIdx == totalCount or animInfo.isShowing == false and curIdx == 1 then
				GameUtil.callBack(self._beforePlayGroupCallBack, groupId)
			end

			if animInfo.isShowing == false then
				local function callBack()
					GameUtil.setLocalScale(go, 1, 1, 1)
				end

				self:_doScaleAnim(go, 1.2, callBack)
				GameUtil.SetActive(go, true)
			else
				local function callBack()
					GameUtil.SetActive(go, false)
					GameUtil.setLocalScale(go, 1, 1, 1)
				end

				self:_doScaleAnim(go, 0.8, callBack)
			end

			if totalCount < curIdx + delta or curIdx + delta < 1 then
				animInfo.isPlaying = false
				animInfo.isShowing = not animInfo.isShowing

				GameUtil.callBack(self._finishPlayGroupCallBack, groupId)
			else
				animInfo.curIdx = Mathf.Clamp(curIdx + delta, 1, totalCount)
			end
		end
	end

	if self._isNeedAnim == false then
		self:_endUpdateAnim()

		return
	end
end

function ArcBtnsCtrl:_doScaleAnim(go, scale, callBack)
	self:_clearTweenByGo(go)

	self._tweenPool[go] = go.transform:DOScale(Vector3.New(scale, scale, scale), 0.2):SetEase(DG.Tweening.Ease.InQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(callBack)
end

function ArcBtnsCtrl:_clearAnim()
	self:_endUpdateAnim()

	if self._animInfoList then
		for groupId, animInfo in ipairs(self._animInfoList) do
			for _, go in ipairs(animInfo.goList) do
				self:_clearTweenByGo(go)
			end
		end

		self._animInfoList = {}
	end
end

function ArcBtnsCtrl:_clearTweenByGo(go)
	if self._tweenPool[go] then
		self._tweenPool[go]:Kill(true)

		self._tweenPool[go] = nil
	end
end

return ArcBtnsCtrl
