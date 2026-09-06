-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaTaskCell.lua

module("logic.extensions.arena.view.ArenaTaskCell", package.seeall)

local ArenaTaskCell = class("ArenaTaskCell")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaTaskCell.AddOnce(go)
	local component = ArenaTaskCell.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaTaskCell)

	return component
end

function ArenaTaskCell.Remove(go)
	LuaComponentContainer.Remove(go, ArenaTaskCell)
end

function ArenaTaskCell.Get(go)
	return (LuaComponentContainer.Get(go, ArenaTaskCell))
end

function ArenaTaskCell:ctor(container)
	self._container = container
end

function ArenaTaskCell:initCell(taskData, index, first)
	GlobalDispatcher:addListener(ArenaAgent.GainDailyTaskPrizeRes, self._gainDailyTaskPrizeRes, self)

	self._taskData = taskData
	self._index = index
	self._refreshed = not first and taskData.hasRefresh or true
	self._progress = taskData.progress or 0

	local cfg = ArenaConfig.instance:getArenaDailyTaskCfgById(taskData.taskId)

	self._progress = math.min(self._progress, cfg.collectProgressNeed)

	local _Txt_title = goutil.findChildTextComponent(self._container, "Txt_title")

	_Txt_title.text = cfg.title

	local _Txt_Content = goutil.findChildTextComponent(self._container, "Txt_Content")

	_Txt_Content.text = cfg.desc .. "(" .. self._progress .. "/" .. cfg.collectProgressNeed .. ")"

	local items = {}
	local icons = {}
	local itemdatas = TableUtil.split(cfg.prize, "#")

	for i = 1, 3 do
		items[i] = goutil.findChild(self._container, "Items/Item_" .. i)
		icons[i] = goutil.findChild(items[i], "Bg")

		items[i]:SetActive(false)
		MaterialMgr.resetAll(items[i])
	end

	for i = 1, #itemdatas do
		items[i]:SetActive(true)
		MaterialMgr.setCellByCfg(itemdatas[i], icons[i])
	end

	self._Btn_Task = goutil.findChild(self._container, "Btn_Task")
	self._imgFinish = goutil.findChild(self._container, "ImgFinish")

	Framework.ButtonAdapter.Get(self._Btn_Task.gameObject):AddClickListener(self._onBtnTask, self)

	self._Btn_Get = Framework.ButtonAdapter.Get(goutil.findChild(self._container, "Btn_Get"))

	self._Btn_Get:AddClickListener(self._onBtnGet, self)

	if self._refreshed or self._progress >= cfg.collectProgressNeed then
		self._Btn_Task.gameObject:SetActive(false)
	end

	GameUtil.SetActive(self._Btn_Get, not taskData.isGain)
	GameUtil.SetGray(self._Btn_Get, self._progress < cfg.collectProgressNeed)
	self._imgFinish:SetActive(taskData.isGain)
end

function ArenaTaskCell:_onBtnTask()
	local cfg = ArenaConfig.instance:getArenaDailyTaskCfgById(self._taskData.taskId)

	if self._progress == cfg.collectProgressNeed then
		-- block empty
	else
		ArenaAgent.instance:sendRefreshDailyTaskInfoReq(self._index - 1)
	end
end

function ArenaTaskCell:_onBtnGet()
	local taskData = self._taskData

	if taskData then
		local cfg = ArenaConfig.instance:getArenaDailyTaskCfgById(taskData.taskId)

		if not cfg then
			return
		end

		if taskData.isGain then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		if self._progress < cfg.collectProgressNeed then
			FloatWordMgr.instance:show("完成以上任务即可领取奖励")

			return
		end

		ArenaController.instance:sendGainDailyTaskPrizeReq(self._index - 1)
	end
end

function ArenaTaskCell:onRefreshCell(taskData, index)
	self:initCell(taskData, taskData.index + 1, true)
end

function ArenaTaskCell:_gainDailyTaskPrizeRes(status, msg)
	if status == 0 then
		local index = msg.index

		if index == self._index - 1 then
			local taskData = self._taskData

			if taskData then
				local cfg = ArenaConfig.instance:getArenaDailyTaskCfgById(taskData.taskId)

				if cfg then
					taskData.isGain = true
					taskData.progress = cfg.collectProgressNeed

					self:initCell(self._taskData, self._index)
				end
			end
		end
	end
end

function ArenaTaskCell:OnDestroy()
	self:onExit()
end

function ArenaTaskCell:onExit()
	GlobalDispatcher:removeListener(ArenaAgent.GainDailyTaskPrizeRes, self._gainDailyTaskPrizeRes, self)
	Framework.ButtonAdapter.Get(self._Btn_Task.gameObject):RemoveClickListener()
	self._Btn_Get:RemoveClickListener()

	for i = 1, 3 do
		local con = goutil.findChild(self._container, "Items/Item_" .. i .. "/Bg")

		MaterialMgr.resetAll(con)
	end
end

return ArenaTaskCell
