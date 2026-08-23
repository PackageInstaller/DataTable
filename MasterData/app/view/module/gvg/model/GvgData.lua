local GvgData = class("GvgData")

function GvgData:ctor()
	self:initData()
end

function GvgData:initData()
	self._hasData = false
end

function GvgData:resetInstance()
	self:initData()
end

function GvgData:hasData()
	return self._hasData
end

function GvgData:onS2CGvgInfo(arg_5_1)
	self._hasData = true
end

function GvgData:reqGvgInfo()
	return
end

return GvgData
