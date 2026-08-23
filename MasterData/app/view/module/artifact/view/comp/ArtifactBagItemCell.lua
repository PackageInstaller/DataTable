local var_0_1 = g.core.common.Path
local var_0_2 = {
	NOT_WEAR = 1,
	WEARING = 0,
	NOT_OWN = 3,
	CAN_COMPOSE = 2
}
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactBagItemCell = class("ArtifactBagItemCell", require("app.fairyGUI.artifact.UI_ArtifactBagItemCell"))

function ArtifactBagItemCell:ctor()
	self._state = nil
	self._baseInfo = nil
	self.m_relatedKnightIcon = self.m_relatedComp:getChild("maskKnightIcon")

	self:addClickListener(handler(self, self._onClick))
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
end

function ArtifactBagItemCell:onLoad()
	if self._data and next(self._data) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				advId = self._data:getAdvanceId(),
				serverId = self._data:getServerOnlyId()
			}
		})
	end
end

function ArtifactBagItemCell:updateItem(arg_3_1)
	if arg_3_1 then
		self._data = arg_3_1

		self:_updateContent()
		self:_updateRedPoint()
	end
end

function ArtifactBagItemCell:_updateContent()
	local var_4_0 = self._data:isLineup()

	self._state = var_0_2.NOT_OWN

	if var_4_0 then
		self._state = var_0_2.WEARING
	elseif self._data:isOwn() then
		self._state = var_0_2.NOT_WEAR
	elseif self._data:canCompose() then
		self._state = var_0_2.CAN_COMPOSE
	end

	if self._data:canStarUp() then
		self.m_stateController:setSelectedIndex(4)
	else
		self.m_stateController:setSelectedIndex(self._state)
	end

	if var_4_0 then
		if self.m_smallKnightIcon then
			self.m_smallKnightIcon:setVisible(true)
		end
	elseif self.m_smallKnightIcon then
		self.m_smallKnightIcon:setVisible(false)
	end

	local var_4_1 = self._data:getCfg()

	self._baseInfo = var_4_1

	self.m_bgIcon:setURL((var_0_1:getBigQualityBgByQuality(self._data:getQuality())))
	self.m_nameText:setText(self._data:getArtifactName())

	if self.m_groupBgComp then
		self.m_groupBgComp:getChild("groupBgIcon"):setURL((var_0_1:getArtifactGroupIcon2((self._data:getBelongToGroup()))))
	end

	self.m_icon:setURL(var_0_1:getArtifactImg(var_4_1.res_id))
	self.m_relatedKnightIcon:updateBelongToIcon((self._data:getBelongToKnightAvdIdIncludingMainRole()))

	if self._state == var_0_2.WEARING and self.m_smallKnightIcon then
		self.m_smallKnightIcon:setIcon((self._data:getWearKnightIconUrl()))
	end

	if self._state == var_0_2.WEARING or self._state == var_0_2.NOT_WEAR then
		self.m_levelTxt:setText((self._data:getLevel()))
		self.m_starComp:initStar({
			gap = -5,
			style = 2,
			index = 3,
			max = self._data:getMaxStar(),
			num = self._data:getStar()
		})
	else
		local var_4_2, var_4_3, var_4_4 = self._data:canCompose()

		self.m_curTxt:setText(var_4_4)
		self.m_needTxt:setText("/" .. var_4_3)
	end

	if self._data:isHasWeaponSpirit() and self._data:getSpiritStage() > 0 then
		self.m_spiritComp:updateCurWeapon(self._data)
		self.m_urStageAddController:setSelectedIndex(1)
	else
		self.m_urStageAddController:setSelectedIndex(0)
	end
end

function ArtifactBagItemCell:_updateRedPoint()
	if self._data and self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				advId = self._data:getAdvanceId(),
				serverId = self._data:getServerOnlyId()
			}
		})
	end
end

function ArtifactBagItemCell:_onClick()
	if self._state == var_0_2.WEARING or self._state == var_0_2.NOT_WEAR then
		if self._data:canStarUp() then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_DEVELOP, {
					tabType = 3,
					artifact = self._data
				})
			end
		elseif self._data:isLineup() then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_LINE_UP, {
					tabType = 2,
					knightIndex = self._data:getFormationPos()
				})
			end
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_DEVELOP, {
				artifact = self._data
			})
		end
	elseif self._state == var_0_2.CAN_COMPOSE then
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = self._baseInfo.fragment_id
		})
	else
		local var_6_0 = require("app.view.module.artifact.view.ArtifactInfoPop").new
		local var_6_1 = {}

		var_6_1.baseId = self._data:getArtifactBaseId()

		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifact.view.ArtifactInfoPop").new(var_6_1), {
			touchDisappear = true
		})
	end
end

function ArtifactBagItemCell:setRebornState()
	if self.m_redPointComp then
		self.m_redPointComp:setVisible(false)
	end

	self:setTouchable(false)
end

return ArtifactBagItemCell
