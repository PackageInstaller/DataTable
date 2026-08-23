local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local BattleRewardIcon = class("BattleRewardIcon", require("app.fairyGUI.battle.UI_BattleRewardIcon"), BaseIconComp)

function BattleRewardIcon:ctor()
	BattleRewardIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._type = var_0_0.TYPE_KNIGHT
	self._params = {}
	self._info = nil
	self._knightStruct = nil
end

function BattleRewardIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BattleRewardIcon, "__index"), "__supers"))) do
		var_2_0 = BattleRewardIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BattleRewardIcon._addClassMethodsToMethodList(self, BattleRewardIcon, var_2_0))) do
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

function BattleRewardIcon:_addClassMethodsToMethodList(arg_4_1, arg_4_2)
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

function BattleRewardIcon:_addTouchFunc()
	self:addClickListener(handler(self, self._onClickIcon))
end

function BattleRewardIcon:_onClickIcon()
	if self._touchFunc then
		-- block empty
	end
end

function BattleRewardIcon:_bindAllUIAndControllers()
	self:_bindIconLoader(self.m_iconLoader)
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_starBg, "starBg")
	self:_bindUI(self.m_starComp, "starComp")
	self:_bindUI(self.m_advanceText, "advanceText")
	self:_bindUI(self.m_advanceBg, "advanceBg")
	self:_bindUI(self.m_infoGroup, "infoGroup")
	self:_bindUI(self.m_grayGraph, "grayGraph")
	self:_bindUI(self.m_nameText, "nameText")
end

function BattleRewardIcon:_changeControllers()
	local var_8_0 = {}

	if self._params.struct then
		if self._controllersInitIndexMap.m_isShowInfoController and self._controllersInitIndexMap.m_isShowInfoController ~= 1 then
			var_8_0.m_isShowInfoController = 1
		end
	end

	if self._params.nameRow or self._otherInfo.nameRow then
		local var_8_3 = self._params.nameRow

		if self._controllersInitIndexMap.m_nameTypeController and self._controllersInitIndexMap.m_nameTypeController ~= var_8_3 then
			var_8_0.m_nameTypeController = var_8_3
		end
	end

	if self._params.hideSkin then
		if self._controllersInitIndexMap.m_hideSkinController and self._controllersInitIndexMap.m_hideSkinController ~= 1 then
			var_8_0.m_hideSkinController = 1
		end
	end

	self:initControllers(var_8_0)
end

function BattleRewardIcon:setShowInfoEnable(arg_9_1)
	local var_9_0 = {}

	var_9_0.m_isShowInfoController = arg_9_1 and 1 or 0

	self:initControllers(var_9_0)
end

function BattleRewardIcon:initControllers(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if self[iter_10_0] then
			self[iter_10_0]:setSelectedIndex(iter_10_1)
		end
	end
end

function BattleRewardIcon:_getIconUrl(arg_11_1)
	local var_11_0

	if arg_11_1.icon then
		var_11_0 = arg_11_1.icon
	else
		local var_11_1 = g.core.config.knight_base_info.get(self._info.res_id).icon_id

		if ((self._bindControllers.m_hideSkinController or nil) and self._bindControllers.m_hideSkinController:getSelectedIndex()) == 0 and self._knightStruct and self._knightStruct:isWearSkin() then
			local var_11_3 = g.core.config.skin_info.fetch((self._knightStruct:getSkin()))

			if var_11_3 then
				var_11_1 = g.core.config.knight_base_info.get(var_11_3.res).icon_id
			end
		end

		var_11_0 = var_0_1:getKnightIconById(var_11_1)
	end

	return var_11_0
end

function BattleRewardIcon:_updateDetailUI()
	self.m_imgEmpty:setVisible(false)

	if self._info then
		self:setQuality(self._info.quality)
	else
		self:setQuality(self._params.quality)
	end

	if self._knightStruct and self._knightStruct:getInfo() then
		self:setAdvanceLevel((self._knightStruct:getAdvStageAndLevel()))
		self:setStar(self._knightStruct:getStarLv())
	else
		self:setAdvanceLevel(0)
		self:setStar(0)
	end

	self:setNameRow(self._params.nameRow)

	if self._knightStruct then
		self:setIconName(self._knightStruct:getName())
	end

	self.m_awardNum:setText(g.core.lang:get(107073, {
		num = self._params.size
	}))
end

function BattleRewardIcon:setIconName(arg_13_1)
	if not self._bindUINodes.nameText then
		return
	end

	if self._bindUINodes.nameText:getText() == arg_13_1 then
		return
	end

	arg_13_1 = arg_13_1 or ""

	self._bindUINodes.nameText:setText(arg_13_1)
end

function BattleRewardIcon:setNameRow(arg_14_1)
	if not arg_14_1 or self._bindControllers.m_nameTypeController then
		return
	end

	if arg_14_1 < 0 then
		arg_14_1 = 0
	elseif arg_14_1 > 2 then
		arg_14_1 = 2
	end

	self._bindControllers.m_nameTypeController:setSelectedIndex(arg_14_1)
end

function BattleRewardIcon:setQuality(arg_15_1, arg_15_2)
	return
end

function BattleRewardIcon:setAdvanceLevel(arg_16_1)
	if self._advanceLevel == arg_16_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_16_0 = self._bindUINodes.advanceText

	if arg_16_1 == 0 then
		self._bindUINodes.advanceBg:setVisible(false)
		var_16_0:setText("")
	else
		var_16_0:setText(g.core.lang:get(2050, {
			level = arg_16_1
		}))
		self._bindUINodes.advanceBg:setVisible(true)
	end

	self._advanceLevel = arg_16_1
end

function BattleRewardIcon:setStar(arg_17_1)
	if self._star == arg_17_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_17_0 = self._bindUINodes.starComp

	if not self._star then
		var_17_0:initStar({
			gap = -10,
			style = 1,
			type = 1,
			index = 3,
			num = 0
		})
	end

	var_17_0:setStarNum(arg_17_1)

	self._star = arg_17_1
end

function BattleRewardIcon:setLevelTxt(arg_18_1)
	return
end

function BattleRewardIcon:setEmpty()
	self:setQuality(var_0_3.NONE)
	self:_setIcon("", false)
	self:setStar(0)
	self.m_isShowInfoController:setSelectedIndex(0)

	self._advanceLevel = nil

	self.m_imgEmpty:setVisible(true)
end

function BattleRewardIcon:setIconBgVisible(arg_20_1)
	if self._bindUINodes.bgLoader then
		self._bindUINodes.bgLoader:setVisible(arg_20_1)
	end
end

function BattleRewardIcon:setStarBgVisible(arg_21_1)
	if self._bindUINodes.starBg then
		self._bindUINodes.starBg:setVisible(false)
	end
end

return BattleRewardIcon
