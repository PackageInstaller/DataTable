local KnightSkinShowTimePop = class("KnightSkinShowTimePop", require("app.fairyGUI.infoPop.UI_KnightSkinShowTimePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "KnightSkinShowTimePop",
		pkgName = "infoPop",
		isFullScreen = true
	})
end)
local DrawKnight = require("app.view.common.DrawKnight")

function KnightSkinShowTimePop:ctor(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._params = arg_2_1

	self:addClickListener(handler(self, self._onReturnBtnClick))
	self:addBg("bg/recruit/pic_zm_danchou.jpg")
end

function KnightSkinShowTimePop:_onReturnBtnClick()
	g.core.module.ModuleManager:popComponent()
end

function KnightSkinShowTimePop:onLoad()
	self:_updatePop()
end

function KnightSkinShowTimePop:_updatePop()
	if self._params.skinId then
		local var_5_0 = g.core.config.skin_info.fetch(self._params.skinId)
		local var_5_1 = DrawKnight.new({
			isShowBg = true,
			scale = 1,
			resId = var_5_0.res
		})

		self.m_spineComp:removeChildren()
		self.m_spineComp:addChild(var_5_1)
		var_5_1:playSpecialShowAction(self.m_knightMovieComp, nil, handler(self, self._showTransEffect))

		if self._params.hideUI then
			self.m_hideUIController:setSelectedIndex(1)
		else
			self.m_hideUIController:setSelectedIndex(0)
			self.m_knightTxt:setText(g.core.lang:get(201023, {
				name = g.core.config.knight_info.get(var_5_0.knight_advance_id).name
			}))
			self.m_skinTxt:setText(var_5_0.name)
		end
	end
end

function KnightSkinShowTimePop:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		remove = true,
		name = "eff_ui_home_trans",
		isLoop = false
	})
end

function KnightSkinShowTimePop:onUnload()
	local var_7_0 = self.m_spineComp:getChild()

	if var_7_0 then
		var_7_0:removeSpecialShowAction()
	end
end

return KnightSkinShowTimePop
