-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkShopAmbushSetView.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkShopAmbushSetView", package.seeall)

local M = class("AirWorkShopAmbushSetView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("title_view/layout/btnReturn_1")

	local goCondition = self:getGoByPath("objLeft/conditionGo")
	local goTime = self:getGoByPath("objLeft/timingGo")

	goutil.setActive(goCondition, false)
	goutil.setActive(goTime, false)

	self._txtPos = self:getTextByPath("objLeft/txtCoordinate")
	self._txtCondition = goutil.findChildComponent(self.mainGO, "objLeft/messageContent/txtMessage", typeof(TMPro.TMP_Text))
	self._headIconGo = self:getGoByPath("objLeft/hero_item")
	self._rightPanelGo = self:getGoByPath("objRight")
	self._heroItem = AirHeroItem.New(self._headIconGo)
	self._resLoader = PrefabLoader.Get(self.mainGO)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:destroyUI()
	self._heroItem:destroyUI()
end

function M:_onClickClose()
	self:close()
end

function M:onEnter()
	self:_init()
	self:_updateView()
	self._resLoader:load(ResName.AirWorkShop_air_workshop_def_set_ambush_times, self._onResourceLoaded, self)
end

function M:onExit()
	if self._conditionView then
		self._conditionView:destroyUI()
	end

	self._resLoader:clear()
end

function M:_init()
	local unitMO = self:getFirstParam()

	self._unitMO = unitMO

	if unitMO:getUnitType() == AirWorkShopEnum.UnitType.Hero then
		self._condition = 1001
		self._params = 1
	else
		self._condition = self._unitMO:getCondition()
		self._params = self._unitMO:getParams()
	end
end

function M:_updateView()
	self:_updateHeadIcon()
end

function M:_onResourceLoaded(resource)
	self._conditionPanelGo = resource:getInst()

	goutil.addChildToParent(self._conditionPanelGo, self._rightPanelGo)

	self._conditionView = AirAmbushConditionSelect.New(self._conditionPanelGo)

	self._conditionView:setHandler(self)
	self._conditionView:setHeroMO(self._unitMO)
	self._conditionView:setSelectCondition(self._condition, self._params)
end

function M:_updateHeadIcon()
	local id = self._unitMO:getId()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(id)

	self._heroItem:setHeroMO(heroData)

	local x, y = self._unitMO:getPosition()

	self._txtPos.text = string.format(lang("tip_airwork_ambush_position"), x, y)
end

function M:onClickSave(condition, params)
	AirWorkShopDefOperateUtil.changeToAmbush(self._unitMO, condition, params)
	self:close()
end

function M:setDescStr(str)
	self._txtCondition.text = str
end

return M
