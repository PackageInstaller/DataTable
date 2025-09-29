-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/UIAirWorkUnitPropertyInCenter.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.UIAirWorkUnitPropertyInCenter", package.seeall)

local M = class("UIAirWorkUnitPropertyInCenter", IBattleReusable)
local kNameBarRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
local kName = "UIAirWorkUnitPropertyInCenter"

function M:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function M:ctor()
	self.rootGO = goutil.create(kName, true)

	goutil.addChildToParent(self.rootGO, kNameBarRoot)

	self._priorityEnableMgr = GameObjectsEnableByPriority.New()
	self.mainGO = false
	self._url = false
end

function M:reuse()
	goutil.setActive(self.rootGO, true)
end

function M:reset()
	self._unit = false

	goutil.setActive(self.rootGO, false)
end

function M:destroy()
	self:_clearResource()

	self._url = false

	if self.rootGO then
		goutil.destroy(self.rootGO)

		self.rootGO = false
	end
end

function M:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function M:buidUI()
	self._goAmbushSign = goutil.findChild(self.mainGO, "top/imgAmbush")
	self._goMessageSign = goutil.findChild(self.mainGO, "top/imgMessage")
	self._goSignPanel = goutil.findChild(self.mainGO, "top")
	self._uselessPanelGo = goutil.findChild(self.mainGO, "operator/useless")
	self._operatorPanelGo = goutil.findChild(self.mainGO, "operator")
	self._btnRemove = Astral.ButtonAdapter.GetFrom(self.mainGO, "operator/left/btnRCancel")
	self._countPanelList = {
		goutil.findChild(self.mainGO, "operator/right/count1"),
		goutil.findChild(self.mainGO, "operator/right/count2"),
		goutil.findChild(self.mainGO, "operator/right/count3")
	}
	self._count1holeList = {
		goutil.findChild(self.mainGO, "operator/right/count1/pos1")
	}
	self._count2holeList = {
		goutil.findChild(self.mainGO, "operator/right/count2/pos2_1"),
		goutil.findChild(self.mainGO, "operator/right/count2/pos2_2")
	}
	self._count3holeList = {
		goutil.findChild(self.mainGO, "operator/right/count3/pos3_1"),
		goutil.findChild(self.mainGO, "operator/right/count3/pos3_2"),
		goutil.findChild(self.mainGO, "operator/right/count3/pos3_3")
	}
	self._countHoleList = {
		self._count1holeList,
		self._count2holeList,
		self._count3holeList
	}
	self._btnAmbush = Astral.ButtonAdapter.GetFrom(self.mainGO, "operator/useless/btnAmbush")
	self._btnDefend = Astral.ButtonAdapter.GetFrom(self.mainGO, "operator/useless/btnDefense")
	self._btnSetting = Astral.ButtonAdapter.GetFrom(self.mainGO, "operator/useless/btnSetting")
	self._btnMessage = Astral.ButtonAdapter.GetFrom(self.mainGO, "operator/useless/btnMessage")

	self._btnRemove:AddClickListener(self._onClickRemove, self)
	self._btnAmbush:AddClickListener(self._onClickAmbush, self)
	self._btnDefend:AddClickListener(self._onClickDefend, self)
	self._btnMessage:AddClickListener(self._onClickMessage, self)
	self:_initUIState()
	self:_refreshState()
end

function M:_initUIState()
	goutil.setActive(self._goSignPanel, false)
	goutil.setActive(self._goMessageSign, false)
	goutil.setActive(self._goAmbushSign, false)
	goutil.addChildToParent(self._btnAmbush.gameObject, self._uselessPanelGo)
	goutil.addChildToParent(self._btnDefend.gameObject, self._uselessPanelGo)
	goutil.addChildToParent(self._btnSetting.gameObject, self._uselessPanelGo)
	goutil.addChildToParent(self._btnMessage.gameObject, self._uselessPanelGo)
	self:setOperatorVisible(false)
end

function M:destroyUI()
	self._btnRemove:RemoveClickListener()
	self._btnAmbush:RemoveClickListener()
	self._btnDefend:RemoveClickListener()
	self._btnMessage:RemoveClickListener()
end

function M:setUrl(url)
	if self._url == url then
		self:_initUIState()

		return
	end

	self:_clearResource()

	local resMgr = AirWorkShopDefMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(url)

	goutil.addChildToParent(mainGO, self.rootGO)

	self._url = url
	self.mainGO = mainGO

	self:buidUI()
end

function M:setUnit(unit)
	self._unit = unit

	self:_refreshState()
	self:_refreshTopSign()
end

function M:_refreshState()
	if not self._unit then
		return
	end

	local tabType = self._unit.property:getTabType()
	local unitType = self._unit.property:getUnitType()
	local holeCount = 0

	if tabType == AirWorkShopEnum.TabEnum.Hero then
		local index = 1

		holeCount = unitType == AirWorkShopEnum.UnitType.Hero and 2 or 3
		self._activeHoleList = self._countHoleList[holeCount]

		self:_addBtnInHole(self._btnAmbush.gameObject, self._activeHoleList[index])

		index = index + 1

		if unitType ~= AirWorkShopEnum.UnitType.Hero then
			self:_addBtnInHole(self._btnDefend.gameObject, self._activeHoleList[index])

			index = index + 1
		end

		self:_addBtnInHole(self._btnMessage.gameObject, self._activeHoleList[index])
	elseif tabType == AirWorkShopEnum.TabEnum.Message then
		holeCount = 1
		self._activeHoleList = self._countHoleList[holeCount]

		self:_addBtnInHole(self._btnMessage.gameObject, self._activeHoleList[1])
	end

	for i, v in ipairs(self._countPanelList) do
		goutil.setActive(v, i == holeCount)
	end
end

function M:_addBtnInHole(btnGo, parentGo)
	goutil.addChildToParent(btnGo, parentGo)
	Astral.TransformUtil.SetLocalPos(btnGo.transform, 0, 0, 0)
end

function M:_refreshTopSign()
	if not self._unit then
		return
	end

	local tabType = self._unit.property:getTabType()
	local unitType = self._unit.property:getUnitType()
	local topCount = 0

	if unitType == AirWorkShopEnum.UnitType.Ambush then
		goutil.setActive(self._goAmbushSign, true)

		topCount = topCount + 1
	else
		goutil.setActive(self._goAmbushSign, false)
	end

	local msg = self._unit.property:getUnitMO():getMsgMO()

	if msg then
		goutil.setActive(self._goMessageSign, true)

		topCount = topCount + 1
	else
		goutil.setActive(self._goMessageSign, false)
	end

	goutil.setActive(self._goSignPanel, topCount > 0)
end

function M:setVisible(status)
	if self.mainGO then
		goutil.setActive(self.mainGO, status)
	end
end

function M:setOperatorVisible(status)
	goutil.setActive(self._operatorPanelGo, status)
end

function M:_onClickRemove()
	AirWorkShopDefOperateUtil.removeUnitWithDoubleCheck(self._unit, true)
end

function M:_onClickAmbush()
	if AirWorkShopDefSceneUtil.canSetAmbush(self._unit.property:getUnitMO()) then
		ViewMgr.instance:open(ViewName.AirWorkShopDefAmbushSetView, self._unit.property:getUnitMO())
	else
		FloatWordMgr.instance:show(lang("tip_airwork_upto_ambush_limit"))
	end
end

function M:_onClickDefend()
	if self._unit.property:getUnitType() == AirWorkShopEnum.UnitType.Hero then
		FloatWordMgr.instance:show(lang("tip_airwork_already_be_defender"))

		return
	end

	if self._unit.property:getUnitType() == AirWorkShopEnum.UnitType.Ambush then
		local info = {}

		info.clickRightCallBackFunc = self._changeAmbushToDefend
		info.clickRightCallBackHandler = self
		info.content = lang("tip_airwork_trans_ambush_hero")
		info.leftTxt = lang("tip_airwork_cancel")
		info.rightTxt = lang("tip_airwork_ensure_2")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
	else
		self:_changeAmbushToDefend()
	end
end

function M:_changeAmbushToDefend()
	AirWorkShopDefOperateUtil.changeToHero(self._unit.property:getUnitMO())
	self:_refreshState()
end

function M:_onClickMessage()
	local tabType = self._unit.property:getTabType()

	ViewMgr.instance:open(ViewName.AirWorkShopDefMessageSetView, self._unit.property:getUnitMO())
end

return M
