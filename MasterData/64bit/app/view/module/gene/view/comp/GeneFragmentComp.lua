local var_0_0 = g.core.model.User.geneData
local var_0_1 = g.core.const.ConstMgr.GeneConst
local var_0_2 = g.core.config.gene_segment_info
local var_0_3 = g.core.common.Path
local GeneFragmentComp = class("GeneFragmentComp", require("app.fairyGUI.gene.UI_GeneFragmentComp"))

function GeneFragmentComp:ctor()
	self._info = {}

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_stateBgLoader:addClickListener(handler(self, self.showInfoPop))
	end
end

function GeneFragmentComp:setInfo(arg_2_1)
	self._info.geneId = arg_2_1.geneId
	self._info.id = arg_2_1.id
	self._info.x = arg_2_1.x
	self._info.y = arg_2_1.y
	self._geneLen = var_0_0:getGeneLen(self._info.geneId)

	self.m_lenController:setSelectedIndex(self._geneLen == 7 and 1 or 0)

	self._gridSize = var_0_1.GRID_SIZE[self._geneLen]
	self._type = var_0_2.get(self._info.id).type
	self._state = var_0_0:getFragActivatedState(self._info.geneId, self._info.x, self._info.y)

	self.m_fragIconLoader:setURL((var_0_3:getGeneFragIconByType(self._type, self._state)))
	self:setPosition({
		x = arg_2_1.x * self._gridSize.W - self._gridSize.W / 2,
		y = arg_2_1.y * self._gridSize.H - self._gridSize.H / 2
	})
	self:setName("frag" .. arg_2_1.x .. "_" .. arg_2_1.y)
	self:updateEffectState(self._state)
	self:updateLinkVisible()
end

function GeneFragmentComp:getInfo()
	return self._info
end

function GeneFragmentComp:setPlaceState(arg_4_1)
	self.m_placeStateController:setSelectedIndex(arg_4_1)
end

function GeneFragmentComp:updateLinkVisible()
	self.m_effLine:removeAllEffect()

	local var_5_0 = self._geneLen == 7 and "short" or "long"
	local var_5_1 = "eff_ui_gene_line"
	local var_5_2 = var_0_0:getLinkedFrags(self._info.geneId, self._info.id)

	if next(var_5_2) then
		local var_5_3 = self:isShowLinkLine(var_5_2, self._info.x, self._info.y - 1)
		local var_5_4 = self:isShowLinkLine(var_5_2, self._info.x, self._info.y + 1)
		local var_5_5 = self:isShowLinkLine(var_5_2, self._info.x - 1, self._info.y)
		local var_5_6 = self:isShowLinkLine(var_5_2, self._info.x + 1, self._info.y)

		self.m_top:setVisible(var_5_3)

		if var_5_3 then
			self.m_effLine:addEffectSpine({
				isLoop = true,
				name = var_5_1,
				anim = var_5_0 .. "Top"
			})
		end

		self.m_down:setVisible(var_5_4)

		if var_5_4 then
			self.m_effLine:addEffectSpine({
				isLoop = true,
				name = var_5_1,
				anim = var_5_0 .. "Down"
			})
		end

		self.m_left:setVisible(var_5_5)

		if var_5_5 then
			self.m_effLine:addEffectSpine({
				isLoop = true,
				name = var_5_1,
				anim = var_5_0 .. "Left"
			})
		end

		self.m_right:setVisible(var_5_6)

		if var_5_6 then
			self.m_effLine:addEffectSpine({
				isLoop = true,
				name = var_5_1,
				anim = var_5_0 .. "Right"
			})
		end
	else
		self.m_top:setVisible(false)
		self.m_down:setVisible(false)
		self.m_left:setVisible(false)
		self.m_right:setVisible(false)
	end
end

function GeneFragmentComp:isShowLinkLine(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1["frag" .. arg_6_2 .. "_" .. arg_6_3] then
		return var_0_0:getFragActivatedState(self._info.geneId, arg_6_2, arg_6_3) > 1
	end

	return false
end

function GeneFragmentComp:playLightAni()
	self._state = var_0_0:getFragActivatedState(self._info.geneId, self._info.x, self._info.y)

	self.m_fragIconLoader:setURL((var_0_3:getGeneFragIconByType(self._type, self._state)))
	self.m_effLightUp:addEffectSpine({
		isLoop = false,
		remove = true,
		name = var_0_1.SEGMENT_LIGHT_EFF[self._type]
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TB_SMALLACTIVATE)
end

function GeneFragmentComp:updateEffectState()
	self._state = var_0_0:getFragActivatedState(self._info.geneId, self._info.x, self._info.y)

	self.m_effLink:removeAllEffect()
	self.m_effLightUp:removeAllEffect()

	if self._state == 2 then
		self.m_linkTransition:play()
		self.m_effLink:addEffectSpine({
			name = "eff_ui_gene_link",
			isLoop = true,
			anim = var_0_1.THIRD_LINK_PLAY_NAME[self._type]
		})
	elseif self._state == 3 then
		self.m_linkTransition:play()
		self.m_effLightUp:addEffectSpine({
			name = "eff_ui_gene_intersect",
			isLoop = true,
			anim = var_0_1.THIRD_LINK_PLAY_NAME[self._type]
		})
	end
end

function GeneFragmentComp:showInfoPop()
	g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.GENE_FIGURE_INFO, self._info)
end

return GeneFragmentComp
