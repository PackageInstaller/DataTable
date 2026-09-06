-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaTaskView.lua

module("logic.extensions.arena.view.ArenaTaskView", package.seeall)

local ArenaTaskView = class("ArenaTaskView", ViewComponent)

function ArenaTaskView:ctor()
	ArenaTaskView.super.ctor(self)

	self._taskCell = {}
end

function ArenaTaskView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addListener(GlobalNotify.ArenaTaskRefresh, self._onTaskRefresh, self)
end

function ArenaTaskView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.ArenaTaskRefresh, self._onTaskRefresh, self)
end

function ArenaTaskView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._Pnl_Task = self:getGo("Pnl_Task")
end

function ArenaTaskView:destroyUI()
	return
end

function ArenaTaskView:onEnter()
	local param = self._viewPresentor:getFirstParam()

	self:_onInitTasks(param)
end

function ArenaTaskView:onEnterFinished()
	return
end

function ArenaTaskView:onExit()
	for k, go in pairs(self._taskCell) do
		ArenaTaskCell.AddOnce(go):onExit()
	end
end

function ArenaTaskView:onExitFinished()
	return
end

function ArenaTaskView:_onClickClose()
	self:close()
end

function ArenaTaskView:_onInitTasks(taskInfos)
	for i, v in ipairs(taskInfos) do
		if i > 2 then
			return nil
		end

		local taskCell = self._taskCell[i]

		if not taskCell then
			taskCell = goutil.clone(self._Pnl_Task)

			taskCell.gameObject:SetActive(true)
			goutil.addChildToParent(taskCell, self.mainGO)

			self._taskCell[i] = taskCell
		end

		ArenaTaskCell.AddOnce(taskCell):initCell(v, i)

		if i == 2 then
			local pos = taskCell.gameObject.transform.localPosition

			taskCell.gameObject.transform.localPosition = Vector3.New(math.abs(pos.x), pos.y, pos.z)
		end
	end
end

function ArenaTaskView:_onTaskRefresh(taskData)
	ArenaTaskCell.AddOnce(self._taskCell[taskData.index + 1]):onRefreshCell(taskData)
end

return ArenaTaskView
