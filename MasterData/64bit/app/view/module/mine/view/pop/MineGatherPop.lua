local var_0_0 = {
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO] = "ui://mine/bg_qsmy_jiaoguo",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG] = "ui://mine/bg_qsmy_lindong",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI] = "ui://mine/bg_qsmy_dongxi",
	[g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN] = "ui://mine/bg_qsmy_lijin"
}
local MineConst = require("app.view.module.mine.const.MineConst")
local MineGatherPop = class("MineGatherPop", require("app.fairyGUI.mine.UI_MineGatherPop"), function()
	return fgui.GComponent:create({
		resName = "MineGatherPop",
		pkgPath = "ui/mine/mine",
		pkgName = "mine"
	})
end)

function MineGatherPop:ctor()
	self:showAtCenter()

	self._citys = {}
	self._cityQualityMap = {}
	self._selectionList = {}
	self._selectedCity = nil
	self._selQuality = 4

	self.m_cityList:setVirtual()
	self.m_cityList:setItemRenderer(handler(self, self._onCityListRender))
	self.m_cityList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_cityList:doFairyBatching(false)
	self.m_gatherBtn:addClickListener(handler(self, self._onClickGather))
	self.m_cancelGatherBtn:addClickListener(handler(self, self._onClickCancelGather))
	self:_updateView()
end

function MineGatherPop:onLoad()
	g.core.model.User.mineData:setGatherRedPoint(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETMASSINFO, self._onRcvGetMassInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MASS, self._onRcvMineMass, self)
	g.core.network.GameNetProxy:send_C2S_Mine_GetMassInfo({})
	self:_onScheduleUpdate()
	self:newSchedule(handler(self, self._onScheduleUpdate), 1)
end

function MineGatherPop:_onRcvGetMassInfo()
	self:_updateView()
	self:_onScheduleUpdate()
end

function MineGatherPop:_onRcvMineMass(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.type == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(307546))
		self:_updateView()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MINE_GATHER_SUCCESS)
	elseif arg_5_3.type == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(307547))
		self:removeSelf()
	end
end

function MineGatherPop:_onScheduleUpdate()
	local var_6_0 = g.core.common.ServerTime:getTime()
	local var_6_1 = g.core.model.User.mineData:getGatherTs()

	if var_6_0 <= var_6_1 then
		self.m_gatherBtn:setText(g.core.lang:get(1064, {
			second = var_6_1 - var_6_0
		}))
	else
		self.m_gatherBtn:setText(g.core.lang:get(307548))
	end
end

function MineGatherPop:_updateView()
	self._cityQualityMap = {}
	self._selectionList = {}

	for iter_7_0, iter_7_1 in g.core.config.mine_map_info.ipairs() do
		if iter_7_1.type ~= MineConst.TYPE_CAPITAL then
			if not self._cityQualityMap[iter_7_1.quality] then
				self._cityQualityMap[iter_7_1.quality] = {}

				table.insert(self._selectionList, g.core.lang:get(307507 + iter_7_1.quality))
			end

			table.insert(self._cityQualityMap[iter_7_1.quality], iter_7_1)
		end
	end

	self.m_selectGroupComp:setSelectionData(self._selectionList)

	local var_7_0 = g.core.model.User.mineData:getGatherCityId()

	if g.core.model.User.mineData:isGathering() and var_7_0 > 0 then
		self.m_gatheringController:setSelectedIndex(1)

		local var_7_1 = g.core.config.mine_map_info.get(var_7_0)

		self.m_curGatherName:setText(var_7_1.name)
		self.m_curGatherIcon:setURL(g.core.common.Path:getCityBuildingPic(var_7_1.city_pic))
		self.m_curAwardTxt:setText(g.core.lang:get(307506, {
			num = g.core.model.User.mineData:getCityRadio(var_7_1.id)
		}))

		if g.core.model.User.mineData:getCityObjById(var_7_1.id):isInBonusEvent() then
			self.m_upProductController:setSelectedIndex(1)
		else
			self.m_upProductController:setSelectedIndex(0)
		end

		self.m_cityBg:setURL(var_0_0[tonumber(var_7_1.camp)])
		self.m_awardIcon:setURL(g.core.common.Goods:convert(g.core.const.ConstMgr.MineConst.PRODUCT_ITEM).icon)
	else
		self.m_gatheringController:setSelectedIndex(0)
	end

	self:_updateCityList()
	self.m_resComp:updateByTVS({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MINE_GATHER_COST_GOLD).parameter
	})
end

function MineGatherPop:_updateCityList()
	self._citys = self._cityQualityMap[self._selQuality] or {}

	self.m_cityList:setNumItems(#self._citys)
end

function MineGatherPop:_onCityListRender(arg_9_1, arg_9_2)
	if self._citys[arg_9_1 + 1] then
		arg_9_2:updateCity({
			cityInfo = self._citys[arg_9_1 + 1]
		})
	end
end

function MineGatherPop:_onClickGather()
	if g.core.model.User.mineData:getGatherTs() >= g.core.common.ServerTime:getTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(307516))

		return
	end

	if not self._selectedCity then
		g.core.module.ModuleManager:tip(g.core.lang:get(307514))

		return
	end

	if g.core.model.User.mineData:isGathering() and self._selectedCity.id == g.core.model.User.mineData:getGatherCityId() then
		g.core.module.ModuleManager:tip(g.core.lang:get(307515))

		return
	end

	local var_10_0

	if not g.core.model.User.guildData:hasMineGatherRight() then
		g.core.module.ModuleManager:tip(g.core.lang:get(307544))

		do return end

		var_10_0 = g.core.model.User:getFreeGold()
	end

	if var_10_0 < g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MINE_GATHER_COST_GOLD).parameter then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = g.core.common.Goods.TYPE_GOLD,
			size = var_10_0
		})

		return
	end

	local var_10_1 = self._selectedCity.id

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(307533),
		desc = g.core.lang:get(307534, {
			city = g.core.config.mine_map_info.get(self._selectedCity.id).name
		}),
		onConfirm = function()
			if g.core.model.User.guildData:hasGuild() then
				g.core.network.GameNetProxy:send_C2S_Mine_Mass({
					type = 1,
					cityId = var_10_1
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(307537))
			end
		end
	}), {
		touchDisappear = true
	})
end

function MineGatherPop:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "onCheckCityQuality" then
		if self._selQuality ~= arg_12_2.index then
			self._selQuality = arg_12_2.index + 3

			self:_updateCityList()
		end
	end
end

function MineGatherPop:_onClickCancelGather()
	local var_13_0

	if not g.core.model.User.guildData:hasMineGatherRight() then
		g.core.module.ModuleManager:tip(g.core.lang:get(307545))

		do return end

		var_13_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(307543),
		desc = g.core.lang:get(307542),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_Mine_Mass({
				type = 2
			})
		end
	}))
end

function MineGatherPop:_onClickItem(arg_15_1)
	self._selectedCity = self._citys[arg_15_1:getDataValue() + 1]
end

return MineGatherPop
