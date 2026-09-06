-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotterymainView.lua

module("logic.extensions.armorherolottery.view.ArmorherolotterymainView", package.seeall)

local ArmorherolotterymainView = class("ArmorherolotterymainView", ViewComponent)

function ArmorherolotterymainView:ctor()
	ArmorherolotterymainView.super.ctor(self)
end

function ArmorherolotterymainView:unbindEvents()
	ArmorherolotterymainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnRecharge:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function ArmorherolotterymainView:bindEvents()
	ArmorherolotterymainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._btnRecharge:AddClickListener(self._onClickbtnRecharge, self)
	self._btnOneKey:AddClickListener(self._onClickbtnOneKey, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
end

function ArmorherolotterymainView:buildUI()
	ArmorherolotterymainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnRecharge = self:getBtn("node/btnRecharge")
	self._btnOneKey = self:getBtn("node/btnOneKey")
	self._btnTask = self:getBtn("btnTask")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._goCell = self:getGo("node/cell")
	self._goTableview = self:getGo("node/tableview")
	self._clipRect = goutil.findChild(self._goTableview, "Viewport"):GetComponent(goutil.Type_RectTransform)
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtProgress = self:getTxt("node/txtProgress")
	self._txtCharge = self:getTxt("node/txtCharge")
	self._slider = self:getSlider("node/slider")
	self._showcell = self:getGo("node/showcell")
	self._showcellTxtNum = goutil.findChildTextComponent(self._showcell, "txtNum")
	self._showcellItemcon = goutil.findChild(self._showcell, "itemcon")
	self._btnBuy = self:getBtn("btnBuy")
	self._hdGo = self:getGo("btnBuy/hd")
end

function ArmorherolotterymainView:onExit()
	ArmorherolotterymainView.super.onExit(self)
	self._tableview:dispose()
	self:_removeAllEffect()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showcellItemcon)

	self._showId = -1

	RedPointController.instance:unregRedPoint(self._hdGo)
end

function ArmorherolotterymainView:onEnter()
	ArmorherolotterymainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ArmorHeroLotteryInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ArmorHeroLotteryGainPrizeRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ArmorHeroLotteryOneKeyGainPrizeRes, self._updateUI, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ArmorHeroLottery)

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	self._skinId = actCfg.raceId

	ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryInfoReq(self._activityId)
	self:_updateUI()
	self:_updateStaticUI()
	RedPointController.instance:regRedPoint(self._hdGo, 476)
end

function ArmorherolotterymainView:_onClickbtnRecharge()
	UIStateManager.instance:push(ViewName.ArmorherolotterygameView, self._activityId)
end

function ArmorherolotterymainView:_onClickbtnOneKey()
	local info = ArmorherolotteryModel.instance:getInfo(self._activityId)
	local prizeCfgs = ArmorherolotteryConfig.instance:getPrizeCfgs(self._activityId)
	local hasPrize = false

	for i, v in ipairs(prizeCfgs) do
		if not ArmorherolotteryModel.instance:isGetedReward(self._activityId, v.prizeId) and info.score >= v.needScore then
			hasPrize = true

			break
		end
	end

	if not hasPrize then
		FloatWordMgr.instance:show("暂无奖励可领取")

		return
	end

	ArmorHeroLotteryAgent:sendPM_ArmorHeroLotteryOneKeyGainPrizeReq(self._activityId)
end

function ArmorherolotterymainView:_onClickbtnTask()
	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	GotoMgr.gotoByString(actCfg.taskJump)
end

function ArmorherolotterymainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("armor_hero_lottery_rule")
end

function ArmorherolotterymainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self:_getRaceId())

	PetbookController.instance:previewBattle(petSkinCfg.raceId, self:_getRaceId())
end

function ArmorherolotterymainView:_onClickbtnInfo()
	GlobalDispatcher:dispatch(PetbookController.NotifyName_HandBookHandBookOpenSkinView, {
		self:_getRaceId()
	})
end

function ArmorherolotterymainView:_getRaceId()
	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	return actCfg.raceId
end

function ArmorherolotterymainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self._skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function ArmorherolotterymainView:_updateUI()
	self._info = ArmorherolotteryModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	self._curScore = self._info.score
	self._prizeCfgs = ArmorherolotteryConfig.instance:getPrizeCfgs(self._activityId)

	self._tableview:reloadData(self._prizeCfgs)
	self:_refreshProgressInfo()
end

function ArmorherolotterymainView:_refreshProgressInfo()
	local nextCfg

	for _, v in ipairs(self._prizeCfgs) do
		if v.needScore > self._curScore then
			nextCfg = v

			break
		end
	end

	if nextCfg then
		self._txtProgress.text = langPara("%s/%s", self._curScore, nextCfg.needScore)

		self._slider:SetValue(checknumber(self._curScore) / checknumber(nextCfg.needScore))
	else
		self._txtProgress.text = langPara("%s/%s", self._curScore, self._prizeCfgs[#self._prizeCfgs].needScore)

		self._slider:SetValue(1)
	end

	self._txtCharge.text = langPara("<color=#7afb80>%s</color>", self._curScore)
end

function ArmorherolotterymainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local proxyArr = MaterialMgr.setCellListByCfg(data.prize, cell.itemcon)

	cell.txtNum.text = data.needScore

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, data))

	local isGain = ArmorherolotteryModel.instance:isGetedReward(self._activityId, data.prizeId)

	if self._curScore >= data.needScore and not isGain then
		goutil.setActive(cell.btn, true)
		goutil.setActive(cell.eff, true)

		for i = 1, #proxyArr do
			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effcon, cell.go, true, self._clipRect, i)
		end
	else
		goutil.setActive(cell.mark, isGain)
	end

	self:_refreshShowCell(self._tableview._tableview:GetCurrentIndex() + 1)
end

function ArmorherolotterymainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.itemcon = goutil.findChild(cell.go, "itemcon")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.eff = goutil.findChild(cell.go, "eff")
	cell.effcon = goutil.findChild(cell.go, "effcon")
	cell.mark = goutil.findChild(cell.go, "mark")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.btn, false)
	goutil.setActive(cell.eff, false)
	goutil.setActive(cell.mark, false)
	MaterialMgr.resetAll(cell.itemcon)
	self:_removeEffect(cell.go)

	return cell
end

function ArmorherolotterymainView:_refreshShowCell(dataId)
	if self._prizeCfgs[dataId] then
		if self._showId ~= self._prizeCfgs[dataId] then
			self._showId = self._prizeCfgs[dataId]

			local data = self._prizeCfgs[self._showId]

			if data then
				MaterialMgr.resetAll(self._showcellItemcon)
				MaterialMgr.setCellListByCfg(data.prize, self._showcellItemcon)

				self._showcellTxtNum.text = data.needScore

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function ArmorherolotterymainView:_createEff(effPath, effParent, effKey, isLoop, clipRect, id)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	self:_removeEffect(key)

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end
	end)

	self._exictEffs[effKey] = self._exictEffs[effKey] or {}

	if id then
		self._exictEffs[effKey][id] = newEff
	else
		self._exictEffs[effKey][1] = newEff
	end
end

function ArmorherolotterymainView:_removeAllEffect()
	if self._exictEffs then
		for k, eff in pairs(self._exictEffs) do
			self:_removeEffect(k)
		end

		self._exictEffs = nil
	end
end

function ArmorherolotterymainView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			for _, eff in pairs(self._exictEffs) do
				UIEffectManager.instance:stopEffect(eff)
			end

			self._exictEffs[key] = nil
		end
	end
end

function ArmorherolotterymainView:_onClickGainPrize(data)
	ArmorHeroLotteryAgent.instance:sendPM_ArmorHeroLotteryGainPrizeReq(self._activityId, data.prizeId)
end

function ArmorherolotterymainView:_onClickbtnBuy()
	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	GotoMgr.gotoByString(actCfg.shopJump)
end

return ArmorherolotterymainView
