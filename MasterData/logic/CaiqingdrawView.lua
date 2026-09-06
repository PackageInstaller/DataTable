-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CaiqingdrawView.lua

module("logic.extensions.caiqingdraw.view.CaiqingdrawView", package.seeall)

local CaiqingdrawView = class("CaiqingdrawView", ViewComponent)
local spineUrl = {
	{
		"effect/prefabs/ui/1025/fx_longhunjuexinghoujiang_donghua.prefab"
	},
	{
		"character/10137_xiaotian/10137_xiaotian-ui_p.prefab"
	}
}
local spinePos = {
	{
		-305,
		-165,
		0.6
	},
	{
		275,
		-165,
		0.6,
		-0.6
	},
	{
		0,
		-176,
		0.35,
		0.35
	}
}
local spineAnim = {
	[1] = "idle-all",
	[2] = "skill-all"
}
local drawAnimPath = {
	"storyconfig/animations/story_xingshicaiqing.txt",
	"storyconfig/animations/story_longfanchoujiang.txt",
	"storyconfig/animations/story_shikongxiuer.txt"
}

function CaiqingdrawView:ctor()
	CaiqingdrawView.super.ctor(self)
end

function CaiqingdrawView:unbindEvents()
	CaiqingdrawView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnAnim)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTenLottery)
end

function CaiqingdrawView:bindEvents()
	CaiqingdrawView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnAnim, self._onClickAnim, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTenLottery, self._onClickTenLottery, self)
end

function CaiqingdrawView:buildUI()
	CaiqingdrawView.super.buildUI(self)

	self._costIcon = self:getImg("txtCost/icon")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtlotteryNum = self:getTxt("lotteryNum/txtNum")
	self._txtCost = self:getTxt("txtCost")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnLottery = self:getBtn("btnLottery")
	self._btnTask = self:getBtn("btnTask")
	self._btnAnim = self:getBtn("btnAnim")
	self._btnTenLottery = self:getBtn("btnTenLottery")
	self._roleView_role1 = self:getGo("roleView/role1")
	self._roleView_role2 = self:getGo("roleView/role2")
	self._rdTenLottery = self:getGo("btnLottery/redpoint")
	self._rdTask = self:getGo("btnTask/redpoint")
	self._animSelect = self:getGo("btnAnim/imgSelect")
	self._tenSelect = self:getGo("btnTenLottery/imgSelect")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tableview = self:getGo("lotteryList/tableview")
	self._cell = self:getGo("lotteryList/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._spineAnimRoot = self:getGo("spineAnimRoot")
	self._spineRoot_Role1 = self:getGo("spineAnimRoot/root")
	self._lotteryBg = self:getGo("roleView/bg")
	self._imgSlogan = self:getGo("imgSlogan")
end

function CaiqingdrawView:onExit()
	CaiqingdrawView.super.onExit(self)
	self._scrollList:dispose()

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self:_clearAllSpine()
	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._rdTenLottery)
	RedPointController.instance:unregRedPoint(self._rdTask)
	removetimer(self._spineAnim, self)
	removetimer(self._playHitEffect, self)

	if self._hiteffectHandler then
		UIEffectManager.instance:stopEffect(self._hiteffectHandler)

		self._hiteffectHandler = nil
	end
end

function CaiqingdrawView:onEnter()
	CaiqingdrawView.super.onEnter(self)
	self:_initAnimPre()
	self:_setTimeUI()
	self:_playEffect()
	self:_lotteryCost()
	self:_animTenSelectState()
	self:_initSpine()
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawGetInfoRes, self._initView, self)
	GlobalDispatcher:addListener(GlobalNotify.CaiQingDrawPrizeRes, self._refreshView, self)
	RedPointController.instance:regRedPoint(self._rdTenLottery, RedPointModel.ID_CAIQINGDRAW_TENLOTTERY)
	RedPointController.instance:regRedPoint(self._rdTask, RedPointModel.ID_CAIQINGDRAW_TASK)
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)
end

function CaiqingdrawView:_initAnimPre()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Caiqingdraw)
	end

	self._activityCfg = CaiQingDrawConfig.instance:getActivityCfgById(self._activityId)
	self._animationPreKey = self.__cname
end

function CaiqingdrawView:_initSpine()
	self:_loadSpine(self._roleView_role1, spineUrl[1], spinePos[3])
end

function CaiqingdrawView:_initView(msg)
	CaiqingdrawModel.instance:_setInfoData(msg)
	self._scrollList:reloadData(self:_sortPrizeCfg())

	self._txtlotteryNum.text = CaiqingdrawModel.instance:_getRewardProgress()

	local isRed = self:_canLottery(true)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CAIQINGDRAW_TENLOTTERY, isRed)
	GameUtil.SetActive(self._lotteryBg, false)
	GameUtil.SetActive(self._imgSlogan, true)
	GameUtil.SetActive(self._btnAnim, true)
	GameUtil.SetActive(self._btnTenLottery, true)
end

function CaiqingdrawView:_refreshView()
	CaiQingDrawAgent.instance:sendPM_CaiQingDrawGetInfoReq(self._activityId)
end

function CaiqingdrawView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtNum.text = CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id) and "已抽中" or data.maxHit

	MaterialMgr.setCellByCfg(data.gain, item)
	GameUtil.SetActive(geted, CaiqingdrawModel.instance:_isPlayerRewardGeted(data.id))
end

function CaiqingdrawView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function CaiqingdrawView:_sortPrizeCfg()
	local planId = self._activityCfg.drawPlan
	local maxHitRewardCfg = CaiQingDrawConfig.instance:getMaxHitReward(planId)

	table.sort(maxHitRewardCfg, function(a, b)
		local bHasGet = CaiqingdrawModel.instance:_isPlayerRewardGeted(b.id)
		local aHasGet = CaiqingdrawModel.instance:_isPlayerRewardGeted(a.id)

		if bHasGet == aHasGet then
			return a.maxHit < b.maxHit
		elseif aHasGet then
			return false
		else
			return true
		end
	end)

	return maxHitRewardCfg
end

function CaiqingdrawView:_setTimeUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Caiqingdraw, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function CaiqingdrawView:_playEffect()
	return
end

function CaiqingdrawView:_lotteryCost()
	local costStr = self._activityCfg.cost
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)

	self._txtCost.text = matNum

	MaterialMgr.setIcon(self._costIcon, matType, matId)

	local objList = {
		{
			showAdd = false,
			id = costStr
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function CaiqingdrawView:_animTenSelectState()
	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.SetActive(self._animSelect, isPass)
	GameUtil.SetActive(self._tenSelect, isTen)
end

function CaiqingdrawView:_loadSpine(mainGo, spinePath, pos)
	if self._spineCtrlPool == nil then
		self._spineCtrlPool = {}
	end

	if not self._spineCtrlPool[mainGo] then
		local ctrl = CaiqingdrawSpineCtrl.New()

		self._spineCtrlPool[mainGo] = ctrl

		ctrl:onInit(mainGo, self._view, spinePath)

		pos = pos or {}

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			if not pos[4] then
				local scaleX = scale

				GameUtil.setLocalPos(mainGo, x, y)
				GameUtil.setLocalScale(mainGo, scaleX, scale, scale)
			end
		end
	end
end

function CaiqingdrawView:_clearSpine(mainGo)
	if self._spineCtrlPool then
		local ctrl = self._spineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

function CaiqingdrawView:_clearAllSpine()
	if self._spineCtrlPool then
		for mainGo, ctrl in pairs(self._spineCtrlPool) do
			self:_clearSpine(mainGo)
		end
	end
end

function CaiqingdrawView:_onClickTip()
	TipsFacade.instance:openRulesView("caiqingdraw")
end

function CaiqingdrawView:_onClickTask()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function CaiqingdrawView:_onClickAnim()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		FloatWordMgr.instance:show("首次动画不可跳过哦~")
	else
		local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

		GameUtil.saveUserDayData(self._animationPreKey .. "PassAnim", not isPass)
		GameUtil.SetActive(self._animSelect, not isPass)
	end
end

function CaiqingdrawView:_onClickTenLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.saveUserData(self._animationPreKey .. "Ten", not isTen)
	GameUtil.SetActive(self._tenSelect, not isTen)
end

function CaiqingdrawView:_onClickLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")
	local isCanLottery, curState = self:_canLottery(isTen)

	if not isCanLottery then
		if curState == 1 then
			local limit = self._activityCfg.weekLimit

			FloatWordMgr.instance:show(string.format("目前已达到每周抽奖次数上限%s次，等周五5点刷新后再来抽吧~", limit))

			return
		elseif curState == 2 then
			FloatWordMgr.instance:show("请去获得足够的抽奖道具后再来抽吧~")

			return
		end
	end

	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	if not isPass then
		self._status = spineAnim[2]
		self._isPlayAnim = false

		GameUtil.SetActive(self._lotteryBg, true)
		GameUtil.SetActive(self._imgSlogan, false)
		GameUtil.SetActive(self._btnAnim, false)
		GameUtil.SetActive(self._btnTenLottery, false)
		self._spineCtrlPool[self._roleView_role1]:_playAnim(self._status, false, function()
			self._status = spineAnim[1]
			self._isPlayAnim = false

			self._spineCtrlPool[self._roleView_role1]:_playAnim("idle-all", true)
			GameUtil.SetActive(self._lotteryBg, false)
			GameUtil.SetActive(self._imgSlogan, true)
			GameUtil.SetActive(self._btnAnim, true)
			GameUtil.SetActive(self._btnTenLottery, true)
		end)
		settimer(0.5, self._playHitEffect, self, false)
		settimer(2, self._CaiQingDrawPrizeReq, self, false)
	else
		self:_CaiQingDrawPrizeReq()
	end
end

function CaiqingdrawView:_spineAnim()
	if self._isPlayAnim then
		return
	end

	GameUtil.SetActive(self._spineAnimRoot, true)
	GameUtil.SetActive(self._roleView_role1, false)
	GameUtil.SetActive(self._roleView_role2, false)

	if self._status == spineAnim[1] then
		self._isPlayAnim = true

		local function callBack()
			self._status = spineAnim[2]
			self._isPlayAnim = false
		end

		self:_playAnimSpine(self._status, callBack)
	elseif self._status == spineAnim[2] then
		self._isPlayAnim = true

		local function callBack()
			self._status = spineAnim[3]
			self._isPlayAnim = false
		end

		self:_playAnimSpine(self._status, callBack)
	elseif self._status == spineAnim[3] then
		self._isPlayAnim = true

		local function callBack()
			self:_CaiQingDrawPrizeReq()
			GameUtil.SetActive(self._spineAnimRoot, false)
			GameUtil.SetActive(self._roleView_role1, true)
			GameUtil.SetActive(self._roleView_role2, true)

			self._status = spineAnim[1]

			self._spineCtrlPool[self._spineRoot_Role1]:playDefaultAnim()
		end

		self:_playAnimSpine(self._status, callBack)
	end
end

function CaiqingdrawView:_playAnimSpine(animName, callBack)
	if self._spineCtrlPool[self._spineRoot_Role1] and not string.nilorempty(animName) then
		self._spineCtrlPool[self._spineRoot_Role1]:_playAnim(animName, false, callBack)
	end
end

function CaiqingdrawView:_getDrawAnimPath()
	return drawAnimPath[3]
end

function CaiqingdrawView:_CaiQingDrawPrizeReq()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		GameUtil.saveUserDayData(self._animationPreKey .. "FristAnim", true)
	end

	local isTen = checkbool(GameUtil.getUserData(self._animationPreKey .. "Ten"))

	CaiQingDrawAgent.instance:sendPM_CaiQingDrawPrizeReq(self._activityId, isTen)
	removetimer(self._CaiQingDrawPrizeReq, self)
	removetimer(self._spineAnim, self)
end

function CaiqingdrawView:_canLottery(isTen)
	local weekLotteryCount = CaiqingdrawModel.instance:_getRewardProgress()

	if isTen then
		if not (weekLotteryCount + 10) then
			local addWeekCount = weekLotteryCount + 1

			if addWeekCount > self._activityCfg.weekLimit then
				return false, 1
			else
				local costStr = self._activityCfg.cost
				local arr = string.split(costStr, "#")

				for i, cfgStr in ipairs(arr) do
					local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)
					local haveNum = MaterialModel.instance:getMaterialsNumber(matType, matId) or 0

					if isTen then
						if not (matNum * 10) then
							local needCostNum = matNum

							if haveNum < needCostNum then
								return false, 2
							end
						end
					end
				end
			end

			return true
		end
	end
end

function CaiqingdrawView:_playHitEffect()
	removetimer(self._playHitEffect, self)

	local effName = "1025/fx_longhunchoujiang_eff.prefab"

	if self._hiteffectHandler then
		UIEffectManager.instance:stopEffect(self._hiteffectHandler)

		self._hiteffectHandler = nil
	end

	self._hiteffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._hiteffectHandler:setParent(self.mainGO.transform)
	self._hiteffectHandler:setScale(10)
	self._hiteffectHandler:setLocalPos(0, -90, 0)
end

return CaiqingdrawView
