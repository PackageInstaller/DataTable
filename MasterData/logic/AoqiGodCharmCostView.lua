-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCharmCostView.lua

module("logic.extensions.aoqigod.view.AoqiGodCharmCostView", package.seeall)

local AoqiGodCharmCostView = class("AoqiGodCharmCostView", ViewComponent)
local COST_TYPE_DIAMOND = 1
local COST_TYPE_FLOWER = 2

function AoqiGodCharmCostView:ctor()
	AoqiGodCharmCostView.super.ctor(self)
end

function AoqiGodCharmCostView:unbindEvents()
	AoqiGodCharmCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnDiamond)
	GameUtil.rmClickHandler(self._btnFlower)
	GameUtil.rmClickHandler(self._petInfo)
end

function AoqiGodCharmCostView:bindEvents()
	AoqiGodCharmCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDiamond, self._onClickDiamond, self)
	GameUtil.addClickHandler(self._btnFlower, self._onClickFlower, self)
	GameUtil.addClickHandler(self._petInfo, self._onClickPetInfo, self)
end

function AoqiGodCharmCostView:buildUI()
	AoqiGodCharmCostView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._petInfo = self:getGo("petInfo")
	self._Img_attr = self:getGo("petInfo/cover/layout/Nego_Attr/Img_attr")
	self._attrIcon = self._Img_attr:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtPetName = self:getTxt("petInfo/cover/txtName")
	self._petCon = self:getGo("petInfo/mask/con")
	self._txtEmpty = self:getGo("txtEmpty")
	self._btnDiamond = self:getGo("btnDiamond")
	self._btnFlower = self:getGo("btnFlower")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtCount = self:getTxt("txtCount")
	self._txtTotalCharm = self:getTxt("txtTotalCharm")
end

function AoqiGodCharmCostView:onExit()
	AoqiGodCharmCostView.super.onExit(self)
end

function AoqiGodCharmCostView:onEnter()
	AoqiGodCharmCostView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AoqiGodBuyCharmChange, self._onBuyCharmChange, self)
	self.addGEvent(self, GlobalNotify.AoqiGodSelectFlowerChange, self._onSelectFlowerChange, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._challengeId = checknumber(params[2])
	self._activityCfg = AoqiGodConfig.instance:getActData(self._activityId)

	local challengeCfg = AoqiGodConfig.instance:getClgData(self._activityId, self._challengeId)

	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(challengeCfg.skinId)

	race = race % 10

	local targetValue = race - 1

	if self._attrIcon then
		self._attrIcon:SetState(targetValue)
	end

	local petData = CharacterConfig.instance:getPetCo(challengeCfg.skinId)

	if petData then
		if not petData.name then
			self._txtPetName.text = ""

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(challengeCfg.skinId))

			if not modelCo then
				printError("t_model id not exist:" .. challengeCfg.skinId)

				return
			end

			uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

			self._selectItem = {}
			self._costDiamond = 0

			self:_refreshView()

			self._txtCount.text = langPara("本周剩余发布:%d", self._aoqiGodMo:getLeftCountOfCallerPublicInWeek())
		end
	end
end

function AoqiGodCharmCostView:_refreshView()
	if #self._selectItem == 0 and self._costDiamond <= 0 then
		GameUtil.SetActive(self._txtEmpty, true)
	else
		GameUtil.SetActive(self._txtEmpty, false)
	end

	local list = {}
	local totalCharm = 0

	if self._costDiamond > 0 then
		table.insert(list, {
			type = COST_TYPE_DIAMOND,
			num = self._costDiamond
		})

		totalCharm = self._activityCfg.diamondBuyCharm * self._costDiamond
	end

	for i, v in ipairs(self._selectItem) do
		table.insert(list, {
			type = COST_TYPE_FLOWER,
			id = v.id,
			num = v.num
		})

		local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(v.id)

		totalCharm = totalCharm + flowerCfg.value * v.num
	end

	self._tableList:reloadData(list)

	self._txtTotalCharm.text = langPara("%s/%s", totalCharm, self._activityCfg.charmLimit)
end

function AoqiGodCharmCostView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtCharmNum = goutil.findChildTextComponent(go, "txtCharmNum")
	local btn = goutil.findChild(go, "btn")
	local matType, matId, matNum
	local charmNum = 0

	GameUtil.rmClickHandler(btn)

	if data.type == COST_TYPE_DIAMOND then
		matType = MatType.Diamond
		matId = MatType.Diamond_Binding
		matNum = data.num
		charmNum = data.num * checknumber(self._activityCfg.diamondBuyCharm)

		GameUtil.addClickHandler(btn, self._onClickDiamondCell, self)
	elseif data.type == COST_TYPE_FLOWER then
		local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(data.id)

		matType, matId, matNum = MaterialMgr.getMatParams(flowerCfg.content)
		matNum = matNum * data.num
		charmNum = data.num * flowerCfg.value

		GameUtil.addClickHandler(btn, function()
			self:_onClickFlowerCell(data.id)
		end, self)
	else
		matNum = data.num
		matId = data.id
		matType = data.type
	end

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCell(matType, matId, con)

	if proxy then
		proxy.binder:setNum(matNum)
		proxy.binder:setAutoTips(false)
	end

	txtName.text = MaterialMgr.getMaterialsName(matType, matId)
	txtCharmNum.text = langPara("%d", charmNum)
end

function AoqiGodCharmCostView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function AoqiGodCharmCostView:_onClickSure()
	local challengeCfg = AoqiGodConfig.instance:getClgData(self._activityId, self._challengeId)
	local petData = CharacterConfig.instance:getPetCo(challengeCfg.skinId)

	if petData then
		if not petData.name then
			local petName = ""
			local maxFinishCountInWeek = self._aoqiGodMo:getMaxFinishCountInWeek()
			local tipsContent = string.format("是否确认发起%s的挑战请求\n发起请求后不可撤回与修改,有效期内大神完成挑战即可获得该精灵,每周仅可发布%s次求助。", petName, maxFinishCountInWeek)

			local function okFunc()
				AoqiGodController.instance:sendPM_AoqiGodSeekHelpReq(self._activityId, self._challengeId, self._costDiamond, self._selectItem)
				self:close()
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
		end
	end
end

function AoqiGodCharmCostView:_onClickDiamondCell()
	self._costDiamond = 0

	self:_refreshView()
end

function AoqiGodCharmCostView:_onClickFlowerCell(id)
	local removeIndex = 0

	for i, v in ipairs(self._selectItem) do
		if v.id == id then
			removeIndex = i
		end
	end

	table.remove(self._selectItem, removeIndex)
	self:_refreshView()
end

function AoqiGodCharmCostView:_onClickDiamond()
	local flowerCharm = 0

	for i, v in ipairs(self._selectItem) do
		local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(v.id)

		flowerCharm = flowerCharm + flowerCfg.value * v.num
	end

	UIStateManager.instance:push(ViewName.AoqiGodDiamondCostView, self._activityId, self._costDiamond, flowerCharm)
end

function AoqiGodCharmCostView:_onClickFlower()
	local diamondCharm = self._activityCfg.diamondBuyCharm * self._costDiamond

	UIStateManager.instance:push(ViewName.AoqiGodFlowerCostView, self._activityId, self._selectItem, diamondCharm)
end

function AoqiGodCharmCostView:_onBuyCharmChange(costDiamond)
	self._costDiamond = costDiamond

	self:_refreshView()
end

function AoqiGodCharmCostView:_onSelectFlowerChange(selectItem)
	self._selectItem = selectItem

	self:_refreshView()
end

function AoqiGodCharmCostView:_onClickPetInfo()
	local challengeCfg = AoqiGodConfig.instance:getClgData(self._activityId, self._challengeId)

	CommonTipsMgr.instance:openMaterialTips(self._petInfo, MatType.Pet, challengeCfg.skinId)
end

return AoqiGodCharmCostView
