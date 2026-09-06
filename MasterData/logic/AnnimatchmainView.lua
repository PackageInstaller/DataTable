-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchmainView.lua

module("logic.extensions.annimatch.view.AnnimatchmainView", package.seeall)

local AnnimatchmainView = class("AnnimatchmainView", ViewComponent)

function AnnimatchmainView:ctor()
	AnnimatchmainView.super.ctor(self)
end

function AnnimatchmainView:unbindEvents()
	AnnimatchmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnForm)
	GameUtil.rmClickHandler(self.btnMatch)
	GameUtil.rmClickHandler(self.btnQuit)
	GameUtil.rmClickHandler(self.btnRewardLook)
	GameUtil.rmClickHandler(self._btnFailSelect)
end

function AnnimatchmainView:bindEvents()
	AnnimatchmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnForm, self.onClickForm, self)
	GameUtil.addClickHandler(self.btnMatch, self.onClickMatch, self)
	GameUtil.addClickHandler(self.btnQuit, self.onClickQuit, self)
	GameUtil.addClickHandler(self.btnRewardLook, self.onClickReward, self)
	GameUtil.addClickHandler(self._btnFailSelect, self.onClickFailSelect, self)
end

function AnnimatchmainView:buildUI()
	AnnimatchmainView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnQuit = self:getGo("btnQuit")
	self.btnForm = self:getGo("btnForm")
	self.btnMatch = self:getGo("btnMatch")
	self.txtMatch = self:getTxt("btnMatch/Text")
	self.formation = self:getGo("formation")
	self._recordPos = self.formation:GetComponent(typeof(TestRecordPos))

	self._recordPos:LoadPlan(1)

	self.txtDesc = self:getTxt("txtDesc")
	self.txtTip = self:getTxt("tip/txtTitle")
	self.txtTitle = self:getTxt("txtTitle")
	self.info = self:getGo("info")
	self.btnRewardLook = self:getGo("info/btnRewardLook")
	self.badge = self:getGo("info/badge")
	self.rewardCon = self:getGo("info/reward/container")
	self.rewardCell = self:getGo("info/reward/itemcell")
	self.winNum = self:getGo("info/winNum/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.lostGoList = {}

	for i = 1, 3 do
		local go = self:getGo("info/failNum/flase_" .. i)

		table.insert(self.lostGoList, go)
	end

	self.goEmpty = self:getGo("godAdd/goEmpty")
	self.cell = self:getGo("godAdd/cell")
	self.tableview = self:getGo("godAdd/tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.txtTitle.text = "竞技大赛"
	self._btnFailSelect = self:getGo("btnFailSelect")
	self._fmtBuff = self:getGo("fmtBuff")
	self._fmt = self:getGo("fmtBuff/fmt")
	self._txtFmt = self:getTxt("fmtBuff/txtFmt")
	self._fmtBuffContent = self:getGo("fmtBuffContent")
end

function AnnimatchmainView:onExit()
	AnnimatchmainView.super.onExit(self)
	self.scrollList:dispose()
	self:clearFormation()
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchBuffUpdate, self._onAnnimatchBuffUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchGiveUp, self.onGiveUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchInfoUpdate, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchReplaceCreeps, self.handleReplaceCreeps, self)
	uGuiUtil.clearImage(self.badge.gameObject)
	GameUtil.clearCells(self.rewardCon, self._clearPrizeCell, self)
end

function AnnimatchmainView:onEnter()
	AnnimatchmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchBuffUpdate, self._onAnnimatchBuffUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchGiveUp, self.onGiveUp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchInfoUpdate, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchReplaceCreeps, self.handleReplaceCreeps, self)
	self.addGEvent(self, GlobalNotify.AnniMatchCloseFmtBuff, self._onAnniMatchCloseFmtBuff, self)

	local notSend = self:getFirstParam()

	if notSend == nil then
		local activityId = AnnimatchController.instance:getCurrActId()

		AnnimatchController.instance:sendGetInfoWithOpenView(activityId)
	end

	self._replacingPetState = false

	self:_onSetUI()
	self:refreshUI()
end

function AnnimatchmainView:_onSetUI()
	self.txtTip.text = AnnimatchConfig.instance:getCommonByKey("MAIN_VIWE_TIPS")
end

function AnnimatchmainView:_getCurSummon()
	return
end

function AnnimatchmainView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local activityId = AnnimatchController.instance:getCurrActId()
	local anniCfg = AnnimatchConfig.instance:getCfgById(activityId)
	local cfg = AnnimatchConfig.instance:getBuffCfg(anniCfg.buffPlanId, data)

	if cfg then
		txtDesc.text = cfg.desc

		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
	else
		printError("缺少buff配置", activityId, anniCfg.buffPlanId, data)
	end
end

function AnnimatchmainView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function AnnimatchmainView:refreshUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)
	local fmo = AnnimatchModel.instance:getFormationMo(activityId)
	local curSummonMasterPetId = fmo:GetSummonMasterPetId()

	self.winNum:SetNum(info.winTimes)

	for i, v in ipairs(self.lostGoList) do
		GameUtil.SetActive(v, i <= info.failTimes)
	end

	local idx = math.max(1, math.ceil(info.winTimes / 2))

	uGuiUtil.setSpriteToImage(self.badge.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("annimatch", "scuffle_icon_0" .. idx))

	local actCfg = AnnimatchConfig.instance:getCfgById(activityId)
	local prizePlanId = actCfg.prizePlanId
	local prizeCfg = AnnimatchConfig.instance:getCompetitionPrizeCfgByWinTimes(prizePlanId, info.winTimes) or {}
	local arr = MaterialMgr.changeItemStrArr(prizeCfg.prize)

	GameUtil.updateCellsList(self.rewardCon, self.rewardCell, arr, self._updatePrizeCell, self)

	for i = 1, 9 do
		local petId = fmo:GetPosition(i)
		local cell = goutil.findChild(self.formation, "cell_" .. i)
		local con = goutil.findChild(self.formation, "cell_" .. i .. "/con")
		local summon = goutil.findChild(self.formation, "cell_" .. i .. "/summon")

		GameUtil.SetActive(cell, false)

		local petMo = AnnimatchModel.instance:getPetMo(activityId, petId)

		if petMo then
			GameUtil.SetActive(cell, true)
			GameUtil.SetActive(summon, petId == curSummonMasterPetId)
			MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, con)
		else
			MaterialMgr.resetAll(con)
		end
	end

	self.txtMatch.text = AnnimatchConfig.instance:getCommonByKey("MAIN_VIWE_START")

	GameUtil.SetActive(self._fmtBuff, false)

	if self:checkOpenBuff() then
		self.txtMatch.text = AnnimatchConfig.instance:getCommonByKey("MAIN_VIEW_SELECT_BUFF")

		UIStateManager.instance:push(ViewName.AnnimatchBuffView)

		self._needPopFmtBuff = true

		self:_tryPopFmtBuff()
		GameUtil.SetActive(self._fmtBuff, false)
	else
		self:_updateFmtUI()
		GameUtil.SetActive(self._fmtBuff, not checkbool(self._needPopFmtBuff))
	end

	self.txtMatch.text = lang("开始匹配")

	if self:checkOpenReplace() and checkbool(self._finishChooseBuff) then
		self.txtMatch.text = lang("替换精灵")

		UIStateManager.instance:push(ViewName.AnnimatchReplaceView)
	end

	local tmp = AnnimatchModel.instance:getCurrBuffIds(activityId) or {}
	local buffList = {}

	if info.hasFailBuff and actCfg.failBuffID > 0 then
		table.insert(buffList, actCfg.failBuffID)
	end

	for i, v in ipairs(tmp) do
		table.insert(buffList, v)
	end

	self.scrollList:reloadData(buffList)
	GameUtil.SetActive(self.goEmpty, #buffList == 0)
end

function AnnimatchmainView:_clearPrizeCell(cell, idx)
	MaterialMgr.resetAll(cell)
end

function AnnimatchmainView:_updatePrizeCell(cell, data, idx)
	MaterialMgr.setCellByCfg(data, cell)
end

function AnnimatchmainView:clearFormation()
	for i = 1, 9 do
		local cell = goutil.findChild(self.formation, "cell_" .. i)
		local con = goutil.findChild(self.formation, "cell_" .. i .. "/con")

		MaterialMgr.resetAll(con)
	end
end

function AnnimatchmainView:onClickForm()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info then
		if not info.formId then
			local formId = 1

			UIStateManager.instance:push(ViewName.AnnimatchfmtView, activityId, formId)
		end
	end
end

function AnnimatchmainView:onClickMatch()
	if self:checkOpenBuff() then
		UIStateManager.instance:push(ViewName.AnnimatchBuffView)
	else
		if self:checkOpenReplace() then
			UIStateManager.instance:push(ViewName.AnnimatchReplaceView)

			return
		end

		local activityId = AnnimatchController.instance:getCurrActId()
		local info = AnnimatchModel.instance:getInfo(activityId)
		local fmo = AnnimatchModel.instance:getFormationMo(activityId)

		if fmo == nil or fmo:isEmpty() then
			TipsFacade.instance:openPopupWindow(lang("tip"), AnnimatchConfig.instance:getCommonByKey("MAIN_VIEW_EMPTY"), function()
				self:onClickForm()
			end)
		else
			local activityId = AnnimatchController.instance:getCurrActId()

			AnnimatchController.instance:sendGoFinding(activityId)
		end
	end
end

function AnnimatchmainView:onClickQuit()
	TipsFacade.instance:openPopupWindow(lang("tip"), AnnimatchConfig.instance:getCommonByKey("MAIN_VIEW_GIVE_UP"), function()
		local activityId = AnnimatchController.instance:getCurrActId()

		AnnimatchController.instance:sendGoGiveup(activityId)
	end)
end

function AnnimatchmainView:onGiveUp()
	self:close()
end

function AnnimatchmainView:onClickReward()
	UIStateManager.instance:push(ViewName.AnnimatchprizeView)
end

function AnnimatchmainView:checkOpenBuff()
	local activityId = AnnimatchController.instance:getCurrActId()
	local alternativeBuffConfigIds = AnnimatchModel.instance:getCurrSelectBuffIds(activityId)

	if alternativeBuffConfigIds and #alternativeBuffConfigIds > 0 then
		return true
	end

	return false
end

function AnnimatchmainView:checkOpenReplace()
	local activityId = AnnimatchController.instance:getCurrActId()
	local replaceCreepsIds = AnnimatchModel.instance:getReplaceCreepsIds(activityId)

	if replaceCreepsIds and #replaceCreepsIds > 0 then
		return true
	end

	return false
end

function AnnimatchmainView:handleReplaceCreeps()
	local activityId = AnnimatchController.instance:getCurrActId()
	local fmo = AnnimatchModel.instance:getFormationMo(activityId)

	if fmo == nil or fmo:isEmpty() then
		TipsFacade.instance:openPopupWindow(lang("tip"), AnnimatchConfig.instance:getCommonByKey("MAIN_VIEW_EMPTY"), function()
			self:onClickForm()
		end)
	end

	AnnimatchController.instance:sendGetInfoWithOpenView(activityId)
	self:refreshUI()
end

function AnnimatchmainView:onClickFailSelect()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if self._replacingPetState then
		UIStateManager.instance:push(ViewName.AnnimatchReplaceView)
	end
end

function AnnimatchmainView:_tryPopFmtBuff()
	local fmtBuffPos = GameUtil.getLocalPos(self._fmtBuff)
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info then
		if not info.formId then
			local formId = 1

			self:showTabAt(self._fmtBuffContent, ViewName.AnnimatchFmtBuffView, activityId, formId, fmtBuffPos)
		end
	end
end

function AnnimatchmainView:_updateFmtUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info then
		if not info.formId then
			local formId = 1
			local formCfg = AnnimatchConfig.instance:getFormCfg(activityId, formId) or {}
			local posList = formCfg.posList

			self._txtFmt.text = formCfg.desc

			for i = 1, 9 do
				local img = goutil.findChild(self._fmt, "img_" .. i)
				local isInPos = table.indexof(posList, i)

				GameUtil.SetActive(img, isInPos)
			end
		end
	end
end

function AnnimatchmainView:_onAnniMatchCloseFmtBuff()
	self:_updateFmtUI()
	GameUtil.SetActive(self._fmtBuff, true)

	self._needPopFmtBuff = false

	self:refreshUI()
end

function AnnimatchmainView:_onAnnimatchBuffUpdate()
	self._finishChooseBuff = true

	self:refreshUI()
end

return AnnimatchmainView
