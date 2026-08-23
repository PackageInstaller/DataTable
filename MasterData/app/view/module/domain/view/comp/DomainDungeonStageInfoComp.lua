local var_0_0 = g.core.const.ConstMgr.DomainConst
local var_0_1 = g.core.model.User.domainData
local DomainDungeonStageInfoComp = class("DomainDungeonStageInfoComp", require("app.fairyGUI.domainDungeon.UI_DomainDungeonStageInfoComp"))

function DomainDungeonStageInfoComp:ctor()
	self.m_firstAwardList:setVirtual()
	self.m_firstAwardList:setItemRenderer(handler(self, self._onFirstItemRender))
	self.m_gradeList:setVirtual()
	self.m_gradeList:setItemRenderer(handler(self, self._onGradeItemRender))
end

function DomainDungeonStageInfoComp:updateInfoComp(arg_2_1, arg_2_2)
	self._curStage, self._curGrade = arg_2_1:getCurStageAndGrade()
	self._stageInfo = arg_2_2:getStageInfo()

	if self._stageInfo.stage < self._curStage then
		self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. var_0_0.GRADE.S)
	elseif self._curStage == self._stageInfo.stage or self._curGrade > 0 then
		self.m_gradeLoader:setURL("ui://domainDungeon/pic_mnly_" .. self._curGrade)
	else
		self.m_gradeLoader:setURL("")
	end

	self.m_title:setText(g.core.utils.Number.getFormatNum(2, self._stageInfo.stage))
	self.m_descTxt:setText(self._stageInfo.description)

	self._firstAwards = arg_2_2:getFirstReward()

	self.m_firstAwardList:setNumItems(#self._firstAwards)

	self._gradeList = arg_2_2:getStageGradeInfo()

	self.m_gradeList:setNumItems(#self._gradeList)
	self.m_bgLoader:setURL(var_0_1:getDungeonResource(arg_2_1:getId(), "pic_mnly_cebiandi.png"))
	self.m_firstTips:setIcon(var_0_1:getDungeonResource(arg_2_1:getId(), "pic_mnly_biaotidi.png"))
	self.m_gradeTips:setIcon(var_0_1:getDungeonResource(arg_2_1:getId(), "pic_mnly_biaotidi.png"))
	self.m_titleBg:setURL(var_0_1:getDungeonResource(arg_2_1:getId(), "pic_mnly_tittledi.png"))
	self.m_infoBg:setURL(var_0_1:getDungeonResource(arg_2_1:getId(), "pic_mnly_xinxidi.png"))
end

function DomainDungeonStageInfoComp:_onFirstItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateFirstCell(self._firstAwards[arg_3_1 + 1], self._stageInfo.stage < self._curStage or self._curGrade > 0)
end

function DomainDungeonStageInfoComp:_onGradeItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateGradeCell(self._gradeList[arg_4_1 + 1])
end

return DomainDungeonStageInfoComp
