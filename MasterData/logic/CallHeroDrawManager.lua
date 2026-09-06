-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/CallHeroDrawManager.lua

module("logic.extensions.lottery.view.CallHeroDrawManager", package.seeall)

local CallHeroDrawManager = class("CallHeroDrawManager")

function CallHeroDrawManager:ctor(parent, drawObj, angle, radius)
	self._parentObj = parent
	self._darwObj = drawObj
	self._angle = angle
	self._radius = radius
	self._selectIndex = nil
end

function CallHeroDrawManager:genDrawObj()
	local num = 360 / self._angle * 2

	self._transList = {}
	self._oriPosList = {}

	for i = 1, num do
		local a = (i - 1) * self._angle
		local x = math.sin(math.rad(a)) * self._radius
		local y = math.cos(math.rad(a)) * self._radius
		local pos = Vector3.New(x, y, 0)
		local trans = Framework.GameObjectUtil.AddPrefabChildToParent(self._parentObj, self._darwObj, tostring(i)).transform

		trans.localPosition = pos
		self._oriPosList[#self._oriPosList + 1] = pos
		self._transList[#self._transList + 1] = trans

		goutil.setActive(trans.gameObject, true)

		if i > num / 2 then
			trans:GetComponent(typeof(UnityEngine.UI.Graphic)).raycastTarget = false
		end
	end
end

function CallHeroDrawManager:dispatchPos(vec)
	local l = #self._transList / 2

	for i = 1, l do
		local index = i - 1 + self._selectIndex

		if l < index then
			index = index - l
		end

		if index ~= self._selectIndex then
			local oriTrans = self._transList[index]

			oriTrans.localPosition = Quaternion.AngleAxis(-self._angle * (i - 1), Vector3.forward) * vec
			self._transList[index + l].localPosition = self:_getMirrorPoint(oriTrans.localPosition, self._oriPosList[index])
		else
			local oriTrans = self._transList[index]

			self._transList[index + l].localPosition = self:_getMirrorPoint(oriTrans.localPosition, self._oriPosList[index + l])
		end
	end
end

function CallHeroDrawManager:_getMirrorPoint(pos, axis)
	local axis_x = math.floor(math.abs(axis.x))
	local axis_y = math.floor(math.abs(axis.y))

	if axis_x == 0 then
		return Vector3.New(-pos.x, pos.y, 0)
	elseif axis_y == 0 then
		return Vector3.New(pos.x, -pos.y, 0)
	end

	local m = pos.x
	local n = pos.y
	local k = axis.y / axis.x
	local b2 = n + m / k
	local x = 2 * b2 * k / (k * k + 1) - m
	local y = -1 / k * x + (n + m / k)

	return Vector3.New(x, y, 0)
end

function CallHeroDrawManager:setSelectIndex(index)
	if self._selectIndex == nil or index == nil then
		self._selectIndex = index
	end
end

function CallHeroDrawManager:getSelectIndex()
	return self._selectIndex
end

function CallHeroDrawManager:getTranss()
	return self._transList
end

function CallHeroDrawManager:getSeletedTrans()
	if self._transList then
		return self._transList[self._selectIndex]
	end
end

function CallHeroDrawManager:resetPosition()
	for i = 1, #self._oriPosList do
		self._transList[i].localPosition = self._oriPosList[i]
	end
end

function CallHeroDrawManager:onDestroy()
	self._transList = nil
	self._oriPosList = nil
end

function CallHeroDrawManager:destoryObjs()
	for i = 1, #self._transList do
		goutil.destroy(self._transList[i].gameObject)
	end

	self._transList = nil
	self._oriPosList = nil
end

function CallHeroDrawManager:hide()
	for i = 1, #self._transList do
		goutil.setActive(self._transList[i].gameObject, false)
	end
end

function CallHeroDrawManager:show()
	for i = 1, #self._transList do
		goutil.setActive(self._transList[i].gameObject, true)
	end
end

return CallHeroDrawManager
