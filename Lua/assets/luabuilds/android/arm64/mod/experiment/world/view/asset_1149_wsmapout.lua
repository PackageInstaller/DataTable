local WSMapOut = class("WSMapOut", import("...BaseEntity"))

WSMapOut.Fields = {
	map = "table",
	gid = "number",
	emotion = "string",
	transform = "userdata",
	emotionTFs = "table",
	fleet = "table"
}
WSMapOut.Listeners = {
	onUpdateFleetEmotion = "OnUpdateFleetEmotion",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function WSMapOut:Build()
	return
end

function WSMapOut:Setup()
	pg.DelegateInfo.New(self)

	self.emotionTFs = {}

	return
end

function WSMapOut:Dispose()
	self:RemoveFleetListener(self.fleet)
	self:RemoveMapListener()

	local var_3_0 = PoolMgr.GetInstance()

	for iter_3_0, iter_3_1 in pairs(self.emotionTFs) do
		var_3_0:ReturnUI(iter_3_0, go(iter_3_1))
	end

	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSMapOut:UpdateMap(arg_4_1)
	if self.map ~= arg_4_1 or self.gid ~= arg_4_1.gid then
		self:RemoveMapListener()

		self.map = arg_4_1
		self.gid = arg_4_1.gid

		self:AddMapListener()
		self:OnUpdateSelectedFleet()
	end

	return
end

function WSMapOut:AddMapListener()
	if self.map then
		self.map:AddListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapOut:RemoveMapListener()
	if self.map then
		self.map:RemoveListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapOut:AddFleetListener(arg_7_1)
	if arg_7_1 then
		arg_7_1:AddListener(WorldMapFleet.EventUpdateLocation, self.onUpdateFleetEmotion)
	end

	return
end

function WSMapOut:RemoveFleetListener(arg_8_1)
	if arg_8_1 then
		arg_8_1:RemoveListener(WorldMapFleet.EventUpdateLocation, self.onUpdateFleetEmotion)
	end

	return
end

function WSMapOut:OnUpdateSelectedFleet()
	local var_9_0 = self.map:GetFleet()

	if self.fleet ~= var_9_0 then
		self:RemoveFleetListener(self.fleet)

		self.fleet = var_9_0

		self:AddFleetListener(self.fleet)
	end

	self:OnUpdateFleetEmotion()

	return
end

function WSMapOut:OnUpdateFleetEmotion()
	if not self.map.active then
		return
	end

	local var_10_0 = self.map:GetCell(self.fleet.row, self.fleet.column):GetEmotion()

	if self.emotion ~= var_10_0 then
		local var_10_2 = PoolMgr.GetInstance()

		if self.emotion and self.emotionTFs[self.emotion] then
			setActive(self.emotionTFs[self.emotion], false)
		end

		self.emotion = var_10_0

		if var_10_0 then
			if self.emotionTFs[var_10_0] then
				setActive(self.emotionTFs[self.emotion], true)
			else
				var_10_2:GetUI(var_10_0, true, function(arg_11_0)
					if self.emotion == var_10_0 then
						setParent(arg_11_0, self.transform)
						setActive(arg_11_0, true)

						self.emotionTFs[var_10_0] = tf(arg_11_0)
					else
						var_10_2:ReturnUI(var_10_0, arg_11_0)
					end

					return
				end)
			end
		end
	end

	return
end

return WSMapOut
