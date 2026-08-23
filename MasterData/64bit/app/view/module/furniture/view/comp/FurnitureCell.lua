local FurnitureRoomGird = require("app.view.module.furniture.view.sub.FurnitureRoomGird")
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.common.Path
local FurnitureCell = class("FurnitureCell", require("app.fairyGUI.furniture.UI_FurnitureCell"))

function FurnitureCell:ctor()
	self._info = nil
	self._furnitureSpine = nil
	self._ground = nil
	self._isinitedFurnitureGird = false
	self.m_furnitureComp = self.m_furnitureImgCell:getChild("furnitureComp")
	self.m_furnitureLoader = self.m_furnitureImgCell:getChild("furnitureLoader")
	self.m_furnitureLightLoader = self.m_furnitureImgCell:getChild("furnitureLightLoader")
	self.m_debugBg = self.m_furnitureImgCell:getChild("debugBg")

	self.m_debugBg:setVisible(false)
end

function FurnitureCell:updateFurnitureCell(arg_2_1, arg_2_2)
	if self._info then
		return
	end

	self._info = arg_2_1

	if self._furnitureSpine then
		self._furnitureSpine:removeFromParent()

		self._furnitureSpine = nil
	end

	if self:isSpineResource() then
		self.m_furnitureComp:addEffectSpineAsync({
			isLoop = true,
			name = self._info.res,
			anim = var_0_2.LOOP_ACTION.IDLE
		}, handler(self, self._onCreateSpineSuccess))
		self.m_debugBg:setVisible(var_0_1.FURNITURE_SPINE_DEBUG_TOUCH.show)
		self.m_debugBg:setSize(self._info.spine_width, self._info.spine_height)
		self.m_furnitureComp:setPosition(self._info.spine_width / 2, self._info.spine_height / 2)
	else
		self.m_furnitureLoader:setURL(var_0_3:getFurniturePicByRes(self._info.res), (self._info.mirror == 1 or nil) and false)
	end

	self.m_furnitureImgCell:setPosition(self._info.x, self._info.y)
end

function FurnitureCell:setSpinImg(arg_3_1)
	if self._info.mirror ~= 1 or self:isSpineResource() then
		-- block empty
	else
		local var_3_0 = var_0_3:getFurniturePicByRes(self._info.res)

		self.m_furnitureLoader:setURL((arg_3_1 or nil) and var_0_3:getFurnitureRightPicByRes(self._info.res))
		self.m_furnitureLoader:setScaleX(arg_3_1 and -1 or 1)
		self.m_furnitureLoader:setPosition(cc.p(arg_3_1 and self.m_furnitureLoader:getWidth() or 0, 0))
	end
end

function FurnitureCell:_onCreateSpineSuccess(arg_4_1)
	self._furnitureSpine = arg_4_1
end

function FurnitureCell:setFurnitureLightImg(arg_5_1)
	if arg_5_1 then
		local var_5_0 = var_0_3:getFurnitureLightPicByRes(self._info.res)

		if string.len(var_5_0) > 0 then
			self.m_furnitureLightLoader:setURL(var_5_0, true)
		end
	else
		self.m_furnitureLightLoader:setURL("")
	end
end

function FurnitureCell:setAnimation(arg_6_1)
	if self._info.type == var_0_1.FURNITURE_TYPE.BATH_CROCK and self._furnitureSpine then
		self._furnitureSpine:setAnimation(0, arg_6_1, true)
	end
end

function FurnitureCell:getFurnitureSpine()
	return self._furnitureSpine
end

function FurnitureCell:isSpineResource()
	return checkbool((string.find(self._info.res, "jiayuan_")))
end

function FurnitureCell:getSpineRoleSlotNode()
	if self._furnitureSpine and self._furnitureSpine:isHaveNodeForSlot("role") then
		return self._furnitureSpine:getNodeForSlot("role")
	end
end

function FurnitureCell:isExistSpineRoleSlotNode()
	return checkbool((self:getSpineRoleSlotNode()))
end

function FurnitureCell:addKnightSpineToRoleSlotNode(arg_11_1)
	local var_11_0 = self:getSpineRoleSlotNode()

	if var_11_0 then
		var_11_0:addChild(arg_11_1)
	end
end

function FurnitureCell:clearSpineRoleSlot()
	local var_12_0 = self:getSpineRoleSlotNode()

	if var_12_0 then
		var_12_0:removeAllChildren()
	end
end

function FurnitureCell:initFurnitureGird()
	if self._isinitedFurnitureGird then
		return
	end

	self._isinitedFurnitureGird = true

	if self._ground then
		self._ground:removeFromParent()
	end

	local var_13_0 = self._info.length

	self._ground = FurnitureRoomGird.new(self, true, self._info.length, self._info.width, self._info.height)

	self._ground:showGridCell(false)

	local function var_13_1(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0
		local var_14_1
		local var_14_2
		local var_14_3 = arg_14_3 and cc.c4f(0.48627450980392156, 0.9882352941176471, 0, 0.5) or cc.c4f(1, 0, 0, 0.5)

		if arg_14_2 then
			var_14_0, var_14_1 = self._ground:coordToPixelZL(arg_14_0, arg_14_1)
			var_14_2 = self._ground:createWallGridCell(var_14_3, true)
		else
			var_14_0, var_14_1 = self._ground:coordToPixel(arg_14_0, arg_14_1)
			var_14_2 = self._ground:createGroundGridCell(var_14_3, true)
		end

		var_14_2:setPosition(var_14_0, var_14_1)
		var_14_2:setScale(0.95)

		if arg_14_3 then
			self.m_greenGridNode:addNode(var_14_2)
		else
			self.m_redGridNode:addNode(var_14_2)
		end
	end

	if self._info.type ~= 3 then
		for iter_13_0 = 0, var_13_0 - 1 do
			for iter_13_1 = 0, self._info.width - 1 do
				var_13_1(iter_13_0, iter_13_1, false, true)
				var_13_1(iter_13_0, iter_13_1, false, false)
			end
		end
	else
		for iter_13_2 = 0, self._info.width - 1 do
			for iter_13_3 = 0, var_13_0 - 1 do
				var_13_1(iter_13_2, iter_13_3, true, true)
				var_13_1(iter_13_2, iter_13_3, true, false)
			end
		end
	end

	self.m_gridPos:addNode(self._ground)
end

return FurnitureCell
