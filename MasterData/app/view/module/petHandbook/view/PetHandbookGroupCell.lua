local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.PetHandBookConst
local PetHandbookGroupCell = class("PetHandbookGroupCell", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupCell"))

function PetHandbookGroupCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)

	self._groupStruct = nil
	self._upgradeType = var_0_2.GROUP_UPGRADE_TYPE.UPGRADE
	self._downEff = nil
	self._upEff = nil

	self.m_upgradeBtn:addClickListener(handler(self, self._onClickUpgradeBtn))
end

function PetHandbookGroupCell:updateGroupCell(arg_2_1)
	self._groupStruct = arg_2_1

	self.m_picComp:updatePicComp(arg_2_1)

	self._upgradeType = arg_2_1:getUpgradeType()

	self.m_groupName:setText(arg_2_1:getName())
	self.m_upgradeTypeController:setSelectedIndex(self._upgradeType)
	self.m_qualityIcon:setURL(var_0_1:getPetHandbookQualityFrame(arg_2_1:getQuality()))
	self.m_qualityEnglish:setURL("ui://base_new/pic_yzs_" .. arg_2_1:getQuality() + 1 .. "_tujian_zs3")

	if self._upgradeType == var_0_2.GROUP_UPGRADE_TYPE.MAX_LEVEL then
		-- block empty
	elseif self._upgradeType == var_0_2.GROUP_UPGRADE_TYPE.UPGRADE then
		self.m_upgradeBtn:setTitle(g.core.lang:get(428004))
		self.m_tipTxt:setText(g.core.lang:get(428001, {
			star = arg_2_1:getNeedStar()
		}))
		self.m_canUpgradeController:setSelectedIndex(arg_2_1:isGroupCanUpgrade() and 1 or 0)
	else
		self.m_upgradeBtn:setTitle(g.core.lang:get(428003))
		self.m_tipTxt:setText(g.core.lang:get(428002))
		self.m_canUpgradeController:setSelectedIndex(arg_2_1:isGroupCanActivate() and 1 or 0)
	end

	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = arg_2_1:getLevel()
	}))
	self.m_attrComp:updateAttrComp(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			groupStruct = self._groupStruct
		}
	})
end

function PetHandbookGroupCell:_onClickUpgradeBtn()
	local var_3_0 = self._groupStruct:getBaseId()

	if self._upgradeType == var_0_2.GROUP_UPGRADE_TYPE.ACTIVATE then
		g.core.network.GameNetProxy:send_C2S_Pet_UR_HandbookActive({
			id = var_3_0
		})
	elseif self._upgradeType == var_0_2.GROUP_UPGRADE_TYPE.UPGRADE then
		g.core.network.GameNetProxy:send_C2S_Pet_UR_HandbookUpgrade({
			id = var_3_0
		})
	end
end

return PetHandbookGroupCell
