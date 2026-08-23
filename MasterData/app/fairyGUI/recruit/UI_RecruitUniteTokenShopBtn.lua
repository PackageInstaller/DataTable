local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46vb7pgic0m"

function var_0_0:__ctor()
	self.m_isArtifactController = self:getController("isArtifact")
end

var_0_0.IsArtifactCtrl = {
	artifact = 1,
	normal = 0
}

return var_0_0
