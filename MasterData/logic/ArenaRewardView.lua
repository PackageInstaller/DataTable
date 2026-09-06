-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaRewardView.lua

module("logic.extensions.arena.view.ArenaRewardView", package.seeall)

local ArenaRewardView = class("ArenaRewardView", ViewComponent)

function ArenaRewardView:ctor()
	ArenaRewardView.super.ctor(self)
end

function ArenaRewardView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_Week:AddClickListener(self._OnClickWeek, self)
	self._Btn_Rank:AddClickListener(self._OnClickRank, self)
	self._Btn_Day:AddClickListener(self._OnClickDay, self)
end

function ArenaRewardView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Week:RemoveClickListener()
	self._Btn_Rank:RemoveClickListener()
	self._Btn_Rank:RemoveClickListener()
	self._Btn_Day:RemoveClickListener()
end

function ArenaRewardView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._Btn_Week = self:getBtn("Marks/BtnWeek")
	self._week_img_redpoint = self:getGo("Marks/BtnWeek/img_redpoint")
	self._Btn_Rank = self:getBtn("Marks/BtnRank")
	self._Btn_Day = self:getBtn("Marks/BtnDay")
	self._rank_img_redpoint = self:getGo("Marks/BtnRank/img_redpoint")
	self._weekSel = self:getGo("Marks/BtnWeek/Sel")
	self._rankSel = self:getGo("Marks/BtnRank/Sel")
	self._daySel = self:getGo("Marks/BtnDay/Sel")
	self._weekUnSel = self:getGo("Marks/BtnWeek/Txt2")
	self._rankUnSel = self:getGo("Marks/BtnRank/Txt2")
	self._dayUnSel = self:getGo("Marks/BtnDay/Txt2")
	self._Pnl_Week = self:getGo("Pnl_Week")
	self._Pnl_Rank = self:getGo("Pnl_Rank")
	self._Pnl_DayCon = self:getGo("Pnl_Day")
end

function ArenaRewardView:destroyUI()
	ArenaRankReward.Remove(self._Pnl_Rank)
	ArenaWeekReward.Remove(self._Pnl_Week)
end

function ArenaRewardView:ShowRedPoint()
	if self._rank_img_redpoint then
		GameUtil.SetActive(self._rank_img_redpoint, RedPointModel.instance:isActive(RedPointModel.ID_ARENA))
	end
end

function ArenaRewardView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ArenaAchievePrize, self._onAchieveInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.ArenaGainAchieve, self.AddRankTabRedPointData, self)
	GlobalDispatcher:addListener(GlobalNotify.ArenaGainWeekReward, self.ShowRedPoint, self)
	ArenaRankReward.AddOnce(self._Pnl_Rank):onEnter()
	ArenaWeekReward.AddOnce(self._Pnl_Week):onEnter()
	ArenaAgent.instance:sendGetAchievePrizeInfoReq()

	if RedPointModel.instance:isActive(RedPointModel.ID_ARENA) then
		self:_OnClickRank()
	else
		self:_OnClickDay()
	end

	self:ShowRedPoint()
end

function ArenaRewardView:onEnterFinished()
	return
end

function ArenaRewardView:onExit()
	ArenaRankReward.AddOnce(self._Pnl_Rank):onExit()
	ArenaWeekReward.AddOnce(self._Pnl_Week):onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ArenaAchievePrize, self._onAchieveInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.ArenaGainAchieve, self.AddRankTabRedPointData, self)
	GlobalDispatcher:removeListener(GlobalNotify.ArenaGainWeekReward, self.ShowRedPoint, self)
end

function ArenaRewardView:onExitFinished()
	return
end

function ArenaRewardView:_onClickClose()
	self.rank_bitTable = nil
	self.rank_maxTopGroupId = nil

	self:close()
end

function ArenaRewardView:_refreshObjs(index)
	local isWeek = index == 3
	local isRank = index == 2
	local isday = index == 1

	self._Pnl_Week:SetActive(isWeek)
	self._weekSel:SetActive(isWeek)
	self._weekUnSel:SetActive(not isWeek)
	self._rankSel:SetActive(isRank)
	self._rankUnSel:SetActive(not isRank)
	self._daySel:SetActive(isday)
	self._dayUnSel:SetActive(not isday)
	self._Pnl_Rank:SetActive(isRank)
	goutil.setActive(self._Pnl_DayCon, isday)

	if isday then
		self:showTabAt(self._Pnl_DayCon, ViewName.ArenaWeekRewardTip)
		GlobalDispatcher:dispatch(ArenaWeekRewardTip.ForReloadData)
	end
end

function ArenaRewardView:_OnClickWeek()
	self:_refreshObjs(3)
end

function ArenaRewardView:_OnClickRank()
	self:_refreshObjs(2)
end

function ArenaRewardView:AddRankTabRedPointData(result)
	if self.rank_bitTable then
		for _, groupId in ipairs(result.groupId or {}) do
			self.rank_bitTable[32 - groupId] = 1
		end
	end

	self:ShowRedPoint()
end

function ArenaRewardView:_onAchieveInfo(info)
	ArenaRankReward.AddOnce(self._Pnl_Rank):onRefreshInfo(info)
	self:ShowRedPoint()
end

function ArenaRewardView:_OnClickDay()
	self:_refreshObjs(1)
end

return ArenaRewardView
