local CpkPerformPlayer = class("CpkPerformPlayer", import(".BasePerformPlayer"))

function CpkPerformPlayer:Ctor(arg_1_1)
	CpkPerformPlayer.super.Ctor(self, arg_1_1)

	self.bgTF = self._tf:Find("bg")
	self.nameTF = self.bgTF:Find("name")
	self.sliderTF = self.bgTF:Find("slider")
	self.cpkParentTF = self.bgTF:Find("cpk")
	self.cpkCoverTF = self.bgTF:Find("cpk_cover")
	self.frameRate = Application.targetFrameRate or 60
	self.maxStage = #pg.child_data[1].stage
	self.personalityIds = pg.child_data[1].attr_2_list

	return
end

function CpkPerformPlayer:getCpkName(arg_2_1)
	local var_2_0 = getProxy(EducateProxy):GetCharData():GetStage()

	if var_2_0 < self.maxStage then
		return arg_2_1[var_2_0]
	elseif var_2_0 == self.maxStage then
		return arg_2_1[var_2_0][table.indexof(self.personalityIds, (getProxy(EducateProxy):GetPersonalityId()))]
	end

	return ""
end

function CpkPerformPlayer:Play(arg_3_1, arg_3_2, arg_3_3)
	self:Show()

	if arg_3_3 then
		setText(self.nameTF, arg_3_3)
	end

	setActive(self.bgTF, not IsNil(self.cpkTF))

	local var_3_0 = self:getCpkName(arg_3_1.param[1]) or ""
	local var_3_1 = arg_3_1.param[2] or 3

	if checkABExist("educateanim/" .. var_3_0) then
		LoadAnyAsync("educateanim/" .. var_3_0, "", nil, function(arg_4_0)
			local var_4_0 = Object.Instantiate(arg_4_0, self.cpkParentTF)

			setActive(self.bgTF, true)

			self.player = var_4_0.transform:Find("usm"):GetComponent(typeof(CriManaCpkUI))
			self.time = var_3_1
			self.cpkTF = var_4_0

			self.player:SetPlayEndHandler(function()
				if arg_3_2 then
					arg_3_2()
				end

				self:onCpkEnd()

				return
			end)

			if self._anim then
				self._anim:Play()
			end

			self.player:SetMaxFrameDrop(CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)
			self.player:SetCpkTotalTimeCallback(function(arg_6_0)
				self.time = arg_6_0

				self:onCpkStart(arg_6_0)

				return
			end)
			self.player:PlayerManualUpdate()
			self.player:PlayCpk()

			if not IsNil(self.cpkTF) then
				Destroy(self.cpkTF)
			end

			return
		end)
	elseif arg_3_2 then
		arg_3_2()
	end

	return
end

function CpkPerformPlayer:onCpkStart(arg_7_1)
	setSlider(self.sliderTF, 0, 1, 0)

	self.playingTime = 0
	self.timer = Timer.New(function()
		self.playingTime = self.playingTime + 1 / self.frameRate

		setSlider(self.sliderTF, 0, 1, self.playingTime / arg_7_1)

		return
	end, 1 / self.frameRate, -1)

	self.timer:Start()

	return
end

function CpkPerformPlayer:onCpkEnd()
	setSlider(self.sliderTF, 0, 1, 1)

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CpkPerformPlayer:SetUIParam(arg_10_1)
	setAnchoredPosition(self.sliderTF, arg_10_1.sliderPos)
	setAnchoredPosition(self.cpkParentTF, arg_10_1.cpkPos)
	setAnchoredPosition(self.cpkCoverTF, arg_10_1.cpkCoverPos)

	GetComponent(self.bgTF, typeof(Image)).enabled = arg_10_1.showCpkBg

	return
end

function CpkPerformPlayer:Clear()
	if not IsNil(self.cpkTF) then
		Destroy(self.cpkTF)
	end

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.player = nil

	setText(self.nameTF, "")
	self:Hide()
	gcAll()

	return
end

function CpkPerformPlayer:Dispose()
	self:Clear()

	return
end

return CpkPerformPlayer
