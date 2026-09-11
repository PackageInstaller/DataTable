local AutoChessActionBaseNode = class("AutoChessActionBaseNode")

function AutoChessActionBaseNode:Ctor()
	self:Reset()
	self:OnCtor()
end

function AutoChessActionBaseNode:Reset()
	self.nextNode = nil
	self.status = AutoChessConst.ACTION_NODE_STATUS.NEW
	self.player = nil
	self.blackboard = nil
	self.actionData = nil
end

function AutoChessActionBaseNode:Init(arg_3_1, arg_3_2, arg_3_3)
	self.player = arg_3_1
	self.blackboard = arg_3_2
	self.actionData = arg_3_3
end

function AutoChessActionBaseNode:Enter()
	if self.actionData then
		AutoChessBattleRecord.PrintRecord(self.actionData)
	end

	self.status = AutoChessConst.ACTION_NODE_STATUS.RUNNING

	self:OnEnter()
end

function AutoChessActionBaseNode:Execute()
	self:OnExecute()

	return self.status
end

function AutoChessActionBaseNode:Exit()
	self:OnExit()
end

function AutoChessActionBaseNode:Dispose()
	self:Reset()
	self:OnDispose()
end

function AutoChessActionBaseNode:OnCtor()
	return
end

function AutoChessActionBaseNode:OnEnter()
	return
end

function AutoChessActionBaseNode:OnExecute()
	return
end

function AutoChessActionBaseNode:OnExit()
	return
end

function AutoChessActionBaseNode:OnDispose()
	return
end

return AutoChessActionBaseNode
