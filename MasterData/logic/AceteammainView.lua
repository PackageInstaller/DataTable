-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteammainView.lua

module("logic.extensions.aceteam.view.AceteammainView", package.seeall)

local AceteammainView = class("AceteammainView", ViewComponent)

function AceteammainView:ctor()
	AceteammainView.super.ctor(self)
end

function AceteammainView:unbindEvents()
	AceteammainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnChangeTeam)
	GameUtil.rmClickHandler(self.btnFight)
	GameUtil.rmClickHandler(self.btnPet)
	GameUtil.rmClickHandler(self.btnForm)
	GameUtil.rmClickHandler(self.btnRank)
	GameUtil.rmClickHandler(self.btnPrize)
	GameUtil.rmClickHandler(self.btnExchange)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnHelp)
end

function AceteammainView:bindEvents()
	AceteammainView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnChangeTeam, self.onClickChangeTeam, self)
	GameUtil.addClickHandler(self.btnFight, self.onClickFight, self)
	GameUtil.addClickHandler(self.btnPet, self.onClickPet, self)
	GameUtil.addClickHandler(self.btnForm, self.onClickForm, self)
	GameUtil.addClickHandler(self.btnRank, self.onClickRank, self)
	GameUtil.addClickHandler(self.btnPrize, self.onClickPrize, self)
	GameUtil.addClickHandler(self.btnExchange, self.onClickExchange, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickInTip, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAddTimes, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
end

function AceteammainView:buildUI()
	AceteammainView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnChangeTeam = self:getGo("btnChangeTeam")
	self.txtChangeTeam = self:getTxt("btnChangeTeam/txt")
	self.btnFight = self:getGo("btnFight")
	self.txtFight = self:getTxt("btnFight/txt")
	self.btnPet = self:getGo("btnPet")
	self.btnForm = self:getGo("btnForm")
	self.btnRank = self:getGo("btnRank")
	self.btnPrize = self:getGo("btnPrize")
	self.btnExchange = self:getGo("btnExchange")
	self.btnHelp = self:getGo("btnHelp")
	self.btnPrizeRed = self:getGo("btnPrize/imgPoint")
	self.btnExchangeRed = self:getGo("btnExchange/imgPoint")
	self.txtTime = self:getTxt("time/txtTime")
	self.exchangeBubble = self:getGo("exchangeBubble")
	self.exchangeBubbleItem = self:getGo("exchangeBubble/item")
	self.exchangeBubbleTxt = self:getTxt("exchangeBubble/txt")
	self.remaining = self:getGo("remaining")
	self.btnAdd = self:getGo("remaining/btnAdd")
	self.txtCount = self:getTxt("remaining/txtCount")
	self.teamInfo = self:getGo("teamInfo")
	self.poster = self:getGo("teamInfo/poster")
	self.cell = self:getGo("teamInfo/cell")
	self.info = self:getGo("teamInfo/info")
	self.btnTip = self:getGo("teamInfo/info/btnTip")

	GameUtil.SetActive(self.btnTip, false)

	self.txtName = self:getTxt("teamInfo/info/txtName")
	self.txtLevel = self:getTxt("teamInfo/info/txtLevel")
	self.txtBadge = self:getTxt("teamInfo/info/txtBadge")
	self.zdlGo = self:getGo("teamInfo/zdl")
	self.imgRecZdl = self:getGo("teamInfo/zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	self._goldBarCon = self:getGo("goldBarCon")
end

function AceteammainView:onExit()
	AceteammainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	removetimer(self._updateCountDownTime, self)
	RedPointController.instance:unregRedPoint(self.btnPrizeRed)
	RedPointController.instance:unregRedPoint(self.btnExchangeRed)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
	uGuiUtil.clearImage(self.poster.gameObject)
end

function AceteammainView:onEnter()
	AceteammainView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self.btnPrizeRed, RedPointModel.ID_ACETEAM_PRIZE)
	RedPointController.instance:regRedPoint(self.btnExchangeRed, RedPointModel.ID_ACETEAM_EXCHANGE)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	AceTeamController.instance:getInfo()

	local btnList = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT),
			showAddCallBack = function()
				AceTeamController.instance:sendAddPointCount()
			end
		},
		{
			showAdd = false,
			id = AceTeamConfig.instance:getCommonValue("MAIN_TOP_ITEM")
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)

	local matcfg = AceTeamConfig.instance:getCommonValue("SHOP_EXPLICIT_ID")

	MaterialMgr.updateItemByStr(self.exchangeBubbleItem, matcfg)

	local t, i, num = MaterialMgr.getMatParams(matcfg)

	self.exchangeBubbleTxt.text = langPara("aceteammainview__14", num)

	local effPath = "fx_ui_2021930/fx_ui_zhengbasai/fx_ui_wodezhandui_zhandui.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_2021930/fx_ui_zhengbasai/fx_ui_anniu_wodezhandui.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.btnFight, 0, 0, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.btnFight.transform)
	self._pmEff2:setScale(1)
	self._pmEff2:setLocalPos(-4, 0, 0)
	self:onRefreshUI()
end

function AceteammainView:onRefreshUI()
	GameUtil.SetActive(self.teamInfo, false)

	local activityId = checknumber(AceTeamModel.instance.activityId)
	local groupId = checknumber(AceTeamModel.instance.teamId)

	self.txtFight.text = AceTeamModel.instance:checkBossExits() and lang("aceteammainview__1") or lang("aceteammainview__2")

	if activityId > 0 then
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AceTeam, activityId)

		self.endTime = endTime

		if groupId > 0 then
			AceTeamController.instance:closeRedPointHud()
			GameUtil.SetActive(self.teamInfo, true)
			self:showGroupPets(activityId, groupId)
		else
			local function selectTeamCallback()
				TipsFacade.instance:openPopupWindow(lang("tip"), lang("aceteammainview__5"), function()
					self:onClickChangeTeam()
				end, function()
					self:close()
				end)
			end

			GameUtil.doCallbackWhenFirst("AceteammainView210923", function()
				UIStateManager.instance:push(ViewName.AceteamruleView, function()
					selectTeamCallback()
				end)
			end, function()
				selectTeamCallback()
			end)
		end

		local configTimes = AceTeamConfig.instance:getCommonValue("DAILY_PVP_FREE_TIMES")
		local allCount = AceTeamModel.instance.buyMatchFightTimes + configTimes

		self.leftTimes = allCount - AceTeamModel.instance.hasMatchFightTimes
		self.txtCount.text = langPara("aceteammainview__11", self.leftTimes, configTimes)

		removetimer(self._updateCountDownTime, self)
		settimer(1, self._updateCountDownTime, self, true)
		self:_updateCountDownTime()
	end
end

function AceteammainView:showGroupPets(activityId, groupId)
	local cfg = AceTeamConfig.instance:getSeasonCfg(activityId)
	local teamCfg = AceTeamConfig.instance:getTeamCfgById(cfg.seasonId, groupId)
	local list = AceTeamConfig.instance:getPetListByGroupId(groupId)

	self.txtName.text = teamCfg.name

	local medalNum = checknumber(AceTeamModel.instance.historyMedal)
	local lvlDesc = AceTeamConfig.instance:getTeamLvlDesc(medalNum)

	self.txtLevel.text = langPara("aceteammainview__6", lvlDesc)
	self.txtBadge.text = langPara("aceteammainview__7", medalNum)

	local zdl, spd = AceTeamModel.instance:getPowerAndSpeed()

	self.imgRecZdl:SetNum(zdl)
	GameUtil.SetActive(self.zdlGo, zdl > 0)

	local imgName = teamCfg.posterUrl

	uGuiUtil.setSpriteToImage(self.poster.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aceteam", imgName))
	goutil.clearChildren(self.poster)

	for i, v in ipairs(list) do
		if checknumber(v.isShowAtPoster) == 1 then
			local cell = goutil.clone(self.cell)

			GameUtil.SetActive(cell, true)
			goutil.addChildToParent(cell, self.poster)

			if not v.pos then
				GameUtil.setAnchoredPos(cell, checknumber(v.pos[1]), checknumber(v.pos[2]))
				GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetCell, self, v))

				local txtName = goutil.findChildTextComponent(cell, "name/txtName")
				local txtPower = goutil.findChildTextComponent(cell, "txtPower")
				local petMo = AceTeamModel.instance:getPetMoByCfgId(v.creepsMasterId, v.creepsId)

				txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)
				txtPower.text = petMo:getFightingPower()
			end
		end
	end
end

function AceteammainView:onClickChangeTeam()
	local activityId = checknumber(AceTeamModel.instance.activityId)

	UIStateManager.instance:push(ViewName.AceteamgroupView, activityId)
end

function AceteammainView:onClickFight()
	if AceTeamModel.instance:isCurFormationEmpty() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("aceteammainview__8"), function()
			self:onClickForm()
		end)
	else
		local starTime = AceTeamConfig.instance:getCommonValue("DAILY_START_TIME")
		local endTime = AceTeamConfig.instance:getCommonValue("DAILY_END_TIME")

		if GameUtil.checkIsInTimePeriod(starTime, endTime, true) then
			local bossId = checknumber(AceTeamModel.instance.bossId)

			if bossId > 0 then
				UIStateManager.instance:push(ViewName.AceteambossView)
			else
				local configTimes = AceTeamConfig.instance:getCommonValue("DAILY_PVP_FREE_TIMES")
				local allCount = AceTeamModel.instance.buyMatchFightTimes + configTimes
				local leftTimes = allCount - AceTeamModel.instance.hasMatchFightTimes

				if leftTimes > 0 then
					AceTeamController.instance:sendGoFight()
				elseif self:checkCanBuy() then
					local curBuyTimes = AceTeamModel.instance.buyMatchFightTimes + 1
					local cfg = AceTeamConfig.instance:getBuyTimeCfg(curBuyTimes)
					local type, id, count = MaterialMgr.getMatParams(cfg.cost)
					local content = langPara("aceteammainview__15", count, MaterialMgr.getMaterialsName(type, id))

					TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
						AceTeamController.instance:sendAceTeamBuyMatchTimes()
					end)
				else
					FloatWordMgr.instance:show(lang("aceteammainview__17"))
				end
			end
		else
			TipsFacade.instance:openCommonTips(lang("aceteammainview__16"))
		end
	end
end

function AceteammainView:onClickPetCell(cfg)
	local petMo = AceTeamModel.instance:getPetMoByCfgId(cfg.creepsMasterId, cfg.creepsId)

	CommonTipsMgr.instance:showPetTips(petMo)
end

function AceteammainView:onClickPet()
	local ID_1 = 3
	local malNum = checknumber(AceTeamModel.instance.historyMedal)
	local cfg = AceTeamConfig.instance:getTeamLvlCfg()

	for i, v in ipairs(cfg) do
		if v.openStrengthenLvUp == ID_1 then
			if malNum >= v.medal then
				UIStateManager.instance:push(ViewName.AceteamshowView)

				break
			end

			FloatWordMgr.instance:show(v.lockTips)

			break
		end
	end
end

function AceteammainView:onClickForm()
	AceTeamModel.instance:resetFormationMo()
	UIStateManager.instance:push(ViewName.AceteamFormationView)
end

function AceteammainView:onClickRank()
	UIStateManager.instance:push(ViewName.AceteamrankView)
end

function AceteammainView:onClickPrize()
	AceTeamController.instance:closeRedPointPrize()
	UIStateManager.instance:push(ViewName.AceteamrewardView)
end

function AceteammainView:onClickExchange()
	AceTeamController.instance:closeRedPointExchange()
	AceTeamController.instance:openExchangeView()
end

function AceteammainView:_updateCountDownTime()
	local time = self.endTime - ServerTime.nowServerLook()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	self.txtTime.text = langPara("aceteammainview__9", day, hour, min, sec)
end

function AceteammainView:checkCanBuy()
	local curBuyTimes = AceTeamModel.instance.buyMatchFightTimes + 1
	local cfg = AceTeamConfig.instance:getBuyTimeCfg(curBuyTimes)

	if cfg then
		return true
	end

	return false
end

function AceteammainView:onClickAddTimes()
	if self.leftTimes > 0 then
		FloatWordMgr.instance:show(lang("aceteammainview__12"))

		return
	end

	local curBuyTimes = AceTeamModel.instance.buyMatchFightTimes + 1
	local cfg = AceTeamConfig.instance:getBuyTimeCfg(curBuyTimes)

	if not cfg then
		FloatWordMgr.instance:show(lang("aceteammainview__13"))

		return
	end

	local type, id, count = MaterialMgr.getMatParams(cfg.cost)
	local content = langPara("aceteammainview__10", count, MaterialMgr.getMaterialsName(type, id))

	TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
		AceTeamController.instance:sendAceTeamBuyMatchTimes()
	end)
end

function AceteammainView:onClickInTip()
	return
end

function AceteammainView:onClickHelp()
	UIStateManager.instance:push(ViewName.AceteamruleView)
end

return AceteammainView
