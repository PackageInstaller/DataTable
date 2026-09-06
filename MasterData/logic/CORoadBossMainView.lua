-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossMainView.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossMainView", package.seeall)

local CORoadBossMainView = class("CORoadBossMainView", ViewComponent)

function CORoadBossMainView:buildUI()
	CORoadBossMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtDamage = goutil.findChildTextComponent(self.mainGO, "infoCol/totalDamage/txtDamage")
	self._txtRank = goutil.findChildTextComponent(self.mainGO, "infoCol/rank/txtRank")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "infoCol/txtDesc")

	local itemScrollerview = goutil.findChild(self.mainGO, "infoCol/itemCol/itemScrollerview")
	local itemScrollercell = goutil.findChild(self.mainGO, "infoCol/itemCol/itemScrollercell")

	self._sliderComp = self:getSlider("progressCol/progressSlider")
	self._txtTotalValue = goutil.findChildTextComponent(self.mainGO, "progressCol/txtTotalValue")
	self._txtTargetValue = goutil.findChildTextComponent(self.mainGO, "progressCol/txtTargetValue")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge")
	self._txtRemain = goutil.findChildTextComponent(self.mainGO, "btnChallenge/txtRemain")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnReward = goutil.findChild(self.mainGO, "btnReward")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._boosCon = goutil.findChild(self.mainGO, "boosCon")
	self._bgEff = nil
	self._itemScrollList = ScrollerList.create(itemScrollerview, itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function CORoadBossMainView:bindEvents()
	CORoadBossMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
end

function CORoadBossMainView:unbindEvents()
	CORoadBossMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReward)
end

function CORoadBossMainView:onEnter()
	CORoadBossMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.BOSS

	local key = "COR" .. "S" .. self._activityId

	local function firstTimeCallback()
		local storyId = CantonOperaRoadConfig.instance:getCorSTORYIDAsBOSS()

		if storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.CORBossInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORBossRankRes, self._onUpdateInfoColUI, self)
	GlobalDispatcher:addListener(GlobalNotify.CORBossFormRes, self._handleBossFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadBossInfoReq(self._activityId)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadBossRankReq(self._activityId)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
end

function CORoadBossMainView:onExit()
	CORoadBossMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORBossInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORBossRankRes, self._onUpdateInfoColUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORBossFormRes, self._handleBossFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._loader then
		self._loader = RoleObjectPool.instance:removeRole(self._loader)
	end

	self._itemScrollList:dispose()
end

function CORoadBossMainView:_sendInfoReq()
	return
end

function CORoadBossMainView:_onSetUI()
	local skinId = 10369
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._boosCon, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function CORoadBossMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORoadBossMainView:_onUpdateData()
	return
end

function CORoadBossMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateInfoColUI()
	self:_onUpdateProgressColUI()
end

function CORoadBossMainView:_onUpdatePlaneUI()
	local remainTimes = CantonOperaRoadController.instance:getRemainChallengeTimesAsCORBoss()
	local maxTimes = CantonOperaRoadController.instance:getMaxChallengeTimesAsCORBoss()

	self._txtRemain.text = string.format("挑战次数：%d/%d", remainTimes, maxTimes)
end

function CORoadBossMainView:_checkIsCanEnter()
	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(self._modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:close()
	end
end

function CORoadBossMainView:_onUpdateInfoColUI()
	local damage = CantonOperaRoadModel.instance:getTotalDmgAsCORBoss()

	self._txtDamage.text = damage >= 100000000 and string.format("%.1f亿", damage / 100000000) or damage > 0 and string.format("%.1f万", damage / 10000) or "暂无"

	local myRank = CantonOperaRoadModel.instance:getMyRankAsCORBoss()

	if myRank > 0 then
		self._txtRank.text = myRank
	end

	local prizesStr = CantonOperaRoadConfig.instance:getCorCommonValue("BOSS_PRIZE_PREVIEW")

	if not string.nilorempty(prizesStr) then
		local prizeArr = string.split(prizesStr, "#")

		self._itemScrollList:reloadData(prizeArr)
		self._itemScrollList:dragNotifyParent()
	end
end

function CORoadBossMainView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function CORoadBossMainView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function CORoadBossMainView:_onUpdateProgressColUI()
	local curProgress = CantonOperaRoadModel.instance:getModelProgress(self._modelId)
	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(self._modelId)

	self._txtTotalValue.text = string.format("全服伤害达到：<color=#eb4642>%s</color>亿", curProgress)
	self._txtTargetValue.text = maxProgress

	local progressPercentage = CantonOperaRoadController:getProgressPercentageAsCORModel(self._modelId)

	self._sliderComp:SetValue(progressPercentage)
end

function CORoadBossMainView:_onClickBtnTip()
	return
end

function CORoadBossMainView:_onClickBtnChallenge()
	local result = CantonOperaRoadController.instance:getEnterChallengeResultAsCORBoss()

	if result ~= GameEnum.ResultCode.Success then
		local str = ""

		str = result == GameEnum.ResultCode.NotEnoughTimes and "已达挑战次数上限" or result == GameEnum.ResultCode.NoEnergy and "能量不足" or CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(str) then
			FloatWordMgr.instance:show(str)
		end

		return
	end

	CantonOperaRoadModel.instance:clearViewInfos()
	CantonOperaRoadModel.instance:addViewInfo(ViewName.CORoadMainView)
	CantonOperaRoadModel.instance:addViewInfo(self._viewPresentor.viewName)

	local curTimes = CantonOperaRoadModel.instance:getCostChallengeTimesAsCORBoss()

	CantonOperaRoadController.instance:sendPM_CantonOperaRoadBossFormReq(self._activityId, curTimes + 1)
end

function CORoadBossMainView:_handleBossFormRes()
	CantonOperaRoadController.instance:enterBattleAsCORBoss()
end

function CORoadBossMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.CORoadBossRankView)
end

function CORoadBossMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.CORoadBossPrizeView)
end

return CORoadBossMainView
