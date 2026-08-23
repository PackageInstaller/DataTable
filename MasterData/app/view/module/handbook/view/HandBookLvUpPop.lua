local var_0_0 = g.core.model.User.handBookData
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local HandBookLvUpPop = class("HandBookLvUpPop", require("app.fairyGUI.handBook.UI_HandBookLvUpPop"), function()
	return fgui.GComponent:create({
		resName = "HandBookLvUpPop",
		pkgPath = "ui/handBook/handBook",
		pkgName = "handBook"
	})
end)

function HandBookLvUpPop:ctor(arg_2_1)
	self._showLvUpFeedBack = arg_2_1.showLvUpFeedBack
	self._oldScore = arg_2_1.oldScore

	self:setWidth(display.width)
	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self:updateView(arg_2_1)
end

function HandBookLvUpPop:updateView(arg_3_1)
	local var_3_0 = g.core.model.User.knightsData:getKnightByAdvanceId(arg_3_1.advId)
	local var_3_1 = g.core.config.knight_base_info.get(var_3_0:getBaseInfo().res_id)
	local var_3_2 = g.core.model.User.handBookData:getKnightBookLevel(arg_3_1.advId)

	self.m_knightPicComp:updateKnight({
		scale = 1.1,
		resId = var_3_1.painted_id
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_nameComp:setData(var_3_1)

	if var_3_2 == 0 then
		self.m_stateController:setSelectedIndex(0)

		local var_3_3 = var_0_0:getKnightBookAttr(arg_3_1.advId, var_3_2)

		for iter_3_0 = 1, 5 do
			local var_3_4 = {
				name = var_3_3[iter_3_0].attr[1]
			}

			var_3_4.value = 0
			var_3_4.value2 = var_3_3[iter_3_0].attr[2]
			var_3_4.isAll = var_3_3[iter_3_0].isAll

			self["m_attr" .. iter_3_0]:updateAttr(var_3_4)
		end

		self.m_enter_0Transition:play()

		self._state = 0

		KnightVoiceCommon.playVoice({
			voiceType = "book1_sound",
			knight = var_3_0
		})
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_levelTxt2:setText(var_3_2)
		self.m_levelTxt1:setText(var_3_2 - 1)

		local var_3_5 = var_0_0:getKnightBookAttr(arg_3_1.advId, var_3_2 - 1)
		local var_3_6 = var_0_0:getKnightBookAttr(arg_3_1.advId, var_3_2)

		for iter_3_1 = 1, 5 do
			self["m_attr" .. iter_3_1]:updateAttr({
				name = var_3_5[iter_3_1].attr[1],
				value = var_3_5[iter_3_1].attr[2],
				value2 = var_3_6[iter_3_1].attr[2],
				isAll = var_3_6[iter_3_1].isAll
			})
		end

		self.m_enter_1Transition:play()

		self._state = 1

		self.m_lvUpEffHolder:addEffectSpine({
			remove = true,
			name = "eff_ui_handbook_upgrade",
			isLoop = false
		})
		KnightVoiceCommon.playVoice({
			voiceType = "book2_sound",
			knight = var_3_0
		})
	end
end

function HandBookLvUpPop:uniqueStyleOutTrans(arg_4_1)
	self["m_back_" .. self._state .. "Transition"]:play(arg_4_1)
end

function HandBookLvUpPop:onUnload()
	KnightVoiceCommon.stopVoice()

	if self._showLvUpFeedBack then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				oldScore = self._oldScore
			},
			title = g.core.lang:get(111537),
			showComp = fgui.UIPackage:createObject("handBook", "HandBookLvUpComp")
		}), {
			touchDisappear = true,
			hideContinue = false
		})
	end
end

return HandBookLvUpPop
