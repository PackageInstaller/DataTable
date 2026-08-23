local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.config.ksoul_info
local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local BaseKnightSoulIcon = class("BaseKnightSoulIcon", BaseIconComp)

function BaseKnightSoulIcon:ctor()
	BaseKnightSoulIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._bindAllUI = false
	self._type = var_0_1.TYPE_KNIGHT_SOUL
	self._params = {}
	self._info = nil
end

function BaseKnightSoulIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BaseKnightSoulIcon, "__index"), "__supers"))) do
		var_2_0 = BaseKnightSoulIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BaseKnightSoulIcon._addClassMethodsToMethodList(self, BaseKnightSoulIcon, var_2_0))) do
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

function BaseKnightSoulIcon:_addClassMethodsToMethodList(arg_4_1, arg_4_2)
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

function BaseKnightSoulIcon:_bindAllUIAndControllers()
	self:_bindIconLoader(self.m_iconLoader)
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_frameLoader, "frameLoader")
	self:_bindUI(self.m_groupLoader, "groupLoader")
	self:_bindUI(self.m_numTxt, "numTxt")
end

function BaseKnightSoulIcon:_checkAndFixParams(arg_6_1, arg_6_2)
	self._info = nil
	arg_6_2 = arg_6_2 or {}

	if arg_6_1.value then
		self._info = var_0_3.get(arg_6_1.value)
	end

	return arg_6_1
end

function BaseKnightSoulIcon:_getIconUrl(arg_7_1)
	return arg_7_1.icon or self._info.type == var_0_1.TYPE_KNIGHT and var_0_2:getRoleHeadIcon(self._info.icon) or self._info.type == var_0_1.TYPE_ARTIFACT and var_0_2:getArtifactIconById(self._info.icon) or var_0_2:getRoleHeadIcon(self._info.icon)
end

function BaseKnightSoulIcon:_updateDetailUI()
	if self._info then
		self:setQuality(self._info.quality)
	else
		self:setQuality(self._params.quality)
	end

	if self._params.size and self._params.size >= 0 then
		self.m_numTxt:setVisible(true)
		self.m_numTxt:setText(self._params.size)
	else
		self.m_numTxt:setVisible(false)
	end

	self:setKnightSoulGroupLoader(self._info.group)
end

function BaseKnightSoulIcon:setQuality(arg_9_1)
	if self._quality == arg_9_1 then
		return
	end

	self._quality = arg_9_1

	self._bindUINodes.bgLoader:setURL((var_0_2:getKnightSoulIconBgByQuality(arg_9_1)))
	self._bindUINodes.frameLoader:setURL((var_0_2:getKnightSoulIconBgByQuality(arg_9_1, true)))
end

function BaseKnightSoulIcon:setKnightSoulGroupLoader(arg_10_1)
	if arg_10_1 == 0 then
		self._bindUINodes.groupLoader:setVisible(false)
	else
		self._bindUINodes.groupLoader:setVisible(true)
		self._bindUINodes.groupLoader:setURL((var_0_2:getKnightSoulCardGroupIcon(self._quality, arg_10_1)))
	end
end

function BaseKnightSoulIcon:setEmpty()
	self:setQuality(var_0_0.NONE)
	self:_setIcon("", false)
end

function BaseKnightSoulIcon:setIconBgVisible(arg_12_1)
	if self._bindUINodes.bgLoader then
		self._bindUINodes.bgLoader:setVisible(arg_12_1)
	end
end

function BaseKnightSoulIcon:_setIcon(arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or ""

	self._bindUINodes.iconLoader:setURL(arg_13_1)
end

return BaseKnightSoulIcon
