-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonFightEndView.lua

module("logic.extensions.bonedragon.view.BoneDragonFightEndView", package.seeall)

local BoneDragonFightEndView = class("BoneDragonFightEndView", ViewComponent)

function BoneDragonFightEndView:ctor()
	BoneDragonFightEndView.super.ctor(self)
end

function BoneDragonFightEndView:unbindEvents()
	BoneDragonFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function BoneDragonFightEndView:bindEvents()
	BoneDragonFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BoneDragonFightEndView:buildUI()
	BoneDragonFightEndView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._itemCell = self:getGo("itemCol/itemCell")
	self._itemView = self:getGo("itemCol/itemView")
	self._scrollList = ScrollerList.create(self._itemView, self._itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BoneDragonFightEndView:onExit()
	BoneDragonFightEndView.super.onExit(self)
end

function BoneDragonFightEndView:onEnter()
	BoneDragonFightEndView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgConfirmRes, self._onConfirmRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._petList = params[2]

	self._scrollList:reloadData(self._petList)
end

function BoneDragonFightEndView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local btnPet = goutil.findChild(cell, "btnPet")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local bagPetMo = BagPetsController.instance:getPet(data.petId)

	if bagPetMo then
		MaterialMgr.setCell(MatType.Pet, bagPetMo.curFaceId, item)

		local hp = math.ceil(data.leftHp / bagPetMo._maxHp * 10000) / 100

		hp = math.min(hp, 100)
		txtNum.text = string.format("<color=#%s>%d%%</color>", (data.leftHp == 0 or nil) and "F75820FF", hp)
	else
		local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(data.petId)
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportPetCfg)

		local petMo = fmo:toBaseBagPetMo()

		bagPetMo = petMo

		petMo:setSupportedPet(true)
		MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

		local hp = math.ceil(data.leftHp / petMo._maxHp * 10000) / 100

		hp = math.min(hp, 100)
		txtNum.text = string.format("<color=#%s>%d%%</color>", (data.leftHp == 0 or nil) and "F75820FF", hp)
	end

	GameUtil.addClickHandler(btnPet, function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end, self)
end

function BoneDragonFightEndView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnPet = goutil.findChild(cell, "btnPet")

	GameUtil.rmClickHandler(btnPet)
	MaterialMgr.resetAll(item)
end

function BoneDragonFightEndView:_onClickBtnSure()
	BoneDragonController.instance:sendPM_BoneDragonClgConfirmReq(self._activityId, true)
end

function BoneDragonFightEndView:_onClickBtnCancel()
	BoneDragonController.instance:sendPM_BoneDragonClgConfirmReq(self._activityId, false)
end

function BoneDragonFightEndView:_onConfirmRes()
	BattleController.instance:endBattle()
	self:close()
end

return BoneDragonFightEndView
