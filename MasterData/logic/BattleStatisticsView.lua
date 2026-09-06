-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleStatisticsView.lua

module("logic.extensions.battlesettlement.view.BattleStatisticsView", package.seeall)

local BattleStatisticsView = class("BattleStatisticsView", ViewComponent)

function BattleStatisticsView:buildUI()
	self._playerTableview = self:getGo("player/tableview"):GetComponent(ComponentType.UITableview)
	self._enemyTableview = self:getGo("enemy/tableview"):GetComponent(ComponentType.UITableview)
	self._playerTableCell = self:getGo("player/cell")
	self._enemyTableCell = self:getGo("enemy/cell")

	self._playerTableCell:SetActive(false)
	self._enemyTableCell:SetActive(false)

	self._btnClose = self:getBtn("btnClose")
end

function BattleStatisticsView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._playerTableview:RegisterCallback(self._numCellsInStaticsView, self._cellSizeFormStaticsView, self._cellAtStaticsView, self)
	self._enemyTableview:RegisterCallback(self._numCellsInStaticsView, self._cellSizeFormStaticsView, self._cellAtStaticsView, self)
end

function BattleStatisticsView:unbindEvents()
	self._playerTableview:UnRegisterAllCallbacks()
	self._enemyTableview:UnRegisterAllCallbacks()
	self._btnClose:RemoveClickListener()
end

function BattleStatisticsView:onEnter()
	BattleStatisticsView.super.onEnter(self)

	local myTeamId = BattleModel.instance:getLeftTeamId()
	local enemyId = BattleModel.instance:getRightTeamId()

	self._playTotalDamage = BattleStatisticsDataModel.instance:getTotalDamage(myTeamId)
	self._playTotalDefDamage = BattleStatisticsDataModel.instance:getTotalDefDamage(myTeamId)
	self._playTotalTreatment = BattleStatisticsDataModel.instance:getTotalTreatment(myTeamId)
	self._enemyTotalDamage = BattleStatisticsDataModel.instance:getTotalDamage(enemyId)
	self._enemyTotalDefDamage = BattleStatisticsDataModel.instance:getTotalDefDamage(enemyId)
	self._enemyTotalTreatment = BattleStatisticsDataModel.instance:getTotalTreatment(enemyId)
	self._playerDatas = BattleStatisticsDataModel.instance:getStatistics(myTeamId)
	self._enemyDatas = BattleStatisticsDataModel.instance:getStatistics(enemyId)

	self:_prepareStatics(myTeamId)
	self:_prepareStatics(enemyId)
	self._playerTableview:SetOffsetWithoutRefresh(0)
	self._enemyTableview:SetOffsetWithoutRefresh(0)
	self._playerTableview:ReloadData()
	self._enemyTableview:ReloadData()
end

function BattleStatisticsView:onExit()
	self._playTotalDamage = nil
	self._playTotalDefDamage = nil
	self._playTotalTreatment = nil
	self._enemyTotalDamage = nil
	self._enemyTotalDefDamage = nil
	self._enemyTotalTreatment = nil

	self._playerTableview:Travel(self._clearPetCell, self)
	self._enemyTableview:Travel(self._clearPetCell, self)
	BattleStatisticsView.super:onExit(self)
end

function BattleStatisticsView:_prepareStatics(teamId)
	local totalDamage = BattleStatisticsDataModel.instance:getTotalDamage(teamId)
	local totalDefDamage = BattleStatisticsDataModel.instance:getTotalDefDamage(teamId)
	local totalTreatment = BattleStatisticsDataModel.instance:getTotalTreatment(teamId)
	local staticsDatas = BattleStatisticsDataModel.instance:getStatistics(teamId)
	local currDamagePercent = 0
	local currDefDamagePercent = 0
	local currTreatmentPercent = 0

	for i = 1, #staticsDatas do
		staticsDatas[i].damagePercent = math.floor(staticsDatas[i].damage / totalDamage * 100)
		staticsDatas[i].defDamagePercent = math.floor(staticsDatas[i].defentDamage / totalDefDamage * 100)
		staticsDatas[i].treatmentPercent = math.floor(staticsDatas[i].treatment / totalTreatment * 100)
		currDamagePercent = currDamagePercent + staticsDatas[i].damagePercent
		currDefDamagePercent = currDefDamagePercent + staticsDatas[i].defDamagePercent
		currTreatmentPercent = currTreatmentPercent + staticsDatas[i].treatmentPercent
	end

	local deltaDamagePercent = 100 - currDamagePercent
	local deltaDefDamagePercent = 100 - currDefDamagePercent
	local deltaTreatmentPercent = 100 - currTreatmentPercent

	if deltaDamagePercent ~= 0 then
		for i = 1, #staticsDatas do
			if deltaDamagePercent > 0 then
				if i == #staticsDatas then
					staticsDatas[i].damagePercent = staticsDatas[i].damagePercent + deltaDamagePercent
				elseif staticsDatas[i].damage > 0 then
					staticsDatas[i].damagePercent = staticsDatas[i].damagePercent + 1
					deltaDamagePercent = deltaDamagePercent - 1
				end
			end
		end
	end

	if deltaDefDamagePercent ~= 0 then
		for i = 1, #staticsDatas do
			if deltaDefDamagePercent > 0 then
				if i == #staticsDatas then
					staticsDatas[i].defDamagePercent = staticsDatas[i].defDamagePercent + deltaDefDamagePercent
				elseif staticsDatas[i].defentDamage > 0 then
					staticsDatas[i].defDamagePercent = staticsDatas[i].defDamagePercent + 1
					deltaDefDamagePercent = deltaDefDamagePercent - 1
				end
			end
		end
	end

	if deltaTreatmentPercent ~= 0 then
		for i = 1, #staticsDatas do
			if deltaTreatmentPercent > 0 then
				if i == #staticsDatas then
					staticsDatas[i].treatmentPercent = staticsDatas[i].treatmentPercent + deltaTreatmentPercent
				elseif staticsDatas[i].treatment > 0 then
					staticsDatas[i].treatmentPercent = staticsDatas[i].treatmentPercent + 1
					deltaTreatmentPercent = deltaTreatmentPercent - 1
				end
			end
		end
	end
end

function BattleStatisticsView:_clearPetCell(cell)
	local pet = goutil.findChild(cell.gameObject, "pet")

	MaterialMgr.resetAll(pet)
end

function BattleStatisticsView:_numCellsInStaticsView(view)
	if view == self._playerTableview then
		return (self._playerDatas or nil) and (#self._playerDatas or 0)
	end

	return (self._enemyDatas or nil) and (#self._enemyDatas or 0)
end

function BattleStatisticsView:_cellSizeFormStaticsView(view, idx)
	return 636, 88
end

function BattleStatisticsView:_cellAtStaticsView(view, idx)
	local staticsMo, cell, totalDamage, totalDefDamage, totalTreament

	if view == self._playerTableview then
		staticsMo = self._playerDatas[idx + 1]
		cell = self._playerTableview:DequeueCell() or view:AddChild(self._playerTableCell)
		totalDamage = self._playTotalDamage
		totalDefDamage = self._playTotalDefDamage
		totalTreament = self._playTotalTreatment
	else
		staticsMo = self._enemyDatas[idx + 1]
		cell = self._enemyTableview:DequeueCell() or view:AddChild(self._enemyTableCell)
		totalDamage = self._enemyTotalDamage
		totalDefDamage = self._enemyTotalDefDamage
		totalTreament = self._enemyTotalTreatment
	end

	self:_fillCell(cell.gameObject, staticsMo, totalDamage, totalDefDamage, totalTreament)

	return cell
end

function BattleStatisticsView:_fillCell(gameObject, data, totalDamage, totalDefDamage, totalTreament)
	local pet = goutil.findChild(gameObject, "pet")
	local sliderDamage = Framework.SliderAdapter.GetFrom(gameObject, "damage/slider")
	local txtDamage = goutil.findChildTextComponent(gameObject, "damage/txtDamage")
	local txtDamageRate = goutil.findChildTextComponent(gameObject, "damage/txtDamageRate")
	local sliderDefDamage = Framework.SliderAdapter.GetFrom(gameObject, "bearinjury/slider")
	local txtDefDamage = goutil.findChildTextComponent(gameObject, "bearinjury/txtbearinjury")
	local txtDefDamageRate = goutil.findChildTextComponent(gameObject, "bearinjury/txtBearinjuryRate")
	local sliderTreatment = Framework.SliderAdapter.GetFrom(gameObject, "treatment/slider")
	local txtTreatment = goutil.findChildTextComponent(gameObject, "treatment/txttreatment")
	local txtTreatmentRate = goutil.findChildTextComponent(gameObject, "treatment/txtTreatmentRate")
	local damageRate = data.damagePercent / 100
	local damageDefRate = data.defDamagePercent / 100
	local treatmentRate = data.treatmentPercent / 100

	txtDamage.text = tostring(math.abs(data.damage))
	txtDefDamage.text = tostring(math.abs(data.defentDamage))
	txtTreatment.text = tostring(data.treatment)
	txtDamageRate.text = tostring(data.damagePercent) .. "%"
	txtDefDamageRate.text = tostring(data.defDamagePercent) .. "%"
	txtTreatmentRate.text = tostring(data.treatmentPercent) .. "%"

	sliderDamage:SetValue(damageRate)
	sliderDefDamage:SetValue(damageDefRate)
	sliderTreatment:SetValue(treatmentRate)

	local item = ""

	MaterialMgr.resetAll(pet)

	if data.faceId and data.faceId ~= 0 then
		item = string.format("%s:%s:%s", MatType.Pet, data.faceId, data.petLv)

		local proxy = MaterialMgr.setCellByCfg(item, pet)

		proxy.binder:setAutoTips(false)
	else
		local scene = SceneMgr.instance:getCurScene()
		local unit = scene.unitFactory:getUnit(data.teamId, data.charactorId)

		item = MatType.Pet .. ":" .. unit.attrs:getOriginSkinId() .. ":" .. unit.attrs:getLevel()

		local proxy = MaterialMgr.setCellByCfg(item, pet)

		proxy.binder:setStars(unit.attrs:getAwakenLv())
		proxy.binder:setAutoTips(false)
	end
end

function BattleStatisticsView:_onClickClose()
	ViewMgr.instance:close(self._viewPresentor.viewName)
end

return BattleStatisticsView
