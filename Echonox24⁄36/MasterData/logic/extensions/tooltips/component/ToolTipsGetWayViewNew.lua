-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsGetWayViewNew.lua

module("logic.extensions.tooltips.component.ToolTipsGetWayViewNew", package.seeall)

local M = class("ToolTipsGetWayViewNew")
local SystemOpenState = CommEnum.SystemOpenState
local DisableView = {
	ViewName.GainItemView,
	ViewName.ItemConvert,
	ViewName.BattleCalculateNew,
	ViewName.BackpackRecycleView,
	ViewName.BattleMain
}

function M:ctor(container)
	self._go = container.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._canvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
	self._btnGetJump = UIComponentType.ButtonAdapter(self._go)

	self._btnGetJump:AddClickListener(self._dealJump, self)

	self._goSign = goutil.findChild(self._go, "com_label")

	local registry = self._viewElementsRegistry

	self._getWayDesc = registry:findUIElement("path_get_item_-283171413", UIComponentType.Text)
	self._goSign1 = registry:findUIElement("0&com_label_787295976")
	self._txtSign1 = registry:findUIElement("0&com_label_-1513538352", UIComponentType.Text)
	self._goSign2 = registry:findUIElement("0&com_label_1181881388")
	self._txtSign2 = registry:findUIElement("0&com_label_1979641530", UIComponentType.Text)
end

function M:_dealJump()
	if self._state == SystemOpenState.OpenState and not self._disable then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(self._jumpId)

		if jumpInfo and jumpInfo.viewName == ViewName.CharacterMainSystemViewNew then
			local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
			local moList = _tmpHeroList:getMoList()
			local herodata = moList[1]

			HeroDepotModel.instance:setViewPageMo({
				index = 1,
				hero = herodata,
				list = {
					herodata
				}
			})
		end

		local paramsTable = self._jumpParamsTable or {}

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._jumpId, unpack(paramsTable))
	else
		if self._isTreasureWays then
			FloatWordMgr.instance:show(lang("tip_jump_backpack_empty"))

			return
		end

		if self._isDisableView then
			FloatWordMgr.instance:show(lang("tip_item_tips_disable_view"))
		else
			FloatWordMgr.instance:show(lang("tip_item_tips_unopen"))
		end
	end
end

function M:setDisable(disable)
	if disable == nil then
		disable = true
	end

	local alpha = disable and 0.2 or 1

	self._disable = disable
	self._canvasGroup.alpha = alpha
end

function M:updateData(data)
	self._state = nil
	self._jumpId = nil
	self._disable = true
	self._isDisableView = false
	self._isTreasureWays = false

	local jumpInfo = data.jumpInfo

	if jumpInfo then
		self._state = data.state
		self._jumpId = jumpInfo.jumpId

		local isOpen = SystemOpenState.OpenState == self._state

		self:setActive(true)
		self:setDisable(not isOpen)
		self:setGetWayDesc(not string.nilorempty(jumpInfo.jumpDesc) and jumpInfo.jumpDesc or "暂无常规获取途径")
		self:_updateProbability(data.getTips)
		self:_handleTreasureWays(jumpInfo)
	else
		self:setActive(false)
	end

	for _, view in pairs(DisableView) do
		if ViewMgr.instance:isOpen(view) then
			self:setDisable(true)

			self._isDisableView = true
		end
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Lottery and self._jumpId == 22000000 then
		self:setDisable(true)

		self._isDisableView = true
	end
end

function M:_handleTreasureWays(jumpInfo)
	if jumpInfo.viewName ~= ViewName.TreasureChooseViewNew then
		return
	end

	local itemId = checknumber(jumpInfo.extValue1)
	local count = ItemModel.instance:getItemCountByItemId(itemId)

	self:setDisable(count < 1)

	self._disable = count < 1
	self._isTreasureWays = true
end

function M:_updateProbability(getTips)
	local data = BackpackOtherConfig.instance:getTipsById(getTips)

	goutil.setActive(self._goSign1, data ~= nil)
	goutil.setActive(self._goSign, data ~= nil)

	if data ~= nil and self._txtSign1 then
		self._txtSign1.text = data.tips
	end
end

function M:setJumpParamsTable(paramsTable)
	self._jumpParamsTable = paramsTable
end

function M:setGetWayDesc(str)
	self._getWayDesc.text = str
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:destroy()
	self._btnGetJump:RemoveClickListener()
end

function M:getColorTextStr(str, color)
	if color then
		return string.format("<color=%s>%s</color>", color, str)
	else
		return str
	end
end

function M:setGetLineVisible(visible)
	return
end

return M
