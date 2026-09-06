-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignprogressView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignprogressView", package.seeall)

local BirthdaywelfaresignprogressView = class("BirthdaywelfaresignprogressView", TableViewComponent)

function BirthdaywelfaresignprogressView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function BirthdaywelfaresignprogressView:ctor()
	BirthdaywelfaresignprogressView.super.ctor(self)
end

function BirthdaywelfaresignprogressView:unbindEvents()
	BirthdaywelfaresignprogressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDayPrize)
end

function BirthdaywelfaresignprogressView:bindEvents()
	BirthdaywelfaresignprogressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDayPrize, self._onClickDayPrize, self)
end

function BirthdaywelfaresignprogressView:buildUI()
	BirthdaywelfaresignprogressView.super.buildUI(self)

	self._clipRect = self:getGo("tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._btnDayPrize = self:getGo("btnDayPrize")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtSignDays = self:getTxt("txtSignDays")
	self._dayItem = self:getGo("btnDayPrize/item")
	self._imgDayGot = self:getGo("btnDayPrize/imgGot")
	self._con = self:getGo("con")
	self._dayRedPoint = self:getGo("btnDayPrize/redPoint")

	goutil.setActive(self._dayRedPoint, false)
	goutil.setActive(self._imgDayGot, false)
end

function BirthdaywelfaresignprogressView:onExit()
	BirthdaywelfaresignprogressView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self._updateAll, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	MaterialMgr.resetAll(self._dayItem)
	self:_removeAllEffect()
end

function BirthdaywelfaresignprogressView:onEnter()
	BirthdaywelfaresignprogressView.super.onEnter(self)

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

	self._activityId = activityId

	self:_initActivityTimeText(data)
	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self._updateAll, self)
	ActivitySummaryController.instance:sendGetSignInfo(self._activityId)
	self:_initRole()
end

function BirthdaywelfaresignprogressView:setRoleId()
	local str = XiaonuoBirthConfig.instance:getCommonValue(self.SIGN_ID_KEY)

	return (checknumber(str))
end

function BirthdaywelfaresignprogressView:_initRole()
	local skinId = self:setRoleId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function BirthdaywelfaresignprogressView:_initActivityTimeText(data)
	self._txtTime.text = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT")

	if data and not string.nilorempty(data.limitTime) then
		local arr = string.split(data.limitTime, "#")

		if #arr == 2 then
			local startTime = GameUtil.parseToTimeTable(arr[1])
			local endTime = GameUtil.parseToTimeTable(arr[2])
			local content = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TIME_LIMIT_EXT")

			self._txtTime.text = langPara(content, startTime.month, startTime.day, startTime.hour, startTime.sec, endTime.month, endTime.day, endTime.hour, endTime.sec)
		end
	end
end

function BirthdaywelfaresignprogressView:_updateAll()
	local info = ActivitySummaryModel.instance:getSignInfo(self._activityId) or {}

	self._onlineDay = checknumber(info.onlineDay)

	if not info.hasGainPrizeDays then
		local signInMap = {}

		for i, v in ipairs(info.hasGainPrizeDays) do
			signInMap[v] = true
		end

		self._signInMap = signInMap
		self._bGainedDailyPrize = info.hasGainedDailyPrize
		self._txtSignDays.text = langPara("已累计登录天数：<color=#bdff77>%d</color>天", self._onlineDay)

		local actCfg = XiaonuoBirthConfig.instance:getActivity(self._activityId)

		if not string.nilorempty(actCfg.dailyPrize) then
			MaterialMgr.setCellListByCfg(actCfg.dailyPrize, self._dayItem)
			goutil.setActive(self._dayRedPoint, not self._bGainedDailyPrize)
		else
			goutil.setActive(self._dayRedPoint, false)
		end

		goutil.setActive(self._imgDayGot, self._bGainedDailyPrize)

		local cfgList = XiaonuoBirthConfig.instance:getSignInList(self._activityId)
		local array = {}

		for i, v in pairs(cfgList) do
			if checknumber(i) > 0 then
				table.insert(array, v)
			end
		end

		table.sort(array, function(a, b)
			local bHasSignA = self._signInMap[a.signInDays]
			local bHasSignB = self._signInMap[b.signInDays]

			if bHasSignA == bHasSignB then
				return a.signInDays < b.signInDays
			elseif bHasSignA then
				return false
			else
				return true
			end
		end)
		self:updateListData(array)
	end
end

function BirthdaywelfaresignprogressView:_cellSize(view, index)
	return 116, 372
end

function BirthdaywelfaresignprogressView:_updateCell(view, goCell, data)
	local cell = self:_clearTableview(goCell)
	local proxyArr = MaterialMgr.setCellListByCfg(data.showPrize, cell.itemcon)

	for i, v in ipairs(proxyArr) do
		v.binder:setEffStatus(false)
	end

	cell.txtNum.text = langPara("登录<size=40>%d</size>天", data.signInDays)

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, data))

	if self._onlineDay >= data.signInDays and not self._signInMap[data.signInDays] then
		goutil.setActive(cell.btn, true)
		goutil.setActive(cell.eff, true)

		for i = 1, #proxyArr do
			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effcon, cell.go, true, self._clipRect, i)
		end
	else
		goutil.setActive(cell.mark, self._signInMap[data.signInDays])
	end
end

function BirthdaywelfaresignprogressView:_clearTableview(goCell)
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

function BirthdaywelfaresignprogressView:_createEff(effPath, effParent, effKey, isLoop, clipRect, id)
	self._existEffs = self._existEffs or {}

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

		local rendererList = eff.effGo:GetComponentsInChildren(ComponentType.Renderer)
		local propertyName = "_LineCoord"
		local vec4 = Vector4.New(0.89, 0, 1, 0.9)

		for i = 0, rendererList.Length - 1 do
			MaterialUtils.SetVector(rendererList[i], propertyName, vec4)
		end
	end)

	self._existEffs[effKey] = self._existEffs[effKey] or {}

	if id then
		self._existEffs[effKey][id] = newEff
	else
		self._existEffs[effKey][1] = newEff
	end
end

function BirthdaywelfaresignprogressView:_removeAllEffect()
	if self._existEffs then
		for k, eff in pairs(self._existEffs) do
			self:_removeEffect(k)
		end

		self._existEffs = nil
	end
end

function BirthdaywelfaresignprogressView:_removeEffect(key)
	if self._existEffs then
		if self._existEffs then
			for _, eff in pairs(self._existEffs) do
				if eff and not goutil.isNil(eff.effGo) then
					local rendererList = eff.effGo:GetComponentsInChildren(ComponentType.Renderer)

					if rendererList and rendererList.Length > 0 then
						local propertyName = "_LineCoord"
						local vec4 = Vector4.New(1, 0, 1, 1)

						for i = 0, rendererList.Length - 1 do
							MaterialUtils.SetVector(rendererList[i], propertyName, vec4)
						end
					end
				end

				UIEffectManager.instance:stopEffect(eff)
			end

			self._existEffs[key] = nil
		end
	end
end

function BirthdaywelfaresignprogressView:_onClickGainPrize(data)
	ActivitySummaryController.instance:sendGetSignInPrize(self._activityId)
end

function BirthdaywelfaresignprogressView:_onClickDayPrize()
	ActivitySummaryController.instance:sendGetSignInPrize(self._activityId)
end

return BirthdaywelfaresignprogressView
