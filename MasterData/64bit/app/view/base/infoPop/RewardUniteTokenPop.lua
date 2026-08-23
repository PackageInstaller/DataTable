local var_0_0 = g.core.const.ConstMgr
local DrawUniteToken = require("app.view.common.DrawUniteToken")
local RewardUniteTokenPop = class("RewardUniteTokenPop", require("app.fairyGUI.infoPop.UI_RewardUniteTokenPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		pkgPath = "ui/infoPop/infoPop",
		resName = "RewardUniteTokenPop"
	})
end)

function RewardUniteTokenPop:ctor(arg_2_1)
	self:showAtCenter()
	self:getView():setSize(display.width, display.height)

	local var_2_0 = arg_2_1.good
	local var_2_1 = arg_2_1.good.from

	if arg_2_1.good.from then
		-- block empty
	end

	local var_2_4 = g.core.config.unite_token_info.get(var_2_0.value)

	self._quality = var_2_4.quality

	if DrawUniteToken:showSpineEnable(var_2_0.value) then
		self.m_itemSpineDad:removeChildren()
		self.m_itemSpineDad:addChild((DrawUniteToken.new({
			loop = true,
			advId = var_2_4.advance_id,
			anim = var_0_0.SpineConst.UniteTokenAni.IDLE
		})))
		self.m_itemLoader:setVisible(false)
	else
		self.m_itemLoader:setURL((g.core.common.Path:getUniteTokenCardImg(var_2_4.res_id)))
		self.m_itemLoader:setVisible(true)
	end

	self.m_nameTxt:setText(var_2_4.name)
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(var_2_4.quality))

	if var_2_1 then
		self.m_convertGroup:setVisible(true)
		self.m_autoFragmentTxt2:setText("X" .. var_2_0.size)
		self.m_fragIcon2:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, var_2_0.value, true)))
	else
		self.m_convertGroup:setVisible(false)
	end

	self.m_qualityEffectNode:addEffectSpine({
		remove = true,
		name = "eff_ui_recruitReward_show",
		isLoop = false,
		anim = "play_role_" .. self._quality + 1
	})
	self.m_effPlaceHolder:addEffectSpine({
		name = "eff_ui_knight_idleEff",
		isLoop = true,
		anim = "play_" .. self._quality + 1
	})
	self:addClickListener(handler(self, self._onTouchClick))

	self._closeEnabled = false

	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
	g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.RECRUIT_UNITE_TOKEN_SHOW_POP)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
end

function RewardUniteTokenPop:_onEnterAnimEnd()
	self._closeEnabled = true
end

function RewardUniteTokenPop:_onTouchClick()
	if not self._closeEnabled then
		return
	end

	if not self._close then
		self._close = true

		g.core.module.ModuleManager:popComponent()
	end
end

function RewardUniteTokenPop:_onShareClick()
	if not self._closeEnabled or self._close then
		return
	end

	self.m_shareComp:setVisible(false)

	local var_5_0 = cc.utils:captureNode(self)

	var_5_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_5_0:release()
	self.m_shareComp:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = var_0_0.ShareConst.SHARE_TYPE.TYPE_ID_9
	})
end

return RewardUniteTokenPop
