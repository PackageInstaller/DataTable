-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewBlockMgr.lua

module("frameworkext.lmvc.view.ViewBlockMgr", package.seeall)

local ViewBlockMgr = class("ViewBlockMgr")

setglobal("kBlockKeyDefault", 10001)
setglobal("kBlockKeyViewLoading", 10002)

function ViewBlockMgr:ctor()
	self._blockKeys = {}
	self._blockClickMaskGO = nil
	self._transparentColor = "#00000000"
end

function ViewBlockMgr:blockClick(isBlock, blockKey)
	blockKey = blockKey or kBlockKeyDefault

	if isBlock then
		if not self._blockKeys[blockKey] then
			self._blockKeys[blockKey] = true

			self:_tryCreateBlockClickMask()

			if not self._blockClickMaskGO.activeSelf then
				goutil.setActive(self._blockClickMaskGO, true)
			end
		end
	else
		self._blockKeys[blockKey] = nil

		if self._blockClickMaskGO and self._blockClickMaskGO.activeSelf and table.nums(self._blockKeys) == 0 then
			goutil.setActive(self._blockClickMaskGO, false)
		end
	end
end

function ViewBlockMgr:cancelAll()
	self._blockKeys = {}

	if self._blockClickMaskGO and self._blockClickMaskGO.activeSelf then
		goutil.setActive(self._blockClickMaskGO, false)
	end
end

function ViewBlockMgr:_tryCreateBlockClickMask()
	if self._blockClickMaskGO then
		return
	end

	self._blockClickMaskGO = goutil.create("ViewBlockMask")

	local root = ViewMgr.instance:getRoot(ViewRootType.Top)

	goutil.addChildToParent(self._blockClickMaskGO, root)

	local img = goutil.addComponentOnce(self._blockClickMaskGO, typeof(UnityEngine.UI.Image))

	img.color = parsecolor(self._transparentColor)

	local rect = self._blockClickMaskGO.transform

	rect.anchorMin = UnityEngine.Vector2.zero
	rect.anchorMax = UnityEngine.Vector2.one
	rect.offsetMin = UnityEngine.Vector2.New(-150, -150)
	rect.offsetMax = UnityEngine.Vector2.New(150, 150)
end

ViewBlockMgr.instance = ViewBlockMgr.New()

return ViewBlockMgr
