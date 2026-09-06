-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementRewardView.lua

module("logic.extensions.achievement.view.AchievementRewardView", package.seeall)

local AchievementRewardView = class("AchievementRewardView", TableViewComponent)

function AchievementRewardView:ctor()
	AchievementRewardView.super.ctor(self)
end

function AchievementRewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function AchievementRewardView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function AchievementRewardView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function AchievementRewardView:buildUI()
	AchievementRewardView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
end

function AchievementRewardView:destroyUI()
	return
end

function AchievementRewardView:onEnter()
	AchievementController.instance:registerLocalNotify("GainAchievementLevelPrize", self._onGainLevelPrize, self)
	self:_refreshList()
end

function AchievementRewardView:_refreshList()
	self._curViewDatas = {}

	local t = AchievementConfig.instance:getLvCfgList()

	for _, v in ipairs(t) do
		if not string.nilorempty(v.prize) then
			table.insert(self._curViewDatas, v)
		end
	end

	table.sort(self._curViewDatas, function(a, b)
		local statusA = AchievementModel.instance:getLevelPrizeStatus(a.level)
		local statusB = AchievementModel.instance:getLevelPrizeStatus(b.level)

		if statusA ~= statusB then
			return statusB < statusA
		else
			return a.level < b.level
		end
	end)
	self:reloadData()
end

function AchievementRewardView:onEnterFinished()
	return
end

function AchievementRewardView:onExit()
	AchievementController.instance:unregisterLocalNotify("GainAchievementLevelPrize", self._onGainLevelPrize, self)
end

function AchievementRewardView:onExitFinished()
	return
end

function AchievementRewardView:_onClickClose()
	self:close()
end

function AchievementRewardView:_cellSize(view, idx)
	return 1000, 165
end

function AchievementRewardView:_onReloadFinish()
	self._tableview:SetOffsetWithoutRefresh(0)
end

function AchievementRewardView:_updateCell(view, cell, data)
	local mats = string.split(data.prize, "#")

	for i = 1, 2 do
		local item = {}

		item.mainGO = goutil.findChild(cell.gameObject, "items/" .. i)

		goutil.setActive(item.mainGO, i <= #mats)

		if i <= #mats then
			MaterialMgr.setCellByCfg(mats[i], item.mainGO)
		end
	end

	local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")
	local imgNotFinish = goutil.findChild(cell.gameObject, "imgNotFinish")
	local imgReceived = goutil.findChild(cell.gameObject, "imgReceived")
	local txtLevel = goutil.findChildComponent(cell.gameObject, "txtreward", "Text")

	txtLevel.text = data.level

	local status = AchievementModel.instance:getLevelPrizeStatus(data.level)

	goutil.setActive(btnReceive.gameObject, status == 3)
	goutil.setActive(imgNotFinish, status == 2)
	goutil.setActive(imgReceived, status == 1)
	btnReceive:RemoveClickListener()
	btnReceive:AddClickListener(function()
		self:_onClickReceive(data.level)
	end, self)
end

function AchievementRewardView:_onClickReceive(level)
	AchievementAgent.instance:sendPM_GainAchievementLevelPrizeReq(level)
end

function AchievementRewardView:_onGainLevelPrize()
	self:_refreshList()
end

return AchievementRewardView
