local LoadingPanel = class("LoadingPanel", import("..base.BaseUI"))

function LoadingPanel:Ctor(arg_1_1)
	LoadingPanel.super.Ctor(self)
	seriesAsync({
		function(arg_2_0)
			self:preload(arg_2_0)

			return
		end
	}, function()
		PoolMgr.GetInstance():GetUI("Loading", true, function(arg_4_0)
			arg_4_0.transform:SetParent(GameObject.Find("Overlay/UIOverlay").transform, false)
			arg_4_0:SetActive(false)
			self:onUILoaded(arg_4_0)
			arg_1_1()

			return
		end)

		return
	end)

	return
end

function LoadingPanel:preload(arg_5_1)
	self.isCri, self.bgPath = getLoginConfig()

	if self.isCri then
		LoadAndInstantiateAsync("effect", self.bgPath, function(arg_6_0)
			self.criBgGo = arg_6_0

			if arg_5_1 then
				arg_5_1()
			end

			return
		end)
	else
		local var_5_0 = LOGIN_HX

		if LOGIN_HX then
			if PlayerProxy.GetDeviceMaxPlayerLevel() > pg.gameset.LOGIN_HX_LV.key_value then
				var_5_0 = false
			end

			local var_5_1

			do
				var_5_0 = true
				var_5_1 = LoadSpriteAsync
			end
		end

		var_5_1((var_5_0 and "loadingbg_hx/" or "loadingbg/") .. self.bgPath, function(arg_7_0)
			self.staticBgSprite = arg_7_0

			if arg_5_1 then
				arg_5_1()
			end

			return
		end)
	end

	return
end

function LoadingPanel:init()
	self.infos = self._tf:Find("infos")
	self.infoTpl = self:getTpl("infos/info_tpl")
	self.indicator = self._tf:Find("load")
	self.bg = self._tf:Find("BG")

	self:displayBG(true)

	return
end

function LoadingPanel:appendInfo(arg_9_1)
	local var_9_0 = cloneTplTo(self.infoTpl, self.infos)

	setText(var_9_0, arg_9_1)

	local var_9_1 = LeanTween.alphaCanvas(GetOrAddComponent(var_9_0, "CanvasGroup"), 0, 0.3)

	var_9_1:setDelay(1.5)
	var_9_1:setOnComplete(System.Action(function()
		destroy(var_9_0)

		return
	end))

	return
end

function LoadingPanel:onLoading()
	return self._go.activeInHierarchy
end

local var_0_1 = 0

function LoadingPanel:on(arg_12_1)
	self.displayIndicator = defaultValue(self.displayIndicator, true) and defaultValue(arg_12_1, true)

	setImageAlpha(self._tf, arg_12_1 and 0.01 or 0)

	if not self.displayIndicator then
		setActive(self.indicator, arg_12_1)

		if self.delayTimer then
			pg.TimeMgr.GetInstance():RemoveTimer(self.delayTimer)

			self.delayTimer = nil
		end
	else
		self.delayTimer = self.delayTimer or pg.TimeMgr.GetInstance():AddTimer("loading", 1, 0, function()
			setImageAlpha(self._tf, 0.2)
			setActive(self.indicator, true)

			return
		end)
	end

	if var_0_1 * (var_0_1 + 1) == 0 then
		setActive(self._go, true)
		self._go.transform:SetAsLastSibling()
	end

	var_0_1 = var_0_1 + 1

	return
end

function LoadingPanel:off()
	if var_0_1 * (var_0_1 - 1) == 0 then
		setActive(self._go, false)
		setActive(self.indicator, false)

		self.displayIndicator = true

		if self.delayTimer then
			pg.TimeMgr.GetInstance():RemoveTimer(self.delayTimer)

			self.delayTimer = nil
		end
	end

	var_0_1 = var_0_1 - 1

	assert(var_0_1 >= 0)

	return
end

function LoadingPanel:displayBG(arg_15_1)
	setActive(self.bg, arg_15_1)

	local var_15_0 = GetComponent(self.bg, "Image")

	if arg_15_1 then
		if not self.isCri then
			if IsNil(var_15_0.sprite) then
				var_15_0.sprite = self.staticBgSprite
			end
		elseif self.bg.childCount == 0 then
			var_15_0.enabled = false

			self.criBgGo.transform:SetParent(self.bg.transform, false)
			self.criBgGo.transform:SetAsFirstSibling()

			local var_15_1 = self.criBgGo:GetComponent("AspectRatioFitter")

			if var_15_1 then
				var_15_1.enabled = true
			end
		end
	else
		if not self.isCri then
			var_15_0.sprite = nil
		else
			removeAllChildren(self.bg)
		end

		self.criBgGo = nil
		self.staticBgSprite = nil
	end

	return
end

function LoadingPanel:getRetainCount()
	return var_0_1
end

return LoadingPanel
