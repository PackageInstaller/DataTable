-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityreturnsignin/view/ActivityReturnSpineCtrl.lua

module("logic.extensions.activityreturnsignin.view.ActivityReturnSpineCtrl", package.seeall)

local ActivityReturnSpineCtrl = class("ActivityReturnSpineCtrl", HLSpineCtrl)

function ActivityReturnSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	ActivityReturnSpineCtrl.super.onInit(self, spineRoot, view)
end

function ActivityReturnSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function ActivityReturnSpineCtrl:_getDefaultScale()
	return 1
end

function ActivityReturnSpineCtrl:playDefaultAnim()
	return
end

function ActivityReturnSpineCtrl:_playAnim(animName, isLoop, callBack, isReStart, path)
	if self._playerSpine then
		local effGo = self._playerSpine.effGo

		if goutil.isNil(effGo) then
			return
		end

		local go = goutil.findChild(effGo, "skeleton")

		if not goutil.isNil(effGo) then
			RoleObjectPool.instance:playAnimation(go, animName, isLoop, callBack, isReStart)
		end

		self:resumeAnim()
	end
end

return ActivityReturnSpineCtrl
