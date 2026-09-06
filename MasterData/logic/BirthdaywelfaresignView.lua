-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignView", package.seeall)

local BirthdaywelfaresignView = class("BirthdaywelfaresignView", ViewComponent)

function BirthdaywelfaresignView:ctor()
	BirthdaywelfaresignView.super.ctor(self)
end

function BirthdaywelfaresignView:unbindEvents()
	BirthdaywelfaresignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnGet)
	GameUtil.rmClickHandler(self.btnSkill)
	GameUtil.rmClickHandler(self.btnBuyTime)
end

function BirthdaywelfaresignView:bindEvents()
	BirthdaywelfaresignView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnGet, self.onClickGet, self)
	GameUtil.addClickHandler(self.btnSkill, self.onClickSkill, self)
	GameUtil.addClickHandler(self.btnBuyTime, self.onClickBuyTime, self)
end

function BirthdaywelfaresignView:buildUI()
	BirthdaywelfaresignView.super.buildUI(self)

	self.btnGet = self:getGo("btnGet")
	self.con = self:getGo("con")
	self.petInfo = self:getGo("petInfo")
	self.btnSkill = self:getGo("petInfo/btnSkill")
	self.rare = self:getGo("petInfo/rare")
	self.txtName = self:getTxt("petInfo/txtName")
	self.txtTimeGo = self:getGo("time")
	self.txtTime = self:getTxt("time/txtTime")
	self.tipsGo = self:getGo("tipsGo")
	self.txtTip = self:getTxt("tipsGo/txtTip")
	self.signCellsTran = self:getGo("signCells"):GetComponent(goutil.Type_RectTransform)
	self.items = {}

	for i = 1, 100 do
		local go = self:getGo("signCells/Viewport/Content/cell_" .. i)

		if go == nil then
			break
		end

		table.insert(self.items, go)
	end

	self.btnBuyTime = self:getGo("btnBuyTime")
	self.txtBtnBuyTime = self:getTxt("btnBuyTime/Text")
end

function BirthdaywelfaresignView:onExit()
	BirthdaywelfaresignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	self:removeAllEff()
	MaterialMgr.resetAll(self.rare)
end

function BirthdaywelfaresignView:onEnter()
	BirthdaywelfaresignView.super.onEnter(self)

	local data = self:getFirstParam()
	local activityId = 0

	if data then
		activityId = checknumber(data.parameter)
	end

	self.SIGN_ID_KEY = "SIGN_IN_SKINID_EXT"
	self.SIGN_ID_JUMP = "SIGN_IN_JUMP_EXT"

	if activityId == 0 then
		self.SIGN_ID_JUMP = "SIGN_IN_JUMP"
		self.SIGN_ID_KEY = "SIGN_IN_SKINID"
		activityId = ActivitySummaryController.instance:getActivityId()
	end

	self.activityId = activityId

	local skinId = self:setRoleId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self.con, scale, nil, true, modelCfg[1], y)

				GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)
				ActivitySummaryController.instance:sendGetSignInfo(activityId)

				self.txtTime.text = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT")

				if data and not string.nilorempty(data.limitTime) then
					local arr = string.split(data.limitTime, "#")

					if #arr == 2 then
						local startTime = GameUtil.parseToTimeTable(arr[1])
						local endTime = GameUtil.parseToTimeTable(arr[2])
						local content = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT_EXT")

						self.txtTime.text = langPara(content, startTime.month, startTime.day, startTime.hour, startTime.sec, endTime.month, endTime.day, endTime.hour, endTime.sec)
					end
				end

				self._actCfg = XiaonuoBirthConfig.instance:getActivity(self.activityId)
				self._buyTimeDesc = ""
				self.txtBtnBuyTime.text = "提前签到"

				local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.WelfareSummary, self._actCfg.activityId)

				if self._actCfg.relativeOpenDays <= 0 or cfg == nil or string.nilorempty(cfg.startTime) then
					GameUtil.SetActive(self.tipsGo, false)
				else
					local startTime = GameUtil.string2time(cfg.startTime) + self._actCfg.relativeOpenDays * 86400

					GameUtil.SetActive(self.tipsGo, true)

					local timer = GameUtil.time2date(startTime)
					local desc = string.format("【%s.%s 开启提前签到】", timer.month, timer.day)

					if startTime > ServerTime.now() then
						self.txtBtnBuyTime.text = "提前签到"
						self._buyTimeDesc = desc
					end

					self.txtTip.text = lang("text_boonsign_desc_1")
				end

				ActivitySummaryController.instance:sendGetSignInfo(self._actCfg.activityId)

				if string.nilorempty(self._buyTimeDesc) then
					uGuiUtil.setImageGrayState(self.btnBuyTime.gameObject, false)
					uGuiUtil.setTextGrayState(self.txtBtnBuyTime.gameObject, false)
				else
					uGuiUtil.setImageGrayState(self.btnBuyTime.gameObject, true)
					uGuiUtil.setTextGrayState(self.txtBtnBuyTime.gameObject, true)
				end

				self:onRefreshUI()
			end
		end
	end
end

function BirthdaywelfaresignView:onRefreshUI()
	local activityId = self.activityId
	local cfgList = XiaonuoBirthConfig.instance:getSignInList(activityId)
	local info = ActivitySummaryModel.instance:getSignInfo(activityId) or {}
	local onlineDay = checknumber(info.onlineDay) + checknumber(info.buytimes)

	if not info.hasGainPrizeDays then
		local signInMap = {}

		for i, v in ipairs(info.hasGainPrizeDays) do
			signInMap[v] = true
		end

		local codeMap = {}

		for i, v in ipairs(info.exchangeCodes or {}) do
			codeMap[v.day] = v.exchangeCode
		end

		self:removeAllEff()

		self.effList = {}

		local effPath = self:getEffectPath()

		for i, cell in ipairs(self.items) do
			local cfg = cfgList[i]

			GameUtil.SetActive(cell, false)

			if cfg and not string.nilorempty(cfg.prize) then
				GameUtil.SetActive(cell, true)

				local item = goutil.findChild(cell, "item")
				local receive = goutil.findChild(cell, "receive")
				local txtNum = goutil.findChildTextComponent(cell, "txtNum")
				local btnExchangeCode = goutil.findChild(cell, "btnExchangeCode")
				local top = goutil.findChild(cell, "top")
				local lock = goutil.findChild(cell, "lock")
				local effect = goutil.findChild(cell, "effect")
				local isUnlockAsSignDay = ActivitySummaryController.instance:isUnlockAsSignDay(activityId, cfg.signInDays)

				GameUtil.SetActive(lock, not isUnlockAsSignDay)

				if i <= onlineDay and signInMap[i] == nil and isUnlockAsSignDay then
					local _pmEff = UIEffectManager.instance:playEffect(self, effPath, effect, 0, 0, true, nil, nil, function(target, eff)
						eff:setClipping(self.signCellsTran)
					end, self)

					_pmEff:setParent(effect.transform)
					_pmEff:setScale(self:getEffectScale())
					_pmEff:setLocalPos(self:getEffectPos())
					table.insert(self.effList, _pmEff)
				end

				local prizeStr = MaterialMgr.changeItemStrArr(cfg.showPrize)
				local matType, id, num = MaterialMgr.getMatParams(prizeStr[1])

				MaterialMgr.setIcon(item, matType, id)

				txtNum.text = "x" .. num

				GameUtil.SetActive(receive, signInMap[i] ~= nil)
				GameUtil.SetActive(btnExchangeCode, not string.nilorempty(codeMap[i]))
				GameUtil.addClickHandler(btnExchangeCode, function()
					UIStateManager.instance:push(ViewName.BirthdaytipsView, codeMap[i])

					if checknumber(cfg.reportBehavior) > 0 then
						SurveyController.instance:reportBehavior(checknumber(cfg.reportBehavior))
					end
				end)
				GameUtil.addClickHandler(top, function()
					if i <= onlineDay and signInMap[i] == nil then
						ActivitySummaryController.instance:sendGetSignInPrize(self.activityId, i)
					elseif prizeStr and prizeStr[1] then
						CommonTipsMgr.instance:openTipsByConfStr(item, prizeStr[1])
					end
				end)
			end
		end
	end
end

function BirthdaywelfaresignView:onClickGet()
	local str = XiaonuoBirthConfig.instance:getCommonValue(self.SIGN_ID_JUMP)

	GotoMgr.gotoByString(str)
end

function BirthdaywelfaresignView:onClickSkill()
	local str = XiaonuoBirthConfig.instance:getCommonValue(self.SIGN_ID_KEY)
	local skinId = checknumber(str)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		PetbookController.instance:openPetinfoView(cfg.raceId)
	end
end

function BirthdaywelfaresignView:onClickBuyTime()
	if not string.nilorempty(self._buyTimeDesc) then
		FloatWordMgr.instance:show(self._buyTimeDesc)

		return
	end

	if self._isSignFinish then
		FloatWordMgr.instance:show("已签满")

		return
	end

	if self._actCfg.payType == 1 then
		PayController.instance:pay(self._actCfg.payGoodsId, GameEnum.PaySubGoodsType.WELFARE_SUMMARY, self._actCfg.activityId)
	else
		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.payGoodsId)

		if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
			local name = MaterialMgr.getMaterialsName(matType, matId)

			FloatWordMgr.instance:show(string.format("购买签到所需%s不足%s", name, matNum))

			return
		end

		local function okFunc()
			XiaoNuoSummaryAgent.instance:sendPM_XiaoNuoSummaryBuyDaysReq(self._actCfg.activityId)
		end

		local text = string.format("是否花费%s%s提前签到1天？", matNum, MaterialMgr.getMaterialsName(matType, matId))

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	end
end

function BirthdaywelfaresignView:removeAllEff()
	for i, v in ipairs(self.effList or {}) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function BirthdaywelfaresignView:setRoleId()
	local str = XiaonuoBirthConfig.instance:getCommonValue(self.SIGN_ID_KEY)

	return (checknumber(str))
end

function BirthdaywelfaresignView:getEffectPath()
	return "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"
end

function BirthdaywelfaresignView:getEffectScale()
	return 1.7
end

function BirthdaywelfaresignView:getEffectPos()
	return 5, 0, 0
end

return BirthdaywelfaresignView
