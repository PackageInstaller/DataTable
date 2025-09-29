-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirAdditionalTerrainInfoView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirAdditionalTerrainInfoView", package.seeall)

local M = class("AirAdditionalTerrainInfoView", ViewComponent)

function M:buildUI()
	self.mainGO = self:getGoByPath("terrainInformation")
	self._invisibleAmount = SignalAmount.New()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtTerrainName")
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "txtRound")
	self._txtTimes = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._goTimes = goutil.findChild(self.mainGO, "time")
	self._goRound = goutil.findChild(self.mainGO, "txtRound")
	self._goItemContent = goutil.findChild(self.mainGO, "content")
	self._goItemTemplate = goutil.findChild(self.mainGO, "content/txt_item")
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)

	goutil.setActive(self._goItemTemplate, false)

	self._itemPool = LocalReusableCollection.New(M.DescriptionItem)
	self._timeWaiter = TimeWaiter.New()
end

function M:destroyUI()
	self._itemPool:clearPool()

	self._itemPool = nil
	self._txtContent = nil
	self._txtRound = nil
	self._txtTimes = nil
	self._goTimes = nil
	self._goRound = nil
	self._goItemContent = nil
	self._goItemTemplate = nil
	self._animation = nil
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	self._invisibleAmount:clear()
	self._timeWaiter:clear()
end

function M:_setEvent(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, self._onTerrainUpdate, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, self._onTerrainUpdate, self)
	end
end

function M:_onTerrainUpdate(_, terrainId)
	self._terrainId = terrainId

	self:_setVisible(terrainId and true or false)
	self:_updateView(terrainId)
end

function M:_setVisible(visible)
	local hasChanged = self._isVisible ~= visible

	self._isVisible = visible

	if hasChanged then
		if visible then
			goutil.setActive(self.mainGO, true)
			self:_doOpenAnimation()
		else
			self:_doCloseAnimation()
		end
	end
end

function M:_doOpenAnimation()
	self._timeWaiter:clear()
	self._animation:Play("terraininformation_open")
end

function M:_doCloseAnimation()
	self._invisibleAmount:addUnique()
	self._timeWaiter:clear()
	self._timeWaiter:start(0.1, self._onWaitFinished, self)
	self._animation:Play("terraininformation_close")
end

function M:_onWaitFinished()
	local isEnable = self._invisibleAmount:isUnactive()

	goutil.setActive(self.mainGO, isEnable)
end

function M:_updateView(terrainId)
	if not terrainId then
		self:_setVisible(false)

		return
	end

	self._itemPool:clearAllInstance()

	local terrainCO = TerrainConfig.instance:getAdditionalTerrainCO(terrainId)

	self._txtName.text = terrainCO.name

	goutil.setActive(self._goRound, false)

	if terrainCO.times > 0 then
		self._txtTimes.text = string.format("可触发%s次", terrainCO.times)

		goutil.setActive(self._goTimes, true)
	else
		goutil.setActive(self._goTimes, false)
	end

	local description = terrainCO.description

	if not string.nilorempty(description) then
		local desList = string.split(description, "\r\n")

		for _, des in ipairs(desList) do
			local item = self._itemPool:createInstance(self._goItemTemplate, self._goItemContent)

			item:setVisible(true)
			item:setContent(ActiveSkillCOUtil.replaceDescriptionSpecialColor(des))
		end
	elseif terrainCO.skillCode > 0 then
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(terrainCO.skillCode)
		local item = self._itemPool:createInstance(self._goItemTemplate, self._goItemContent)

		item:setVisible(true)
		item:setContent(skillCOWrapper:getDescription())
	end
end

M.DescriptionItem = class("ToolTipsBattleAdditionalTerrainView_DescriptionItem", UIReusableLuaBehavior)

function M.DescriptionItem:buildUI()
	self._txtDescription = goutil.addComponentOnce(self.mainGO, UIComponentType.Text)
end

function M.DescriptionItem:destroyUI()
	self._txtDescription = nil
end

function M.DescriptionItem:setContent(content)
	self._txtDescription.text = content
end

function M.DescriptionItem:setVisible(visible)
	goutil.setActive(self.mainGO, true)
end

return M
