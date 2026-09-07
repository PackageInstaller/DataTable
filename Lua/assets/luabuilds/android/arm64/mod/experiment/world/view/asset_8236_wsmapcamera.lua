local WSMapCamera = class("WSMapCamera", import("...BaseEntity"))

WSMapCamera.Fields = {
	map = "table",
	gid = "number",
	camera = "userdata"
}

function WSMapCamera:Setup()
	self:Init()

	return
end

function WSMapCamera:Dispose()
	self.camera.enabled = false

	self:Clear()

	return
end

function WSMapCamera:UpdateMap(arg_3_1)
	if self.map ~= arg_3_1 or self.gid ~= arg_3_1.gid then
		self.map = arg_3_1
		self.gid = arg_3_1.gid
		self.camera.fieldOfView = arg_3_1.theme.fov
	end

	return
end

function WSMapCamera:Init()
	self.camera.enabled = true

	return
end

return WSMapCamera
