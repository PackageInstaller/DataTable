local BaseStarComp = class("BaseStarComp")
local var_0_1 = {
	HORIZONTAL = 1,
	VERTICAL = 2
}
local var_0_2 = {
	SHOW_FULL = 2,
	ONLY_NUM = 1
}
local var_0_3 = 10
local var_0_4 = {
	{
		unActive = "ui://base_new/icon_jiban_2",
		active = "ui://base_new/icon_jiban_1"
	},
	{
		unActive = "ui://base_new/pic_star_4",
		active = "ui://base_new/pic_star_3"
	},
	{
		unActive = "ui://base_new/pic_star_2",
		active = "ui://base_new/pic_star_1"
	},
	{
		unActive = "ui://base_new/pic_star_4",
		active = "ui://base_new/pic_star_3"
	},
	{
		unActive = "ui://robTreasure/pic_weijihuo",
		active = "ui://robTreasure/pic_jihuo"
	},
	{
		unActive = "ui://base_new/icon_bf_qianghua1_2",
		active = "ui://base_new/icon_bf_qianghua1_1"
	},
	{
		unActive = "ui://bagNew/pic_bb_suipian_2",
		active = "ui://bagNew/pic_bb_suipian_1"
	},
	{
		unActive = "ui://base_new/icon_wzjj_xiaoduanwei_2",
		active = "ui://base_new/icon_wzjj_xiaoduanwei"
	},
	{
		unActive = "ui://base_new/pic_star_2",
		active = "ui://base_new/pic_star_7"
	},
	{
		unActive = "ui://base_new/icon_wzjj_xiaoduanwei_2",
		active = "ui://base_new/icon_wzjj_xiaoduanwei_3"
	},
	{
		unActive = "ui://base_new/icon_wzjj_xiaoduanwei_2",
		active = "ui://base_new/icon_wzjj_xiaoduanwei_6"
	},
	{
		unActive = "ui://precious/pic_gzp_dengjiesmall2",
		active = "ui://precious/pic_gzp_dengjiesmall1"
	},
	{
		unActive = "ui://pubg/icon_sihaiqiusheng_zd_xinxi_xin_2",
		active = "ui://pubg/icon_sihaiqiusheng_zd_xinxi_xin_1"
	},
	{
		unActive = "ui://outpost/pic_hxsz_star",
		active = "ui://outpost/pic_hxsz_star"
	},
	{
		unActive = "ui://outpost/pic_hxsz_starred",
		active = "ui://outpost/pic_hxsz_starred"
	}
}
local var_0_5 = 7

function BaseStarComp:ctor()
	self._effectSpine = {}
end

function BaseStarComp:initStar(arg_2_1)
	self.m_star1 = self:getChild("icon")

	self.m_star1:setPivot(0.5, 0.5, true)

	self._type = arg_2_1.type or var_0_1.HORIZONTAL
	self._style = arg_2_1.style or var_0_2.ONLY_NUM
	self._gap = arg_2_1.gap or var_0_3
	self._urlIndex = arg_2_1.index or 1
	self._max = arg_2_1.max or var_0_5

	if (self._oldMax or 0) > self._max then
		self._oldMax = self._oldMax or self._max
	end

	assert(self._max > 0, "the star max num must bigger than 0")

	self._num = arg_2_1.num or 1
	self._backWard = arg_2_1.isBackWard and -1 or 1
	self._lightBackWard = arg_2_1.isLightBackWard
	self._scale = arg_2_1.scale or 1
	self._specialStarStyle = {}
	self._curStarNum = self._curStarNum or 0

	if self._style == var_0_2.SHOW_FULL then
		self._urls = arg_2_1.urls or var_0_4[self._urlIndex]

		assert(self._urls.active, "BaseStarComp: urls.active is nil")
		assert(self._urls.unActive, "BaseStarComp: urls.unActive is nil")
	else
		self._urls = arg_2_1.urls or var_0_4[self._urlIndex]

		assert(self._urls.active, "BaseStarComp: urls.active is nil")
	end

	self.m_star1:setURL(self._urls.active)

	self._starSize = self.m_star1:getSize()
	self._starSize.width = self._scale * self._starSize.width
	self._starSize.height = self._scale * self._starSize.height

	self:_updateShow()
end

function BaseStarComp:setStarNum(arg_3_1)
	self._num = arg_3_1

	self:_updateShow()
end

function BaseStarComp:setStarStyle(arg_4_1, arg_4_2)
	self._specialStarStyle[arg_4_1] = arg_4_2

	self:_updateShow()
end

function BaseStarComp:updatePos()
	local var_5_0 = 1

	while self["m_star" .. var_5_0] do
		if self._type == var_0_1.HORIZONTAL then
			self["m_star" .. var_5_0]:setPosition(cc.p(self._backWard * ((var_5_0 - 0.5) * self._starSize.width + (var_5_0 - 1) * self._gap), self._starSize.height * 0.5))
		else
			self["m_star" .. var_5_0]:setPosition(cc.p(self._starSize.width * 0.5, self._backWard * ((var_5_0 - 0.5) * self._starSize.height + (var_5_0 - 1) * self._gap)))
		end

		var_5_0 = var_5_0 + 1
	end

	local var_5_1 = self._num

	if self._style == var_0_2.SHOW_FULL then
		var_5_1 = var_5_0 - 1
	end

	if self._type == var_0_1.HORIZONTAL then
		self:setSize(self._starSize.width * var_5_1 + (var_5_1 - 1) * self._gap, self._starSize.height)
	else
		self:setSize(self._starSize.width, self._starSize.height * var_5_1 + (var_5_1 - 1) * self._gap)
	end
end

function BaseStarComp:_updateShow()
	if self._style == var_0_2.SHOW_FULL then
		for iter_6_0 = 1, self._max do
			if not self["m_star" .. iter_6_0] then
				self:_createStar(iter_6_0)
			else
				self["m_star" .. iter_6_0]:setVisible(true)
			end

			local var_6_0 = self._urls

			if self._specialStarStyle and self._specialStarStyle[iter_6_0] then
				var_6_0 = self._specialStarStyle[iter_6_0]
			end

			if self._lightBackWard then
				if (self._max - iter_6_0 + 1 or iter_6_0) <= self._num then
					self["m_star" .. iter_6_0]:setURL(var_6_0.active)

					goto label_6_0
				end
			end

			self["m_star" .. iter_6_0]:setURL(var_6_0.unActive)

			::label_6_0::
		end

		if self._oldMax > self._max then
			for iter_6_1 = self._max + 1, self._oldMax do
				if self["m_star" .. iter_6_1] then
					self["m_star" .. iter_6_1]:setVisible(false)
				end
			end
		end
	else
		for iter_6_2 = 1, self._num do
			if not self["m_star" .. iter_6_2] then
				self:_createStar(iter_6_2)
			else
				self["m_star" .. iter_6_2]:setVisible(true)
			end

			self["m_star" .. iter_6_2]:setURL(((self._specialStarStyle and self._specialStarStyle[iter_6_2] or nil) and self._specialStarStyle[iter_6_2]).active)
		end

		if self._curStarNum > self._num then
			for iter_6_3 = self._num + 1, self._curStarNum do
				if self["m_star" .. iter_6_3] then
					self["m_star" .. iter_6_3]:setVisible(false)
				end
			end
		end

		if self._curStarNum > self._num then
			self._curStarNum = self._curStarNum or self._num
		end

		if self._curStarNum == 0 and self.m_star1:isVisible() then
			self.m_star1:setVisible(false)
		end
	end

	self:updatePos()
end

function BaseStarComp:_createStar(arg_7_1)
	self["m_star" .. arg_7_1] = fgui.GLoader:create()

	self["m_star" .. arg_7_1]:setAutoSize(true)
	self["m_star" .. arg_7_1]:setPivot(0.5, 0.5, true)
	self:addChild(self["m_star" .. arg_7_1])
end

function BaseStarComp:getFullStarSize()
	local var_8_0 = {}

	if self._type == var_0_1.HORIZONTAL then
		var_8_0.height = self._starSize.height
		var_8_0.width = self._style == var_0_2.ONLY_NUM and (self._num - 1) * (self._starSize.width + self._gap) or (self._max - 1) * (self._starSize.width + self._gap)
	else
		var_8_0.width = self._starSize.width
		var_8_0.height = self._style == var_0_2.ONLY_NUM and (self._num - 1) * (self._starSize.height + self._gap) or (self._max - 1) * (self._starSize.height + self._gap)
	end

	return var_8_0, self._starSize
end

function BaseStarComp:addStarEffect(arg_9_1, arg_9_2)
	if arg_9_1 and arg_9_2 then
		arg_9_2.x = self._starSize.width / 2
		arg_9_2.y = self._starSize.height / 2

		for iter_9_0 = 1, self._max do
			if self._effectSpine[iter_9_0] then
				self._effectSpine[iter_9_0]:setVisible(false)
			end

			if self["m_star" .. iter_9_0] then
				if self._lightBackWard then
					if (self._max - iter_9_0 + 1 or iter_9_0) <= arg_9_1 then
						if self._effectSpine[iter_9_0] then
							self._effectSpine[iter_9_0]:setVisible(true)
						else
							self._effectSpine[iter_9_0] = self["m_star" .. iter_9_0]:addEffectSpine(arg_9_2)
						end
					end
				end
			end
		end
	end
end

function BaseStarComp:addEffectToStars(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if not arg_10_1 or not arg_10_3 then
		return
	elseif arg_10_1 < 1 or arg_10_1 > self._max then
		return
	elseif arg_10_2 < arg_10_1 then
		return
	end

	local var_10_0 = 0.1

	arg_10_2 = arg_10_2 or self._max
	arg_10_2 = math.min(arg_10_2, self._max)

	local var_10_1 = 1

	if self._lightBackWard then
		var_10_1 = -1
		arg_10_1 = self._max + 1 - arg_10_1
		arg_10_2 = self._max + 1 - arg_10_2
	end

	for iter_10_0 = arg_10_1, arg_10_2, var_10_1 do
		local var_10_2 = self["m_star" .. iter_10_0]

		if not self["m_star" .. iter_10_0] then
			break
		end

		arg_10_3.x = self._starSize.width / 2 + ((arg_10_4 or nil) and (arg_10_4.x or 0))
		arg_10_3.y = self._starSize.height / 2 + ((arg_10_4 or nil) and (arg_10_4.y or 0))

		if iter_10_0 == arg_10_1 then
			var_10_2:addEffectSpine(arg_10_3)
		else
			local var_10_3 = math.abs(iter_10_0 - arg_10_1) * var_10_0
			local var_10_4, var_10_5

			if arg_10_5 == false then
				var_10_3 = 0
				var_10_4 = fgui.FCallFunc:create(function()
					var_10_2:addEffectSpine(arg_10_3)
				end)
				var_10_5 = {}
			end

			var_10_5[1] = fgui.FDelayTime:create(var_10_3)
			var_10_5[2] = var_10_4

			var_10_2:runFGAction((fgui.FSequence:create(var_10_5)))
		end
	end
end

return BaseStarComp
