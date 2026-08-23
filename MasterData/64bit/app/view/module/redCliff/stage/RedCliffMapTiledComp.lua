local RedCliffConst = require("app.view.module.redCliff.const.RedCliffConst")
local RedCliffMapTiledComp = class("RedCliffMapTiledComp", require("app.fairyGUI.redCliff.UI_RedCliffMapTiledComp"))

function RedCliffMapTiledComp:ctor()
	self._info = nil
	self._struct = nil
	self._boxEffect = nil
	self._caveEffect = nil
	self._editorType = RedCliffConst.EDITOR_TYPE.BARRIER
end

function RedCliffMapTiledComp:updateCompView(arg_2_1)
	self._struct = arg_2_1
	self._info = arg_2_1:getComponentInfo()
	self._editorType = arg_2_1:getEditorType()

	self.m_editorTypeController:setSelectedIndex(self._editorType)
	self.m_icon:setURL((self:_getIconUIByEditorId((arg_2_1:getEditorId()))))

	local var_2_0 = arg_2_1:isBarrier()

	self.m_isBarrierController:setSelectedIndex(var_2_0 and 1 or 0)
	self:updateFertile()
	self:updateOccupyPlayer()

	if not var_2_0 then
		self.m_editorName:setText(self._info.name)
	end
end

function RedCliffMapTiledComp:getStruct()
	return self._struct
end

function RedCliffMapTiledComp:updateOccupyPlayer(arg_4_1)
	local var_4_0 = self._struct:getPlayer()

	if var_4_0 and var_4_0:getComponentId() ~= self._struct:getComponentId() then
		var_4_0 = nil

		self._struct:setPlayer(nil)
	end

	self.m_knightComp:setVisible(checkbool(var_4_0))
	self.m_outputScore:setVisible(checkbool(var_4_0))

	if var_4_0 then
		self.m_knightComp:updateEditorRole(var_4_0)
		self.m_outputScore:getTransition("float"):play(-1, 0)

		if arg_4_1 then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SMALL_SLIDE_HAIDAO)
			self.m_knightComp:playOccupyEffect()
		end
	end
end

function RedCliffMapTiledComp:updateCountDown()
	if self._struct:getPlayer() then
		self.m_knightComp:updateCountDown()
		self.m_knightComp:updateHpView()
	end
end

function RedCliffMapTiledComp:getEditorType()
	return self._struct:getEditorType()
end

function RedCliffMapTiledComp:updateFertile()
	if self.m_isBarrierController:getSelectedIndex() ~= 1 then
		local var_7_0 = self._struct:isFertile()

		self.m_isFertileController:setSelectedIndex(var_7_0 and 1 or 0)
		self:_updateFertileEffect(var_7_0)

		local var_7_1 = self._struct:getFinalOutput()

		self.m_editorScore:setText(g.core.lang:get(421026, {
			num = var_7_1
		}))
		self.m_outputScore:getChild("title"):setText("+" .. var_7_1)
	end
end

function RedCliffMapTiledComp:_updateFertileEffect(arg_8_1)
	if arg_8_1 then
		if self._editorType == RedCliffConst.EDITOR_TYPE.SMALL then
			self._boxEffect = self._boxEffect or self.m_boxEffect:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = "eff_ui_redCliff_doubleProduction"
			})
		elseif self._editorType == RedCliffConst.EDITOR_TYPE.MIDDLE and not self._caveEffect then
			self._caveEffect = self.m_caveEffect:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = "eff_ui_redCliff_doubleProduction"
			})
		end
	end
end

function RedCliffMapTiledComp:_getIconUIByEditorId(arg_9_1)
	return "ui://redCliff/" .. arg_9_1
end

return RedCliffMapTiledComp
