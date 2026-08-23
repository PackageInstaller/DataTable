local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr
local BaseIconNew = class("BaseIconNew", require("app.fairyGUI.base_new.UI_BaseIcon"))

function BaseIconNew:ctor()
	self._iconComp = nil
	self._params = nil
	self._otherInfo = nil
end

function BaseIconNew:updateIconByTypeAndValue(arg_2_1, arg_2_2, arg_2_3)
	arg_2_3 = arg_2_3 or 1

	self:updateIcon({
		type = arg_2_1,
		value = arg_2_2,
		size = arg_2_3
	})
end

function BaseIconNew:updateIcon(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	if not arg_3_1.iconCompName then
		if arg_3_1.type == var_0_0.TYPE_KNIGHT then
			arg_3_1.iconCompName = "BaseKnightIcon"
			arg_3_1.baseId = arg_3_1.baseId or arg_3_1.value
		else
			local var_3_0 = var_0_0:convert({
				type = arg_3_1.type,
				value = arg_3_1.value,
				size = arg_3_1.size
			})

			assert(var_3_0, "cannot find icon data: type:" .. arg_3_1.type .. " value: " .. arg_3_1.value)

			for iter_3_0, iter_3_1 in pairs(arg_3_1) do
				var_3_0[iter_3_0] = var_3_0[iter_3_0] or iter_3_1
			end

			arg_3_1 = var_3_0
		end
	end

	arg_3_1.scale = nil

	if arg_3_1.scaleIndex then
		self.m_scaleIndexController:setSelectedIndex(arg_3_1.scaleIndex)
	end

	arg_3_1.scaleIndex = nil

	self:_checkAndCreateIcon(arg_3_1.iconCompName)
	self:checkOweTag(arg_3_1)

	self._params = arg_3_1
	self._otherInfo = arg_3_2

	self:_updateUI()
end

function BaseIconNew:checkOweTag(arg_4_1)
	if arg_4_1.type == var_0_0.TYPE_SKIN then
		if g.core.model.User.skinData:getSkinState(arg_4_1.value) ~= 0 then
			arg_4_1.iconTagType = var_0_1.BASE_CONST.ICON_TAG_TYPE.HAVE
		end
	elseif arg_4_1.type == var_0_0.TYPE_HALIDOM then
		arg_4_1.iconTagType = var_0_1.BASE_CONST.ICON_TAG_TYPE.LEVEL
		arg_4_1.level = g.core.config.gve_equipment_info.get(arg_4_1.value).level
	elseif arg_4_1.type == var_0_0.TYPE_THEME_BIO_ITEM then
		arg_4_1.iconTagType = var_0_1.BASE_CONST.ICON_TAG_TYPE.NEW_CLUE
	elseif arg_4_1.type == var_0_0.TYPE_KNIGHT_FAVORABILITY_ITEM then
		arg_4_1.iconTagType = var_0_1.BASE_CONST.ICON_TAG_TYPE.ITEM_SPECIAL_USE
		arg_4_1.iconTagTypeParams = 1
	elseif arg_4_1.type == var_0_0.TYPE_TREASURE then
		-- block empty
	end
end

function BaseIconNew:updateByGoods(arg_5_1, arg_5_2)
	if not next(arg_5_1) then
		return
	end

	self:_checkAndCreateIcon(var_0_0:getIconCompName(arg_5_1.type))
	self._iconComp:setQuality(arg_5_1.quality, arg_5_1.isRare)
	self:setIcon(arg_5_1.icon, arg_5_2)
	self._iconComp:setIconName(arg_5_1.name, arg_5_1.quality)
	self._iconComp:setElement(g.core.config.knight_info.get(arg_5_1.advanceId).classical)
	self._iconComp:setLeaderIcon(g.core.config.knight_info.get(arg_5_1.advanceId).is_element_leader > 0)
end

function BaseIconNew:_updateUI()
	self._iconComp:updateIcon(self._params, self._otherInfo)

	if config.PUBLISH_REGION == var_0_1.PlatformConst.REGION.JAPAN and self._params.prob and self._params.iconTagType ~= var_0_1.BASE_CONST.ICON_TAG_TYPE.LUCKY then
		self.m_BaseIconTagComp:setIconTagType(var_0_1.BASE_CONST.ICON_TAG_TYPE.PROB_NUM, self._params.prob)
	elseif self._params.iconTagType == var_0_1.BASE_CONST.ICON_TAG_TYPE.LEVEL then
		self.m_BaseIconTagComp:setIconTagType(self._params.iconTagType, self._params.level)
	else
		self.m_BaseIconTagComp:setIconTagType(self._params.iconTagType, self._params.iconTagTypeParams)
	end
end

function BaseIconNew:updateTagType()
	if self._params.prob then
		self.m_BaseIconTagComp:setIconTagType(var_0_1.BASE_CONST.ICON_TAG_TYPE.PROB_NUM, self._params.prob)
	elseif self._params.iconTagType then
		self.m_BaseIconTagComp:setIconTagType(self._params.iconTagType)
	end
end

function BaseIconNew:_checkAndCreateIcon(arg_8_1)
	if self._iconComp then
		if self._iconComp:getName() == arg_8_1 then
			return
		end

		self._iconComp:removeSelf()
	end

	self._iconComp = fgui.UIPackage:createObject("base_new", arg_8_1)

	self._iconComp:setPivot(0.5, 0.5, true)
	self._iconComp:setName(arg_8_1)
	self.m_iconHoldComp:addChild(self._iconComp)
	self:_initIconCompController()
	self._iconComp:setVisible(true)
end

function BaseIconNew:_initIconCompController()
	local var_9_0 = {}

	var_9_0.m_showLevelController = self.m_showLevelController:getSelectedIndex() > 0 and self.m_showLevelController:getSelectedIndex() - 1 or nil
	var_9_0.m_isShowNumController = self.m_isShowNumController:getSelectedIndex() > 0 and self.m_isShowNumController:getSelectedIndex() - 1 or nil
	var_9_0.m_isShowRefineController = self.m_isShowRefineController:getSelectedIndex() > 0 and self.m_isShowRefineController:getSelectedIndex() - 1 or nil
	var_9_0.m_isShowInfoController = self.m_isShowInfoController:getSelectedIndex() > 0 and self.m_isShowInfoController:getSelectedIndex() - 1 or nil
	var_9_0.m_nameTypeController = self.m_nameTypeController:getSelectedIndex() > 0 and self.m_nameTypeController:getSelectedIndex() - 1 or nil
	var_9_0.m_hideSkinController = self.m_hideSkinController:getSelectedIndex() > 0 and self.m_nameTypeController:getSelectedIndex() - 1 or nil

	self._iconComp:initControllers(var_9_0)
end

function BaseIconNew:setIcon(arg_10_1, arg_10_2, arg_10_3)
	if self._iconComp == nil then
		self:_checkAndCreateIcon(arg_10_3)
	end

	if self._iconComp.setIcon then
		self._iconComp:setIconByUrl(arg_10_1, arg_10_2)
	end
end

function BaseIconNew:getIconComp()
	return self._iconComp
end

function BaseIconNew:setTouchFunc(arg_12_1)
	if self._iconComp then
		self._iconComp:setTouchFunc(arg_12_1)
	end
end

function BaseIconNew:setTouchEnable(arg_13_1)
	if self._iconComp then
		self._iconComp:setTouchable(arg_13_1)
	end
end

function BaseIconNew:setIconGray(arg_14_1)
	self._iconComp:setIconGray(arg_14_1)
end

function BaseIconNew:setCompGray(arg_15_1)
	if self._iconComp then
		self._iconComp:setCompGray(arg_15_1)
	end
end

function BaseIconNew:setIconEmpty()
	if self._iconComp then
		self._iconComp:setVisible(false)
	end
end

function BaseIconNew:setShowZeroNum(arg_17_1)
	if self._iconComp then
		self._iconComp:setShowZeroNum(arg_17_1)
	end
end

function BaseIconNew:playIconEffect(arg_18_1, arg_18_2)
	if self._iconComp then
		self._iconComp:playIconEffect(arg_18_1, arg_18_2)
	end
end

function BaseIconNew:setIconQualityBgVisible(arg_19_1)
	if self._iconComp then
		self._iconComp:setIconQualityBgVisible(arg_19_1)
	end
end

return BaseIconNew
