local ArtifactSpiritStageUpPop = class("ArtifactSpiritStageUpPop", require("app.fairyGUI.artifact.UI_ArtifactSpiritStageUpPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactSpiritStageUpPop",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactSpiritStageUpPop:ctor(arg_2_1)
	self:showAtCenter()

	self._closing = false
	self._struct = arg_2_1.artifact

	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self:updateView()
	self.m_closePnl:addClickListener(handler(self, self._onClickClose))
	self.m_enter_0Transition:play()
end

function ArtifactSpiritStageUpPop:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateInfoAttr(self._stageUpAttrs[arg_3_1 + 1].name, self._stageUpAttrs[arg_3_1 + 1].attr1, self._stageUpAttrs[arg_3_1 + 1].attr2)
end

function ArtifactSpiritStageUpPop:updateView()
	self._curCfg = self._struct:getSpiritStageCfg()

	local var_4_0 = g.core.config.artifact_info.get(self._struct:getAdvanceId())
	local var_4_1 = self._struct:getSpiritLvUpStageAttrs()

	self._stageUpAttrs = var_4_1

	self.m_oldStageTxt:setText(self._struct:getSpiritStage() - 1)
	self.m_stageTxt:setText(self._struct:getSpiritStage())
	self.m_attrList:setNumItems(#var_4_1)
	self.m_imgLoader:setURL(g.core.common.Path:getArtifactPic(var_4_0.res_id))
	self.m_nameComp:setData({
		name = var_4_0.name,
		quality = var_4_0.quality
	}, "artifact")
	self.m_skillIcon:updateSpiritSkillIcon({
		artifact = self._struct
	})

	local var_4_2 = self._struct:getSpiritAdjointSkill()

	if var_4_2 > 0 then
		local var_4_3 = g.core.config.passive_skill_info.get(var_4_2)
		local var_4_4, var_4_5 = g.core.utils.String.formatSkillEnchantInfoDesc(var_4_3.passive_skill_value, var_4_3.passive_skill_type)

		self.m_descTxt1:enableRich()
		self.m_descTxt1:setText(var_4_4)
		self.m_skillNameTxt:setText(var_4_3.name)
		self.m_skill1:setVisible(true)

		local var_4_6, var_4_7 = self._struct:isLastSpiritStageSkillChange()

		if var_4_6 then
			self.m_skillUpdateDescTxt:setText(g.core.lang:get(205563, {
				name = var_4_3.name
			}))
			self.m_skill1:setVisible(true)
		elseif var_4_7 then
			self.m_skillUpdateDescTxt:setText(g.core.lang:get(205564, {
				name = var_4_3.name
			}))
			self.m_skill1:setVisible(true)
		else
			self.m_skillUpdateDescTxt:setText("")
			self.m_skill1:setVisible(false)
		end
	else
		self.m_skill1:setVisible(false)
	end
end

function ArtifactSpiritStageUpPop:_onClickClose()
	if self._closing then
		return
	end

	self._closing = true

	self.m_back_0Transition:play(handler(self, self._onExitPlayFinish))
end

function ArtifactSpiritStageUpPop:_onExitPlayFinish()
	self:removeSelf()
end

function ArtifactSpiritStageUpPop:onUnload()
	return
end

return ArtifactSpiritStageUpPop
