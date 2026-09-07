local L2dBoundsUI = class("L2dBoundsUI")
local var_0_1 = "l2dui"

function L2dBoundsUI:Ctor()
	self._timer = Timer.New(function()
		self:step()

		return
	end, 0.03333333333333333, -1)

	self._timer:Start()

	self._dragsUI = {}
	self.visible = true
	var_0_1 = pg.gameset.l2d_tips_default_icon.description

	return
end

function L2dBoundsUI:InitUI(arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 or "l2dboundsui"

	PoolMgr.GetInstance():GetUI(arg_3_1, true, function(arg_4_0)
		if self._isDispose then
			Destroy(arg_4_0)

			return
		end

		self:onLoaded(arg_4_0)

		if arg_3_2 then
			arg_3_2(self)
		end

		return
	end)

	return
end

function L2dBoundsUI:SetData(arg_5_1, arg_5_2)
	self._bounds = arg_5_1
	self._tipConfig = pg.ship_l2d_tips[arg_5_2]

	if not self._tipConfig then
		return
	end

	self._tipOffset = self._tipConfig.tips_offset
	self._tipsScale = self._tipConfig.tips_scale
	self._tipsIdleBlackList = self._tipConfig.idle_black_list
	self._tipsAnimWhiteList = self._tipConfig.anim_white_list

	self:createDrags()

	return
end

function L2dBoundsUI:SetParent(arg_6_1)
	if self._tf then
		SetParent(self._tf, arg_6_1)
	end

	return
end

function L2dBoundsUI:onLoaded(arg_7_1)
	self._tf = tf(arg_7_1)
	self._container = findTF(self._tf, "ad")
	self._boundsTpl = findTF(self._tf, "ad/bounds_tpl")

	setActive(self._boundsTpl, false)
	setActive(self._tf, true)

	return
end

function L2dBoundsUI:step()
	if not self._bounds or #self._dragsUI == 0 then
		return
	end

	local var_8_0 = GameObject.Find("UICamera")
	local var_8_1 = var_8_0:GetComponent(typeof(Camera))
	local var_8_2 = var_8_1:ScreenToWorldPoint(Vector3(0, 0, -10))
	local var_8_3 = var_8_1:ScreenToWorldPoint(Vector3(Screen.width, Screen.height, -10))
	local var_8_4 = Screen.width / (var_8_0.x - var_8_2.x)
	local var_8_5 = Screen.height / (var_8_3.y - var_8_2.y)

	for iter_8_0 = 1, #self._bounds do
		local var_8_6 = self._bounds[iter_8_0]
		local var_8_7 = true

		if not self.visible then
			var_8_7 = false
		elseif self._state.isPlaying then
			if not self:MatchPlayingList(self._bounds[iter_8_0].name) then
				var_8_7 = false
			end
		elseif not self._state.isPlaying and self:MatchIdleBlackList(self._bounds[iter_8_0].name) then
			var_8_7 = false
		elseif self._bounds[iter_8_0].bounds.min.x >= var_8_3.x or self._bounds[iter_8_0].bounds.min.y >= var_8_3.y or self._bounds[iter_8_0].bounds.max.x <= var_8_2.x or self._bounds[iter_8_0].bounds.max.y <= var_8_2.y then
			var_8_7 = false
		end

		self:setUIVisible(self._dragsUI[iter_8_0], var_8_7)

		if var_8_7 then
			local var_8_8 = var_8_6.bounds.min
			local var_8_9 = var_8_6.bounds.max

			if var_8_6.bounds.min.x < var_8_2.x then
				var_8_8.x = var_8_2.x or var_8_8.x
			end

			if var_8_8.y < var_8_2.y then
				var_8_8.y = var_8_2.y or var_8_8.y
			end

			if var_8_9.x > var_8_3.x then
				var_8_9.x = var_8_3.x or var_8_9.x
			end

			if var_8_9.y > var_8_3.y then
				var_8_9.y = var_8_3.y or var_8_9.y
			end

			self._dragsUI[iter_8_0].position = Vector3(var_8_8.x + (var_8_9.x - var_8_8.x) / 2, var_8_8.y + (var_8_9.y - var_8_8.y) / 2, 0)
			self._dragsUI[iter_8_0].sizeDelta = Vector2((var_8_9.x - var_8_8.x) * var_8_4 - 10, (var_8_9.y - var_8_8.y) * var_8_5 - 10)
		end
	end

	return
end

function L2dBoundsUI:setUIVisible(arg_9_1, arg_9_2)
	if isActive(arg_9_1) ~= arg_9_2 then
		setActive(arg_9_1, arg_9_2)
	end

	return
end

function L2dBoundsUI:createDrags()
	if self._isDispose or not self._boundsTpl then
		return
	end

	self:clearDrags()

	for iter_10_0 = 1, #self._bounds do
		local var_10_0 = Instantiate(self._boundsTpl)

		GetOrAddComponent(var_10_0, typeof(EventTriggerListener))
		SetParent(var_10_0, self._container)
		table.insert(self._dragsUI, tf(var_10_0))

		var_10_0.name = self._bounds[iter_10_0].name

		setText(findTF(var_10_0, "ad/text"), self._bounds[iter_10_0].name)
		setActive(findTF(var_10_0, "ad/text"), false)

		local var_10_1 = self._bounds[iter_10_0].name

		self:getDragBoundUI(self._bounds[iter_10_0].name, function(arg_11_0)
			if self._tf then
				local var_11_0 = tf(arg_11_0)

				arg_11_0.name = var_10_1

				SetParent(var_11_0, (findTF(var_10_0, "ad")))

				var_11_0.localScale, var_11_0.anchoredPosition = self:GetScale(var_10_1), self:GetOffset(var_10_1)

				setActive(var_11_0, true)
				setText(findTF(var_11_0, "Image/Text"), tostring(iter_10_0))
			else
				Destroy(arg_11_0)
			end

			return
		end)
	end

	return
end

function L2dBoundsUI:MatchIdleBlackList(arg_12_1)
	if self._tipsIdleBlackList and #self._tipsIdleBlackList >= 0 then
		for iter_12_0, iter_12_1 in ipairs(self._tipsIdleBlackList) do
			if table.contains(iter_12_1.drawable, arg_12_1) and table.contains(iter_12_1.idle, self._state.idleIndex) then
				return true
			end
		end
	end

	return false
end

function L2dBoundsUI:MatchPlayingList(arg_13_1)
	if not self._state.isPlaying then
		return false
	end

	local var_13_0 = self._state.actionName

	if self._tipsAnimWhiteList and #self._tipsAnimWhiteList >= 0 then
		for iter_13_0, iter_13_1 in ipairs(self._tipsAnimWhiteList) do
			if table.contains(iter_13_1.drawable, arg_13_1) and table.contains(iter_13_1.white_list, var_13_0) then
				return true
			end
		end
	end

	return false
end

function L2dBoundsUI:GetScale(arg_14_1)
	local var_14_0 = Vector3(1, 1, 1)

	if self._tipsScale and #self._tipsScale > 0 then
		for iter_14_0, iter_14_1 in ipairs(self._tipsScale) do
			if table.contains(iter_14_1.drawable, arg_14_1) then
				var_14_0.x = iter_14_1.scale[1]
				var_14_0.y = iter_14_1.scale[2]
				var_14_0.z = iter_14_1.scale[3]
			end
		end
	end

	return var_14_0
end

function L2dBoundsUI:GetOffset(arg_15_1)
	local var_15_0 = Vector2(0, 0)

	if self._tipOffset and #self._tipOffset > 0 then
		for iter_15_0, iter_15_1 in ipairs(self._tipOffset) do
			if table.contains(iter_15_1.drawable, arg_15_1) then
				var_15_0.x = iter_15_1.offset[1]
				var_15_0.y = iter_15_1.offset[2]
			end
		end
	end

	return var_15_0
end

function L2dBoundsUI:getDragBoundUI(arg_16_1, arg_16_2)
	local var_16_0 = var_0_1

	if self._tipConfig.tips_icon and #self._tipConfig.tips_icon > 0 then
		for iter_16_0, iter_16_1 in ipairs(self._tipConfig.tips_icon) do
			if table.contains(iter_16_1.drawable, arg_16_1) then
				var_16_0 = iter_16_1.icon
			end
		end
	end

	PoolMgr.GetInstance():GetPrefab("ui/" .. var_16_0, nil, true, function(arg_17_0)
		if arg_16_2 then
			arg_16_2(arg_17_0)
		end

		return
	end)

	return
end

function L2dBoundsUI:GetDragsCount()
	if self._dragsUI then
		return #self._dragsUI
	end

	return 0
end

function L2dBoundsUI:ActionChange(arg_19_1)
	self._state = arg_19_1

	return
end

function L2dBoundsUI:SetVisible(arg_20_1)
	self.visible = arg_20_1

	return
end

function L2dBoundsUI:clearDrags()
	if self._dragsUI and #self._dragsUI > 0 then
		for iter_21_0 = 1, #self._dragsUI do
			ClearEventTrigger(GetComponent(self._dragsUI[iter_21_0], typeof(EventTriggerListener)))
			Destroy(self._dragsUI[iter_21_0])
		end

		self._dragsUI = {}
	end

	return
end

function L2dBoundsUI:Dispose()
	self._isDispose = true

	if self._timer then
		self._timer:Stop()

		self._timer = nil
	end

	if self._bounds then
		self._bounds = nil
	end

	if self._tf then
		Destroy(self._tf)

		self._tf = nil
	end

	self._boundsTpl = nil

	self:clearDrags()

	return
end

return L2dBoundsUI
