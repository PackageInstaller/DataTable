-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/view/BrotherHoodMainView.lua

module("logic.extensions.brotherhood.view.BrotherHoodMainView", package.seeall)

local BrotherHoodMainView = class("BrotherHoodMainView", ViewComponent)

function BrotherHoodMainView:ctor()
	BrotherHoodMainView.super.ctor(self)
end

function BrotherHoodMainView:buildUI()
	BrotherHoodMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._tablecell = self:getGo("cell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BrotherHoodMainView:bindEvents()
	BrotherHoodMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function BrotherHoodMainView:unbindEvents()
	BrotherHoodMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function BrotherHoodMainView:onEnter()
	BrotherHoodMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BrotherHoodPanelInfoRes, self._onPanelInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BrotherHoodRewardProcessRes, self._onRewardProcessRes, self)

	self._activityId = BrotherHoodModel.instance:getActivityId()

	if self._activityId == 0 then
		local title = lang("tip")
		local text = lang("outtime")

		local function func()
			self:_onClickClose()
		end

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)

		return
	end

	self._cfgActivity = BrotherHoodConfig.instance:getActivityCfg(self._activityId)
	self._rewardPlanId = self._cfgActivity.plotPlanReward

	self:_initTimeShow()
	self:_setGoldBarCon()
	self:_initRewardParams()
	self:_setPlayerScore()
	self:_initTableview()
	BrotherHoodAgent.instance:sendPM_BrotherHoodPanelInfoReq(self._activityId)
end

function BrotherHoodMainView:onExit()
	BrotherHoodMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherHoodPanelInfoRes, self._onPanelInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherHoodRewardProcessRes, self._onRewardProcessRes, self)
	self._playerSliderMo:onExit()
	self._scrollList:dispose()
end

function BrotherHoodMainView:_onClickClose()
	self:close()
end

function BrotherHoodMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "brotherhoodmain_rule")
end

function BrotherHoodMainView:_onPanelInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
	self:_updateTableview()
end

function BrotherHoodMainView:_onRewardProcessRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function BrotherHoodMainView:_initTimeShow()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.BrotherHood, self._activityId)
	local dateStart = GameUtil.time2date(startTime)
	local dateEnd = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("%s：%02d.%02d-%02d.%02d", lang("activitytime"), dateStart.month, dateStart.day, dateEnd.month, dateEnd.day)
end

function BrotherHoodMainView:_setGoldBarCon()
	local energyMat = self._cfgActivity.energy
	local energyList = {}

	if not string.nilorempty(energyMat) then
		local energyMatArr = string.splitToNumber(energyMat, ":")
		local energyId = energyMatArr[2]
		local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)
		local isNeedShowAdd = not string.nilorempty(energyCfg.source)

		local function callBack()
			EnergyController.instance:openBuyView(energyId)
		end

		energyList = {
			id = energyMat,
			showAdd = isNeedShowAdd,
			showAddCallBack = callBack
		}

		local list = {}

		table.insert(list, energyList)
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function BrotherHoodMainView:_initRewardParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = BrotherHoodConfig.instance:getRewardList(self._rewardPlanId)

	function playerParam.getPlayerProgress()
		return BrotherHoodModel.instance:getRewardProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.matchNum
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.reward, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return BrotherHoodModel.instance:isPlayerRewardCanGet(rewardCfg.progress, rewardCfg.matchNum)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return BrotherHoodModel.instance:isPlayerRewardGeted(rewardCfg.progress)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		BrotherHoodAgent.instance:sendPM_BrotherHoodRewardProcessReq(self._activityId, rewardCfg.progress)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function BrotherHoodMainView:_setPlayerScore()
	self._txtPlayerScore.text = BrotherHoodModel.instance:getRewardProgress()
end

function BrotherHoodMainView:_initTableview()
	local idList = self._cfgActivity.plotPlan
	local cfgList = {}

	for i, plotPlanId in ipairs(idList) do
		local cfg = BrotherHoodConfig.instance:getPlotCfgById(plotPlanId)

		if cfg then
			table.insert(cfgList, cfg)
		end
	end

	self._cfgList = cfgList

	self:_updateTableview()
end

function BrotherHoodMainView:_updateTableview()
	self._scrollList:reloadData(self._cfgList)
end

function BrotherHoodMainView:_updateCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local redPoint = goutil.findChild(cell, "redPoint")

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("brotherhood", data.iconName))

	txtTitle.text = data.titleName

	local isCanOpen = not BrotherHoodModel.instance:isFinishPlotPlan(data.plotPlan)

	goutil.setActive(redPoint, isCanOpen)

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:AddClickListener(function()
		if isCanOpen then
			UIStateManager.instance:push(ViewName.BrotherHoodStoryView, self._activityId, data.plotPlan)
		else
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, data.story)
		end
	end)
end

function BrotherHoodMainView:_clearCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

return BrotherHoodMainView
