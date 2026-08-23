local BlazingArenaEmbryoIcon = class("BlazingArenaEmbryoIcon", require("app.fairyGUI.blazingArena.UI_BlazingArenaEmbryoKnightIcon"))

function BlazingArenaEmbryoIcon:ctor()
	self.m_starComp:initStar({
		gap = -10,
		style = 1,
		type = 1,
		index = 3,
		num = 0
	})
end

function BlazingArenaEmbryoIcon:updateIconComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = g.core.common.Goods:convert({
		size = 0,
		type = arg_2_1,
		value = arg_2_2
	})

	self:setIcon(var_2_0.icon)

	local var_2_1

	if self.m_elementLoader then
		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_2_0.info.classical))

		var_2_1 = 0
	end

	self.m_starComp:setStarNum((g.core.common.Goods.CFG[arg_2_1].hasKey("star") or nil) and g.core.common.Goods.CFG[arg_2_1].get(arg_2_2).star)

	if arg_2_3 and arg_2_3 > 0 then
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = arg_2_3
		}))
		self.m_hideLvController:setSelectedIndex(0)
	else
		self.m_hideLvController:setSelectedIndex(1)
	end

	if arg_2_4 and arg_2_4 > 0 then
		self.m_advanceText:setText(g.core.lang:get(2050, {
			level = arg_2_4
		}))
		self.m_hideAdvanceController:setSelectedIndex(0)
	else
		self.m_hideAdvanceController:setSelectedIndex(1)
	end

	if g.core.common.Goods.TYPE_KNIGHT == arg_2_1 then
		self.m_qualityBg:setURL(table.concat({
			"ui://blazingArena/pic_bljt_zhanchong_",
			var_2_0.quality + 1
		}))
	end

	self.m_qualityLoader:setURL(table.concat({
		"ui://base_new/pic_bljt_zhanchong_pinzhi_",
		var_2_0.quality + 1
	}))

	self._data = var_2_0
	self._data.level = arg_2_3
	self._data.advanceStage = arg_2_4
end

function BlazingArenaEmbryoIcon:updateIconCompWithStruct(arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = 1
	local var_3_2 = ""
	local var_3_3 = 1
	local var_3_4 = 0
	local var_3_5

	if g.core.common.Goods.TYPE_UNITETOKEN == arg_3_1 then
		var_3_0 = arg_3_2:getStar()
		var_3_1 = arg_3_2:getLevel()
		var_3_3 = arg_3_2:getQuality()
		var_3_5 = arg_3_2:getBaseId()
		var_3_2 = g.core.common.Path:getIconByTypeValue(arg_3_1, var_3_5)
	elseif g.core.common.Goods.TYPE_PET == arg_3_1 then
		var_3_0 = arg_3_2:getStar()
		var_3_1 = arg_3_2:getLevel()
		var_3_3 = arg_3_2:getQuality()
		var_3_5 = arg_3_2:getCfg().id
		var_3_2 = g.core.common.Path:getIconByTypeValue(arg_3_1, var_3_5)
		var_3_4 = arg_3_2:getBigSmallStage()
	elseif g.core.common.Goods.TYPE_KNIGHT == arg_3_1 then
		var_3_0 = arg_3_2:getStar()
		var_3_1 = arg_3_2:getLevel()
		var_3_3 = arg_3_2:getQuality()
		var_3_5 = arg_3_2:getBaseId()
		var_3_2 = g.core.common.Path:getIconByTypeValue(arg_3_1, var_3_5)
	end

	self:setIcon(var_3_2)
	self.m_qualityBg:setURL(table.concat({
		"ui://blazingArena/pic_bljt_zhanchong_",
		var_3_3 + 1
	}))
	self.m_starComp:setStarNum(var_3_0)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = var_3_1
	}))

	if var_3_4 and var_3_4 > 0 then
		self.m_advanceText:setText(g.core.lang:get(2050, {
			level = var_3_4
		}))
		self.m_hideAdvanceController:setSelectedIndex(0)
	else
		self.m_hideAdvanceController:setSelectedIndex(1)
	end

	self.m_hideLvController:setSelectedIndex(0)
	self.m_qualityLoader:setURL(table.concat({
		"ui://base_new/pic_bljt_zhanchong_pinzhi_",
		var_3_3 + 1
	}))

	if g.core.common.Goods.TYPE_KNIGHT == arg_3_1 then
		self.m_qualityBg:setURL(table.concat({
			"ui://blazingArena/pic_bljt_zhanchong_",
			var_3_3 + 1
		}))
	end

	self._data = {
		type = arg_3_1,
		value = var_3_5,
		struct = arg_3_2
	}
end

function BlazingArenaEmbryoIcon:showDetailPop()
	if not self._data.value or not self._data.type then
		return
	end

	self._data.component = self

	if self._data.type == g.core.common.Goods.TYPE_UNITETOKEN and not self._data.tokenData then
		if self._data.struct then
			self._data.tokenData = self._data.struct
		else
			local var_4_0 = require("app.view.module.uniteToken.model.UniteTokenStructData").new(self._data.value)

			var_4_0:updateByNetData({
				id = var_4_0:getAdvanceId(),
				level = self._data.level
			})

			self._data.value = var_4_0:getAdvanceId()
			self._data.tokenData = var_4_0
		end
	elseif self._data.type == g.core.common.Goods.TYPE_PET and not self._data.tokenData then
		if self._data.struct then
			self._data.petData = self._data.struct
		else
			local var_4_1 = require("app.view.module.pet.model.PetStruct").new(g.core.config.pet_info.get(self._data.value).advance_id)

			var_4_1:setServerData({
				base_id = self._data.value,
				level = self._data.level,
				stage = self._data.advanceStage
			})

			self._data.petData = var_4_1
		end
	end

	g.core.common.GlobalFunc.pushInfoPop(self._data)
end

function BlazingArenaEmbryoIcon:setLevel(arg_5_1)
	if arg_5_1 and arg_5_1 > 0 then
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = arg_5_1
		}))
		self.m_hideLvController:setSelectedIndex(0)
	else
		self.m_hideLvController:setSelectedIndex(1)
	end

	self._data.level = arg_5_1
end

return BlazingArenaEmbryoIcon
