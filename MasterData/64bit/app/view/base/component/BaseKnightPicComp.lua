local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.config.knight_base_info
local var_0_4 = g.core.config.skin_info
local BaseKnightPicComp = class("BaseKnightPicComp", require("app.fairyGUI.base_new.UI_BaseKnightPicComp"))

function BaseKnightPicComp:ctor()
	self._picWidth = 1000
	self._orgPos = self.m_knightImg:getPosition()
	self._offX = 0
	self._offY = 0
	self._scale = 1
	self._knightImgUrl = ""
	self._isNeedDownload = false

	self:setAlphaLRDistance(150)

	self._rectInfo = nil
end

function BaseKnightPicComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_FINISH, handler(self, self.onPackageDownloadFinish), self)
end

function BaseKnightPicComp:_reloadUIEListener()
	if self.__onLoaded then
		return
	end

	self:addEventListener(fgui.UIEventType.EnterFinish, handler(self, self.onUICompEnter))
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self.onUICompExit))
	self:onEnterFinish()
end

function BaseKnightPicComp:getKnightImg()
	return self.m_knightImg
end

function BaseKnightPicComp:updatePic(arg_5_1)
	if type(arg_5_1) ~= "table" then
		return
	end

	self._knightImgUrl = arg_5_1.url

	self.m_knightImg:setURL(arg_5_1.url)

	self._scale = arg_5_1.scale or 1

	self:setScale(self._scale)

	self._offX = arg_5_1.x or 0
	self._offY = arg_5_1.y or 0

	self.m_knightImg:setPosition(self._orgPos.x + self._offX, self._orgPos.y + self._offY)

	if arg_5_1.isReverse then
		self.m_knightImg:setScaleX(-1)
	end

	self:setClickCallback(arg_5_1.callback)
end

function BaseKnightPicComp:onPackageDownloadFinish()
	if self._isNeedDownload and self._params then
		self._isNeedDownload = false

		self:updateKnight(self._params)

		if self._rectInfo then
			self:setAlphaRect(self._rectInfo.type, self._rectInfo.rect, self._rectInfo.alphaDistance)
		end

		self._rectInfo = nil
	end
end

function BaseKnightPicComp:updateKnight(arg_7_1)
	if type(arg_7_1) ~= "table" then
		return
	end

	if not self.__onLoade and self:getParent() then
		self:_reloadUIEListener()
	end

	self._params = arg_7_1
	self._scale = arg_7_1.scale or 1

	local var_7_0 = self:_getKnightBaseInfo(arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_0_0:getKnightPicById(var_7_0.painted_id)

	if arg_7_1.useMidKnight then
		var_7_1 = var_0_0:getMiddleKnightPicById(var_7_0.painted_id)
	elseif arg_7_1.knightUrl then
		var_7_1 = arg_7_1.knightUrl
	end

	self._knightImgUrl = var_7_1

	if g.core.common.PackageRes:checkResIsNeedUpgrade(var_7_0.painted_id, g.core.common.PackageRes.resType.KNIGHT) then
		self.m_isNeedDownloadController:setSelectedIndex(1)

		self._isNeedDownload = true

		return
	end

	self.m_isNeedDownloadController:setSelectedIndex(0)
	self.m_knightImg:setURL(var_7_1)

	local var_7_2 = 0
	local var_7_3 = 0

	if arg_7_1.isUsePrePos then
		var_7_2 = var_7_0.pre_pos_x or 0
		var_7_3 = var_7_0.pre_pos_y or 0

		if var_7_0.pre_scale > 0 then
			self._scale = self._scale * var_7_0.pre_scale / 100
		end
	end

	if not arg_7_1.useMidKnight then
		self._offX = var_7_0.pic_pos_x + var_7_2
		self._offY = var_7_0.pic_pos_y + var_7_3

		self.m_knightImg:setPosition(self._orgPos.x + self._offX, self._orgPos.y + self._offY)
	end

	if arg_7_1.isReverse then
		self.m_knightImg:setScaleX(-1)
	end

	self:setScale(self._scale)
	self:setClickCallback(arg_7_1.callback, arg_7_1.isCustom)
end

function BaseKnightPicComp:_getKnightBaseInfo(arg_8_1)
	local var_8_0

	if arg_8_1.baseId then
		var_8_0 = var_0_3.get(var_0_2.get(arg_8_1.baseId).res_id)
	elseif arg_8_1.knight then
		local var_8_1 = arg_8_1.knight:getInfo()

		var_8_0 = var_8_1 and var_8_1.skin and var_8_1.skin > 0 and (var_8_1.skin_ts and (var_8_1.skin_ts == 0 or var_8_1.skin_ts > g.core.common.ServerTime:getTime()) and var_0_3.get(var_0_4.get(var_8_1.skin).res) or arg_8_1.knight:getResInfo()) or arg_8_1.knight:getResInfo()
	elseif arg_8_1.snapshot then
		local var_8_2, var_8_3 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_8_1.snapshot)

		if var_8_2 then
			var_8_0 = var_8_3.resId == nil and var_0_3.get(var_0_2.get(var_8_3.showId).res_id) or var_0_3.get(var_8_3.resId)
		else
			local var_8_4 = arg_8_1.snapshot.show_knight_dress

			if arg_8_1.snapshot.show_knight_dress and var_8_4 > 0 then
				var_8_0 = var_0_3.get(g.core.config.skin_info.get(var_8_4).res)
			else
				local var_8_5 = arg_8_1.snapshot.show_knight_id

				if not arg_8_1.snapshot.show_knight_id or var_8_5 == 0 then
					var_8_5 = arg_8_1.snapshot.base_id
				end

				var_8_0 = var_0_3.get(var_0_2.get(var_8_5).res_id)
			end
		end
	elseif arg_8_1.resId then
		var_8_0 = var_0_3.get(arg_8_1.resId)
	elseif arg_8_1.skinId then
		var_8_0 = var_0_3.get(g.core.config.skin_info.get(arg_8_1.skinId).res)
	end

	return var_8_0
end

function BaseKnightPicComp:setClickCallback(arg_9_1, arg_9_2)
	if arg_9_1 then
		self:addEventListener(fgui.UIEventType.TouchBegin, function(arg_10_0)
			arg_10_0:captureTouch()
		end, 1001)
		self:addEventListener(fgui.UIEventType.TouchEnd, function()
			return
		end, 1001)
		self:addClickListener(function(arg_12_0)
			arg_9_1(arg_12_0)
		end, 1001)
		self:setTouchable(true)
	elseif arg_9_2 then
		self:setTouchable(true)
	else
		self:removeEventListener(fgui.UIEventType.TouchBegin, 1001)
		self:removeEventListener(fgui.UIEventType.TouchEnd, 1001)
		self:removeClickListener(1001)
		self:setTouchable(false)
	end
end

function BaseKnightPicComp:setAlphaRect(arg_13_1, arg_13_2, arg_13_3)
	self._rectInfo = {
		type = arg_13_1,
		rect = arg_13_2,
		alphaDistance = arg_13_3
	}

	local var_13_0 = self.m_knightImg:getContentSprite()

	if var_13_0 == nil then
		return
	end

	if arg_13_2 == nil then
		arg_13_2 = {
			x = var_0_1.MASK_RECT.x,
			y = var_0_1.MASK_RECT.y,
			width = var_0_1.MASK_RECT.width,
			height = var_0_1.MASK_RECT.height
		}
	end

	arg_13_2.x = arg_13_2.x - self._offX
	arg_13_2.y = arg_13_2.y + self._offY

	if arg_13_3 == nil then
		arg_13_3 = var_0_1.MASK_A_RANGE
	end

	if arg_13_1 == var_0_1.MASK_TYPE.HORIZON then
		arg_13_2.height = 0
	elseif arg_13_1 == var_0_1.MASK_TYPE.VERTICAL then
		arg_13_2.width = 0
	elseif arg_13_1 == var_0_1.MASK_TYPE.ALL then
		-- block empty
	else
		arg_13_2.width = 0
		arg_13_2.height = 0
		arg_13_3 = 0
	end

	var_13_0:showChangingRect(arg_13_2, arg_13_3)
end

function BaseKnightPicComp:setAlphaLRDistance(arg_14_1)
	self:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-(self._picWidth - 2 * arg_14_1) / 2, 0, self._picWidth - 2 * arg_14_1, 0), arg_14_1)
end

function BaseKnightPicComp:setImageColor(arg_15_1)
	self.m_knightImg:setColor(arg_15_1)
end

function BaseKnightPicComp:getScaleNum()
	return self._scale
end

function BaseKnightPicComp:getImageUrl()
	return self._knightImgUrl
end

return BaseKnightPicComp
