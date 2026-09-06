-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonSummonedPetView.lua

module("logic.extensions.bonedragon.view.BoneDragonSummonedPetView", package.seeall)

local BoneDragonSummonedPetView = class("BoneDragonSummonedPetView", ViewComponent)

function BoneDragonSummonedPetView:ctor()
	BoneDragonSummonedPetView.super.ctor(self)
end

function BoneDragonSummonedPetView:unbindEvents()
	BoneDragonSummonedPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function BoneDragonSummonedPetView:bindEvents()
	BoneDragonSummonedPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BoneDragonSummonedPetView:buildUI()
	BoneDragonSummonedPetView.super.buildUI(self)

	self._posCell = self:getGo("left/posCell")
	self._posView = self:getGo("left/posView")
	self._btnSure = self:getGo("btnSure")
end

function BoneDragonSummonedPetView:onExit()
	BoneDragonSummonedPetView.super.onExit(self)

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local formationGo = self._formationList[i]

		if table.indexof(self._summonPosList, i) then
			GameUtil.rmClickHandler(formationGo)
		end

		goutil.destroy(formationGo)
	end
end

function BoneDragonSummonedPetView:onEnter()
	BoneDragonSummonedPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._summonPosList = params[3]
	self._formationList = {}
	self._selectPos = self._summonPosList[1]

	self:_initFormation()
	self:_updateFormationUI()
end

function BoneDragonSummonedPetView:_initFormation()
	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local go = goutil.cloneAndSetParent(self._posCell, self._posView.transform, "posCell" .. i)

		GameUtil.SetActive(go, true)
		table.insert(self._formationList, go)
	end

	GameUtil.SetActive(self._posCell, false)
end

function BoneDragonSummonedPetView:_updateFormationUI()
	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		if table.indexof(self._summonPosList, i) then
			local formationGo = self._formationList[i]
			local contentGo = goutil.findChild(formationGo, "content")
			local imgSelect = goutil.findChild(formationGo, "imgSelect")
			local txtPos = goutil.findChild(formationGo, "content/txtPos"):GetComponent(typeof(UIImgNumeralText))

			txtPos:SetNum(i)
			GameUtil.SetActive(imgSelect, self._selectPos == i)
			GameUtil.SetActive(contentGo, true)
			GameUtil.addClickHandler(formationGo, function()
				self._selectPos = i

				self:_updateFormationUI()
			end, self)
		end
	end
end

function BoneDragonSummonedPetView:_onClickBtnSure()
	local petPosList, petMoList = BoneDragonModel.instance:getFormationPosAndMo(self._activityId)

	self._info = BoneDragonModel.instance:getInfo(self._activityId) or {}
	self._curInfo = self._info.curInfo or {}

	BoneDragonController.instance:enterBattleClg(self._activityId, self._stageId, petPosList, petMoList, self._selectPos, self._curInfo.pets)
	self:close()
end

return BoneDragonSummonedPetView
