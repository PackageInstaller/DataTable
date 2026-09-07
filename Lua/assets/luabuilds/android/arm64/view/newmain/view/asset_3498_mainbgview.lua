local MainBGView = class("MainBGView", import("..base.MainBaseView"))
local var_0_1 = {
	{
		{
			0,
			5
		},
		"bg_main_night"
	},
	{
		{
			5,
			8
		},
		"bg_main_twilight"
	},
	{
		{
			8,
			16
		},
		"bg_main_day"
	},
	{
		{
			16,
			19
		},
		"bg_main_twilight"
	},
	{
		{
			19,
			24
		},
		"bg_main_night"
	}
}
local var_0_2 = 0

function MainBGView.GetBgAndBgm()
	local var_1_0 = var_0_1
	local var_1_1 = getProxy(ActivityProxy):RawGetActivityById(pg.gameset.dayandnight_bgm.key_value)

	if var_1_1 and not var_1_1:isEnd() then
		var_1_0 = pg.gameset.dayandnight_bgm.description
	end

	local var_1_2 = pg.TimeMgr.GetInstance():GetServerHour()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if var_1_2 >= iter_1_1[1][1] and var_1_2 < iter_1_1[1][2] then
			return iter_1_1[2], iter_1_1[3]
		end
	end

	return
end

function MainBGView:Ctor(arg_2_1)
	MainBGView.super.Ctor(self, arg_2_1, nil)

	self._tf = arg_2_1
	self._go = arg_2_1.gameObject

	local var_2_0 = {}

	var_2_0[1] = arg_2_1.parent.parent:Find("paintBg"):GetComponent(typeof(Canvas))
	var_2_0[2] = arg_2_1.parent.parent:Find("paint"):GetComponent(typeof(Canvas))
	self.paintingCanvases = var_2_0
	self.isSpecialBg = false
	self.isloading = false

	return
end

function MainBGView:getUIName()
	return "MainBGView"
end

function MainBGView:Init(arg_4_1)
	self.ship = arg_4_1

	self:ClearSpecailBg()

	local var_4_0 = arg_4_1:getShipBgPrint()

	self.isSpecialBg = var_4_0 ~= arg_4_1:rarity2bgPrintForGet()

	local var_4_1, var_4_2 = MainPaintingView.GetAssistantStatus(arg_4_1)

	self._showBg = var_4_2

	if self.isSpecialBg and var_4_2 then
		self:SetSpecailBg(var_4_0)
		self:ClearMapBg()
		self:ClearCommonBg()
	elseif var_0_2 and var_0_2 ~= 0 then
		assert(pg.expedition_data_by_map[var_0_2], "expedition_data_by_map >>> " .. var_0_2)

		if self.mapLoaderKey ~= pg.expedition_data_by_map[var_0_2].bg .. "_" .. pg.expedition_data_by_map[var_0_2].ani_name then
			self:ClearMapBg()

			self.mapLoaderKey = pg.expedition_data_by_map[var_0_2].bg .. "_" .. pg.expedition_data_by_map[var_0_2].ani_name

			self:SetMapBg(pg.expedition_data_by_map[var_0_2].bg, pg.expedition_data_by_map[var_0_2].ani_name)
		end

		self:ClearCommonBg()
	else
		local var_4_3 = MainBGView.GetBgAndBgm()

		if self.commonBg == var_4_3 then
			return
		end

		self:SetCommonBg(var_4_3)
		self:ClearMapBg()

		self.commonBg = var_4_3
	end

	return
end

function MainBGView:ClearCommonBg()
	self.commonBg = nil

	return
end

function MainBGView:Refresh(arg_6_1)
	self:Init(arg_6_1)

	return
end

function MainBGView:SetSpecailBg(arg_7_1)
	self.isloading = true

	local var_7_0 = MainBGView.GetBgAndBgm()

	pg.DynamicBgMgr.GetInstance():LoadBg(self, arg_7_1, self._tf.parent, self._tf, function(arg_8_0)
		self:SetCommonBg(var_7_0)
		setActive(self._tf, true)
		tf(arg_8_0):SetAsLastSibling()

		self.isloading = false
		arg_8_0.transform.localPosition = Vector3(0, 0, 200)

		return
	end, function()
		self.isloading = false

		return
	end)

	return
end

function MainBGView:SetMapBg(arg_10_1, arg_10_2)
	self.isloading = true
	self.effectGo = nil

	parallelAsync({
		function(arg_11_0)
			PoolMgr.GetInstance():GetSprite("levelmap/" .. arg_10_1, "", true, function(arg_12_0)
				setImageSprite(self._tf, arg_12_0)
				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			if not arg_10_2 or arg_10_2 == "" then
				arg_13_0()

				return
			end

			PoolMgr.GetInstance():GetPrefab("ui/" .. arg_10_2, "", true, function(arg_14_0)
				setParent(arg_14_0, self._tf)
				self:AdjustMapEffect(arg_14_0)

				self.effectGo = arg_14_0

				arg_13_0()

				return
			end)

			return
		end
	}, function()
		self.isloading = false

		return
	end)

	return
end

function MainBGView:ClearMapBg()
	if not IsNil(self.effectGo) then
		Object.Destroy(self.effectGo)

		self.effectGo = nil
	end

	for iter_16_0, iter_16_1 in ipairs(self.paintingCanvases) do
		iter_16_1.overrideSorting = false
		iter_16_1.sortingOrder = 0
	end

	self.mapLoaderKey = nil

	return
end

function MainBGView:AdjustMapEffect(arg_17_1)
	local var_17_0 = -math.huge

	for iter_17_0, iter_17_1 in ipairs((arg_17_1:GetComponentsInChildren(typeof(Canvas)):ToTable())) do
		if var_17_0 < iter_17_1.sortingOrder then
			var_17_0 = iter_17_1.sortingOrder
		end
	end

	for iter_17_2, iter_17_3 in ipairs((arg_17_1:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
		if var_17_0 < iter_17_3.sortingOrder then
			var_17_0 = iter_17_3.sortingOrder
		end
	end

	for iter_17_4, iter_17_5 in ipairs(self.paintingCanvases) do
		iter_17_5.overrideSorting = true
		iter_17_5.sortingOrder = var_17_0 + (iter_17_4 == 3 and 2 or 1)
	end

	return
end

function MainBGView:SetCommonBg(arg_18_1)
	setActive(self._tf, false)
	setActive(self._tf, true)

	local var_18_0 = self._tf:GetComponent(typeof(Image)).sprite

	setImageSprite(self._tf, LoadSprite("commonbg/" .. arg_18_1, ""))

	if var_18_0 then
		Resources.UnloadAsset(var_18_0.texture)
	end

	return
end

function MainBGView:ClearSpecailBg()
	if self.isSpecialBg then
		pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

		self.isSpecialBg = false
	end

	return
end

function MainBGView:IsLoading()
	return self.isloading
end

function MainBGView:Disable()
	self:ClearSpecailBg()

	return
end

function MainBGView:Dispose()
	MainBGView.super.Dispose(self)
	self:ClearSpecailBg()
	self:ClearMapBg()

	return
end

return MainBGView
