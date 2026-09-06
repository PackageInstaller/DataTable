-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodHelpSurePopView.lua

module("logic.extensions.aoqigod.view.AoqiGodHelpSurePopView", package.seeall)

local AoqiGodHelpSurePopView = class("AoqiGodHelpSurePopView", ViewComponent)

function AoqiGodHelpSurePopView:ctor()
	AoqiGodHelpSurePopView.super.ctor(self)
end

function AoqiGodHelpSurePopView:buildUI()
	AoqiGodHelpSurePopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._con = goutil.findChild(self.mainGO, "con")
	self._petCon = goutil.findChild(self.mainGO, "con/img/pet")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._iconPrize = goutil.findChild(self.mainGO, "prize/icon")
	self._txtPrize = goutil.findChildTextComponent(self.mainGO, "prize/txt")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._txtScore = self:getTxt("txtScore")
	self._txtCharm = self:getTxt("txtCharm")
	self._txtContent = MaterialMgr.findGraphicText(self.mainGO, "prize/txtContent")
	self._txtDailyPrize = goutil.findChildTextComponent(self.mainGO, "txtDailyPrize")
	self._dailyPrizeStr = self._txtDailyPrize.text
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function AoqiGodHelpSurePopView:bindEvents()
	AoqiGodHelpSurePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function AoqiGodHelpSurePopView:unbindEvents()
	AoqiGodHelpSurePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function AoqiGodHelpSurePopView:onEnter()
	AoqiGodHelpSurePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._helpItem = params[2]
	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodAcceptHelpItemRes, self._handlePM_AoqiGodAcceptHelpItemRes, self)
	self:_onUpdate()
	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function AoqiGodHelpSurePopView:onExit()
	AoqiGodHelpSurePopView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconPrize)
	MaterialMgr.clearIcon(self._petCon)
	removetimer(self._onTicking, self)
end

function AoqiGodHelpSurePopView:_handlePM_AoqiGodAcceptHelpItemRes()
	self:close()
	AoqiGodController.instance:enterAoqiGod()

	local helpItem = self._aoqiGodMo:getHelper()
	local result = AoqiGodController.instance:getTryStartHelpResultAndTips(true, self._activityId, helpItem)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	AoqiGodController.instance:enterChallenge(self._activityId, helpItem:getChallengeId())
end

function AoqiGodHelpSurePopView:_onTicking()
	local nowMs = ServerTime.nowMs()
	local leftSec = self._helpItem:getLeftTimeSec(nowMs)

	self._txtLeftTime.text = leftSec > 0 and AoqiGodController.instance:FormatLeftTime(leftSec) or "已过期"
end

function AoqiGodHelpSurePopView:_onUpdate()
	local helpItem = self._helpItem
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, helpItem:getChallengeId())
	local skinId = clgData.skinId
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)

	MaterialMgr.setIcon(self._petCon, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(self._con, function()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end)

	self._txtName.text = helpItem:getPlayerName()

	local rewards = string.split(clgData.godPrize, "#")
	local rewardStrList = {}

	for i, itemStr in ipairs(rewards) do
		local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
		local content = MaterialMgr.getContentMatCfg(matType, matId, 30, -5, MaterialMgr.ICON_TYPE_ICON)

		table.insert(rewardStrList, string.format("%sx%s", content, matNum))
	end

	self._txtContent.text = table.concat(rewardStrList, " ")
	self._txtTips.text = string.format("当前%s/%s人帮打", helpItem:getHelperNum(), helpItem:getHelperLimit())
	self._txtScore.text = clgData.helpAddScore
	self._txtCharm.text = helpItem:getCharmValue()

	local cur = self._aoqiGodMo:getDailyHelperTimes()
	local max = self._aoqiGodMo:getGodDailyTimes()
	local left = Mathf.Max(max - cur, 0)

	self._txtDailyPrize.text = string.format(self._dailyPrizeStr, left, max)
end

function AoqiGodHelpSurePopView:_onClickBtnSure()
	local result, tips = AoqiGodController.instance:getTryAcceptHelpResultAndTips(true, self._activityId, self._helpItem)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function successFunc()
		local targetUserId = self._helpItem:getUserId()
		local id = self._helpItem:getId()

		AoqiGodController.instance:sendPM_AoqiGodAcceptHelpItemReq(self._activityId, targetUserId, id)
	end

	local cur = self._aoqiGodMo:getDailyHelperTimes()
	local max = self._aoqiGodMo:getGodDailyTimes()
	local isHavePrize = max >= cur + 1
	local key = string.format("AoqiGod_HelpSure_%s", self._activityId)

	if not isHavePrize and not GameUtil.getUserDayData(key) then
		local togText = "今日不再提示"
		local text = "今日已无奖励次数，完成挑战不再获得奖励，但仍增加大神积分和魅力值，参与排名"

		local function funcTog()
			GameUtil.saveUserDayData(key, true)
		end

		TipsFacade.instance:openPopupWindowNoCancelWithTog("提示", text, successFunc, funcTog, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
	else
		successFunc()
	end
end

return AoqiGodHelpSurePopView
