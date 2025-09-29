-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerItem.lua

module("logic.extensions.msgdebugger.MsgDebuggerItem", package.seeall)

local MsgDebuggerItem = class("MsgDebuggerItem", ListBinderCell)

function MsgDebuggerItem:Awake()
	self._mo = nil
	self._itemClick = Astral.UIClickTrigger.Get(self._go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._txtMsgName = goutil.findChildTextComponent(self._go, "protoMsg/txtMsgName")
	self._txtTime = goutil.findChildTextComponent(self._go, "protoMsg/txtTime")
	self._txtSequence = goutil.findChildTextComponent(self._go, "protoMsg/txtSequence")
	self._imgMsgStatus = goutil.findChildImageComponent(self._go, "protoMsg/imgMsgStatus")
	self._btnCollect = goutil.findChildImageComponent(self._go, "protoMsg/btnCollect")
	self._btnCopy = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "protoMsg/btnCopyParam"))
	self._btnSwitchCollection = Astral.ButtonAdapter.Get(self._btnCollect.gameObject)

	self._btnSwitchCollection:AddClickListener(self._onClickCollection, self)
	self._btnCopy:AddClickListener(self._onClickCopyParam, self)
	GlobalDispatcher:addEventListener(MsgDebugger.EvtModifyParam, self._onModifyParam, self)
end

function MsgDebuggerItem:updateData(mo)
	self._mo = mo

	self:_updateItem()
end

function MsgDebuggerItem:_onModifyParam(paramMO)
	self:_updateItem()
end

function MsgDebuggerItem:_updateItem()
	local msgName = string.format("<size=16><color=#888888>%d_%d</color></size> %s@%d", self._mo.ext, self._mo.cmd, self._mo.pbUpStructName, self._mo.paramCount)

	if self._mo.hasModifyValue then
		self._txtMsgName.text = "<color=red>" .. msgName .. "</color>"
	else
		self._txtMsgName.text = msgName
	end

	self._txtTime.text = os.date("%H:%M:%S", self._mo.time)
	self._txtSequence.text = self._mo.id
	self._imgMsgStatus.color = Astral.ColorUtil.ParseColor(self._mo.isBlock and "#FF0000" or "#00CA34")

	goutil.setActive(self._btnSwitchCollection.gameObject, not MsgDebuggerCollectModel.instance:getInShowCollectList())
end

function MsgDebuggerItem:_onClickItem(eventData, param)
	if MsgDebuggerConfig.NeedPrintStackTrace then
		printWarn(self._mo.callStackTrace)
	end

	MsgDebuggerParamModel.instance:enterMsg(self._mo)
	MsgDebugger.instance:localNotify(MsgDebugger.EvtEnterMsg)
end

function MsgDebuggerItem:_onClickCollection()
	MsgDebuggerCollectModel.instance:checkAddMo(self._mo)
end

function MsgDebuggerItem:_onClickCopyParam()
	local mo = self._mo
	local paramList = mo:getParamList({})
	local paramStrs = ""

	for k, v in ipairs(paramList) do
		local newStr = string.format("%s$%s", v.paramName, v.msgValue)

		if paramStrs == "" then
			paramStrs = newStr
		else
			paramStrs = paramStrs .. "," .. newStr
		end
	end

	print("复制协议", mo.ext, mo.cmd, paramStrs)
	TextUtils.CopyText(string.format("ext:%s cmd:%s value:%s", mo.ext, mo.cmd, paramStrs))
end

function MsgDebuggerItem:OnDestroy()
	GlobalDispatcher:removeEventListener(MsgDebugger.EvtModifyParam, self._onModifyParam, self)

	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end

	if self._btnSwitchCollection then
		self._btnSwitchCollection:RemoveClickListener()

		self._btnSwitchCollection = nil
	end
end

return MsgDebuggerItem
