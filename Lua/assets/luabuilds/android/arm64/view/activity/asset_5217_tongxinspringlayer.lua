local TongXinSpringLayer = class("TongXinSpringLayer", import("..base.BaseUI"))

function TongXinSpringLayer:getUIName()
	return "TongXinSpringUI"
end

function TongXinSpringLayer:init()
	self.closedFlag = false

	return
end

function TongXinSpringLayer:didEnter()
	self.ad = findTF(self._tf, "ad")
	self.animator = GetComponent(self.ad, typeof(Animator))
	self.dftAniEvent = GetComponent(self.ad, typeof(DftAniEvent))

	self.dftAniEvent:SetEndEvent(function()
		self:closeView()

		return
	end)
	onButton(self, findTF(self._tf, "ad/clickClose"), function()
		if self.closedFlag then
			return
		end

		self.closedFlag = true

		self.animator:Play("anim_kinder_spring_out")

		return
	end)
	onButton(self, findTF(self._tf, "ad/btnBack"), function()
		if self.closedFlag then
			return
		end

		self.closedFlag = true

		self.animator:Play("anim_kinder_spring_out")

		return
	end)
	onButton(self, findTF(self._tf, "ad/btnHome"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self.ad)
	GetComponent(findTF(self.ad, "bg/img"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.ad, "title/img"), typeof(Image)):SetNativeSize()

	return
end

function TongXinSpringLayer:createUI()
	self.iconTpl = findTF(self._tf, "ad/list/iconTpl")

	setActive(self.iconTpl, false)

	self.iconContent = findTF(self._tf, "ad/list")
	self.iconTfs = {}

	for iter_8_0 = 1, self.activity:GetTotalSlotCount() do
		local var_8_0 = iter_8_0
		local var_8_1 = tf(instantiate(self.iconTpl))

		setActive(var_8_1, true)
		SetParent(var_8_1, self.iconContent)
		onButton(self, var_8_1, function()
			self:clickIcon(var_8_0)

			return
		end)
		table.insert(self.iconTfs, var_8_1)
	end

	return
end

function TongXinSpringLayer:updateUI()
	local var_10_0 = self.activity:GetShipIds()
	local var_10_1 = self.activity:GetSlotCount()

	for iter_10_0 = 1, self.activity:GetTotalSlotCount() do
		local var_10_2 = findTF(self.iconTfs[iter_10_0], "add")
		local var_10_3 = findTF(self.iconTfs[iter_10_0], "lock")
		local var_10_4 = findTF(self.iconTfs[iter_10_0], "char")

		setActive(var_10_2, false)
		setActive(var_10_3, false)
		setActive(var_10_4, false)

		if iter_10_0 <= var_10_1 then
			if var_10_0[iter_10_0] and var_10_0[iter_10_0] ~= 0 then
				local var_10_5 = getProxy(BayProxy):RawGetShipById(var_10_0[iter_10_0])

				if var_10_5 then
					setImageSprite(findTF(var_10_4, "mask/icon"), (LoadSprite("qicon/" .. var_10_5:getPainting())))
					setActive(var_10_4, true)
				else
					setActive(var_10_2, true)
				end
			else
				setActive(var_10_2, true)
			end
		else
			setActive(var_10_3, true)
		end
	end

	return
end

function TongXinSpringLayer:clickIcon(arg_11_1)
	if arg_11_1 <= self.activity:GetSlotCount() then
		local var_11_0 = self.activity:GetShipIds()[arg_11_1]
		local var_11_1 = var_11_0 > 0 and getProxy(BayProxy):RawGetShipById(var_11_0)

		self:emit(TongXinSpringMediator.OPEN_CHUANWU, arg_11_1, var_11_1 and var_11_1 or nil)
	else
		self:emit(TongXinSpringMediator.UNLOCK_SLOT, self.activity.id)
	end

	print("点击了第" .. arg_11_1 .. "个")

	return
end

function TongXinSpringLayer:InitActivity(arg_12_1)
	self.activity = arg_12_1

	self:createUI()
	self:updateUI()

	return
end

function TongXinSpringLayer:UpdateActivity(arg_13_1)
	self.activity = arg_13_1

	self:updateUI()

	return
end

function TongXinSpringLayer:willExit()
	self.dftAniEvent:SetEndEvent(nil)

	self.closedFlag = true

	pg.UIMgr.GetInstance():UnOverlayPanel(self.ad, self._tf)

	return
end

function TongXinSpringLayer:onBackPressed()
	if self.closedFlag then
		return
	end

	self.closedFlag = true

	self.animator:Play("anim_kinder_spring_out")

	return
end

return TongXinSpringLayer
