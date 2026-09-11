local AutoChessActionLink = class("AutoChessActionLink")

function AutoChessActionLink:Ctor()
	self:Reset()
end

function AutoChessActionLink:Reset()
	self.rootNode = nil
	self.lastNode = self.rootNode
	self.runningNode = nil
	self.status = AutoChessConst.ACTION_NODE_STATUS.NEW
end

function AutoChessActionLink:AddNode(arg_3_1)
	if self.rootNode == nil then
		self.rootNode = arg_3_1
	else
		self.lastNode.nextNode = arg_3_1
	end

	self.lastNode = arg_3_1
end

function AutoChessActionLink:Start()
	if self:GetNextRunningNode() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.RUNNING

		self:StartNode()
	else
		self:Finish()
	end
end

function AutoChessActionLink:StartNode()
	self.runningNode:Enter()
end

function AutoChessActionLink:Execute()
	if self.status == AutoChessConst.ACTION_NODE_STATUS.RUNNING then
		self:ExecuteNode()
	end

	return self.status
end

function AutoChessActionLink:ExecuteNode()
	if self.runningNode:Execute() == AutoChessConst.ACTION_NODE_STATUS.FINISH then
		self.runningNode:Exit()

		if self:GetNextRunningNode() then
			self:StartNode()
		else
			self:Finish()
		end
	end
end

function AutoChessActionLink:Finish()
	self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
end

function AutoChessActionLink:GetNextRunningNode()
	if self.status == AutoChessConst.ACTION_NODE_STATUS.NEW then
		if self.rootNode then
			self.runningNode = self.rootNode

			return true
		else
			self.runningNode = nil

			return false
		end
	elseif self.runningNode.nextNode then
		self.runningNode = self.runningNode.nextNode

		return true
	else
		self.runningNode = nil

		return false
	end
end

function AutoChessActionLink:Dispose()
	while self.rootNode do
		self.rootNode:Dispose()
	end

	self:Reset()
end

return AutoChessActionLink
