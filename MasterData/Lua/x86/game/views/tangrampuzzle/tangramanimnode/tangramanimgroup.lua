local TangramAutoPutNode = class("TangramAutoPutNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramAutoPutNode:Ctor()
	self.nodeDic_ = {}
	self.nodeSize_ = 0
end

function TangramAutoPutNode:Dispose()
	self.root_ = nil
	self.nodeDic_ = nil
end

function TangramAutoPutNode:Add(arg_3_1)
	self.nodeSize_ = self.nodeSize_ + 1
	self.nodeDic_[arg_3_1] = true
end

function TangramAutoPutNode:RunFunc()
	self.runningNodeCount_ = self.nodeSize_

	for iter_4_0, iter_4_1 in pairs(self.nodeDic_) do
		iter_4_0:RunFunc()
	end
end

function TangramAutoPutNode:SetNodeRunComplete()
	self.runningNodeCount_ = self.runningNodeCount_ - 1

	if self.runningNodeCount_ == 0 then
		self.root_:SetNodeRunComplete()
	end
end

return TangramAutoPutNode
