local SyncUnitData = class("SyncUnitData")

function SyncUnitData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.pos = Vector3(arg_1_1.pos.x, arg_1_1.pos.y, arg_1_1.pos.z)
	self.dir = Quaternion(arg_1_1.dir.x, arg_1_1.dir.y, arg_1_1.dir.z, arg_1_1.dir.w)
	self.status = arg_1_1.status

	return
end

function SyncUnitData:Pack()
	return {
		id = self.id,
		pos = {
			x = self.pos.x,
			y = self.pos.y,
			z = self.pos.z
		},
		dir = {
			x = self.dir.x,
			y = self.dir.y,
			z = self.dir.z,
			w = self.dir.w
		},
		status = self.status
	}
end

function SyncUnitData:toString()
	return string.format("id=%d,pos=[%s,%s,%s],dir=[%s,%s,%s,%s],status=%s", self.id, string.format("%.5f", self.pos.x), string.format("%.5f", self.pos.y), string.format("%.5f", self.pos.z), string.format("%.5f", self.dir.x), string.format("%.5f", self.dir.y), string.format("%.5f", self.dir.z), string.format("%.5f", self.dir.w), PrintTable(self.status))
end

return SyncUnitData
