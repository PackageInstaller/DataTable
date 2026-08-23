local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.model.User.petsData
local BasePetPicComp = class("BasePetPicComp", require("app.fairyGUI.base_new.UI_BasePetPicComp"))

function BasePetPicComp:ctor()
	self._picWidth = 1000
	self._orgPos = self.m_petImg:getPosition()
	self._offX = 0
	self._offY = 0
	self._scale = 1
	self._petImgURL = ""

	self:setAlphaLRDistance(150)
end

function BasePetPicComp:getPetImg()
	return self.m_petImg
end

function BasePetPicComp:updatePic(arg_3_1)
	if type(arg_3_1) ~= "table" then
		return
	end

	local var_3_0

	if arg_3_1.advId then
		var_3_0 = var_0_2:getPetByAdvanceId(arg_3_1.advId)
	elseif arg_3_1.pet then
		var_3_0 = arg_3_1.pet
	elseif arg_3_1.baseId then
		var_3_0 = var_0_2:getPetByBaseId(arg_3_1.baseId)
	elseif arg_3_1.sid then
		var_3_0 = var_0_2:getPetBySid(arg_3_1.sid)
	else
		return
	end

	local var_3_1 = var_3_0:getCfg()

	self._petImgURL = arg_3_1.useMiddle and var_0_0:getPetMiddle(var_3_1.resource) or var_0_0:getPetDrawing(var_3_1.resource)

	self.m_petImg:setURL(self._petImgURL)

	if arg_3_1.isUsePrePos then
		if var_3_1.pre_scale > 0 then
			self._scale = self._scale * var_3_1.pre_scale / 100
		end
	end

	self._scale = arg_3_1.scale or 1

	self:setScale(self._scale)

	self._offX = arg_3_1.x or 0
	self._offY = arg_3_1.y or 0

	self.m_petImg:setPosition(self._orgPos.x + self._offX, self._orgPos.y + self._offY)

	if arg_3_1.isReverse then
		self.m_petImg:setScaleX(-1)
	end
end

function BasePetPicComp:setAlphaRect(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self.m_petImg:getContentSprite()

	if var_4_0 == nil then
		return
	end

	if arg_4_2 == nil then
		arg_4_2 = {
			x = var_0_1.MASK_RECT.x,
			y = var_0_1.MASK_RECT.y,
			width = var_0_1.MASK_RECT.width,
			height = var_0_1.MASK_RECT.height
		}
	end

	arg_4_2.x = arg_4_2.x - self._offX
	arg_4_2.y = arg_4_2.y + self._offY

	if arg_4_3 == nil then
		arg_4_3 = var_0_1.MASK_A_RANGE
	end

	if arg_4_1 == var_0_1.MASK_TYPE.HORIZON then
		arg_4_2.height = 0
	elseif arg_4_1 == var_0_1.MASK_TYPE.VERTICAL then
		arg_4_2.width = 0
	elseif arg_4_1 == var_0_1.MASK_TYPE.ALL then
		-- block empty
	else
		arg_4_2.width = 0
		arg_4_2.height = 0
		arg_4_3 = 0
	end

	var_4_0:showChangingRect(arg_4_2, arg_4_3)
end

function BasePetPicComp:setAlphaLRDistance(arg_5_1)
	self:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-(self._picWidth - 2 * arg_5_1) / 2, 0, self._picWidth - 2 * arg_5_1, 0), arg_5_1)
end

return BasePetPicComp
