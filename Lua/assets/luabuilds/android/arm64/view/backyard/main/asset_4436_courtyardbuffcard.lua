local CourtYardBuffCard = class("CourtYardBuffCard")

function CourtYardBuffCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.timeTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.icon = self._tf:GetComponent(typeof(Image))

	return
end

function CourtYardBuffCard:Flush(arg_2_1)
	self.buff = arg_2_1
	self.icon.sprite = LoadSprite(arg_2_1:getConfig("icon") .. "_backyard") or LoadSprite(arg_2_1:getConfig("icon"))

	self:RemoveTimer()

	self.using = true

	if arg_2_1:isActivate() then
		self:StartTimer(arg_2_1)
	end

	return
end

function CourtYardBuffCard:StartTimer(arg_3_1)
	setActive(self._tf, true)

	self.timer = Timer.New(function()
		local var_4_0 = arg_3_1:getLeftTime()

		if var_4_0 > 0 then
			local var_4_1 = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

			self.timeTxt.text = var_4_0 <= 600 and setColorStr(var_4_1, COLOR_RED) or setColorStr(var_4_1, "#FFFFFFFF")
		else
			self:RemoveTimer()
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function CourtYardBuffCard:RemoveTimer()
	self.using = false

	setActive(self._tf, false)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CourtYardBuffCard:IsUsing()
	return self.using
end

function CourtYardBuffCard:Dispose()
	self:RemoveTimer()

	return
end

return CourtYardBuffCard
