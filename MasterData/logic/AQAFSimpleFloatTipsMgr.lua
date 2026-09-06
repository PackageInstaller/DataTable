-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/AQAFSimpleFloatTipsMgr.lua

module("logic.extensions.aoqiattackforce.minigame.AQAFSimpleFloatTipsMgr", package.seeall)

local AQAFSimpleFloatTipsMgr = class("AQAFSimpleFloatTipsMgr")

AQAFSimpleFloatTipsMgr.TYPE_SIMPLE = 1
AQAFSimpleFloatTipsMgr.TYPE_TEXT = 2
AQAFSimpleFloatTipsMgr.TYPE_ENERGY_TEXT = 3
AQAFSimpleFloatTipsMgr.TYPE_MAGIC_TEXT = 4
AQAFSimpleFloatTipsMgr.TYPE_PHYSICS_TEXT = 5
AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT = 6

local floatBaseTime = {
	[AQAFSimpleFloatTipsMgr.TYPE_SIMPLE] = 0.3,
	[AQAFSimpleFloatTipsMgr.TYPE_TEXT] = 0.3,
	[AQAFSimpleFloatTipsMgr.TYPE_ENERGY_TEXT] = 0.3,
	[AQAFSimpleFloatTipsMgr.TYPE_MAGIC_TEXT] = 0.6,
	[AQAFSimpleFloatTipsMgr.TYPE_PHYSICS_TEXT] = 0.6,
	[AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT] = 0.6
}

function AQAFSimpleFloatTipsMgr:ctor()
	self._poolMap = {}
	self._itemMap = {}
	self._index = 0
	self._defaultRootNode = ViewMgr.instance:getRoot(ViewRootType.Top)
	self._v3dList = {}
end

function AQAFSimpleFloatTipsMgr:addItemType(type, item, cls, count)
	item.gameObject:SetActive(false)

	local function createFloatItem()
		local go = goutil.clone(item)

		return (Framework.LuaComponentContainer.Add(go, cls))
	end

	local function destroyFloatItem(obj)
		goutil.destroy(obj.gameObject)
	end

	local function resetFloatItem(obj)
		obj.gameObject:SetActive(false)
		goutil.addChildToParent(obj.gameObject, self._defaultRootNode)
	end

	self._poolMap[type] = ObjectPool.New(count, createFloatItem, destroyFloatItem, resetFloatItem)
end

function AQAFSimpleFloatTipsMgr:flyText(type, content, parent, startX, startY)
	local pool = self._poolMap[type]

	if pool then
		local item = pool:fetchObject()

		goutil.addChildToParent(item.gameObject, parent)
		item.gameObject:SetActive(true)
		item.gameObject.transform:SetAsLastSibling()
		item:setContent(content)
		item:born()
		GameUtil.setLocalPos(item.gameObject, startX, startY, 0)

		self._index = self._index + 1

		local idx = self._index

		self._itemMap[idx] = item

		local startV

		if #self._v3dList > 0 then
			startV = table.remove(self._v3dList)
			startV.x = startX
			startV.y = startY
		else
			startV = Vector3.New(startX, startY, 0)
		end

		local endV

		if #self._v3dList > 0 then
			endV = table.remove(self._v3dList)
			endV.x = startX + math.random(-60, 60)
			endV.y = startY + 60
		else
			endV = Vector3.New(startX + math.random(-60, 60), startY + 60, 0)
		end

		UnityTweens.TweenPosition.StartTween(item.gameObject, startV, endV, (floatBaseTime[type] or 0.3) + 0.3 * math.random(), UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor):AddListener(function()
			pool:returnObject(item)
			table.insert(self._v3dList, startV)
			table.insert(self._v3dList, endV)

			self._itemMap[idx] = nil
		end)
	else
		printError(">>>>>>>>先调用 AQAFSimpleFloatTipsMgr:setItemType 添加自己的item")
	end
end

function AQAFSimpleFloatTipsMgr:clearAll()
	for k, item in pairs(self._itemMap) do
		UnityTweens.TweenPosition.StopTween(item.gameObject)
		goutil.destroy(item.gameObject)
	end

	self._itemMap = {}
end

AQAFSimpleFloatTipsMgr.instance = AQAFSimpleFloatTipsMgr.New()

return AQAFSimpleFloatTipsMgr
