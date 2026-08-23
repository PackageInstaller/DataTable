local ArtifactDevConfig = require("app.view.module.artifact.const.ArtifactDevConfig")
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_2 = {
	[ArtifactConst.DEV_TYPE.ENHANCE] = 245,
	[ArtifactConst.DEV_TYPE.STAR_UP] = 246,
	[ArtifactConst.DEV_TYPE.WEAPON_SPIRIT] = 821
}
local ArtifactRightComp = class("ArtifactRightComp", require("app.fairyGUI.artifact.UI_ArtifactRightComp"), function()
	return fgui.GComponent:create({
		resName = "ArtifactRightComp",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	})
end)

function ArtifactRightComp:ctor()
	self.m_bgLoader:setURL("pic/base_new/bg_yht_rightdi.png")
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClicked))
	self.m_unloadBtn:addClickListener(handler(self, self._onUnLoadArtifactClick))
	self.m_changeBtn:addClickListener(handler(self, self._onChangeArtifactClick))

	self._tabNums = #ArtifactDevConfig.DEV_LIST
end

function ArtifactRightComp:initData(arg_3_1)
	self._childComp = {}
	self._config = ArtifactDevConfig.DEV_LIST or {}
	self._preSelectIndex = nil
	self._viewData = nil
	self._selectIndex = arg_3_1 or 1

	self.m_tabList:setSelectedIndex(self._selectIndex - 1)

	if not self._tabBtn then
		self._redPoints = {}
		self._tabBtn = self.m_tabList:getChildren()

		for iter_3_0, iter_3_1 in ipairs(self._tabBtn) do
			table.insert(self._redPoints, iter_3_1:getChild("redPointComp"))

			if var_0_2[iter_3_0] then
				self._redPoints[iter_3_0]:setId(var_0_2[iter_3_0])
			end
		end
	end
end

function ArtifactRightComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._onRecItemTransform), self)
end

function ArtifactRightComp:updateDevPanel(arg_5_1)
	if not arg_5_1 or not arg_5_1.data then
		return
	end

	self._objData = arg_5_1.data
	self._selectedIndex = arg_5_1.initTabType or 1
	self._knightPos = arg_5_1.pos
	self._isLineUpModel = arg_5_1.isLineUpModel

	self.m_isLineUpModelController:setSelectedIndex(self._isLineUpModel and 1 or 0)

	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._tabBtn) do
		if self._config[iter_5_0] then
			local var_5_1 = self._config[iter_5_0].show(self._objData:getAdvanceId())

			iter_5_1:setVisible(var_5_1)

			if var_5_1 then
				var_5_0 = var_5_0 + 1
			elseif self._childComp[iter_5_0] then
				self._childComp[iter_5_0]:setVisible(false)
			end
		end
	end

	self:_updateRedPoint()

	if var_5_0 < self._selectIndex then
		self._selectIndex = 1

		self.m_tabList:setSelectedIndex(self._selectIndex - 1)
	end

	self._tabNums = var_5_0

	self:_updatePanel(arg_5_1.noAnimation)
end

function ArtifactRightComp:_updateRedPoint()
	for iter_6_0, iter_6_1 in pairs(var_0_2) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._redPoints[iter_6_0],
			customData = {
				pos = self._knightPos,
				advId = self._objData:getAdvanceId()
			}
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeBtn,
		customData = {
			pos = self._knightPos,
			advId = self._objData:getAdvanceId()
		}
	})
end

function ArtifactRightComp:_onTabClicked(arg_7_1)
	local var_7_0 = self.m_tabList:getSelectedIndex() + 1

	if var_7_0 ~= self._selectIndex then
		local var_7_1, var_7_2 = ArtifactDevConfig.DEV_LIST[var_7_0].cond()

		if not var_7_2 then
			g.core.module.ModuleManager:tip(var_7_1)
			self.m_tabList:setSelectedIndex(self._selectIndex - 1)

			return
		end

		self._preSelectIndex = self._selectIndex
		self._selectIndex = var_7_0

		self:_updatePanel()
	end
end

function ArtifactRightComp:_updatePanel(arg_8_1)
	if not self._childComp[self._selectIndex] then
		local var_8_0 = string.split(self._config[self._selectIndex].compNew, "/")
		local var_8_1 = fgui.UIPackage:createObject(var_8_0[1], var_8_0[2])

		self.m_placeHolderComp:addChild(var_8_1)

		self._childComp[self._selectIndex] = var_8_1
	end

	if self._preSelectIndex and self._childComp[self._preSelectIndex] then
		self._childComp[self._preSelectIndex]:setVisible(false)
	end

	self._childComp[self._selectIndex]:setVisible(true)

	local var_8_2 = self._config[self._selectIndex].resInfoId[1]

	if self._isLineUpModel then
		var_8_2 = self._config[self._selectIndex].resInfoId[2]
	end

	if self._config[self._selectIndex].specialResInfo then
		local var_8_3 = g.core.config.artifact_spirit_display_info.get(self._objData:getAdvanceId())

		self:dispatchCompEvent("Event_refresh_top_bar_res", {
			{
				type = var_8_3.itemline_type1,
				value = var_8_3.itemline_value1
			},
			{
				type = var_8_3.itemline_type2,
				value = var_8_3.itemline_value2
			},
			{
				type = var_8_3.itemline_type3,
				value = var_8_3.itemline_value3
			},
			helpId = var_8_3.help_id
		})
	else
		self:dispatchCompEvent("Event_refresh_top_bar", var_8_2)
	end

	self._childComp[self._selectIndex]:updateShow(self._objData, self._knightPos, self._isLineUpModel, arg_8_1)
end

function ArtifactRightComp:_onUnLoadArtifactClick()
	if self._isLineUpModel then
		local var_9_0 = self._objData:getServerOnlyId()

		if var_9_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = 5,
				pos = 0,
				id = var_9_0
			})
		end
	end
end

function ArtifactRightComp:_onChangeArtifactClick()
	self:dispatchCompEvent("event_open_artifact_select_comp")
end

function ArtifactRightComp:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "SWITCH_TAB_TO_SPIRIT" and self._config[ArtifactConst.DEV_TYPE.WEAPON_SPIRIT].show(self._objData:getAdvanceId()) then
		self.m_tabList:setSelectedIndex(ArtifactConst.DEV_TYPE.WEAPON_SPIRIT - 1)
		self:_onTabClicked()
	end
end

function ArtifactRightComp:_onRecItemTransform()
	self:_updateRedPoint()
	self:_updatePanel()
end

function ArtifactRightComp:showStarEffect()
	if self._selectIndex == ArtifactConst.DEV_TYPE.ENHANCE then
		if self._childComp[self._selectIndex] and self._childComp[self._selectIndex].playStarAnimAfterStrength then
			self._childComp[self._selectIndex]:playStarAnimAfterStrength()
		end
	end
end

return ArtifactRightComp
