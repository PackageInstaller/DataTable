local var_0_0 = g.core.common.Path
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.config.knight_base_info
local var_0_4 = g.core.config.skin_info
local RecruitPrimaryKnightIcon = class("RecruitPrimaryKnightIcon", require("app.fairyGUI.recruitKnight.UI_RecruitPrimaryKnightIcon"))

function RecruitPrimaryKnightIcon:ctor()
	self._picWidth = 1000
	self._orgPos = self.m_knightImg:getPosition()
	self._offX = 0
	self._offY = 0
	self._scale = 1
end

function RecruitPrimaryKnightIcon:getKnightImg()
	return self.m_knightImg
end

function RecruitPrimaryKnightIcon:updatePic(arg_3_1)
	if type(arg_3_1) ~= "table" then
		return
	end

	self.m_knightImg:setURL(arg_3_1.url)

	self._scale = arg_3_1.scale or 1

	self:setScale(self._scale)

	self._offX = arg_3_1.x or 0
	self._offY = arg_3_1.y or 0

	self.m_knightImg:setPosition(self._orgPos.x + self._offX, self._orgPos.y + self._offY)

	if arg_3_1.isReverse then
		self.m_knightImg:setScaleX(-1)
	end

	self:setClickCallback(arg_3_1.callback)
end

function RecruitPrimaryKnightIcon:updateKnight(arg_4_1)
	if type(arg_4_1) ~= "table" then
		return
	end

	self._scale = arg_4_1.scale or 1

	local var_4_0 = self:_getKnightBaseInfo(arg_4_1)

	if not var_4_0 then
		return
	end

	self.m_knightImg:setURL((var_0_0:getKnightPicById(var_4_0.painted_id)))

	local var_4_1 = 0
	local var_4_2 = 0

	if arg_4_1.isUsePrePos then
		var_4_1 = var_4_0.pre_pos_x or 0
		var_4_2 = var_4_0.pre_pos_y or 0

		if var_4_0.pre_scale > 0 then
			self._scale = self._scale * var_4_0.pre_scale / 100
		end
	end

	self._offX = var_4_0.pic_pos_x + var_4_1
	self._offY = var_4_0.pic_pos_y + var_4_2

	self.m_knightImg:setPosition(self._orgPos.x + self._offX, self._orgPos.y + self._offY)

	if arg_4_1.isReverse then
		self.m_knightImg:setScaleX(-1)
	end

	self:setScale(self._scale)
	self:setClickCallback(arg_4_1.callback)
end

function RecruitPrimaryKnightIcon:_getKnightBaseInfo(arg_5_1)
	local var_5_0

	if arg_5_1.baseId then
		var_5_0 = var_0_3.get(var_0_2.get(arg_5_1.baseId).res_id)
	elseif arg_5_1.knight then
		local var_5_1 = arg_5_1.knight:getInfo()

		var_5_0 = var_5_1 and var_5_1.skin and var_5_1.skin > 0 and (var_5_1.skin_ts and (var_5_1.skin_ts == 0 or var_5_1.skin_ts > g.core.common.ServerTime:getTime()) and var_0_3.get(var_0_4.get(var_5_1.skin).res) or arg_5_1.knight:getResInfo()) or arg_5_1.knight:getResInfo()
	elseif arg_5_1.snapshot then
		local var_5_2, var_5_3 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_5_1.snapshot)

		if var_5_2 then
			var_5_0 = var_5_3.resId == nil and var_0_3.get(var_0_2.get(var_5_3.showId).res_id) or var_0_3.get(var_5_3.resId)
		else
			local var_5_4 = arg_5_1.snapshot.show_knight_dress

			if arg_5_1.snapshot.show_knight_dress and var_5_4 > 0 then
				var_5_0 = var_0_3.get(g.core.config.skin_info.get(var_5_4).res)
			else
				local var_5_5 = arg_5_1.snapshot.show_knight_id

				if not arg_5_1.snapshot.show_knight_id or var_5_5 == 0 then
					var_5_5 = arg_5_1.snapshot.base_id
				end

				var_5_0 = var_0_3.get(var_0_2.get(var_5_5).res_id)
			end
		end
	elseif arg_5_1.resId then
		var_5_0 = var_0_3.get(arg_5_1.resId)
	elseif arg_5_1.skinId then
		var_5_0 = var_0_3.get(g.core.config.skin_info.get(arg_5_1.skinId).res)
	end

	return var_5_0
end

function RecruitPrimaryKnightIcon:setClickCallback(arg_6_1)
	if arg_6_1 then
		self:addEventListener(fgui.UIEventType.TouchBegin, function(arg_7_0)
			arg_7_0:captureTouch()
		end, 1001)
		self:addEventListener(fgui.UIEventType.TouchEnd, function()
			return
		end, 1001)
		self:addClickListener(function(arg_9_0)
			arg_6_1(arg_9_0)
		end, 1001)
		self:setTouchable(true)
	else
		self:removeEventListener(fgui.UIEventType.TouchBegin, 1001)
		self:removeEventListener(fgui.UIEventType.TouchEnd, 1001)
		self:removeClickListener(1001)
		self:setTouchable(false)
	end
end

function RecruitPrimaryKnightIcon:setImageColor(arg_10_1)
	self.m_knightImg:setColor(arg_10_1)
end

function RecruitPrimaryKnightIcon:getScaleNum()
	return self._scale
end

function RecruitPrimaryKnightIcon:updateColor()
	self.m_knightImg:setColor(cc.WHITE)
	self.m_knightImg:setColor(cc.c3b(80, 80, 80))
end

return RecruitPrimaryKnightIcon
