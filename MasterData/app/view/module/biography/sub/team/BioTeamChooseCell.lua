local var_0_0 = g.core.model.User.bioData
local BioTeamChooseCell = class("BioTeamChooseCell", require("app.fairyGUI.biography.UI_BioTeamChooseCell"))

function BioTeamChooseCell:ctor(arg_1_1)
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)

	self._info = nil
	self._awardData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListRenderer))
	self:addClickListener(handler(self, self._onClickSelf))
end

function BioTeamChooseCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	self._itemIndex = arg_2_2

	local var_2_0 = var_0_0:getCampaign(arg_2_1.id)

	self._info = var_2_0
	self._id = arg_2_1.id
	self._awardData = var_0_0:getBioTeamRandomAwardDataById(arg_2_1.id) or {}

	self.m_name:setText(var_2_0.name)
	self.m_icon:setURL("pic/bioTeam/" .. var_2_0.res .. ".png")

	local var_2_1, var_2_2 = var_0_0:isCampainOpen(self._id)

	self.m_openSateController:setSelectedIndex(var_2_1 and 0 or 1)

	if not var_2_1 then
		self.m_unOpenText:setText(var_2_2 or "")
		self.m_shadowIcon:setURL("pic/bioTeam/pic_jjxd_photo" .. tonumber(var_2_0.res) + 10 .. ".png")
	end

	self._isOpen = var_2_1
	self._unOpenDesc = var_2_2

	self.m_recommendValue:setText(g.core.utils.Number.transFightValue(var_2_0.fight_power))
	self.m_awardList:setNumItems(#self._awardData)

	if self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				id = self._id
			}
		})
	end

	self.m_isHardController:setSelectedIndex(arg_2_3)
end

function BioTeamChooseCell:_onListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._awardData[arg_3_1 + 1])
end

function BioTeamChooseCell:_onClickSelf(arg_4_1)
	if not self._isOpen then
		if self._unOpenDesc and self._unOpenDesc ~= "" then
			g.core.module.ModuleManager:tip(self._unOpenDesc)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(302052))
		end

		return
	end

	var_0_0:setBioTeamCampaignNewSettingRecord(self._id)
	g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM__CAMPAIGN_INFO, {
		cid = self._id
	})
end

return BioTeamChooseCell
