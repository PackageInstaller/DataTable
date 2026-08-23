local KsMath = require("app.core.utils.KsMath")
local MapConst = import("..MapConst")
local MapDataMgr = import("..MapDataMgr")
local MapEntity = class("MapEntity")

function MapEntity:ctor(arg_1_1, arg_1_2)
	self._fatherWorld = nil
	self._resID = arg_1_1.resID
	self._resType = arg_1_1.type
	self._isFlip = arg_1_1.flip
	self._scale = arg_1_1.scale
	self._offset = cc.p(arg_1_1.offx, arg_1_1.offy)
	self._bindID = arg_1_1.bindID
	self._bParam = arg_1_1.bParam
	self._isMainRole = arg_1_1.isMain
	self._descName = arg_1_1.dName
	self._resPath = arg_1_2 or ""
	self._boundRect = nil
	self._layName = nil
	self._coord = cc.p(0, 0)
	self._unified = 0
	self._visualIns = nil
	self._isOptimizeShow = false
	self._isLogicShow = true
	self._isNameInit = false
	self._autoRoleSkin = true

	self:initEntity()
end

function MapEntity:initEntity()
	self:_calcBaseBoundBox()
end

function MapEntity:jump2Coord(arg_3_1)
	local var_3_0, var_3_1 = self._fatherWorld:getMapGround():coordToPixel(arg_3_1.x, arg_3_1.y)

	self._visualIns:setPosBothZ(cc.p(var_3_0, var_3_1))
	self:setCoord(arg_3_1)
end

function MapEntity:setCoord(arg_4_1)
	if KsMath.IsSameCoord(self._coord, arg_4_1) then
		return
	end

	self._coord = arg_4_1
	self._unified = KsMath.coord2Unified(arg_4_1.x, arg_4_1.y)

	self:_onCoordChanged()
end

function MapEntity:setUnified(arg_5_1)
	if arg_5_1 == self._unified then
		return
	end

	self._unified = arg_5_1
	self._coord = KsMath.unified2Coord(arg_5_1)

	self:_onCoordChanged()
end

function MapEntity:getUnified()
	return self._unified
end

function MapEntity:getCoord()
	return self._coord
end

function MapEntity:getOrgPos()
	local var_8_0 = self:getCoord()
	local var_8_1, var_8_2 = self._fatherWorld:getMapGround():coordToPixel(var_8_0.x, var_8_0.y)

	return cc.p(var_8_1 + self._offset.x, var_8_2 + self._offset.y)
end

function MapEntity:getWorldPos()
	if self._visualIns then
		return cc.p(self._visualIns:getPosition())
	else
		return self:getOrgPos()
	end
end

function MapEntity:checkIsNeedShow(arg_10_1)
	local var_10_0 = self:getWorldPos()

	self._boundRect.x = self._boundRect.x + var_10_0.x
	self._boundRect.y = self._boundRect.y + var_10_0.y
	self._boundRect.x = self._boundRect.x - var_10_0.x
	self._boundRect.y = self._boundRect.y - var_10_0.y

	return (KsMath.isRectIntersect(self._boundRect, arg_10_1))
end

function MapEntity:_calcBaseBoundBox()
	local var_11_0 = self:_getBaseResRect()

	self._boundRect = var_11_0 and {
		x = var_11_0.width / 2 - var_11_0.width * var_11_0.x,
		y = var_11_0.height / 2 - var_11_0.height * var_11_0.y,
		width = var_11_0.width / 2,
		height = var_11_0.height / 2
	} or {
		x = 0,
		height = 0,
		y = 0,
		width = 0
	}
end

function MapEntity:_getBaseResRect()
	if self._resType == MapConst.RESTYPE.IMAGE then
		return MapDataMgr.getImageSize(self._resPath, self._resID)
	elseif self._resType == MapConst.RESTYPE.SPINE then
		return {
			x = 0.5,
			height = 150,
			y = 0,
			width = 80
		}
	elseif self._resType == MapConst.RESTYPE.EMPTY_SPACE then
		return {
			x = 0.5,
			height = 150,
			y = 0,
			width = 80
		}
	else
		return {
			x = 0.5,
			height = 150,
			y = 0,
			width = 80
		}
	end
end

function MapEntity:resyncCoord(arg_13_1)
	local var_13_0, var_13_1 = self._fatherWorld:getMapGround():pixelToCoord(arg_13_1.x, arg_13_1.y)

	self:setCoord(cc.p(var_13_0, var_13_1))
end

function MapEntity:setAttachName(arg_14_1)
	self._layName = arg_14_1
end

function MapEntity:getAttachName()
	return self._layName
end

function MapEntity:getBindID()
	return self._bindID
end

function MapEntity:getBindParam()
	return self._bParam
end

function MapEntity:isMainRole()
	return self._isMainRole
end

function MapEntity:getRoleName()
	return self._descName
end

function MapEntity:setRoleName(arg_20_1)
	if not self._visualIns then
		return false
	end

	self._visualIns:setDescName(arg_20_1)

	if arg_20_1 and arg_20_1 ~= "" then
		self._descName = arg_20_1
	end

	return true
end

function MapEntity:setAutoRoleSkin(arg_21_1)
	self._autoRoleSkin = arg_21_1
end

function MapEntity:enterWorld(arg_22_1)
	self._fatherWorld = arg_22_1

	self:_checkVisualShow()
end

function MapEntity:showBubbleTalk(arg_23_1, arg_23_2)
	if self._visualIns and self._visualIns.showTalkBubble then
		self._visualIns:showTalkBubble(arg_23_1, arg_23_2)
	end
end

function MapEntity:leaveWorld()
	self:_cleanVisual()

	self._fatherWorld = nil
end

function MapEntity:serializeRecord()
	local var_25_0 = self._fatherWorld:doCreateFactory().createRecord()

	var_25_0.resID = self._resID
	var_25_0.type = self._resType
	var_25_0.flip = self._isFlip
	var_25_0.scale = self._scale
	var_25_0.offx = self._offset.x
	var_25_0.offy = self._offset.y
	var_25_0.bindID = self._bindID
	var_25_0.dName = self._descName

	return var_25_0
end

function MapEntity:checkHit(arg_26_1)
	if self._visualIns == nil then
		return false
	end

	return self._visualIns:realRangeCheck(arg_26_1)
end

function MapEntity:setShow(arg_27_1)
	if arg_27_1 == self._isLogicShow then
		return
	end

	self._isLogicShow = arg_27_1

	self:_checkVisualShow()
end

function MapEntity:setInView(arg_28_1)
	if arg_28_1 == self._isOptimizeShow then
		return
	end

	self._isOptimizeShow = arg_28_1

	self:_checkVisualShow()
end

function MapEntity:setSignShow(arg_29_1, arg_29_2)
	arg_29_1 = arg_29_1 or self._taskState or -1
	arg_29_2 = arg_29_2 or self._battleTaskIsMain or -1
	self._taskState = arg_29_1
	self._battleTaskIsMain = arg_29_2

	if self._visualIns == nil then
		return
	end

	local var_29_0 = "ui_cocos/biography/"
	local var_29_1
	local var_29_2

	if self._bindID and self._fatherWorld then
		local var_29_3 = self._fatherWorld:getMapStage()

		if var_29_3 and var_29_3.isNextMissionTarget and var_29_3:isNextMissionTarget(self._bindID) then
			var_29_1 = var_29_0 .. "icon_zhuxianbiaoji.png"
			var_29_2 = var_29_0 .. "icon_zhixianbiaoji.png"
		end
	end

	if arg_29_1 == 1 then
		self._visualIns:setSignIcon(var_29_0 .. "icon_lz_zhixian.png", var_29_2)
	elseif arg_29_1 == 2 then
		if arg_29_2 then
			self._visualIns:setSignIcon("ui_cocos/biography/icon_lz_gongji.png", var_29_1)
		else
			self._visualIns:setSignIcon("ui_cocos/biography/icon_lz_gongji.png", var_29_2)
		end
	elseif arg_29_1 == 3 then
		self._visualIns:setSignIcon("ui_cocos/biography/icon_lz_zhuxian.png", var_29_1)
	else
		self._visualIns:setSignIcon(nil)
	end
end

function MapEntity:_checkVisualShow()
	if self._isLogicShow and self._isOptimizeShow then
		if self._visualIns == nil then
			self:_buildVisual()
		end
	else
		self:_cleanVisual()
	end
end

function MapEntity:_buildVisual()
	self._visualIns = self._fatherWorld:doCreateFactory().createVisual(self._resType, self._resID, self._bindID, self._layName)

	if self._isMainRole and self._autoRoleSkin then
		self._visualIns:addEffectSpine()
		self._visualIns:_doUpdateRoleSkin(g.core.model.User:packUser())
	end

	if self._bParam and self._bParam.snapshot then
		self._visualIns:_doUpdateRoleSkin(self._bParam.snapshot)
	end

	self._fatherWorld:getMapGround():addVisual(self._visualIns, self._layName)
	self:_refreshVisual()
	self:_rebuildInit()
end

function MapEntity:_cleanVisual()
	if self._visualIns then
		self._fatherWorld:getMapGround():delVisual(self._visualIns)

		self._visualIns = nil
	end
end

function MapEntity:_refreshVisual()
	self._visualIns:setScale(self._scale)
	self._visualIns:setInnerFlip(self._isFlip)
	self._visualIns:setDescName(self._descName)
	self:setSignShow()
	self._visualIns:setPosBothZ((self:getOrgPos()))
	self._visualIns:rebuildModel()
end

function MapEntity:_rebuildInit()
	return
end

function MapEntity:_resyncZIndex()
	if self._visualIns then
		self._visualIns:setLocalZOrder((KsMath.countZOrder(self:getCoord())))
	end
end

function MapEntity:_onCoordChanged()
	return
end

function MapEntity:getResId()
	return self._resID
end

function MapEntity:getResType()
	return self._resType
end

function MapEntity:setNameInit(arg_39_1)
	self._isNameInit = arg_39_1
end

function MapEntity:getNameIsInit()
	return self._isNameInit
end

function MapEntity:isHasVisualIns()
	return not not self._visualIns
end

function MapEntity:setOpenState(arg_42_1)
	if self._visualIns then
		self._visualIns:setOpenState(arg_42_1)
	end
end

function MapEntity:getIsOpen()
	if self._visualIns then
		self._visualIns:getIsOpen()
	end
end

function MapEntity:playAnim(arg_44_1, arg_44_2)
	if self._visualIns then
		self._visualIns:playAnim(arg_44_1, arg_44_2)
	end
end

function MapEntity:getIsInteractEntity()
	if self._bindID and self._bindID >= 1000 then
		return true
	end

	return false
end

function MapEntity:getVisual()
	return self._visualIns
end

return MapEntity
