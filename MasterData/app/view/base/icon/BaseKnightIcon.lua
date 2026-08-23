local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local BaseKnightIcon = class("BaseKnightIcon", BaseIconComp)

function BaseKnightIcon:ctor()
	BaseKnightIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._type = var_0_0.TYPE_KNIGHT
	self._params = {}
	self._info = nil
	self._knightStruct = nil
end

function BaseKnightIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BaseKnightIcon, "__index"), "__supers"))) do
		var_2_0 = BaseKnightIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BaseKnightIcon._addClassMethodsToMethodList(self, BaseKnightIcon, var_2_0))) do
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

function BaseKnightIcon:_addClassMethodsToMethodList(arg_4_1, arg_4_2)
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

function BaseKnightIcon:_addTouchFunc()
	self:addClickListener(handler(self, self._onClickIcon))
end

function BaseKnightIcon:_onClickIcon()
	if self._touchFunc then
		-- block empty
	end
end

function BaseKnightIcon:_bindAllUIAndControllers()
	self:_bindIconLoader(self.m_iconLoader)
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_starBg, "starBg")
	self:_bindUI(self.m_starComp, "starComp")
	self:_bindUI(self.m_advanceText, "advanceText")
	self:_bindUI(self.m_advanceBg, "advanceBg")
	self:_bindUI(self.m_infoGroup, "infoGroup")
	self:_bindUI(self.m_grayGraph, "grayGraph")
	self:_bindUI(self.m_nameTxt, "nameText")
	self:_bindUI(self.m_weddingLoader, "weddingLoader")
	self:_bindUI(self.m_weddingEff, "weddingEff")
	self:_bindUI(self.m_elementLoader, "elementLoader")
	self:_bindUI(self.m_leaderLoader, "leaderLoader")
	self:_bindController(self.m_isShowInfoController, "m_isShowInfoController")
	self:_bindController(self.m_nameTypeController, "m_nameTypeController")
	self:_bindController(self.m_hideSkinController, "m_hideSkinController")
	self:_bindController(self.m_isShowWeddingController, "m_isShowWeddingController")
end

function BaseKnightIcon:_changeControllers()
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

function BaseKnightIcon:setShowInfoEnable(arg_9_1)
	local var_9_0 = {}

	var_9_0.m_isShowInfoController = arg_9_1 and 1 or 0

	self:initControllers(var_9_0)
end

function BaseKnightIcon:_checkAndFixParams(arg_10_1, arg_10_2)
	self._knightStruct = nil
	self._info = nil
	arg_10_2 = arg_10_2 or {}

	local var_10_0 = arg_10_1.sid or arg_10_2.sid
	local var_10_1 = arg_10_1.advanceId or arg_10_2.advanceId
	local var_10_2 = arg_10_1.struct or arg_10_2.struct
	local var_10_3 = arg_10_1.baseId or arg_10_2.baseId
	local var_10_4 = arg_10_1.info or arg_10_2.info

	if var_10_4 then
		var_10_3 = var_10_4.id
	end

	if var_10_0 then
		self._knightStruct = var_0_2:getKnight({
			id = var_10_0
		})
	elseif var_10_1 then
		self._knightStruct = var_0_2:getKnight({
			advance_id = var_10_1
		}) or var_0_2:getKnight({
			base_id = var_10_3
		})
	elseif var_10_3 then
		self._knightStruct = var_0_2:getKnight({
			base_id = var_10_3
		})
	elseif var_10_2 then
		self._knightStruct = var_10_2
	end

	self._info = not var_10_4 and self._knightStruct:getBaseInfo() or var_10_4
	arg_10_1.value = arg_10_1.value or self._info.id

	return arg_10_1
end

function BaseKnightIcon:_getIconUrl(arg_11_1)
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

		if arg_11_1.dressId then
			local var_11_4 = g.core.config.avata_info.fetch(arg_11_1.dressId)

			if var_11_4 then
				var_11_1 = var_11_4.res
			end
		end

		var_11_0 = var_0_1:getKnightIconById(var_11_1)
	end

	return var_11_0
end

function BaseKnightIcon:_updateDetailUI()
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
		self:setStar(self._params.star or 0)
	end

	self:setNameRow(self._params.nameRow)

	if self._knightStruct then
		self:setIconName(self._knightStruct:getName())
	end

	self:updateWedding()
	self:setElement(self._info.classical)
	self:setLeaderIcon(self._info.is_element_leader > 0)
end

function BaseKnightIcon:updateWedding()
	self.m_isShowWeddingController:setSelectedIndex(0)

	if self._params.mustShowWedding then
		self.m_weddingLoader:setURL(g.core.common.Path:getWeddingVowBaseIcon())
		self.m_isShowWeddingController:setSelectedIndex(1)
		self:updateWeddingEffect(true)
	else
		self:updateWeddingEffect(false)

		if not self._knightStruct or not self._params.isNeedShowWedding then
			return
		end

		if self._knightStruct:isOwn() and g.core.model.User.weddingData:isWeddingVowByKnightId((self._knightStruct:getAdvanceId())) then
			self.m_weddingLoader:setURL(g.core.common.Path:getWeddingVowBaseIcon())
			self.m_isShowWeddingController:setSelectedIndex(1)
			self:updateWeddingEffect(true)
		end
	end
end

function BaseKnightIcon:updateWeddingEffect(arg_14_1)
	if arg_14_1 then
		self.m_weddingEff:setVisible(true)

		self._weddingEffect = self._weddingEffect or self.m_weddingEff:addEffectSpine({
			anim = "play",
			name = "eff_ui_wedding_frameSmall",
			remove = false,
			isLoop = true
		})
	else
		self.m_weddingEff:setVisible(false)
	end
end

function BaseKnightIcon:setIconName(arg_15_1)
	if not self._bindUINodes.nameText then
		return
	end

	if self._bindUINodes.nameText:getText() == arg_15_1 then
		return
	end

	arg_15_1 = arg_15_1 or ""

	self._bindUINodes.nameText:setText(arg_15_1)
end

function BaseKnightIcon:setNameRow(arg_16_1)
	if arg_16_1 and self._bindControllers.m_nameTypeController then
		arg_16_1 = math.clamp(arg_16_1, 0, 2)

		self._bindControllers.m_nameTypeController:setSelectedIndex(arg_16_1)
	end
end

function BaseKnightIcon:setQuality(arg_17_1, arg_17_2)
	if self._quality == arg_17_1 and self._isRare == arg_17_2 then
		return
	end

	self._quality = arg_17_1
	self._isRare = arg_17_2

	self._bindUINodes.bgLoader:setURL(var_0_1:getUserIconQualityNewBg(arg_17_1))

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self._bindUINodes.starBg:setURL(var_0_1:getUserIconQualityStarBg(arg_17_1))
	end
end

function BaseKnightIcon:setElement(arg_18_1)
	self._bindUINodes.elementLoader:setURL(var_0_1:getKnightElementIcon(arg_18_1))
end

function BaseKnightIcon:setLeaderIcon(arg_19_1)
	self._bindUINodes.leaderLoader:setURL((arg_19_1 or nil) and "ui://base_new/icon_duizhangty")
end

function BaseKnightIcon:setAdvanceLevel(arg_20_1)
	if self._advanceLevel == arg_20_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_20_0 = self._bindUINodes.advanceText

	if arg_20_1 == 0 then
		self._bindUINodes.advanceBg:setVisible(false)
		var_20_0:setText("")
	else
		var_20_0:setText(g.core.lang:get(2050, {
			level = arg_20_1
		}))
		self._bindUINodes.advanceBg:setVisible(true)
	end

	self._advanceLevel = arg_20_1
end

function BaseKnightIcon:hideAdvanceShow()
	self._bindUINodes.advanceBg:setVisible(false)
	self._bindUINodes.advanceText:setText("")
end

function BaseKnightIcon:setStar(arg_22_1)
	if self._star == arg_22_1 or self._controllersInitIndexMap.m_isShowInfoController == 0 then
		return
	end

	local var_22_0 = self._bindUINodes.starComp

	if not self._star then
		var_22_0:initStar({
			gap = -10,
			style = 1,
			type = 1,
			index = 3,
			num = 0
		})
	end

	var_22_0:setStarNum(arg_22_1)

	self._star = arg_22_1
end

function BaseKnightIcon:setLevelTxt(arg_23_1)
	return
end

function BaseKnightIcon:setEmpty()
	self:setQuality(var_0_3.NONE)
	self:_setIcon("", false)
	self:setStar(0)
	self.m_isShowInfoController:setSelectedIndex(0)

	self._advanceLevel = nil

	self.m_imgEmpty:setVisible(true)
end

function BaseKnightIcon:setIconBgVisible(arg_25_1)
	if self._bindUINodes.bgLoader then
		self._bindUINodes.bgLoader:setVisible(arg_25_1)
	end
end

function BaseKnightIcon:setStarBgVisible(arg_26_1)
	if self._bindUINodes.starBg then
		self._bindUINodes.starBg:setVisible(false)
	end
end

return BaseKnightIcon
