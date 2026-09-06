-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementItem.lua

module("logic.extensions.achievement.view.AchievementItem", package.seeall)

local AchievementItem = class("AchievementItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function AchievementItem:ctor(go)
	self.mainGO = go
	self._txtName = goutil.findChildComponent(self.mainGO, "txtName", "Text")
	self._txtContent = goutil.findChildComponent(self.mainGO, "txtContent", "Text")
	self._btnReceive = Framework.ButtonAdapter.GetFrom(self.mainGO.gameObject, "btnReceive")
	self._txtFinishTime = goutil.findChildComponent(self.mainGO, "txtFinishTime", "Text")

	self._btnReceive:AddClickListener(self._onClickReceive, self)

	self._goProgress = goutil.findChild(self.mainGO, "progress")
	self._progressBar = goutil.findChildComponent(self.mainGO, "progress/imgProgress", "Image")
	self._txtProgress = goutil.findChildComponent(self.mainGO, "progress/txtProgress", "Text")
	self._imgIcon = goutil.findChildComponent(self.mainGO, "imgIcon", "UIImageSpriteChange")
	self._items = {}

	for i = 1, 4 do
		local item = {}

		item.mainGO = goutil.findChild(self.mainGO, "items/" .. i)
		item.txtNum = goutil.findChildComponent(item.mainGO, "txtNum", "Text")
		item.imgIcon = goutil.findChildComponent(item.mainGO, "imgIcon", "Image")

		table.insert(self._items, item)
	end
end

function AchievementItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, AchievementItem)

	component = component or LuaComponentContainer.Add(go, AchievementItem)

	return component
end

function AchievementItem:onSetMo(mo)
	self._mo = mo
	self._txtName.text = mo.title
	self._txtContent.text = mo.name

	self:_updateItems(mo.prize)

	local msg = AchievementModel.instance:getAchivementMsg(mo.id)
	local cur, total = AchievementModel.instance:getAchivementProgress(mo.id)
	local isFinished = AchievementModel.instance:getAchivementIsFinished(mo.id)
	local isReceived = isFinished and msg.gainPrize == true
	local canReceive = isFinished and msg.gainPrize ~= true

	if isReceived then
		goutil.setActive(self._txtFinishTime.gameObject, true)

		self._txtFinishTime.text = GameUtil.formatTimeStamp("%Y年%m月%d日", msg.achieveTime / 1000)
	else
		goutil.setActive(self._txtFinishTime.gameObject, false)

		self._txtFinishTime.text = ""
	end

	goutil.setActive(self._btnReceive.gameObject, canReceive)
	goutil.setActive(self._goProgress, not isFinished)

	if not isFinished then
		self._txtProgress.text = string.format("<color=#C54949>%s</color>/%s", cur, total)

		if total > 0 then
			self._progressBar.fillAmount = cur / total or 0
		end
	end

	self._imgIcon:SetState(mo.root - 1)
end

function AchievementItem:_updateItems(itemStr)
	local t = string.split(itemStr, "#")

	for i = 1, 4 do
		local item = self._items[i]

		goutil.setActive(item.mainGO, i <= #t)

		if i <= #t then
			MaterialMgr.setCellByCfg(t[i], item.mainGO)
		end
	end
end

function AchievementItem:_onClickReceive()
	AchievementAgent.instance:sendPM_GainAchievementPrizeReq(self._mo.id)
end

return AchievementItem
