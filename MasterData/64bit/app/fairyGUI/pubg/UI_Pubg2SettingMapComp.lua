local var_0_0 = {}

var_0_0.URL = "ui://pbd24silex4r7e"

function var_0_0:__ctor()
	self.m_modelController = self:getController("model")
	self.m_tiledHolder = self:getChild("tiledHolder")
	self.m_floorComp = self:getChild("floorComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_usersComp = self:getChild("usersComp")
	self.m_debugSettingModel = self:getChild("debugSettingModel")
	self.m_setObstaclePoint = self:getChild("setObstaclePoint")
	self.m_pointCount = self:getChild("pointCount")
	self.m_delaunayBtn = self:getChild("delaunayBtn")
	self.m_selectObstacle = self:getChild("selectObstacle")
	self.m_triangleCount = self:getChild("triangleCount")
	self.m_exportObstacle = self:getChild("exportObstacle")
	self.m_importObstacle = self:getChild("importObstacle")
	self.m_debugCtrlModel = self:getChild("debugCtrlModel")
	self.m_ctrlSettingComp = self:getChild("ctrlSettingComp")
end

return var_0_0
