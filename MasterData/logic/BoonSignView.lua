-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BoonSignView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BoonSignView", package.seeall)

local BoonSignView = class("BoonSignView", ViewComponent)

function BoonSignView:ctor()
	BoonSignView.super.ctor(self)

	self._cellItemList = nil
	self._cellEffList = nil
	self._buyTimeDesc = nil
	self._signInfo = nil
	self._isSignFinish = nil
end

function BoonSignView:bindEvents()
	BoonSignView.super.bindEvents(self)
	self._buyBtn:AddClickListener(self._onClickBuyBtn, self)
end

function BoonSignView:unbindEvents()
	BoonSignView.super.unbindEvents(self)
	self._buyBtn:RemoveClickListener()
end

function BoonSignView:onExit()
	BoonSignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshView, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	self:_removeAllEff()

	self._buyTimeDesc = nil
	self._signInfo = nil
	self._isSignFinish = nil
end

function BoonSignView:_removeAllEff()
	for _, eff in ipairs(self._cellEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end
end

function BoonSignView:buildUI()
	BoonSignView.super.buildUI(self)

	self._buyBtn = self:getBtn("buyBtn")
	self._buyTxt = self:getTxt("buyBtn/buyTxt")
	self._petCon = self:getGo("petCon")
	self._tipsGo = self:getGo("tipsGo")
	self._tipsTxt = self:getTxt("tipsGo/tipsTxt")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._scSRTran = self:getGo("signCellSR"):GetComponent(goutil.Type_RectTransform)

	local cellsTranGo = goutil.findChild(self._scSRTran.gameObject, "Viewport/Content")

	self._cellItemList = {}

	for i = 1, 50 do
		local go = goutil.findChild(cellsTranGo, "cell_" .. i)

		if go == nil then
			break
		end

		table.insert(self._cellItemList, {
			itemGo = go,
			iconGo = goutil.findChild(go, "iconGo"),
			effGo = goutil.findChild(go, "effGo"),
			numTxt = goutil.findChildTextComponent(go, "numTxt"),
			dayTxt = goutil.findChildTextComponent(go, "dayTxt"),
			receiveGo = goutil.findChild(go, "receiveGo"),
			lockGo = goutil.findChild(go, "lockGo"),
			topClickGo = goutil.findChild(go, "topClickGo")
		})
	end
end

function BoonSignView:onEnter()
	BoonSignView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshView, self)

	local data = self:getFirstParam()
	local actId = data and checknumber(data.parameter) or 0

	if actId == 0 then
		actId = ActivitySummaryController.instance:getActivityId()
	end

	self._isSignFinish = false
	self._actCfg = XiaonuoBirthConfig.instance:getActivity(actId)
	self._buyTimeDesc = ""
	self._buyTxt.text = "提前签到"

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.WelfareSummary, self._actCfg.activityId)

	if self._actCfg.relativeOpenDays <= 0 or cfg == nil or string.nilorempty(cfg.startTime) then
		GameUtil.SetActive(self._tipsGo, false)
	else
		local startTime = GameUtil.string2time(cfg.startTime) + self._actCfg.relativeOpenDays * 86400

		GameUtil.SetActive(self._tipsGo, true)

		local timer = GameUtil.time2date(startTime)
		local desc = string.format("【%s.%s 开启提前签到】", timer.month, timer.day)

		if startTime > ServerTime.now() then
			self._buyTxt.text = "提前签到"
			self._buyTimeDesc = desc
		end

		self._tipsTxt.text = lang("text_boonsign_desc_1")
	end

	ActivitySummaryController.instance:sendGetSignInfo(self._actCfg.activityId)

	local skinId = checknumber(XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_SKINID"))
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		local x = 0

		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._petCon, scale, nil, true, x, y)

				if string.nilorempty(self._buyTimeDesc) then
					uGuiUtil.setImageGrayState(self._buyBtn.gameObject, false)
					uGuiUtil.setTextGrayState(self._buyTxt.gameObject, false)
				else
					uGuiUtil.setImageGrayState(self._buyBtn.gameObject, true)
					uGuiUtil.setTextGrayState(self._buyTxt.gameObject, true)
				end

				self._timeTxt.text = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT")

				self:_onRefreshView()
			end
		end
	end
end

function BoonSignView:_onClickBuyBtn()
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

function BoonSignView:_onRefreshView()
	local signInfo = ActivitySummaryModel.instance:getSignInfo(self._actCfg.activityId) or {}
	local cfgList = XiaonuoBirthConfig.instance:getSignInList(self._actCfg.activityId)
	local onlineDay = checknumber(signInfo.onlineDay) + checknumber(signInfo.buytimes)

	self._isSignFinish = cfgList == nil or onlineDay >= #cfgList

	local signInMap = {}

	for i, v in ipairs(signInfo.hasGainPrizeDays or {}) do
		signInMap[v] = true
	end

	self:_removeAllEff()

	self._cellEffList = {}

	local effPath = "20220701/qiandaokelingqu/fx_ui_qiandaokelingqu.prefab"

	for i, cell in ipairs(self._cellItemList) do
		GameUtil.asBtn(cell.topClickGo):RemoveClickListener()

		local cfg = cfgList[i]

		if cfg and not string.nilorempty(cfg.prize) then
			GameUtil.SetActive(cell.itemGo, true)

			local isUnlockAsSignDay = ActivitySummaryController.instance:isUnlockAsSignDay(self._activityId, data.signInDays)

			GameUtil.SetActive(lock, not isUnlockAsSignDay)

			if i <= onlineDay and signInMap[i] == nil and isUnlockAsSignDay then
				local pmEff = UIEffectManager.instance:playEffect(self, effPath, cell.effGo, 0, 0, true, nil, nil, function(target, eff)
					eff:setClipping(self._scSRTran)
				end, self)

				pmEff:setParent(cell.effGo.transform)
				pmEff:setScale(1.38)
				pmEff:setLocalPos(0, 0, 0)
				table.insert(self._cellEffList, pmEff)
			end

			cell.dayTxt.text = "第" .. i .. "天"

			local prizeStr = MaterialMgr.changeItemStrArr(cfg.showPrize)
			local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr[1])

			matNum = math.max(checknumber(matNum), 1)

			MaterialMgr.setIcon(cell.iconGo, matType, matId)

			cell.numTxt.text = "x" .. matNum

			GameUtil.SetActive(cell.receiveGo, signInMap[i] ~= nil)
			GameUtil.asBtn(cell.topClickGo):AddClickListener(function()
				if i <= onlineDay and signInMap[i] == nil then
					ActivitySummaryController.instance:sendGetSignInPrize(self._actCfg.activityId, i)
				elseif prizeStr and prizeStr[1] then
					CommonTipsMgr.instance:openTipsByConfStr(cell.itemGo, prizeStr[1])
				end
			end, self)
		else
			GameUtil.SetActive(cell.itemGo, false)
		end
	end
end

return BoonSignView
