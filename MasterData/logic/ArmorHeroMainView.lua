-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroMainView.lua

module("logic.extensions.armorhero.view.ArmorHeroMainView", package.seeall)

local ArmorHeroMainView = class("ArmorHeroMainView", ViewComponent)

function ArmorHeroMainView:ctor()
	ArmorHeroMainView.super.ctor(self)
end

function ArmorHeroMainView:unbindEvents()
	ArmorHeroMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTaskPrzie)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnReservation)

	for i, cell in ipairs(self._enterCellList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function ArmorHeroMainView:bindEvents()
	ArmorHeroMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTaskPrzie, self._onClickBtnTaskPrzie, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnReservation, self._onClickBtnReservation, self)

	for i, cell in ipairs(self._enterCellList) do
		GameUtil.addClickHandler(cell.btn, function()
			self:_onClickSummon(i)
		end, self)
	end
end

function ArmorHeroMainView:buildUI()
	ArmorHeroMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTaskPrzie = self:getGo("btnTaskPrzie")
	self._gainTaskPrzie = self:getGo("btnTaskPrzie/gain")
	self._showprizeTaskPrzie = self:getGo("btnTaskPrzie/showprize")
	self._txtTaskPrzie = self:getTxt("btnTaskPrzie/txt")
	self._btnShare = self:getGo("share/btn")
	self._showprizeShare = self:getGo("share/bubble/showprize")
	self._gainShare = self:getGo("share/bubble/gain")
	self._shareImg = self:getGo("shareImg")
	self._enterCellList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("enterList/enterCell" .. i)
		cell.bgAf = goutil.findChild(cell.go, "bgAf")
		cell.bgBf = goutil.findChild(cell.go, "bgBf")
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txtBtn = goutil.findChildTextComponent(cell.go, "btn/txt")
		cell.redpoint = goutil.findChild(cell.go, "btn/redpoint")
		cell.summonPrize = goutil.findChild(cell.go, "summonPrize")
		cell.iconSummonPrize = goutil.findChild(cell.go, "summonPrize/icon")
		cell.txtShowName = goutil.findChildTextComponent(cell.go, "bgAf/showName/txt")
		cell.txtShowDate = goutil.findChildTextComponent(cell.go, "bgAf/showDate/txt")
		cell.matcellList = {}

		for j = 1, 5 do
			local matcell = {}

			matcell.go = goutil.findChild(cell.go, "mat" .. j)
			matcell.icon = goutil.findChild(matcell.go, "icon")
			matcell.txt = goutil.findChildTextComponent(matcell.go, "txt")

			table.insert(cell.matcellList, matcell)
		end

		self._enterCellList[i] = cell
	end

	self._btnReservation = self:getGo("btnReservation")
	self._txtCurProgress = self:getTxt("curProgress/txt")
	self._gainBook = self:getGo("prizebubble/gain")
	self._showprizeBook = self:getGo("prizebubble/showprize")
	self._redpointTask = self:getGo("btnTaskPrzie/redpoint")
end

function ArmorHeroMainView:onExit()
	ArmorHeroMainView.super.onExit(self)
	MaterialMgr.resetAll(self._showprizeShare)
	MaterialMgr.resetAll(self._showprizeTaskPrzie)
	MaterialMgr.resetAll(self._showprizeBook)

	for _, cell in ipairs(self._enterCellList) do
		MaterialMgr.resetAll(cell.iconSummonPrize)

		for _, matcell in ipairs(cell.matcellList) do
			MaterialMgr.resetAll(matcell.icon)
		end

		RedPointController.instance:unregRedPoint(cell.redpoint)
	end

	RedPointController.instance:unregRedPoint(self._redpointTask)
end

function ArmorHeroMainView:onEnter()
	ArmorHeroMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroGainSharePrizeRes, self._updateShareStatus, self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroGainTaskPrizeRes, self._updateTaskPrizeStatus, self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroSummonRes, self._updateSummonStatus, self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroGainBookPrizeRes, self._updateReservationStatus, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes, self._updateWorldProgress, self)

	self._activityId = 540001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	ArmorHeroController.instance:getInfo(self._activityId)
	WorldProgressPrizeController.instance:sendPM_WorldProgressPrizeGetInfoReq(self._activityId)
	goutil.setActive(self._shareImg, false)
	self:_updateUIByInfo()
	self:_updateWorldProgress()
end

function ArmorHeroMainView:_updateUIByCfg()
	self._actCfg = ArmorHeroConfig.instance:getActivityCfgByActId(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	if not self._actCfg.sharePrize then
		MaterialMgr.setCellByCfg(self._actCfg.sharePrize, self._showprizeShare)

		if not self._actCfg.taskPrize then
			MaterialMgr.setCellByCfg(self._actCfg.taskPrize, self._showprizeTaskPrzie)

			if not self._actCfg.bookPrize then
				MaterialMgr.setCellByCfg(self._actCfg.bookPrize, self._showprizeBook)

				if not self._actCfg.prizeOpenTime then
					local prizeOpenTime = ""
					local dateOpen = GameUtil.string2date(prizeOpenTime)

					RedPointController.instance:regRedPoint(self._redpointTask, self._actCfg.taskRedPointId)

					self._summonCfgs = ArmorHeroConfig.instance:getSummonCfgsByActId(self._activityId) or {}

					for i, cell in ipairs(self._enterCellList) do
						local summonCfg = self._summonCfgs[i]

						if summonCfg then
							goutil.setActive(cell.redpoint, false)

							if not summonCfg.prize then
								MaterialMgr.setCellByCfg(summonCfg.prize, cell.iconSummonPrize)

								if not summonCfg.needItem then
									local needItem = ""
									local needItemArr = string.split(needItem, "#")

									for j, matcell in ipairs(cell.matcellList) do
										if not needItemArr[j] then
											local matStr = ""

											if GameUtil.isEmptyString(matStr) then
												goutil.setActive(matcell.go, false)
											else
												goutil.setActive(matcell.go, true)

												local itemType, itemId, itemNum = MaterialMgr.getMatParams(matStr)

												MaterialMgr.setIcon(matcell.icon, itemType, itemId)
											end
										end
									end

									goutil.setActive(cell.go, true)

									cell.txtShowName.text = summonCfg.name or ""
									cell.txtShowDate.text = summonCfg.dateStr or ""
								end
							end
						else
							goutil.setActive(cell.go, false)
						end
					end
				end
			end
		end
	end
end

function ArmorHeroMainView:_updateUIByInfo()
	self:_updateShareStatus()
	self:_updateTaskPrizeStatus()
	self:_updateReservationStatus()
	self:_updateSummonStatus()
end

function ArmorHeroMainView:_updateWorldProgress()
	self._curWorldProgress = 0

	local progressInfoMo = WorldProgressPrizeController.instance:getWorldProgressPrizeMo(self._activityId)

	if progressInfoMo then
		self._curWorldProgress = progressInfoMo:getProgress(self._actCfg.progressId)
	end

	self._txtCurProgress.text = string.format("当前已有%s人预约", checknumber(self._curWorldProgress))
end

function ArmorHeroMainView:_updateShareStatus()
	self._isGainShare = false

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		self._isGainShare = info.hasGainSharePrize or false
	end

	goutil.setActive(self._gainShare, self._isGainShare)
end

function ArmorHeroMainView:_updateReservationStatus()
	self._hasBook = false

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		self._hasBook = info.hasGainBookPrize or false
	end

	goutil.setActive(self._gainBook, self._hasBook)
end

function ArmorHeroMainView:_updateSummonStatus()
	self._hasSummonIdMap = {}
	self._matchSumonIdMap = {}

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		for _, summonId in ipairs(info.hasSummonId or {}) do
			self._hasSummonIdMap[summonId] = true
		end
	end

	for i, cell in ipairs(self._enterCellList) do
		local summonCfg = self._summonCfgs[i]

		if summonCfg then
			goutil.setActive(cell.redpoint, false)

			if not self._hasSummonIdMap[summonCfg.summonId] then
				if not summonCfg.needItem then
					local needItem = ""
					local isMatch = true
					local needItemArr = string.split(needItem, "#")

					for _, matStr in ipairs(needItemArr) do
						if not MaterialMgr.getMatEnough(matStr) then
							isMatch = false

							break
						end
					end

					self._matchSumonIdMap[summonCfg.summonId] = isMatch

					RedPointController.instance:unregRedPoint(cell.redpoint)

					if self._hasSummonIdMap[summonCfg.summonId] then
						if not summonCfg.rds then
							local redPointIds = ""

							RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(redPointIds or "", "#")))

							cell.txtBtn.text = summonCfg.txtTitle or "已召唤"

							goutil.setActive(cell.summonPrize, false)

							for j, matcell in ipairs(cell.matcellList) do
								goutil.setActive(matcell.go, false)
							end

							goutil.setActive(cell.bgAf, true)
							goutil.setActive(cell.bgBf, false)
							goutil.setActive(cell.btn, false)
						end
					else
						goutil.setActive(cell.bgAf, false)
						goutil.setActive(cell.bgBf, true)
						goutil.setActive(cell.summonPrize, true)
						goutil.setActive(cell.btn, true)

						local needItemArr = string.split(needItem, "#")

						for j, matcell in ipairs(cell.matcellList) do
							if not needItemArr[j] then
								local matStr = ""

								if GameUtil.isEmptyString(matStr) then
									goutil.setActive(matcell.go, false)
								else
									goutil.setActive(matcell.go, true)

									local itemType, itemId, itemNum = MaterialMgr.getMatParams(matStr)
									local haveNum = MaterialModel.instance:getMaterialsNumber(itemType, itemId)

									matcell.txt.text = string.format("%s/%s", haveNum, itemNum)
								end
							end
						end

						if isMatch then
							goutil.setActive(cell.redpoint, true)

							cell.txtBtn.text = "立即召唤"
						elseif not summonCfg.rds then
							local redPointIds = ""

							RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(redPointIds or "", "#")))

							cell.txtBtn.text = summonCfg.txtTitle or "前往获取"
						end
					end
				end
			end
		end
	end
end

function ArmorHeroMainView:_updateTaskPrizeStatus()
	self._isGainTaskPrzie = false

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		self._isGainTaskPrzie = info.hasGainTaskPrize or false
	end

	goutil.setActive(self._gainTaskPrzie, self._isGainTaskPrzie)
end

function ArmorHeroMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function ArmorHeroMainView:_onClickBtnTaskPrzie()
	UIStateManager.instance:push(ViewName.ArmorHeroTaskView, self._activityId)
end

function ArmorHeroMainView:_onClickBtnShare()
	ShareController.instance:share(19, nil, self._shareImg:GetComponent(typeof(UnityEngine.UI.RawImage)).texture, 0, function()
		if not self._isGainShare then
			ArmorHeroController.instance:sendGainSharePrize(self._activityId)
		end
	end)
end

function ArmorHeroMainView:_onClickBtnReservation()
	if self._hasBook then
		FloatWordMgr.instance:show(lang("已预约"))
	else
		ArmorHeroController.instance:sendGainBookPrize(self._activityId)
	end
end

function ArmorHeroMainView:_onClickSummon(summonId)
	if not self._hasSummonIdMap[summonId] then
		if not self._matchSumonIdMap[summonId] then
			local isMatch = false
			local summonCfg = self._summonCfgs[summonId]

			if not summonCfg then
				return
			end

			if not summonCfg.gotoStr then
				local gotoStr = ""

				if self._hasSummonIdMap[summonId] then
					GotoMgr.gotoByString(gotoStr)
				elseif isMatch then
					ArmorHeroController.instance:sendSummon(self._activityId, summonId)
				else
					GotoMgr.gotoByString(gotoStr)
				end
			end
		end
	end
end

return ArmorHeroMainView
