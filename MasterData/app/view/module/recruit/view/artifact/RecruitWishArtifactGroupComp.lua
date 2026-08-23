local RecruitWishArtifactGroupComp = class("RecruitWishArtifactGroupComp", require("app.fairyGUI.recruitArtifact.UI_RecruitWishArtifactGroupComp"))

function RecruitWishArtifactGroupComp:ctor()
	self._upList = {}

	self:_addListeners()
	self.m_arrowNode:addEffectSpine({
		anim = "play2",
		name = "eff_ui_recruitPrimary_qianwang",
		isLoop = true
	})
	self.m_ratioText:setText(g.core.lang:get(108424, {
		num = math.floor(g.core.config.parameter_info.get(15027).parameter / 100)
	}))
end

function RecruitWishArtifactGroupComp:_addListeners()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onWishItemRender))
	self:addClickListener(handler(self, self._onClickHideBtn))
end

function RecruitWishArtifactGroupComp:updateComp(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1:getUpValue(true) > 0 and g.core.config.artifact_info.get(iter_3_1:getId()).gm_open ~= 1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	self._upList = var_3_0

	self.m_list:setNumItems(#var_3_0)
	self.m_list:resizeToFit(#var_3_0)

	if #var_3_0 > 1 then
		self.m_isMultController:setSelectedIndex(1)
	else
		self.m_isMultController:setSelectedIndex(0)
	end
end

function RecruitWishArtifactGroupComp:_onWishItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._upList[arg_4_1 + 1], arg_4_1)
end

function RecruitWishArtifactGroupComp:_sort(arg_5_1, arg_5_2)
	return arg_5_1:getUpValue() > arg_5_2:getUpValue()
end

function RecruitWishArtifactGroupComp:getUpListNum()
	return #self._upList
end

function RecruitWishArtifactGroupComp:playShow()
	self.m_enterTransition:play()
end

function RecruitWishArtifactGroupComp:playHide(arg_8_1)
	self.m_backTransition:play(arg_8_1)
end

function RecruitWishArtifactGroupComp:setHideFunc(arg_9_1)
	self._hideFunc = arg_9_1
end

function RecruitWishArtifactGroupComp:_onClickHideBtn()
	if self._hideFunc then
		self._hideFunc()
	end
end

return RecruitWishArtifactGroupComp
