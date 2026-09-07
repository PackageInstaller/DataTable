pg = pg or {}

local var_0_0 = singletonClass("IslandVisitorNotificationMgr")

pg.IslandVisitorNotificationMgr = var_0_0

local var_0_1 = 5

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.schedule = {}

	LoadAndInstantiateAsync("ui", "IslandVisitorNotificationUI", function(arg_2_0)
		arg_1_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_2_0.transform:SetParent(arg_1_0.UIOverlay.transform, false)

		arg_1_0._tf = arg_2_0.transform
		arg_1_0.contentTxt = arg_2_0.transform:Find("Text"):GetComponent(typeof(Text))

		setActive(arg_2_0, false)
		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_0:Enqueue(arg_3_1)
	if PlayerPrefs.GetInt(ISLAND_NOTIFYCATION, 0) <= 0 then
		return
	end

	table.insert(self.schedule, arg_3_1)

	if #self.schedule == 1 then
		self:StartTask()
	end

	return
end

function var_0_0:StartTask()
	self:ShowContent(self.schedule[1], function()
		table.remove(self.schedule, 1)

		if #self.schedule > 0 then
			self:StartTask()
		end

		return
	end)

	return
end

function var_0_0:ShowContent(arg_6_1, arg_6_2)
	setActive(self._tf, true)

	self.contentTxt.text = arg_6_1:BuildWhitoutTime()

	self:RemoveTimer()

	local var_6_0 = Timer.New(function()
		self:RemoveTimer()
		self:HideContent()
		arg_6_2()

		return
	end, var_0_1, 1)

	var_6_0:Start()

	self.timer = var_6_0

	return
end

function var_0_0:HideContent()
	self.contentTxt.text = ""

	setActive(self._tf, false)

	return
end

function var_0_0:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function var_0_0:Quit()
	self:RemoveTimer()
	self:HideContent()

	self.schedule = {}

	return
end

return
