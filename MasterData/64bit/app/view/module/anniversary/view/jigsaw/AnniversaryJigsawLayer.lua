local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local var_0_2 = g.core.model.User.bagData
local AnniversaryJigsawLayer = class("AnniversaryJigsawLayer", require("app.fairyGUI.anniversary.UI_AnniversaryJigsawLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/anniversary/anniversary",
		resName = "AnniversaryJigsawLayer",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversaryJigsawLayer:ctor()
	self:addBg(var_0_1:getActivityResource("bg", "bg_xmhy_2.jpg"))
	self.m_jigsawBg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_majiangdi.png"))
	self.m_jifenBg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jifendi.png"))
	self.m_shareBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_fenxiangdi.png"))
	self.m_drawCardBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_mopaidi1.png"))
	self.m_keepDrawCardBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_mopaidi2.png"))
	self.m_shareBtn:getChild("n44"):setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().jigsaw_share_font_color))
	self.m_shareBtn:getChild("n45"):setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().jigsaw_share_font_color))

	self._anniversaryInfo = var_0_1:getAnniversaryInfo()

	self.m_topBarComp:setResInfoById(self._anniversaryInfo.interface_jigsaw)
	self.m_topBarComp:setTitle(self._anniversaryInfo.jigsaw_name)
	self.m_clickIgnoreMask:setVisible(false)
	self.m_clickIgnoreMask:setSortingOrder(var_0_0.JIGSAW_TOP_ORDER + 1)

	self._normalAward = {}
	self._isDrawing = false

	self:_initRegisterUI()
	self.m_enterTransition:play(handler(self, self._checkCanGetSignAward))
end

function AnniversaryJigsawLayer:_initRegisterUI()
	self.m_shareBtn:addClickListener(handler(self, self._onClickShareBtn))
	self.m_drawCardBtn:addClickListener(handler(self, self._onClickDrawCardBtn))
	self.m_keepDrawCardBtn:addClickListener(handler(self, self._onClickKeepDrawCardBtn))
	self.m_clickIgnoreMask:addClickListener(handler(self, self._onClickIgnoreMask))
end

function AnniversaryJigsawLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_SIGNDAY, handler(self, self._onS2CAnniversarySignDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_DRAWJIGSAW, handler(self, self._onS2CAnniversaryDrawJigsaw), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETDRAWNUMAWARD, handler(self, self._onS2CAnniversaryGetDrawNumAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTOTALSCOREAWARD, handler(self, self.onS2CAnniversaryGetTotalScoreAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD, handler(self, self.onS2CAnniversaryGetJigsawGroupAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	self:_updateMainView()
end

function AnniversaryJigsawLayer:_updateMainView()
	self.m_cumulativeComp:updateCumulativeComp()
	self.m_signComp:updateSignComp()
	self.m_bigAwardComp:updateBigAward()
	self:_updateJigsawGroupInfo()
	self:_updateRecruitBtn()
end

function AnniversaryJigsawLayer:_updateJigsawGroupInfo()
	for iter_6_0 = 1, var_0_0.JIGSAW_GROUP_NUM do
		self["m_group" .. iter_6_0]:updateJigsawComp(iter_6_0)
	end
end

function AnniversaryJigsawLayer:_checkCanGetSignAward()
	if var_0_1:getCurSignDay() ~= var_0_1:getAwardSignDays() then
		g.core.network.GameNetProxy:send_C2S_Anniversary_SignDay({})
	else
		self:checkGetGroupAward()
	end
end

function AnniversaryJigsawLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "FLY_TO_SHARE_BTN" then
		self:flyStarToShareBtn(arg_8_2.jigsawId)
	elseif arg_8_1 == "GET_DRAW_NUM_AWARD" then
		g.core.network.GameNetProxy:send_C2S_Anniversary_GetDrawNumAward({
			id = arg_8_2.cumulativeId
		})
	elseif arg_8_1 == "CHECK_CAN_AWARD_GROUP" then
		self:checkGetGroupAward()
	end
end

function AnniversaryJigsawLayer:_onS2CAnniversarySignDay(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not arg_9_4.awards then
		if arg_9_4.extra_awards then
			local var_9_0 = require("app.view.module.anniversary.view.jigsaw.AnniversarySignAwardPop").new
			local var_9_1 = {}

			var_9_1.data = arg_9_4
			var_9_1.callback = handler(self, self.closeSignAwardCallBack)

			g.core.module.ModuleManager:pushPopup((require("app.view.module.anniversary.view.jigsaw.AnniversarySignAwardPop").new(var_9_1)))

			goto label_9_0
		end
	end

	self:checkGetGroupAward()

	::label_9_0::
end

function AnniversaryJigsawLayer:closeSignAwardCallBack()
	local var_10_0 = var_0_1:getSignAwards()
	local var_10_1 = var_0_1:getCurSignAwardId()

	for iter_10_0 = 1, #var_10_0 do
		if var_10_0[iter_10_0].id == var_10_1 then
			if self.m_signComp:getChild("sign" .. iter_10_0) then
				self.m_signComp:getChild("sign" .. iter_10_0):playGetSignEff()
			end

			self.m_signComp:updateBigState()
		end
	end

	self:checkGetGroupAward()
end

function AnniversaryJigsawLayer:checkGetGroupAward()
	local var_11_0 = var_0_1:getCanGetGroupAward()

	if var_11_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Anniversary_GetJigsawGroupAward({
			group = var_11_0
		})
	end
end

function AnniversaryJigsawLayer:_onS2CAnniversaryDrawJigsaw(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.m_clickIgnoreMask:setVisible(true)

	self._isDrawing = true

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Majiang01_Play)

	self._normalAward = {}

	local var_12_0 = {}

	if arg_12_4.ids then
		if arg_12_4.tp == var_0_0.JIGSAW_DRAW_TP.ONCE then
			var_12_0 = self:createOnceDrawJigsawAction(arg_12_4.ids[1])
		elseif #arg_12_4.ids <= var_0_0.JIGSAW_EFF_LIMIT_TIME then
			for iter_12_0, iter_12_1 in ipairs(arg_12_4.ids) do
				for iter_12_2, iter_12_3 in ipairs((self:createOnceDrawJigsawAction(iter_12_1))) do
					table.insert(var_12_0, iter_12_3)
				end
			end
		end
	end

	if arg_12_4.ids then
		local var_12_1 = false
		local var_12_2 = 0

		for iter_12_4, iter_12_5 in ipairs(arg_12_4.ids) do
			var_12_1, var_12_2 = var_0_1:isCanGetGroupAwardById(iter_12_5)

			if var_12_1 then
				table.insert(var_12_0, (fgui.FSequence:create({
					fgui.FDelayTime:create(1.2),
					fgui.FCallFunc:create(handler(self, function()
						g.core.network.GameNetProxy:send_C2S_Anniversary_GetJigsawGroupAward({
							group = var_12_2
						})
					end))
				})))

				break
			end
		end

		if not arg_12_4.awards then
			return
		end

		local var_12_3 = self:mergeDrawAwards(arg_12_4.awards)

		if var_12_1 then
			self._normalAward = var_12_3
		elseif arg_12_4.awards then
			table.insert(var_12_0, (fgui.FSequence:create({
				fgui.FDelayTime:create(1.2),
				fgui.FCallFunc:create(handler(self, function()
					g.core.module.ModuleManager:awardSummary(var_12_3)
				end))
			})))
		end
	end

	table.insert(var_12_0, (fgui.FCallFunc:create(handler(self, function()
		self.m_clickIgnoreMask:setVisible(false)

		self._isDrawing = false

		self.m_cumulativeComp:updateCumulativeComp()
		self.m_bigAwardComp:updateBigAward()
		self:_updateRecruitBtn()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Majiang01_Stop)
	end))))
	self:runFGAction(fgui.FSequence:create(var_12_0))
end

function AnniversaryJigsawLayer:mergeDrawAwards(arg_16_1)
	local var_16_0 = {}

	for iter_16_0 = 1, #arg_16_1 do
		local var_16_1 = false

		for iter_16_1 = 1, #var_16_0 do
			if var_16_0[iter_16_1].type == arg_16_1[iter_16_0].type and var_16_0[iter_16_1].value == arg_16_1[iter_16_0].value then
				var_16_0[iter_16_1].size = var_16_0[iter_16_1].size + arg_16_1[iter_16_0].size
				var_16_1 = true

				break
			end
		end

		if not var_16_1 then
			table.insert(var_16_0, arg_16_1[iter_16_0])
		end
	end

	return var_16_0
end

function AnniversaryJigsawLayer:_randomJigsawComp()
	local var_17_0 = {}

	for iter_17_0 = 1, math.random(var_0_0.JIGSAW_RANDOM.MIN, var_0_0.JIGSAW_RANDOM.MAX) do
		table.insert(var_17_0, (self:getJigsawCompById((var_0_1:getJigsawIdByPos(math.random(1, var_0_0.JIGSAW_GROUP_NUM), (math.random(1, var_0_0.JIGSAW_LEN_NUM)))))))
	end

	return var_17_0
end

function AnniversaryJigsawLayer:createOnceDrawJigsawAction(arg_18_1)
	local var_18_0 = 0.1
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs((self:_randomJigsawComp())) do
		table.insert(var_18_1, fgui.FSequence:create({
			fgui.FCallFunc:create(handler(self, function()
				iter_18_1:playScrollEff(var_18_0)
			end)),
			fgui.FDelayTime:create(0.1)
		}))
	end

	table.insert(var_18_1, (fgui.FCallFunc:create(handler(self, function()
		local var_20_0 = var_0_1:getJigsawPosById(arg_18_1)

		if self["m_group" .. var_20_0.x - 1] then
			self["m_group" .. var_20_0.x - 1]:setSortingOrder(0)
		end

		if self["m_group" .. var_20_0.x + 1] then
			self["m_group" .. var_20_0.x + 1]:setSortingOrder(0)
		end

		self["m_group" .. var_20_0.x]:setSortingOrder(var_0_0.JIGSAW_TOP_ORDER)
		self:getJigsawCompById(arg_18_1):playFinallyEff()
	end))))

	return var_18_1
end

function AnniversaryJigsawLayer:getJigsawCompById(arg_21_1)
	local var_21_0 = var_0_1:getJigsawPosById(arg_21_1)

	return (self["m_group" .. var_21_0.x]:getChild("mahjong" .. var_21_0.y))
end

function AnniversaryJigsawLayer:_onS2CAnniversaryGetDrawNumAward(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_22_4.awards, true)
	end

	self.m_cumulativeComp:updateCumulativeComp()
end

function AnniversaryJigsawLayer:onS2CAnniversaryGetJigsawGroupAward(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_4.group and self._normalAward then
		local var_23_0 = {}

		table.merge(var_23_0, self._normalAward)

		if arg_23_4.awards then
			table.merge(var_23_0, arg_23_4.awards)
		end

		self["m_group" .. arg_23_4.group]:playGetGroupAwardEff(var_23_0)

		self._normalAward = {}
	end
end

function AnniversaryJigsawLayer:onS2CAnniversaryGetTotalScoreAward(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_24_4.awards)
	end

	self.m_bigAwardComp:updateBigAward()
end

function AnniversaryJigsawLayer:_updateRecruitBtn()
	self.m_drawCardBtn:updateBtn()
	self.m_keepDrawCardBtn:updateBtn()
end

function AnniversaryJigsawLayer:_onClickShareBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.anniversary.view.jigsaw.AnniversarySharePop").new()))
end

function AnniversaryJigsawLayer:_isCanDraw()
	local var_27_0 = var_0_1:getAnniversaryInfo()
	local var_27_1 = var_0_2:getOwnNum(var_27_0.recruited_type, var_27_0.recruited_value)

	if var_27_1 < var_27_0.recruited_size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_27_0.recruited_type,
			value = var_27_0.recruited_value,
			size = var_27_1
		})

		return false
	end

	return true
end

function AnniversaryJigsawLayer:_onClickDrawCardBtn()
	if self._isDrawing or not self:_isCanDraw() then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Anniversary_DrawJigsaw({
		tp = var_0_0.JIGSAW_DRAW_TP.ONCE
	})
end

function AnniversaryJigsawLayer:_onClickKeepDrawCardBtn()
	if self._isDrawing or not self:_isCanDraw() then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Anniversary_DrawJigsaw({
		tp = var_0_0.JIGSAW_DRAW_TP.KEEP
	})
end

function AnniversaryJigsawLayer:_onClickIgnoreMask()
	g.core.module.ModuleManager:tip(g.core.lang:get(426022))
end

function AnniversaryJigsawLayer:flyStarToShareBtn(arg_31_1)
	local var_31_0 = self:globalToLocal(self:getJigsawCompById(arg_31_1):localToGlobal(cc.p(0, 0)))
	local var_31_1 = self:globalToLocal(self.m_shareBtn:localToGlobal(cc.p(0, 0)))

	self.m_effFly:setPosition(var_31_0)
	self.m_effFly:setRotation(-require("app.core.utils.KsMath"):calculateRotation(var_31_1) + 90)
	self.m_effFly:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = "eff_ui_anniversaryJigsaw_flystar"
	})
	self.m_effFly:runFGAction((fgui.FSequence:create(fgui.FMoveTo:create(var_0_0.JIGSAW_MOVE_SPEED * (math.sqrt(math.pow(math.abs(var_31_0.x - var_31_1.x), 2) + math.pow(math.abs(var_31_0.y - var_31_1.y), 2)) / var_0_0.JIGSAW_LINE_DISTANCE), var_31_1), fgui.FCallFunc:create(handler(self, function()
		self.m_effFly:removeAllEffect()
		self.m_shareBtn:addEffectSpine({
			isLoop = false,
			anim = "play",
			remove = true,
			name = (var_0_1:getActivityId() > 1 or nil) and "eff_ui_anniversaryJigsaw_sharebtn" .. var_0_1:getAnniversaryInfo().file_type,
			x = self.m_shareBtn:getWidth() / 2,
			y = self.m_shareBtn:getHeight() / 2
		})
	end)))))
end

function AnniversaryJigsawLayer:_onCrossDay()
	if var_0_1:getCurStage() ~= var_0_0.STAGE.GAME then
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end
end

return AnniversaryJigsawLayer
