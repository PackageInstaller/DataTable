-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkShopSelectLevelCell.lua

module("logic.extensions.airworkshop.cell.AirWorkShopSelectLevelCell", package.seeall)

local M = class("AirWorkShopSelectLevelCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._animation = mainGO:GetComponent(ComponentType.Animation)
	self._canvasGroup = goutil.addComponentOnce(mainGO.gameObject, ComponentType.CanvasGroup)
	self._goStateNormal = registry:findUIElement("select_level_item_-1882285223")
	self._goStateEndless = registry:findUIElement("select_level_item_2110406655")
	self._txtStateEndless = registry:findUIElement("select_level_item_-937802365", UIComponentType.Text)
	self._imgStateEndless = registry:findUIElement("select_level_item_2110406655", UIComponentType.Image)
	self._txtScore = registry:findUIElement("select_level_item_-1572880047", UIComponentType.Text)
	self._txtPassRatio = registry:findUIElement("select_level_item_-960705097", UIComponentType.Text)
	self._btnStatistics = UIComponentType.ButtonAdapter(registry:findUIElement("select_level_item_-1251005848"))
	self._goFinishNode = registry:findUIElement("select_level_item_1568283634")
	self._goSelect = registry:findUIElement("select_level_item_205805258")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("select_level_item_-273685468"))
	self._btnCheck = UIComponentType.ButtonAdapter(registry:findUIElement("select_level_item_1884505624"))
	self._btnKeepCheck = UIComponentType.ButtonAdapter(registry:findUIElement("select_level_item_-1833129940"))
	self._btnReviveCheck = UIComponentType.ButtonAdapter(registry:findUIElement("select_level_item_436187096"))
end

function M:destroyUI()
	self:setHandler(nil)
	self:setClickSelfFunction(nil, nil)
	self:setClickCheckFunction(nil, nil)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
	self._btnKeepCheck:AddClickListener(self._onClickKeepCheck, self)
	self._btnReviveCheck:AddClickListener(self._onClickReviveCheck, self)
	self._btnStatistics:AddClickListener(self._onClickStatistics, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
	self._btnKeepCheck:RemoveClickListener()
	self._btnReviveCheck:RemoveClickListener()
	self._btnStatistics:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:getMapId()
	return self._mapId
end

function M:_onClickSelf()
	if self._clickSelfFunc then
		local mapId = self:getMapId()

		if self._clickSelfFuncHandler then
			self._clickSelfFunc(self._clickSelfFuncHandler, mapId)
		else
			self._clickSelfFunc(mapId)
		end
	end
end

function M:_onClickCheck()
	if self._clickCheckFunc then
		local mapId = self:getMapId()

		if self._clickCheckFuncHandler then
			self._clickCheckFunc(self._clickCheckFuncHandler, mapId)
		else
			self._clickCheckFunc(mapId)
		end
	end
end

function M:_onClickKeepCheck()
	self:_onClickCheck()
end

function M:_onClickReviveCheck()
	self:_onClickCheck()
end

function M:_onClickStatistics()
	if self._mapId then
		local params = {}

		params.mapId = self._mapId
		params.showTabCount = 1

		ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
	end
end

function M:setActive(active)
	goutil.setActive(self:getMainGo(), active)
end

function M:setSelect(select)
	goutil.setActive(self._goSelect, select)
end

function M:setBtnCheckStatus(btnStatus)
	goutil.setActive(self._btnCheck.gameObject, btnStatus == AirWorkShopEnum.BtnStatus.Check)
	goutil.setActive(self._btnKeepCheck.gameObject, btnStatus == AirWorkShopEnum.BtnStatus.ContinueCheck)
	goutil.setActive(self._btnReviveCheck.gameObject, btnStatus == AirWorkShopEnum.BtnStatus.ReviveCheck)
end

function M:setStateNormal(airPlayType)
	local activeCount = 1

	if airPlayType == AirAtkExtension_pb.AirPlayType.FREE1 then
		activeCount = 1
	elseif airPlayType == AirAtkExtension_pb.AirPlayType.FREE2 then
		activeCount = 2
	elseif airPlayType == AirAtkExtension_pb.AirPlayType.FREE3 then
		activeCount = 3
	elseif airPlayType == AirAtkExtension_pb.AirPlayType.FREE4 then
		activeCount = 4
	end

	local tr = self._goStateNormal.transform

	for i = 0, tr.childCount - 1 do
		local go = tr:GetChild(i).gameObject

		goutil.setActive(go, i + 1 == activeCount)
	end

	goutil.setActive(self._goStateNormal, true)
	goutil.setActive(self._goStateEndless, false)
end

function M:setStateEndless(endlessText)
	goutil.setActive(self._goStateNormal, false)
	goutil.setActive(self._goStateEndless, true)

	self._txtStateEndless.text = endlessText
end

function M:setClickSelfFunction(fun, handler)
	self._clickSelfFunc = fun
	self._clickSelfFuncHandler = handler
end

function M:setClickCheckFunction(fun, handler)
	self._clickCheckFunc = fun
	self._clickCheckFuncHandler = handler
end

function M:playOpenAni()
	self._animation:Stop()
	self._animation:Play("select_level_item_open")
end

function M:updateData(levelNO)
	local mapId
	local point = 0
	local passRatio = 0

	if levelNO then
		mapId = levelNO.mapId
		point = levelNO.point
		passRatio = levelNO.passRate
	end

	self._mapId = mapId
	self._txtScore.text = string.format("%s%s", point, AirWorkShopEnum.RodeoScoreSuffix)
	self._txtPassRatio.text = string.format("%s%%", AirWorkShopUtil.formatPassRatio(passRatio * 100, 1))
end

function M:setIsFinished(finished)
	goutil.setActive(self._goFinishNode, finished)
	self:setSelect(not finished)

	self._canvasGroup.alpha = finished and 0.5 or 1

	if finished then
		local grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)

		self._imgStateEndless.material = grayMat
	else
		self._imgStateEndless.material = nil
	end
end

return M
