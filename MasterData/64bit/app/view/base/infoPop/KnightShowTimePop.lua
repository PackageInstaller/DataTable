local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local KnightShowTimePop = class("KnightShowTimePop", require("app.fairyGUI.infoPop.UI_KnightShowTimePop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/infoPop/infoPop",
		resName = "KnightShowTimePop",
		pkgName = "infoPop"
	})
end)
local var_0_5 = g.core.common.Path
local TypeWriter = require("app.view.common.TypeWriter")
local DrawKnight = require("app.view.common.DrawKnight")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")

function KnightShowTimePop:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._isIgnoreCheckEnd = arg_2_4 or false
	self._customPlay = arg_2_3
	self._group1OrginPos = self.m_spineGroup1:getPosition()
	self._videoEndCallback = nil
	self._customPlayTimer = nil

	local var_2_0 = config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA

	self.m_groupNameLoader1:setVisible(not (config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA))
	self.m_groupNameLoader2:setVisible(not var_2_0)
	self:_addListeners()

	if not arg_2_1 and not arg_2_2 then
		return
	end

	self:updatePop(arg_2_1, arg_2_2)
end

function KnightShowTimePop:updatePop(arg_3_1, arg_3_2)
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

	if self._needPlaySpecialAnimation then
		self.m_isShowSpcialController:setSelectedIndex(1)
	else
		self.m_isShowSpcialController:setSelectedIndex(0)
	end
end

function KnightShowTimePop:_changeBg(arg_4_1, arg_4_2)
	local var_4_1 = self["m_bgLoader" .. arg_4_1]

	self["m_bgLoader" .. arg_4_1]:setURL(arg_4_2 == var_0_0.GROUP_TYPE.JIAO_GUO and "bg/recruit/bg_zm_jiaoguo.jpg" or arg_4_2 == var_0_0.GROUP_TYPE.LIN_DONG and "bg/recruit/bg_zm_lindong.jpg" or arg_4_2 == var_0_0.GROUP_TYPE.DONG_XI and "bg/recruit/bg_zm_dongxi.jpg" or "bg/recruit/bg_zm_lijin.jpg")

	local var_4_2 = var_4_1:getSize()
	local var_4_3 = math.max(display.width / var_4_2.width, display.height / var_4_2.height)

	if var_4_3 > 1 then
		var_4_1:setScale(var_4_3)
	else
		var_4_1:setScale(1)
	end
end

function KnightShowTimePop:_initShowDatas(arg_5_1)
	self._showDatas = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = {}
		local var_5_1 = {
			resId = iter_5_1.knightId,
			skinId = iter_5_1.skinId
		}

		var_5_0.spineParams = var_5_1
		var_5_0.spineParams.isShowBg = true
		var_5_0.num = iter_5_1.num or 1
		var_5_0.isNew = iter_5_1.isNew
		var_5_0.hideFrag = iter_5_1.hideFrag

		if not var_5_1.resId and var_5_1.skinId then
			var_5_0.type = 1
			var_5_0.skinInfo = g.core.config.skin_info.get(var_5_1.skinId)
			var_5_0.info = g.core.config.knight_info.get(var_5_0.skinInfo.knight_advance_id)
			var_5_0.baseInfo = g.core.config.knight_base_info.get(var_5_0.skinInfo.res)
		else
			var_5_0.type = 0
			var_5_0.info = g.core.config.knight_info.get(var_5_1.resId)
			var_5_0.baseInfo = g.core.config.knight_base_info.get(var_5_1.resId)
		end

		table.insert(self._showDatas, var_5_0)
	end
end

function KnightShowTimePop:_addListeners()
	self:addClickListener(handler(self, self._onReturnBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_skipBtn:addClickListener(handler(self, self._onSkipClick))
end

function KnightShowTimePop:_onReturnBtnClick()
	if self.m_isPlayShowController:getSelectedIndex() == 1 then
		return
	end

	if not self._transPlayEnd or not self._wordAnimEnd or self._playEndAnmi then
		return
	end

	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil

		return
	end

	if self._isIgnoreCheckEnd then
		self:_close()
	else
		self:playNextKnight()
	end
end

function KnightShowTimePop:_onShareClick()
	if not self._transPlayEnd or not self._wordAnimEnd or self._playEndAnmi then
		return
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		self:setVisible(false)

		return
	end

	local var_8_0 = self.m_isNewController:getSelectedIndex()

	self.m_shareComp:setVisibleEx(false)
	self.m_isNewController:setSelectedIndex(0)
	self.m_isAutoFragmentBoxController:setSelectedIndex(0)

	local var_8_1 = cc.utils:captureNode(self)

	var_8_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_8_1:release()
	self.m_shareComp:setVisibleEx(true)
	self.m_isNewController:setSelectedIndex(var_8_0)
	self.m_isAutoFragmentBoxController:setSelectedIndex((self.m_isAutoFragmentBoxController:getSelectedIndex()))
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_4
	})
end

function KnightShowTimePop:_onSkipClick()
	self.m_fragGroup:setVisible(self.m_showTypeController:getSelectedIndex() == 0 and self.m_isAutoFragmentBoxController:getSelectedIndex() == 1)

	if self._videoEndCallback then
		self:_videoEndCallback()

		self._videoEndCallback = nil
	end

	if self._drawKnight then
		self._drawKnight:playIdle()
		self._drawKnight:playBgAction()
		self._drawKnight:removeSpecialShowAction()
		self.m_isPlayShowController:setSelectedIndex(0)
	end
end

function KnightShowTimePop:playNextKnight()
	self.m_flushTopNode:setVisible(false)

	self._playIdx = self._playIdx + 1

	if self._playIdx <= #self._showDatas then
		local var_10_0 = 2

		if self._playIdx % 2 == 1 then
			var_10_0 = 1
		end

		self:_onUpdateKnight(var_10_0)
		self:_play(var_10_0)
	elseif not self._playEndAnmi then
		local var_10_1 = 2

		if self._playIdx % 2 == 1 then
			var_10_1 = 1
		end

		self["m_groupGLoader" .. var_10_1]:setOpacity(0)
		self["m_nameGroup" .. var_10_1]:setOpacity(0)
		self.m_backTransition:play()

		self._playEndAnmi = true

		local var_10_2 = self["m_spineGroup" .. var_10_1]

		self["m_spineGroup" .. var_10_1]:setVisible(false)

		self._schedule = g.core.common.Scheduler:newScheduleOnce(function()
			self._schedule = nil

			if tolua.isnull(var_10_2) then
				return
			end

			var_10_2:setVisible(true)
			self:playNextKnight()
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

function KnightShowTimePop:_play(arg_13_1)
	if self._customPlayTimer then
		self:cancelSchedule(self._customPlayTimer)
	end

	self._transPlayEnd = false

	local var_13_0 = self._showDatas[self._playIdx]
	local var_13_1
	local var_13_2 = self["m_qualityEffectNode" .. arg_13_1]

	self["m_qualityEffectNode" .. arg_13_1]:removeAllEffect()

	local function var_13_3()
		if self._playIdx ~= 1 then
			self["m_spineComp" .. arg_13_1]:setVisible(true)

			return
		end

		local var_14_0 = 0
		local var_14_1 = var_13_0.info

		if var_13_0.skinInfo then
			var_14_1 = var_13_0.skinInfo
		end

		if var_14_1.quality < 3 then
			local var_14_2 = DrawKnight.new(var_13_0.spineParams):popDisplayObject()

			var_14_2:setAnchorPoint(0.5, 0.5)
			var_14_2:setPosition(cc.p(0, var_14_2:getContentSize().height / 2))
			var_13_2:addEffectSpine({
				zorder = 1,
				remove = true,
				isLoop = false,
				name = "eff_ui_recruitReward_show",
				anim = "play_light_" .. var_14_1.quality + 1,
				eventHandler = function(self, arg_15_1)
					if self.type == "complete" then
						self["m_spineComp" .. arg_13_1]:setVisible(true)
					end
				end
			}):getNodeForSlot("role"):addChild(var_14_2)
			self["m_spineComp" .. arg_13_1]:setVisible(true)
		end

		local var_14_3 = self["m_qualityLightNode" .. arg_13_1]

		if var_14_1.quality >= var_0_2.SSR then
			self:newScheduleOnce(handler(self, function(arg_16_0)
				var_14_3:addEffectSpine({
					zorder = 0,
					remove = true,
					isLoop = false,
					name = "eff_ui_recruitReward_show",
					anim = "play_role_" .. var_14_1.quality + 1
				})

				if var_14_1.quality >= var_0_2.SSR then
					arg_16_0["m_spineComp" .. arg_13_1]:setVisible(true)
				end
			end), var_14_0)
		else
			self["m_spineComp" .. arg_13_1]:setVisible(true)
		end
	end

	if self._playIdx == 1 then
		var_13_1 = self.m_normalEnterTransition

		var_13_3()
	else
		var_13_1 = self["m_enter_" .. arg_13_1 .. "Transition"]
		self._schedule = g.core.common.Scheduler:newScheduleOnce(function()
			var_13_3()

			self._schedule = nil
		end, 0.3)

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_KNIGHT_SHOW_POP_SLIDE)
	end

	var_13_1:play(handler(self, self._onOneTransPlayEnd))
end

function KnightShowTimePop:_playSpineCutIn(arg_18_1, arg_18_2)
	self["m_qualityLightNode" .. arg_18_1]:addEffectSpine({
		zorder = 0,
		remove = true,
		isLoop = false,
		name = "eff_ui_recruitReward_show",
		anim = "play_role_" .. arg_18_2.quality + 1
	})
	self["m_qualityLightNode" .. arg_18_1]:setOpacity(255)

	if arg_18_2.quality == var_0_2.UR then
		self["m_spineComp" .. arg_18_1]:setVisible(true)
	end
end

function KnightShowTimePop:_onOneTransPlayEnd()
	self._transPlayEnd = true

	self.m_flushTopNode:setVisible(true)
	self:_playTypeWriter()
end

function KnightShowTimePop:resetUI()
	self.m_spineComp1:removeChildren()
	self.m_spineComp1:setOpacity(255)
	self.m_groupGLoader1:setOpacity(0)
	self.m_nameGroup1:setOpacity(0)
	self.m_spineComp2:removeChildren()
	self.m_spineComp2:setOpacity(255)
	self.m_groupGLoader2:setOpacity(0)
	self.m_nameGroup2:setOpacity(0)
	self.m_spineGroup1:setPosition(self._group1OrginPos)
	self.m_fragGroup:setOpacity(255)
	self.m_qualityEffectNode:setOpacity(255)
end

function KnightShowTimePop:_close()
	if not self._customPlay then
		self:removeSelf()
	end

	if self._callBack then
		self._callBack()
	end
end

function KnightShowTimePop:_onClickClose()
	if not self._isClose then
		self._isClose = true

		self:_close()
	end
end

function KnightShowTimePop:onLoad()
	if not self._customPlay then
		self:playNextKnight()
	end
end

function KnightShowTimePop:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_home_trans"
	})
end

function KnightShowTimePop:_onUpdateKnight(arg_25_1)
	local var_25_0 = self._showDatas[self._playIdx]
	local var_25_1 = self._showDatas[self._playIdx].type

	self.m_showTypeController:setSelectedIndex(self._showDatas[self._playIdx].type)
	self["m_spineComp" .. arg_25_1]:removeChildren()

	local var_25_2 = DrawKnight.new(var_25_0.spineParams)

	self["m_spineComp" .. arg_25_1]:addChild(var_25_2)
	self["m_spineComp" .. arg_25_1]:setVisible(false)

	if var_25_0.baseInfo and var_25_0.baseInfo.knight_show == var_0_0.VIDEO_SHOW_TYPE.ALL then
		self._videoEndCallback = handler(self, function(arg_26_0)
			arg_26_0:_playSpineCutIn(arg_25_1, var_25_0.info)
		end)

		var_25_2:playSpecialShowAction(self.m_knightMovieComp, nil, handler(self, self._onSkipClick), nil, true)

		self._drawKnight = var_25_2

		self.m_isPlayShowController:setSelectedIndex(1)
		self.m_fragGroup:setVisible(false)
	end

	local var_25_3 = var_25_0.info

	if var_25_0.skinInfo then
		var_25_3 = var_25_0.skinInfo
	end

	if var_25_1 == 0 and not self._isJustShow and not var_25_0.isNew then
		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, var_25_0.spineParams.resId, true)))
		self.m_autoFragmentTxt:setText("X" .. var_25_3.return_fragment_num)

		if var_25_0.hideFrag then
			self.m_isAutoFragmentBoxController:setSelectedIndex(0)
		else
			self.m_isAutoFragmentBoxController:setSelectedIndex(1)
		end
	else
		self.m_isAutoFragmentBoxController:setSelectedIndex(0)
	end

	local var_25_4 = ""

	if var_25_0.baseInfo then
		var_25_4 = var_0_5:getCampURL(var_25_0.info.group, 10)

		self:_changeBg(arg_25_1, var_25_0.info.group)

		local var_25_6 = string.gsub(g.core.lang:get(108100 + var_25_0.info.group), " ", "")

		self["m_groupNameLoader" .. arg_25_1]:setURL(var_0_5:getRecruitCampTxt(var_25_0.info.group, var_25_0.info.quality))
	end

	self["m_groupGLoader" .. arg_25_1]:setURL(var_25_4)
	self["m_qualityGLoader" .. arg_25_1]:setURL(var_0_5:getQualityArtTxtURL(var_25_3.quality))
	self["m_knightTxt" .. arg_25_1]:setText(var_25_3.name)

	if var_25_0.isNew then
		self.m_isNewController:setSelectedIndex(1)
	else
		self.m_isNewController:setSelectedIndex(0)
	end

	if var_25_0.baseInfo and var_25_1 == 0 then
		self.m_descTxt:setText(var_25_0.baseInfo.popup_1)
	end

	local var_25_7 = self.m_descTxt:getTextSize().width

	if self.m_descTxt and var_25_7 < 734 then
		self.m_descTxt:setWidth(var_25_7)
	else
		self.m_descTxt:setWidth(734)
	end

	self.m_descTxt:setText("")
	self["m_groupGLoader" .. arg_25_1]:setOpacity(255)
	self["m_nameGroup" .. arg_25_1]:setOpacity(255)
	KnightVoiceCommon.playVoice({
		voiceType = "get_sound",
		knightId = var_25_0.spineParams.resId,
		skinId = var_25_0.spineParams.skinId
	})

	local var_25_8 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_PURPLE

	if var_25_3.quality > 2 then
		var_25_8 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_ORANGE
	elseif self._playIdx == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_R)
	end

	g.core.sound.SoundManager:playSound(var_25_8)
	self.m_bgRightLoader:setURL(var_0_5:getTxtRecruitLogo(var_25_3.quality))
	self.m_lineBg1:setURL(var_0_5:getUserIconQualityStarBg(var_25_3.quality))
	self.m_lineBg2:setURL(var_0_5:getRecruitQualityLine(var_25_3.quality))
	self.m_bgTipLoader:setURL(var_0_5:getRecruitBgTipText(var_25_3.quality))
end

function KnightShowTimePop:onUnload()
	KnightVoiceCommon.stopVoice()
	self:_removeMovie(true)

	if self._schedule then
		g.core.common.Scheduler:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function KnightShowTimePop:_playTypeWriter()
	local var_28_0

	if not self._showDatas[self._playIdx] or not self._showDatas[self._playIdx].baseInfo then
		self._wordAnimEnd = true

		do return end

		var_28_0 = {
			speed = 25,
			label = self.m_descTxt
		}
	end

	var_28_0.str = self._showDatas[self._playIdx].baseInfo.popup_1

	function var_28_0.callback()
		self._typeWriter = nil
		self._wordAnimEnd = true
	end

	self._typeWriter = TypeWriter.new(var_28_0)

	self._typeWriter:start()
	self._typeWriter:finish()
end

function KnightShowTimePop:_removeMovie(arg_30_1)
	if arg_30_1 then
		if self._idleMovie and self._idleMovie.dispose then
			self._idleMovie:stop()
			self._idleMovie:dispose()
		end

		self._idleMovie = nil
	end
end

function KnightShowTimePop:getShowDatas()
	return self._showDatas
end

return KnightShowTimePop
