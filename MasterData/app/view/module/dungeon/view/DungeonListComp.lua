local DungeonListComp = class("DungeonListComp", require("app.fairyGUI.dungeon.UI_DungeonListComp"))
local var_0_1 = g.core.model.User.dungeonData
local var_0_2 = g.core.config.dungeon_land_info
local var_0_3 = g.core.module.ModuleManager

function DungeonListComp:ctor()
	self._listData = nil
	self._preIndex = 1
	self._showLandId = 0

	self:_initListener()
end

function DungeonListComp:_initListener()
	self.m_landList:setVirtual()
	self.m_landList:setItemRenderer(handler(self, self._onRenderItem))
	self.m_landList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_hidePerfectBtn:addClickListener(handler(self, self._onClickHidePerfectBtn))
end

function DungeonListComp:updateListComp(arg_3_1)
	self._showLandId = arg_3_1.landId or 1
	self._listData = var_0_1:getDungeonLandListData()

	self.m_landList:setNumItems(#self._listData)
	self.m_hidePerfectBtn:setSelected((var_0_1:getHidePerfectLand()))
end

function DungeonListComp:_onRenderItem(arg_4_1, arg_4_2)
	if self._listData then
		arg_4_2:updateLandCell({
			landIndex = self._listData[arg_4_1 + 1]
		})

		local var_4_0 = var_0_2.indexOf(self._listData[arg_4_1 + 1])

		if var_4_0 and var_4_0.id == self._showLandId then
			arg_4_2:setCtrlState("button", {
				index = 1
			})
		else
			arg_4_2:setCtrlState("button", {
				index = 0
			})
		end
	end
end

function DungeonListComp:_onClickItem(arg_5_1)
	local var_5_0 = arg_5_1 and arg_5_1:getDataValue() or 1
	local var_5_1 = var_5_0 + 1
	local var_5_2 = var_0_2.indexOf(self._listData[var_5_0 + 1])

	if var_0_1:getMaxEnterLand() < var_5_2.id then
		local var_5_3 = var_0_2.get((var_0_1:getPreLandId(var_5_2.id)))

		self.m_landList:setSelectedIndex(self._preIndex - 1)
		var_0_3:tip(g.core.lang:get(300006, {
			name = var_5_3.id .. "-" .. var_5_3.name
		}))
	elseif var_5_2.id == self._showLandId then
		var_0_3:tip(g.core.lang:get(300030))

		return
	else
		self._preIndex = var_5_1

		self:dispatchCompEvent("DungeonListComp_select", {
			landInfo = var_5_2
		})
	end
end

function DungeonListComp:_onClickHidePerfectBtn(arg_6_1)
	if arg_6_1:getSender():isSelected() then
		var_0_1:setHidePerfectLand(true)
	else
		var_0_1:setHidePerfectLand(false)
	end

	self._listData = var_0_1:getDungeonLandListData()

	self.m_landList:setNumItems(#self._listData)
end

return DungeonListComp
