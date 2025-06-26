

module("MapGridRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_row = refData.row
	self.m_col = refData.col
	self.m_gridSize = refData.gridSize
	self.m_centerPos = refData.centerPos
end

function getRefID(self)
	return self.m_refID
end

function getRow(self)
	return self.m_row
end

function getCol(self)
	return self.m_col
end

function getGridSize(self)
	return self.m_gridSize
end

function getCenterPos(self)
	return self.m_centerPos
end

return _M
