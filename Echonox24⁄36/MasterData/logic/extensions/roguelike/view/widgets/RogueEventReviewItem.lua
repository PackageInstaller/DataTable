-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueEventReviewItem.lua

module("logic.extensions.roguelike.view.widgets.RogueEventReviewItem", package.seeall)

local M = class("RogueEventReviewItem")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	if self._isInit then
		return
	end

	local go = self._go

	self._goType1 = goutil.findChild(go, "exist/type1")
	self._goType2 = goutil.findChild(go, "exist/type2")
	self._goLineLeft1 = goutil.findChild(go, "exist/type1/line")
	self._goLineLeft2 = goutil.findChild(go, "exist/type2/line")
	self._goLineRight1 = goutil.findChild(go, "exist/type1/Image3")
	self._goLineRight2 = goutil.findChild(go, "exist/type2/Image3")
	self._txtEvent = goutil.findChildTextComponent(go, "exist/type2/txtEvent")
	self._goPre = goutil.findChild(go, "exist/linePoint_Pre")
	self._goNext = goutil.findChild(go, "exist/linePoint_Next")
	self._traNextTop = goutil.findChild(go, "empty/top").transform
	self._traNextMiddle = goutil.findChild(go, "empty/middle").transform
	self._traNextBottom = goutil.findChild(go, "empty/bottom").transform
	self._traNodeParents = {
		self._traNextMiddle,
		self._traNextTop,
		self._traNextBottom
	}
	self._isInit = true
end

function M:setName(eventName)
	self._txtEvent.text = eventName
end

function M:getGoPre()
	return self._goPre
end

function M:getGoNext()
	return self._goNext
end

function M:setLeftLineActive(isActive)
	goutil.setActive(self._isFinish and self._goLineLeft2 or self._goLineLeft1, isActive)
end

function M:setRightLineActive(isActive)
	goutil.setActive(self._goLineRight1, isActive)
	goutil.setActive(self._goLineRight2, isActive)
end

function M:setPreNode(data, node)
	local isFinish = data.isFinish

	self._isFinish = isFinish

	local traPre = node:getGoNext().transform
	local traLine = isFinish and self._goLineLeft2.transform or self._goLineLeft1.transform
	local targetDir = traLine.position - traPre.position
	local angle = Vector3.Angle(traPre.right, targetDir)

	traLine.eulerAngles = Vector3.New(0, 0, angle)

	local dis = Vector2.Distance(traPre.position, traLine.position)
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform

	dis = dis * (1 / rectTransform.localScale.x)

	local size = traLine.sizeDelta

	size.x = dis
	traLine.sizeDelta = size

	goutil.setActive(traLine.gameObject, true)
end

function M:delaySetLine(data, node)
	self._data = data
	self._node = node

	settimer(0.04, self.onSetLineDelay, self, false)
end

function M:onSetLineDelay()
	local go = self._go

	RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent)
	RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent.parent)
	RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent.parent.parent)
	self:setPreNode(self._data, self._node)
end

function M:updateData(data, prefab)
	local isFinish = data.isFinish

	goutil.setActive(self._goType1, not isFinish)
	goutil.setActive(self._goType2, isFinish)

	local child = data.child or {}

	self:setName(data.name)
	self:setRightLineActive(#child ~= 0)

	for k, v in pairs(child) do
		local go = Astral.GameObjectUtil.CloneAndSetParent(prefab, self._traNodeParents[k].transform, nil)
		local item = Astral.LuaComponentContainer.Add(go, RogueEventReviewItem)

		item:updateData(v, prefab)
		goutil.setActive(go, true)
		RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent)
		RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent.parent)
		RectTransformUtils.ForceRebuildLayoutImmediate(go.transform.parent.parent.parent)
		item:delaySetLine(v, self)
	end
end

function M:_onClick()
	if self._callback then
		self._callback()
	end
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
