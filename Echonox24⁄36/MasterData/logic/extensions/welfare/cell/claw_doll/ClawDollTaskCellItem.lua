-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/claw_doll/ClawDollTaskCellItem.lua

module("logic.extensions.welfare.cell.claw_doll.ClawDollTaskCellItem", package.seeall)

local M = class("ClawDollTaskCellItem")

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
	local mainGO = self:getMainGo()

	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
	self._txtDesc = goutil.findChildTextComponent(mainGO, "txtDesc")
	self._imgProcess = goutil.findChildImageComponent(mainGO, "Image1/fill")
	self._txtProcess = goutil.findChildTextComponent(mainGO, "txtProgress")
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGet"))
	self._btnJump = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnJump"))
	self._txtDone = goutil.findChild(mainGO, "txtDone")
	self._txtDoing = goutil.findChild(mainGO, "txtDoing")

	local goItem = goutil.findChild(mainGO, "cell/backpack_item").gameObject

	goutil.setActive(goItem, true)

	self._itemCell = Astral.LuaComponentContainer.Add(goItem, ItemCell)

	self._itemCell:Awake()
	self._itemCell:setShowSelectedEffect(false)
end

function M:bindEvents()
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnReceive:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnJump:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
end

function M:getMainGo()
	return self.mainGO
end

function M:getId()
	return self._id
end

function M:getJumpId()
	return self._jumpId
end

function M:_onClickJump()
	local jumpId = self:getJumpId()

	if jumpId <= 0 then
		return
	end

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onClickGet()
	if self._status == ClawDollConfig.TaskState.Doing then
		-- block empty
	elseif self._status == ClawDollConfig.TaskState.IsReceived then
		-- block empty
	elseif self._status == ClawDollConfig.TaskState.CanReceive then
		TaskAgent.instance:sendRewardRequest({
			self._id
		})
	end
end

function M:updateData(taskMo)
	self._id = taskMo:getId()
	self._jumpId = taskMo:getJumpId()
	self._status = taskMo:getRewardStatus()
	self._txtDesc.text = taskMo:getDesc()
	self._txtProcess.text = string.format("(%s/%s)", taskMo:getCount(), taskMo:getMaxCnt())
	self._imgProcess.fillAmount = taskMo:getCount() / taskMo:getMaxCnt()

	local itemData = taskMo:getRewardItemData()

	self._itemCell:updateData(itemData)
	goutil.setActive(self._btnReceive.gameObject, self._status == ClawDollConfig.TaskState.CanReceive)

	local showJump = self._status == ClawDollConfig.TaskState.Doing and self:getJumpId() > 0

	goutil.setActive(self._btnJump.gameObject, showJump)

	local showTips = self._status ~= ClawDollConfig.TaskState.CanReceive

	if showTips and showJump then
		showTips = false
	end

	goutil.setActive(self._txtDone, self._status == ClawDollConfig.TaskState.IsReceived and showTips)
	goutil.setActive(self._txtDoing, self._status == ClawDollConfig.TaskState.Doing and showTips)

	self._canvasGroup.alpha = self._status == ClawDollConfig.TaskState.IsReceived and 0.5 or 1
end

return M
