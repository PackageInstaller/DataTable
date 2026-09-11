local HeroRaiseTrack = class("HeroRaiseTrack")

function HeroRaiseTrack:Ctor()
	self.trackGo = nil
	self.trackTransform = nil
	self.curTrack = 0
	self.trackList = {}
	self.cameraList = {}
	self.tx_property_break_Go = nil
	self.tx_property_break_Animator = nil
end

function HeroRaiseTrack:SetTrackData(arg_2_1)
	if self.curTrack == arg_2_1 or arg_2_1 == 0 then
		return
	end

	if self.curTrack ~= 0 then
		SetActive(self.trackList[self.curTrack], false)
	end

	self.curTrack = arg_2_1

	SetActive(self.trackList[arg_2_1], true)

	self.cameraList = {}

	for iter_2_0, iter_2_1 in ipairs((self.trackList[arg_2_1].transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true):ToTable())) do
		table.insert(self.cameraList, iter_2_1)
	end
end

function HeroRaiseTrack:LoadTrackGo()
	self.trackGo = Object.Instantiate(Asset.Load("UI/HeroCamera/HeroRaiseTrack_CM.prefab"))
	self.trackTransform = self.trackGo.transform

	for iter_3_0 = 0, self.trackTransform.childCount - 1 do
		local var_3_0 = self.trackTransform:GetChild(iter_3_0).gameObject

		SetActive(var_3_0, false)
		table.insert(self.trackList, var_3_0)
	end

	if self.curTrack == 0 then
		self:SetTrackData(1)
	end
end

function HeroRaiseTrack:ChangeCamera(arg_4_1)
	self:CheckLoadTrackGo()

	local var_4_0 = HeroRaiseTrackConst.HeroRaiseName[arg_4_1] or ""

	FrameTimer.New(function()
		if #self.cameraList > 0 then
			for iter_5_0, iter_5_1 in ipairs(self.cameraList) do
				if var_4_0 == iter_5_1.name then
					SetActive(iter_5_1.gameObject, true)
				else
					SetActive(iter_5_1.gameObject, false)
				end
			end
		end
	end, 1, 1):Start()
end

function HeroRaiseTrack:SetActive(arg_6_1)
	self:CheckLoadTrackGo()
	SetActive(self.trackGo, arg_6_1)
end

function HeroRaiseTrack:UnloadTrackGo()
	Object.Destroy(self.trackGo)

	self.trackGo = nil
	self.trackTransform = nil
	self.curTrack = 0
	self.trackList = {}
	self.cameraList = {}
end

function HeroRaiseTrack:CheckLoadTrackGo()
	if isNil(self.trackGo) then
		self:LoadTrackGo()
	end
end

function HeroRaiseTrack:Dispose()
	self:UnloadTrackGo()
end

return HeroRaiseTrack
