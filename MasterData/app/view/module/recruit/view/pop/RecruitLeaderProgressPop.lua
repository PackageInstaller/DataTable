local RecruitLeaderProgressPop = class("RecruitLeaderProgressPop", require("app.fairyGUI.recruitKnight.UI_RecruitLeaderProgressPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitLeaderProgressPop",
		pkgPath = "ui/recruitKnight/recruitKnight",
		pkgName = "recruitKnight"
	})
end)
local var_0_1 = g.core.model.User.recruitData

function RecruitLeaderProgressPop:ctor(arg_2_1)
	self:showAtCenter()

	self._actId = arg_2_1.actId
	self._awardList = {}

	self.m_welfareList:setVirtual()
	self.m_welfareList:setItemRenderer(handler(self, self._renderCell))
	self:_updateData()
end

function RecruitLeaderProgressPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_PROGRESSAWARD, handler(self, self._onProgressAwardResult), self)
end

function RecruitLeaderProgressPop:_updateData()
	local var_4_0 = var_0_1:getDrawInfo(self._actId, nil, true)

	if not var_4_0 then
		return
	end

	self.m_curTimesTxt:setText(g.core.model.User.recruitData:getThreeThemeTicketNum())

	self._awardList = var_4_0:getLeaderProgressAwardList()

	self.m_welfareList:setNumItems(#self._awardList)
end

function RecruitLeaderProgressPop:_renderCell(arg_5_1, arg_5_2)
	if not self._awardList[arg_5_1 + 1] then
		return
	end

	arg_5_2:updateItem(self._awardList[arg_5_1 + 1], self._actId)
end

function RecruitLeaderProgressPop:_onProgressAwardResult(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.recruit_id ~= self._actId then
		return
	end

	if arg_6_4.awards and #arg_6_4.awards > 0 then
		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	end

	self:_updateData()
end

return RecruitLeaderProgressPop
