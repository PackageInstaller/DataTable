local TangramBaseNode = class("TangramBaseNode")

function TangramBaseNode:Ctor()
	return
end

function TangramBaseNode:Init(arg_2_1, arg_2_2, arg_2_3)
	self.root_ = arg_2_1
	self.blackboard_ = arg_2_2
	self.manager_ = arg_2_3
end

function TangramBaseNode:RunFunc()
	self.root_:SetNodeRunComplete()
end

function TangramBaseNode:Dispose()
	self.root_ = nil
	self.blackboard_ = nil
	self.manager_ = nil
end

return TangramBaseNode
