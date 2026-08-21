-- chunkname: @IQIGame\\Module\\RedDot\\RedDotNode.lua

RedDotNode = RedDotNode or {}

function RedDotNode.New(cid)
	local self = {}

	self.cid = cid
	self.parentNode = nil
	self.redDotCnt = 0
	self.objs = {}

	setmetatable(self, RedDotNode)

	function self.refresh()
		for _, obj in pairs(self.objs) do
			if self.redDotCnt > 0 then
				obj:SetActive(true)
			else
				obj:SetActive(false)
			end
		end
	end

	return self
end
