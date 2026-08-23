local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.petsData
local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local BasePetIcon = class("BasePetIcon", BaseIconComp)

function BasePetIcon:ctor()
	BasePetIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._bindAllUI = false
	self._type = var_0_1.TYPE_PET
	self._star = nil
	self._params = {}
	self._info = nil
	self._petStruct = nil
end

function BasePetIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BasePetIcon, "__index"), "__supers"))) do
		var_2_0 = BasePetIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BasePetIcon._addClassMethodsToMethodList(self, BasePetIcon, var_2_0))) do
		if not self[iter_2_2] then
			self[iter_2_2] = iter_2_3
		elseif type(iter_2_2) == "function" and type(self[iter_2_2]) == "function" then
			local var_2_1 = self
			local var_2_2 = self[iter_2_2]
			local var_2_3 = iter_2_3

			self[iter_2_2] = function()
				return var_2_2(var_2_1, ...), (var_2_3(var_2_1, ...))
			end
		end
	end
end

function BasePetIcon:_addClassMethodsToMethodList(arg_4_1, arg_4_2)
	local var_4_0 = {
		super = true,
		ctor = true,
		__supers = true,
		__index = true,
		_bindMethods = true,
		_addClassMethodsToMethodList = true,
		__newindex = true,
		create = true,
		__cname = true,
		new = true
	}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if not var_4_0[iter_4_0] then
			arg_4_2[iter_4_0] = iter_4_1
		end
	end

	return arg_4_2
end

function BasePetIcon:_bindAllUIAndControllers()
	self:_bindIconLoader(self.m_iconLoader)
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_starBg, "starBg")
	self:_bindUI(self.m_starComp, "starComp")
	self:_bindUI(self.m_advanceText, "advanceText")
	self:_bindUI(self.m_advanceBg, "advanceBg")
	self:_bindUI(self.m_infoGroup, "infoGroup")
	self:_bindUI(self.m_grayGraph, "grayGraph")
	self:_bindUI(self.m_nameTxt, "nameText")
	self:_bindController(self.m_isShowInfoController, "m_isShowInfoController")
	self:_bindController(self.m_nameTypeController, "m_nameTypeController")
end

function BasePetIcon:_changeControllers()
	local var_6_0 = {}

	if self._params.struct then
		if self._controllersInitIndexMap.m_isShowInfoController and self._controllersInitIndexMap.m_isShowInfoController ~= 1 then
			var_6_0.m_isShowInfoController = 1
		end
	end

	if self._params.nameRow or self._otherInfo.nameRow then
		local var_6_3 = self._params.nameRow

		if self._controllersInitIndexMap.m_nameTypeController and self._controllersInitIndexMap.m_nameTypeController ~= var_6_3 then
			var_6_0.m_nameTypeController = var_6_3
		end
	end

	self:initControllers(var_6_0)
end

function BasePetIcon:setShowInfoEnable(arg_7_1)
	self:initControllers({
		m_isShowInfoController = arg_7_1 and 1 or 0
	})
end

function BasePetIcon:_checkAndFixParams(arg_8_1, arg_8_2)
	self._petStruct = nil
	self._info = nil
	arg_8_2 = arg_8_2 or {}

	local var_8_0 = arg_8_1.sid or arg_8_2.sid
	local var_8_1 = arg_8_1.advanceId or arg_8_2.advanceId
	local var_8_2 = arg_8_1.struct or arg_8_2.struct
	local var_8_3 = arg_8_1.baseId or arg_8_2.baseId
	local var_8_4 = arg_8_1.info or arg_8_2.info

	if var_8_4 then
		var_8_3 = var_8_4.id
	end

	if var_8_0 then
		self._petStruct = var_0_3:getPetBySid(var_8_0)
	elseif var_8_1 then
		self._petStruct = var_0_3:getPetByAdvanceId(var_8_1)
	elseif var_8_3 then
		self._petStruct = var_0_3:getPetByBaseId(var_8_3)
	elseif var_8_2 then
		self._petStruct = var_8_2
	end

	self._info = var_8_4 and var_8_4 or self._petStruct:getCfg()
	arg_8_1.value = arg_8_1.value or self._info.id

	return arg_8_1
end

function BasePetIcon:_getIconUrl(arg_9_1)
	return arg_9_1.icon or var_0_2:getPetIcon(self._info.advance_id)
end

function BasePetIcon:_updateDetailUI()
	self.m_imgEmpty:setVisible(false)

	if self._info then
		self:setQuality(self._info.quality)
	else
		self:setQuality(self._params.quality)
	end

	self:setNameRow(self._params.nameRow)

	if self._petStruct then
		self:setIconName(self._petStruct:getCfg().name)
		self:setAdvanceLevel((self._petStruct:getBigSmallStage()))
		self:setStar(self._petStruct:getStarNum())
	else
		self:setAdvanceLevel(0)
		self:setStar(0)
	end
end

function BasePetIcon:setIconName(arg_11_1)
	if not self._bindUINodes.nameText then
		return
	end

	arg_11_1 = arg_11_1 or ""

	if self._bindUINodes.nameText:getText() ~= arg_11_1 then
		self._bindUINodes.nameText:setText(arg_11_1)
	end
end

function BasePetIcon:setNameRow(arg_12_1)
	if arg_12_1 and self._bindControllers.m_nameTypeController then
		arg_12_1 = math.clamp(arg_12_1, 0, 2)

		self._bindControllers.m_nameTypeController:setSelectedIndex(arg_12_1)
	end
end

function BasePetIcon:setQuality(arg_13_1)
	if self._quality == arg_13_1 then
		return
	end

	self._quality = arg_13_1

	self._bindUINodes.bgLoader:setURL((var_0_2:getBaseIconQualityBg(arg_13_1)))
end

function BasePetIcon:setAdvanceLevel(arg_14_1)
	if self._advanceLevel == arg_14_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_14_0 = self._bindUINodes.advanceText

	if arg_14_1 == 0 then
		self._bindUINodes.advanceBg:setVisible(false)
		var_14_0:setText("")
	else
		self._bindUINodes.advanceBg:setVisible(true)
		var_14_0:setText(g.core.lang:get(2050, {
			level = arg_14_1
		}))
	end

	self._advanceLevel = arg_14_1
end

function BasePetIcon:hideAdvanceShow()
	self._bindUINodes.advanceBg:setVisible(false)
	self._bindUINodes.advanceText:setText("")
end

function BasePetIcon:setStar(arg_16_1)
	if self._star == arg_16_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_16_0 = self._bindUINodes.starComp

	if not self._star then
		var_16_0:initStar({
			gap = -10,
			style = 1,
			type = 1,
			index = 3,
			num = 0
		})
	end

	var_16_0:setStarNum(arg_16_1)

	self._star = arg_16_1
end

function BasePetIcon:setEmpty()
	self:setQuality(var_0_0.NONE)
	self:_setIcon("", false)
	self:setStar(0)
	self.m_isShowInfoController:setSelectedIndex(0)

	self._advanceLevel = nil

	self.m_imgEmpty:setVisible(true)
end

function BasePetIcon:setIconBgVisible(arg_18_1)
	if self._bindUINodes.bgLoader then
		self._bindUINodes.bgLoader:setVisible(arg_18_1)
	end
end

return BasePetIcon
