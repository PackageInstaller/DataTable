local var_0_0 = g.core.model.User.bioData
local var_0_1 = g.core.lang
local BioConst = require("app.view.module.biography.const.BioConst")
local BioTeamMainElem = import("...model.BioTeamMainElem")
local BioTeamSubElem = import("...model.BioTeamSubElem")
local BioTeamMainEmptyElem = import("...model.BioTeamMainEmptyElem")
local BioTeamJoinPop = class("BioTeamJoinPop", require("app.fairyGUI.biography.UI_BioTeamJoinPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/biography/biography",
		resName = "BioTeamJoinPop",
		pkgName = "biography"
	}, ...)
end)

function BioTeamJoinPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curTabIndex = 0

	if arg_2_1 then
		self._curCampaignId = arg_2_1.campaignId or nil
	end

	self._curTeamData = {}
	self._selTab = 1

	self.m_refreshBtn:addClickListener(handler(self, self._onClickRefreshTeam))
	self.m_teamList:setVirtual()
	self.m_teamList:setItemRenderer(handler(self, self._onTeamListRender))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabSelected))
	self:initTreeComp()
end

function BioTeamJoinPop:initTreeComp()
	local var_3_0 = {
		g.core.lang:get(302100)
	}

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		table.insert(var_3_0, g.core.lang:get(302101))
	end

	if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		table.insert(var_3_0, g.core.lang:get(302107))
	end

	if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		table.insert(var_3_0, g.core.lang:get(302108))
	end

	self.m_treeComp:pushMainElem(BioTeamMainEmptyElem.new(""))

	local var_3_1 = 0
	local var_3_2 = -1
	local var_3_3 = -1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		var_3_1 = var_3_1 + 1

		local var_3_4 = var_0_0:getOpenLands(true, iter_3_0)

		self.m_treeComp:pushMainElem(BioTeamMainElem.new(iter_3_1))
		self.m_treeComp:addMainIndex(var_3_1, iter_3_0)

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			var_3_1 = var_3_1 + 1

			self.m_treeComp:pushSubElem(BioTeamSubElem.new(iter_3_3))

			if self._curCampaignId and self._curCampaignId == iter_3_3.id then
				var_3_2 = iter_3_0
				var_3_3 = iter_3_0 ~= 1 and iter_3_0 + iter_3_2 or var_3_1
			end
		end
	end

	self.m_commonDesc:setText(var_0_1:get(302047))
	self.m_emptyTypeController:setSelectedIndex(1)

	if var_3_2 == -1 then
		self.m_treeComp:setSelectTreeIndex(1)
		self.m_treeComp:setSelectTreeIndex(2)
	else
		self.m_treeComp:setSelectTreeIndex(var_3_2)
		self.m_treeComp:setSelectTreeIndex(var_3_3)
	end
end

function BioTeamJoinPop:onTreeSelectChange(arg_4_1)
	if arg_4_1 and arg_4_1.getCfgId then
		self._curCampaignId = arg_4_1:getCfgId()

		self:_requestData()
	end
end

function BioTeamJoinPop:_requestData()
	if self._curCampaignId then
		g.core.network.GameNetProxy:send_C2S_Biography_GetTeamList({
			id = self._curCampaignId
		})
	end
end

function BioTeamJoinPop:onLoad()
	self:_requestData()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETTEAMLIST, self._updateTeamList, self)
	self.m_treeComp:startUp(self)
	self.m_treeComp:refreshUI()
end

function BioTeamJoinPop:_updateTabList()
	if self._openBioLands then
		self.m_tabList:setNumItems(#self._openBioLands)
	end
end

function BioTeamJoinPop:_onTabSelected(arg_8_1)
	local var_8_0 = arg_8_1:getDataValue()

	self._curTabIndex = var_8_0
	self._curCampaignId = self._openBioLands[var_8_0 + 1].id

	self:_requestData()
end

function BioTeamJoinPop:_updateTeamList()
	self._curTeamData = var_0_0:getCurChooseTeamList(self._curCampaignId)

	self.m_teamList:setNumItems(#self._curTeamData)
	self.m_emptyTypeController:setSelectedIndex(#self._curTeamData > 0 and 0 or 1)
end

function BioTeamJoinPop:_onTeamListRender(arg_10_1, arg_10_2)
	arg_10_2:update(self._curTeamData[arg_10_1 + 1])
end

function BioTeamJoinPop:_onTabListRender(arg_11_1, arg_11_2)
	arg_11_2:setTitle(self._openBioLands[arg_11_1 + 1].id and var_0_0:getCampaign(self._openBioLands[arg_11_1 + 1].id).name or var_0_1:get(302046))
end

function BioTeamJoinPop:_onClickRefreshTeam()
	g.core.network.GameNetProxy:send_C2S_Biography_GetTeamList({
		id = self._curCampaignId
	})
end

function BioTeamJoinPop:_sortOpenLands(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if iter_13_1.id == self._curCampaignId then
			local var_13_0 = clone(iter_13_1)

			table.remove(arg_13_1, iter_13_0)
			table.insert(arg_13_1, 1, var_13_0)

			break
		end
	end
end

return BioTeamJoinPop
