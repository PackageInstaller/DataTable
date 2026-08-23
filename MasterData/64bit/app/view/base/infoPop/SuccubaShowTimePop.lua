local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local SuccubaShowTimePop = class("SuccubaShowTimePop", require("app.fairyGUI.infoPop.UI_SuccubaShowTimePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "SuccubaShowTimePop",
		pkgName = "infoPop",
		isFullScreen = true
	})
end)
local var_0_2 = g.core.common.Path
local DrawSuccuba = require("app.view.common.DrawSuccuba")

function SuccubaShowTimePop:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._isIgnoreCheckEnd = arg_2_4 or false
	self._customPlay = arg_2_3
	self._group1OrginPos = self.m_spineGroup1:getPosition()
	self._videoEndCallback = nil
	self._customPlayTimer = nil

	self:_addListeners()

	if not arg_2_1 and not arg_2_2 then
		return
	end

	self:updatePop(arg_2_1, arg_2_2)
end

function SuccubaShowTimePop:updatePop(arg_3_1, arg_3_2)
	self._playEndAnmi = false
	self._playIdx = 0
	arg_3_2 = arg_3_2 or {
		arg_3_1
	}

	self:_initShowDatas(arg_3_2)

	self._transPlayEnd = false
	self._wordAnimEnd = false
	self._callBack = arg_3_1.callBack
	self._isJustShow = arg_3_1.justShow
	self._needPlaySpecialAnimation = false

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_shareComp:setVisibleEx(false)
	else
		self.m_shareComp:setVisibleEx(not arg_3_1.isPrimary)
	end
end

function SuccubaShowTimePop:_initShowDatas(arg_4_1)
	self._showDatas = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = g.core.config.succuba_info.get(iter_4_1.succubaId)
		local var_4_1 = g.core.config.succuba_show_info.get(var_4_0.advance_id)

		table.insert(self._showDatas, {
			isNew = true,
			showCfg = var_4_1,
			cfg = var_4_0,
			spineParams = {
				isShowBg = false,
				showCfg = var_4_1
			}
		})
	end
end

function SuccubaShowTimePop:_addListeners()
	self:addClickListener(handler(self, self._onReturnBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_skipBtn:addClickListener(handler(self, self._onSkipClick))
end

function SuccubaShowTimePop:_onReturnBtnClick()
	if self.m_isPlayShowController:getSelectedIndex() == 1 then
		return
	end

	if not self._transPlayEnd or self._playEndAnmi then
		return
	end

	if self._isIgnoreCheckEnd then
		self:_close()
	else
		self:playNextSuccuba()
	end
end

function SuccubaShowTimePop:_onShareClick()
	if not self._transPlayEnd or self._playEndAnmi then
		return
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		self:setVisible(false)

		return
	end

	local var_7_0 = self.m_isNewController:getSelectedIndex()

	self.m_shareComp:setVisibleEx(false)
	self.m_isNewController:setSelectedIndex(0)
	self.m_isAutoFragmentBoxController:setSelectedIndex(0)

	local var_7_1 = cc.utils:captureNode(self)

	var_7_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_7_1:release()
	self.m_shareComp:setVisibleEx(true)
	self.m_isNewController:setSelectedIndex(var_7_0)
	self.m_isAutoFragmentBoxController:setSelectedIndex((self.m_isAutoFragmentBoxController:getSelectedIndex()))
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_4
	})
end

function SuccubaShowTimePop:_onSkipClick()
	self.m_fragGroup:setVisible(self.m_isAutoFragmentBoxController:getSelectedIndex() == 1)

	if self._drawSuccuba then
		self._drawSuccuba:playIdle()
		self.m_isPlayShowController:setSelectedIndex(0)
	end
end

function SuccubaShowTimePop:playNextSuccuba()
	self.m_flushTopNode:setVisible(false)

	self._playIdx = self._playIdx + 1

	if self._playIdx <= #self._showDatas then
		local var_9_0 = 2

		if self._playIdx % 2 == 1 then
			var_9_0 = 1
		end

		self:_onUpdateSuccuba(var_9_0)
		self:_play(var_9_0)
	elseif not self._playEndAnmi then
		local var_9_1 = 2

		if self._playIdx % 2 == 1 then
			var_9_1 = 1
		end

		self["m_nameGroup" .. var_9_1]:setOpacity(0)
		self.m_backTransition:play()

		self._playEndAnmi = true

		local var_9_2 = self["m_spineGroup" .. var_9_1]

		self["m_spineGroup" .. var_9_1]:setVisible(false)

		self._schedule = g.core.common.Scheduler:newScheduleOnce(function()
			self._schedule = nil

			if tolua.isnull(var_9_2) then
				return
			end

			var_9_2:setVisible(true)
			self:playNextSuccuba()
		end, 0.3)

		if self._customPlay then
			self._customPlayTimer = self:newScheduleOnce(function()
				self:resetUI()

				self._customPlayTimer = nil
			end, 1)
		end
	elseif self._playEndAnmi then
		self:_close()
	end
end

function SuccubaShowTimePop:_play(arg_12_1)
	if self._customPlayTimer then
		self:cancelSchedule(self._customPlayTimer)
	end

	self._transPlayEnd = false

	local var_12_0 = self._showDatas[self._playIdx]
	local var_12_1
	local var_12_2 = self["m_qualityEffectNode" .. arg_12_1]

	self["m_qualityEffectNode" .. arg_12_1]:removeAllEffect()

	local function var_12_3()
		if self._playIdx ~= 1 then
			self["m_spineComp" .. arg_12_1]:setVisible(true)

			return
		end

		local var_13_0 = 0
		local var_13_1 = var_12_0.cfg

		if var_12_0.cfg.quality < 3 then
			local var_13_2 = DrawSuccuba.new(var_12_0.spineParams):popDisplayObject()

			var_13_2:setAnchorPoint(0.5, 0.5)
			var_13_2:setPosition(cc.p(0, var_13_2:getContentSize().height / 2))
			var_12_2:addEffectSpine({
				remove = true,
				name = "eff_ui_recruitReward_show",
				zorder = 1,
				isLoop = false,
				anim = "play_light_" .. var_12_0.cfg.quality + 1,
				eventHandler = function(self, arg_14_1)
					if self.type == "complete" then
						self["m_spineComp" .. arg_12_1]:setVisible(true)
					end
				end
			}):getNodeForSlot("role"):addChild(var_13_2)
			self["m_spineComp" .. arg_12_1]:setVisible(true)
		end

		local var_13_3 = self["m_qualityLightNode" .. arg_12_1]

		if var_12_0.cfg.quality >= var_0_0.SSR then
			self:newScheduleOnce(handler(self, function(arg_15_0)
				var_13_3:addEffectSpine({
					remove = true,
					name = "eff_ui_recruitReward_show",
					zorder = 0,
					isLoop = false,
					anim = "play_role_" .. var_13_1.quality + 1
				})

				if var_13_1.quality >= var_0_0.SSR then
					arg_15_0["m_spineComp" .. arg_12_1]:setVisible(true)
				end
			end), var_13_0)
		else
			self["m_spineComp" .. arg_12_1]:setVisible(true)
		end
	end

	if self._playIdx == 1 then
		var_12_1 = self.m_normalEnterTransition

		var_12_3()
	else
		var_12_1 = self["m_enter_" .. arg_12_1 .. "Transition"]
		self._schedule = g.core.common.Scheduler:newScheduleOnce(function()
			var_12_3()

			self._schedule = nil
		end, 0.3)

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_KNIGHT_SHOW_POP_SLIDE)
	end

	var_12_1:play(handler(self, self._onOneTransPlayEnd))
end

function SuccubaShowTimePop:_playSpineCutIn(arg_17_1, arg_17_2)
	self["m_qualityLightNode" .. arg_17_1]:addEffectSpine({
		remove = true,
		name = "eff_ui_recruitReward_show",
		zorder = 0,
		isLoop = false,
		anim = "play_role_" .. arg_17_2.quality + 1
	})
	self["m_qualityLightNode" .. arg_17_1]:setOpacity(255)

	if arg_17_2.quality == var_0_0.UR then
		self["m_spineComp" .. arg_17_1]:setVisible(true)
	end
end

function SuccubaShowTimePop:_onOneTransPlayEnd()
	self._transPlayEnd = true

	self.m_flushTopNode:setVisible(true)
end

function SuccubaShowTimePop:resetUI()
	self.m_spineComp1:removeChildren()
	self.m_spineComp1:setOpacity(255)
	self.m_nameGroup1:setOpacity(0)
	self.m_spineComp2:removeChildren()
	self.m_spineComp2:setOpacity(255)
	self.m_nameGroup2:setOpacity(0)
	self.m_spineGroup1:setPosition(self._group1OrginPos)
	self.m_fragGroup:setOpacity(255)
	self.m_qualityEffectNode:setOpacity(255)
end

function SuccubaShowTimePop:_close()
	if not self._customPlay then
		self:removeSelf()
	end

	if self._callBack then
		self._callBack()
	end
end

function SuccubaShowTimePop:_onClickClose()
	if not self._isClose then
		self._isClose = true

		self:_close()
	end
end

function SuccubaShowTimePop:onLoad()
	if not self._customPlay then
		self:playNextSuccuba()
	end
end

function SuccubaShowTimePop:onUnload()
	self:cancelAllSchedule()

	self._customPlayTimer = nil
end

function SuccubaShowTimePop:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		remove = true,
		name = "eff_ui_home_trans",
		isLoop = false
	})
end

function SuccubaShowTimePop:_onUpdateSuccuba(arg_25_1)
	local var_25_0 = self._showDatas[self._playIdx]

	self["m_spineComp" .. arg_25_1]:removeChildren()
	self["m_spineComp" .. arg_25_1]:addChild((DrawSuccuba.new(var_25_0.spineParams)))
	self["m_spineComp" .. arg_25_1]:setVisible(false)

	local var_25_1 = var_25_0.cfg

	if not self._isJustShow and not var_25_0.isNew then
		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, var_25_0.cfg.fragment, true)))
		self.m_autoFragmentTxt:setText("X" .. var_25_1.repeat_size)

		if var_25_0.hideFrag then
			self.m_isAutoFragmentBoxController:setSelectedIndex(0)
		else
			self.m_isAutoFragmentBoxController:setSelectedIndex(1)
		end
	else
		self.m_isAutoFragmentBoxController:setSelectedIndex(0)
	end

	self["m_qualityGLoader" .. arg_25_1]:setURL(var_0_2:getQualityArtTxtURL(var_25_1.quality))
	self["m_nameTxt" .. arg_25_1]:setText(var_25_1.name)

	if var_25_0.isNew then
		self.m_isNewController:setSelectedIndex(1)
	else
		self.m_isNewController:setSelectedIndex(0)
	end

	self["m_nameGroup" .. arg_25_1]:setOpacity(255)

	local var_25_2 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_PURPLE

	if var_25_1.quality > 2 then
		var_25_2 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_ORANGE
	elseif self._playIdx == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_R)
	end

	g.core.sound.SoundManager:playSound(var_25_2)
	self["m_nameBgLoader" .. arg_25_1]:setURL("ui://infoPop/pic_mnzj_pinzhi" .. var_25_1.quality + 1)
	self["m_nameBgLoader" .. arg_25_1]:setOpacity(255)
	self.m_bgRightLoader:setURL(var_0_2:getTxtRecruitLogo(var_25_1.quality))
	self.m_lineBg1:setURL(var_0_2:getUserIconQualityStarBg(var_25_1.quality))
	self.m_lineBg2:setURL(var_0_2:getRecruitQualityLine(var_25_1.quality, "ui://infoPop/bg_zm_pinzhixian_long_"))
	self.m_bgTipLoader:setURL(var_0_2:getRecruitBgTipText(var_25_1.quality))
	self:_onUpdateRoomBg(var_25_1.advance_id, arg_25_1)
end

function SuccubaShowTimePop:_onUpdateRoomBg(arg_26_1, arg_26_2)
	local var_26_0 = {
		"bg/succuba/",
		g.core.config.succuba_room_info.get(1).general
	}

	if arg_26_1 then
		var_26_0[#var_26_0 + 1] = "_"
		var_26_0[#var_26_0 + 1] = arg_26_1
	end

	var_26_0[#var_26_0 + 1] = ".jpg"

	self["m_bgLoader" .. arg_26_2]:setURL((table.concat(var_26_0)))

	local var_26_1 = self["m_bgLoader" .. arg_26_2]:getSize()
	local var_26_2 = math.max(display.width / var_26_1.width, display.height / var_26_1.height)

	if var_26_2 > 1 then
		self["m_bgLoader" .. arg_26_2]:setScale(var_26_2)
	else
		self["m_bgLoader" .. arg_26_2]:setScale(1)
	end
end

function SuccubaShowTimePop:onUnload()
	if self._schedule then
		g.core.common.Scheduler:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function SuccubaShowTimePop:getShowDatas()
	return self._showDatas
end

return SuccubaShowTimePop
