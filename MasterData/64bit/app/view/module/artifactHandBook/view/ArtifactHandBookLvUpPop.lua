local ArtifactHandBookLvUpPop = class("ArtifactHandBookLvUpPop", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookLvUpPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/artifactHandbook/artifactHandbook",
		resName = "ArtifactHandBookLvUpPop",
		pkgName = "artifactHandbook"
	}, ...)
end)

function ArtifactHandBookLvUpPop:ctor(arg_2_1)
	self:showAtCenter()

	self._closing = false
	self._params = arg_2_1.param

	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self:updateView()
	self.m_closePnl:addClickListener(handler(self, self._onClickClose))
	self.m_lvUpBtn:addClickListener(handler(self, self._onLvUpClick))
end

function ArtifactHandBookLvUpPop:updateView()
	local var_3_0 = g.core.model.User.artifactHandBookData:getTargetLvCfg(self._params.advId, self._params.lv)

	self._curCfg = var_3_0

	local var_3_1 = g.core.model.User.artifactHandBookData:getTargetLvCfg(self._params.advId, self._params.lv + 1)

	for iter_3_0 = 1, 4 do
		self["m_attr" .. iter_3_0]:setVisible(false)

		if var_3_0["affect_type_" .. iter_3_0] ~= 0 then
			self["m_attr" .. iter_3_0]:updateAttr({
				isAll = true,
				type = var_3_0["affect_type_" .. iter_3_0],
				value = var_3_0["affect_value_" .. iter_3_0],
				value2 = var_3_1["affect_value_" .. iter_3_0]
			})
			self["m_attr" .. iter_3_0]:setVisible(true)
		end
	end

	self.m_starBefore:initStar({
		style = 2,
		index = 4,
		gap = 20,
		max = self._params.struct:getMaxStar(),
		num = self._params.lv - 1
	})
	self.m_starAfter:initStar({
		style = 2,
		index = 4,
		gap = 20,
		max = self._params.struct:getMaxStar(),
		num = self._params.lv
	})

	self._needStar = var_3_1.need
	self._needCost = {
		type = var_3_1.cost_type,
		value = var_3_1.cost_value,
		size = var_3_1.num
	}

	self.m_costComp:updateByTVS(self._needCost)
	self.m_descTxt:setText(g.core.lang:get(205528, {
		num = var_3_1.need
	}))

	local var_3_2 = g.core.config.artifact_info.get(self._params.advId)

	self.m_imgLoader:setURL(g.core.common.Path:getArtifactPic(var_3_0.icon))
	self.m_nameComp:setData({
		name = var_3_2.name,
		quality = var_3_2.quality
	}, "artifactHandbook")
end

function ArtifactHandBookLvUpPop:_onLvUpClick()
	if self._params.struct:getStar() < self._needStar then
		g.core.module.ModuleManager:tip(g.core.lang:get(205528, {
			num = self._needStar
		}))

		return
	end

	if g.core.model.User.bagData:getCountById(self._needCost.type, self._needCost.value) < self._needCost.size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._needCost.type,
			value = self._needCost.value,
			size = self._needCost.size
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Artifact_HandbookUpgrade({
		id = self._curCfg.id
	})
	self:removeSelf()
end

function ArtifactHandBookLvUpPop:_onClickClose()
	if self._closing then
		return
	end

	self._closing = true

	self.m_back_0Transition:play(handler(self, self._onExitPlayFinish))
end

function ArtifactHandBookLvUpPop:_onExitPlayFinish()
	self:removeSelf()
end

function ArtifactHandBookLvUpPop:onUnload()
	if self._params.closeCallback then
		self._params.closeCallback()
	end
end

return ArtifactHandBookLvUpPop
