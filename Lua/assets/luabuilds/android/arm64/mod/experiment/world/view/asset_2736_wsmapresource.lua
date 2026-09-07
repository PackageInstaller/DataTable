local WSMapResource = class("WSMapResource", import("...BaseEntity"))

WSMapResource.Fields = {
	map = "table",
	rtDarkFog = "userdata",
	rtSairenFog = "userdata"
}

function WSMapResource:Setup(arg_1_1)
	self.map = arg_1_1

	return
end

function WSMapResource:Dispose()
	self:Clear()

	return
end

function WSMapResource:Load(arg_3_1)
	local var_3_0 = {}

	table.insert(var_3_0, function(arg_4_0)
		PoolMgr.GetInstance():GetUI("darkfog", true, function(arg_5_0)
			setParent(arg_5_0, GameObject.Find("__Pool__").transform)

			self.rtDarkFog = arg_5_0.transform

			setActive(self.rtDarkFog, false)
			arg_4_0()

			return
		end)

		return
	end)
	table.insert(var_3_0, function(arg_6_0)
		PoolMgr.GetInstance():GetUI("sairenfog", true, function(arg_7_0)
			setParent(arg_7_0, GameObject.Find("__Pool__").transform)

			self.rtSairenFog = arg_7_0.transform

			setActive(self.rtSairenFog, false)
			arg_6_0()

			return
		end)

		return
	end)
	seriesAsync(var_3_0, arg_3_1)

	return
end

function WSMapResource:Unload()
	if self.rtDarkFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", self.rtDarkFog.gameObject)

		self.rtDarkFog = nil
	end

	if self.rtSairenFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", self.rtSairenFog.gameObject)

		self.rtSairenFog = nil
	end

	return
end

return WSMapResource
