-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualDetailItem.lua

module("logic.extensions.controlaction.view.manual.ManualDetailItem", package.seeall)

local M = class("ManualDetailItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._imgDoingGo = goutil.findChild(self._mainGo, "imgDoing")
	self._imgDoneGo = goutil.findChild(self._mainGo, "imgDone")
	self._imgReceiveGo = goutil.findChild(self._mainGo, "imgReceive")
	self._doneGo = goutil.findChild(self._mainGo, "done")
	self._txtNum1 = goutil.findChildTextComponent(self._mainGo, "Image2/txtNum1")
	self._txtNum2 = goutil.findChildTextComponent(self._mainGo, "Image2/txtNum2")
	self._txtContent = goutil.findChildTextComponent(self._mainGo, "txtContent")
	self._txtProgress = goutil.findChildTextComponent(self._mainGo, "txtContent/Image1/txtNum")
	self._imgContent = goutil.findChildImageComponent(self._mainGo, "txtContent/Image1")
	self._itemGo = goutil.findChild(self._mainGo, "backpack_item")
	self._canvasGroup = goutil.addComponentOnce(self._itemGo, ComponentType.CanvasGroup)
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, ItemCell)
	self._itemClickGo = goutil.findChild(self._mainGo, "itemClick")
	self._btnGet = Astral.ButtonAdapter.Get(self._itemClickGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function M:_unbindEvents()
	self._btnGet:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:_onClickGet()
	local taskId = self._mo:getTaskId()

	printWarn("======taskId=====", taskId)

	if not self._mo:getIsFinish() and self._mo:canGetReward() then
		ControlActionAgent.instance:sendGetTaskRewardRequest(taskId)
	end
end

function M:refresh(taskMo, index)
	self._mo = taskMo

	local strIndex = index

	if index < 10 then
		strIndex = string.format("0%s", index)
	end

	self._txtNum1.text = strIndex
	self._txtNum2.text = strIndex
	self._txtContent.text = self._mo:getShowDesc()
	self._txtProgress.text = string.format("%s/%s", self._mo:getCurCount(), self._mo:getMaxCount())

	goutil.setActive(self._imgDoingGo, not self._mo:canGetReward())
	goutil.setActive(self._imgReceiveGo, self._mo:canGetReward() and not self._mo:getIsFinish())
	goutil.setActive(self._imgDoneGo, self._mo:getIsFinish())
	goutil.setActive(self._doneGo, self._mo:getIsFinish())
	goutil.setActive(self._itemClickGo, self._mo:canGetReward() and not self._mo:getIsFinish())

	self._canvasGroup.alpha = self._mo:getIsFinish() and 0.6 or 1

	if self._mo:getIsFinish() then
		local color = self._txtNum2.color

		color.a = 0.2
		self._txtNum2.color = color
		color = self._txtNum1.color
		color.a = 0.02
		self._txtNum1.color = color
		color = self._txtContent.color
		color.a = 0.2
		self._txtContent.color = color
		color = self._txtProgress.color
		color.a = 0.8
		self._txtProgress.color = color
		color = self._imgContent.color
		color.a = 0.2
		self._imgContent.color = color
	end

	if self._mo:canGetReward() and not self._mo:getIsFinish() then
		self._itemCell:setIsShowTips(false)
	else
		self._itemCell:setIsShowTips(true)
	end

	local rewardList = self._mo:getRewardList()
	local len = #rewardList

	for i = 1, 2 do
		if i <= len then
			self._itemCell:setShowSelectedEffect(false)
			self._itemCell:updateData(ItemUtil.createItemData({
				itemId = rewardList[i].itemId,
				count = rewardList[i].num
			}))
		end
	end
end

return M
