local var_0_0 = g.core.const.ConstMgr.TreasureConst.TREASURE_QUALITY
local var_0_1 = g.core.const.ConstMgr.SpineConst
local DrawUniteToken = require("app.view.common.DrawUniteToken")
local RecruitRewardUniteTokenPop = class("RecruitRewardUniteTokenPop", require("app.fairyGUI.recruitUniteToken.UI_RecruitRewardUniteTokenPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitRewardUniteTokenPop",
		pkgPath = "ui/recruitUniteToken/recruitUniteToken",
		isFullScreen = true,
		pkgName = "recruitUniteToken"
	})
end)

function RecruitRewardUniteTokenPop:ctor(arg_2_1, arg_2_2)
	self._params = arg_2_1

	if arg_2_1 then
		self._isShare = arg_2_1.isShare or false
	end

	self._finishFunc = arg_2_2

	self:showAtCenter()
	self:getView():setSize(display.width, display.height)

	local var_2_0 = arg_2_1[1].good

	table.remove(self._params, 1)

	local var_2_1 = g.core.model.User.recruitData:isNewUniteToken(var_2_0.value)
	local var_2_2 = g.core.config.unite_token_info.get(var_2_0.value)

	self._quality = var_2_2.quality

	if DrawUniteToken:showSpineEnable(var_2_2.id) then
		self.m_itemSpineDad:addChild((DrawUniteToken.new({
			loop = true,
			advId = var_2_2.advance_id,
			anim = var_0_1.UniteTokenAni.IDLE
		})))
		self.m_itemLoader:setVisible(false)
	else
		self.m_itemLoader:setURL((g.core.common.Path:getUniteTokenCardImg(var_2_2.res_id)))
	end

	self.m_nameTxt:setText(var_2_2.name)
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(var_2_2.quality))

	if not var_2_1 then
		self.m_convertGroup:setVisible(true)
		self.m_autoFragmentTxt2:setText("X" .. var_2_2.return_fragment_num)
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
	self.m_shareComp:setVisibleEx(not self._isShare)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))

	if self._quality >= var_0_0.SR then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_SHOW_HEIGHT)
	end

	self._closeEnabled = false

	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
end

function RecruitRewardUniteTokenPop:_onEnterAnimEnd()
	self._closeEnabled = true
end

function RecruitRewardUniteTokenPop:_onClickClose()
	self:_onTouchClick()
end

function RecruitRewardUniteTokenPop:_onTouchClick()
	if not self._closeEnabled then
		return
	end

	if not self._close then
		self._close = true

		self:onSelfExitFinish()
	end
end

function RecruitRewardUniteTokenPop:onSelfExitFinish()
	g.core.module.ModuleManager:popComponent()

	if #self._params > 0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop").new(self._params, self._finishFunc)))
	else
		self._finishFunc()
	end
end

function RecruitRewardUniteTokenPop:_onShareClick()
	if not self._closeEnabled or self._close then
		return
	end

	local var_7_0 = self.m_convertGroup:isVisible()

	self.m_shareComp:setVisibleEx(false)
	self.m_convertGroup:setVisible(false)

	local var_7_1 = cc.utils:captureNode(self)

	var_7_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_7_1:release()
	self.m_shareComp:setVisibleEx(true)
	self.m_convertGroup:setVisible(var_7_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_9
	})
end

return RecruitRewardUniteTokenPop
