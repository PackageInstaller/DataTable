local var_0_0 = g.core.common.Path
local var_0_1 = g.core.common.Drops
local var_0_2 = g.core.const.ConstMgr.WushTowerConst
local var_0_3 = g.core.config.dead_tower_parcel_info
local var_0_4 = g.core.config.dead_tower_card_info
local WushTowerMonsterInfoComp = class("WushTowerMonsterInfoComp", require("app.fairyGUI.wushTower.UI_WushTowerMonsterInfoComp"))

function WushTowerMonsterInfoComp:ctor()
	self._awardDatas = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function WushTowerMonsterInfoComp:updateMonsterInfo(arg_2_1)
	self._parcelCfg = var_0_3.get(arg_2_1)

	local var_2_0 = g.core.model.User.wushTowerData:getDisplayVersion()

	self.m_qualityLoader:setURL((var_0_0:getWushTowerMonsterIcon((var_2_0 == 1 or nil) and (self._parcelCfg.quality or self._parcelCfg["quality_" .. var_2_0]), 1)))
	self.m_monsterNameTxt:setText((var_2_0 == 1 or nil) and (self._parcelCfg.name or self._parcelCfg["name_" .. var_2_0]))
	self.m_monsterDescTxt:setText(self._parcelCfg.monster_des)
	self.m_recFightValueTxt:setText((var_2_0 == 1 or nil) and (self._parcelCfg.monster_fight or self._parcelCfg["monster_fight_" .. var_2_0]))

	local var_2_1 = ""

	for iter_2_0 = 1, var_0_2.RECOMMEND_NUM do
		if self._parcelCfg["recommend_" .. iter_2_0] > 0 then
			local var_2_2 = var_0_4.get(self._parcelCfg["recommend_" .. iter_2_0])

			var_2_1 = string.len(var_2_1) > 0 and var_2_1 .. "、" .. var_2_2.name or var_2_2.name
		end
	end

	self.m_recCardTxt:setText(var_2_1)

	self._awardDatas = var_0_1:getGoodsArray(self._parcelCfg.award_id)

	self.m_awardList:setNumItems(#self._awardDatas)
end

function WushTowerMonsterInfoComp:_onAwardItemRender(arg_3_1, arg_3_2)
	if self._awardDatas[arg_3_1 + 1] then
		arg_3_2:updateIcon(self._awardDatas[arg_3_1 + 1])
	end
end

return WushTowerMonsterInfoComp
