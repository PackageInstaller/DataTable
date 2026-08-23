local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local DebugSwitchComp = class("DebugSwitchComp", require("app.fairyGUI.debug.UI_DebugSwitchComp"))

function DebugSwitchComp:ctor()
	self:_changeConfig()
	self:_initBtn()

	self._lang = {
		"cn",
		"en",
		"jp",
		"id",
		"th",
		"tw",
		"fr",
		"es",
		"de",
		"pt",
		"ru",
		"kr"
	}

	local var_1_0 = 0
	local var_1_1 = MultilingualMgr:getUseLang()

	for iter_1_0 = 1, #self._lang do
		if var_1_1 == self._lang[iter_1_0] then
			var_1_0 = iter_1_0 - 1
		end
	end

	self.m_selectLangController:setSelectedIndex(var_1_0)

	self._text = "\t吕蒙，字子明，汝南富陂人，江东名将，东吴的第三任大都督。吕蒙&<12>为人机警，深谙兵法，做事不择手段，是一个功利心极强的人&。\n\t他在赤壁之战时期与关羽相识，关羽对自己的轻蔑使高傲的吕蒙怀恨良久，他立志要除掉关羽，为江东夺回荆州。\n\t吕蒙出身低微，年少从军，作战凶狠拼命，只为赚一份功名。这份狠劲终于为吕蒙搏来了孙策的赏识。孙权领江东后，重新整顿军务，吕蒙又削尖了脑袋展示自己，才得以保住军权。而后的江东大战中吕蒙都先登在前，赢得了周瑜鲁肃的重视，一步一步向东吴的大都督位置迈进。孙权曾告诫吕蒙读书，吕蒙便手不释卷，迅速成长，有了吴下阿蒙的典故。\n\t周瑜鲁肃相继离世后，吕蒙终于如愿以偿，做到了东吴大都督的位置，而此时紧张的吴蜀关系，也让这位蓄势待发的大都督有了挑战关羽的机会......"
	self._text2 = "\t吕蒙，字子明，汝南富陂人，江东名将，东吴的第三任大都督。吕蒙[c1]为人机警，深谙兵法，做事不择手段，是一个功利心极强的人[/]。\n\t他在赤壁之战时期与关羽相识，关羽对自己的轻蔑使高傲的吕蒙怀恨良久，他立志要除掉关羽，为江东夺回荆州。\n\t吕蒙出身低微，年少从军，作战凶狠拼命，只为赚一份功名。这份狠劲终于为吕蒙搏来了孙策的赏识。孙权领江东后，重新整顿军务，吕蒙又削尖了脑袋展示自己，才得以保住军权。而后的江东大战中吕蒙都先登在前，赢得了周瑜鲁肃的重视，一步一步向东吴的大都督位置迈进。孙权曾告诫吕蒙读书，吕蒙便手不释卷，迅速成长，有了吴下阿蒙的典故。\n\t周瑜鲁肃相继离世后，吕蒙终于如愿以偿，做到了东吴大都督的位置，而此时紧张的吴蜀关系，也让这位蓄势待发的大都督有了挑战关羽的机会......"
	self._text3 = "吕蒙，汝南富陂人，[color=#c33030]为人机警，深谙兵法[/color]。"

	self.m_descTxt:enableRich()
	self.m_descTxt:setText("教国伤害[color=#24bd81]+0%（+15%）[/color]", true)
	self.m_testList:setVirtual()
	self.m_testList:setItemRenderer(function(arg_2_0, arg_2_1)
		return
	end)
	self.m_testList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickDebugListItem))
	self.m_testList:setNumItems(15)
end

function DebugSwitchComp:onClickDebugListItem()
	self.m_testList:setNumItems(15)
end

function DebugSwitchComp:_changeConfig()
	return
end

function DebugSwitchComp:_initBtn()
	self.m_languageTextBtn:addClickListener(handler(self, self._onLanguageTestBtnClick))
	self.m_testBtn:addClickListener(handler(self, self._onTestBtnClick))
	self.m_testRichBtn:addClickListener(handler(self, self._onTestRichBtnClick))
	self.m_selectLangController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onLangChanged))
end

function DebugSwitchComp:_onLangChanged()
	MultilingualMgr:setUseLang(self._lang[self.m_selectLangController:getSelectedIndex() + 1])
end

function DebugSwitchComp:_onTestBtnClick()
	self.m_testRichLabel:setText(self._text, true)
end

function DebugSwitchComp:_onTestRichBtnClick()
	self.m_testLabel2:enableRich()
	self.m_testLabel2:setText(self._text, true)
end

function DebugSwitchComp:_onLanguageTestBtnClick()
	self.m_testLable3:enableRich()
	self.m_testLable3:setText(self._text3)
end

return DebugSwitchComp
