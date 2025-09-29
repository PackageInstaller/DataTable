-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskPointItem2.lua

module("logic.extensions.task.view.TaskPointItem2", package.seeall)

local M = class("TaskPointItem2")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnClick = ButtonAdapter.Get(registry:findUIElement("score_item2_-641361966"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._firstObj = registry:findUIElement("score_item2_-414688740")
	self._dottedline = registry:findUIElement("score_item2_-478713438")
	self._solidline = registry:findUIElement("score_item2_-1926319204")
	self._normalBox = registry:findUIElement("score_item2_-1470748232")
	self._lastBox = registry:findUIElement("score_item2_-342469749")
	self._canGetRewardObj = registry:findUIElement("score_item2_-2106500621")
	self._imgCostIcon = registry:findUIElement("score_item2_-1009381567", UIComponentType.Image)
	self._txtCostNum = registry:findUIElement("score_item2_-1582520247", UIComponentType.Text)
	self._imgCostIcon2 = registry:findUIElement("score_item2_-1813757059", UIComponentType.Image)
	self._txtCostNum2 = registry:findUIElement("score_item2_-906141530", UIComponentType.Text)
	self._finishObj = registry:findUIElement("score_item2_-821063097")
end

function M:_clickSelf()
	ViewMgr.instance:open(ViewName.RewardPreview, {
		self._data:getRewardId()
	}, self._data:getFinish())
end

function M:setCellData(data, index, islast)
	goutil.setActive(self._normalBox, not islast)
	goutil.setActive(self._lastBox, islast)
	goutil.setActive(self._firstObj, index == 1)

	self._curIndex = index
	self._data = data
	self._txtCostNum.text = data:getNeedPoint()
	self._txtCostNum2.text = data:getNeedPoint()

	if not data:getFinish() then
		goutil.setActive(self._canGetRewardObj, data:canGetReward())
		goutil.setActive(self._finishObj, false)
		goutil.setActive(self._imgCostIcon.gameObject, true)
		goutil.setActive(self._txtCostNum.gameObject, true)
		goutil.setActive(self._dottedline, not data:canGetReward())
		goutil.setActive(self._solidline, data:canGetReward())
	else
		goutil.setActive(self._dottedline, false)
		goutil.setActive(self._solidline, true)
		goutil.setActive(self._imgCostIcon.gameObject, false)
		goutil.setActive(self._txtCostNum.gameObject, false)
		goutil.setActive(self._canGetRewardObj, false)
		goutil.setActive(self._finishObj, true)
	end

	if index == 1 then
		goutil.setActive(self._dottedline, false)
		goutil.setActive(self._solidline, false)
	end
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._imgCostIcon = nil
	self._txtCostNum = nil
	self._canGetRewardObj = nil
	self._finishObj = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
