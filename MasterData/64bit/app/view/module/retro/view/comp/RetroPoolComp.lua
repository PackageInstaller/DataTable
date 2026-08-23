local var_0_0 = g.core.model.User.retroData
local RetroPoolComp = class("RetroPoolComp", require("app.fairyGUI.retro.UI_RetroPoolComp"))

function RetroPoolComp:ctor()
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
end

function RetroPoolComp:updatePoolComp()
	self.m_descTxt:setText(g.core.lang:get(430303))

	local var_2_0 = var_0_0:getSvrRandBoxData()

	for iter_2_0 = 1, #var_2_0 do
		self["m_award" .. iter_2_0]:updateAwardInfo(var_2_0[iter_2_0], iter_2_0)
	end
end

function RetroPoolComp:openBoxAwardEffect(arg_3_1)
	if self["m_award" .. arg_3_1 + 1] then
		self["m_award" .. arg_3_1 + 1]:openAwardEff()
	end
end

function RetroPoolComp:playRefreshEffect()
	self.m_enterTransition:play()
end

function RetroPoolComp:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.retro.view.RetroActivityPreviewPop").new()))
end

return RetroPoolComp
