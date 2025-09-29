-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeTaskCell.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeTaskCell", package.seeall)

local M = class("PowerChallengeTaskCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnReceive"))
	self._txtReceived = goutil.findChild(self.mainGO, "txtReceived")
	self._unFinishGo = goutil.findChild(self.mainGO, "txtDoing")
	self._cells = {
		goutil.findChild(self.mainGO, "cell/backpack_item1"),
		goutil.findChild(self.mainGO, "cell/backpack_item2")
	}
end

function M:bindEvents()
	self._btnReceive:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnReceive:RemoveClickListener()
end

function M:_onClickGet()
	local taskId = self._task:getId()

	TaskAgent.instance:sendRewardRequest({
		taskId
	})
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.PowerChallenge)
end

function M:updateData(taskId)
	self._task = PowerChallengeModel.instance:getTaskMo(taskId)
	self._txtDesc.text = self._task:getDesc()

	if not string.nilorempty(self._task:getIcon()) then
		IconLoader.setSprite(self._imgIcon, IconType.PowerChallenge, self._task:getIcon())
	else
		goutil.setActive(self._imgIcon.gameObject, false)
	end

	goutil.setActive(self._unFinishGo, false)
	goutil.setActive(self._btnReceive.gameObject, self._task:canGetReward())
	goutil.setActive(self._txtReceived, self._task:getIsFinish())

	if not self._task:canGetReward() and not self._task:getIsFinish() then
		goutil.setActive(self._unFinishGo, true)
	end

	local rewards = self._task:getRewardItemData()

	for idx, reward in ipairs(self._cells) do
		if idx <= #rewards then
			goutil.setActive(self._cells[idx], true)

			local itemView = Astral.LuaComponentContainer.Add(self._cells[idx], ItemCell)

			itemView:setShowSelectedEffect(false)
			itemView:updateData(rewards[idx])
		else
			goutil.setActive(self._cells[idx], false)
		end
	end
end

function M:getCurIndex()
	return self._curIndex
end

return M
