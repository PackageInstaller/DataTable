local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local KnightSkinComp = class("KnightSkinComp", require("app.fairyGUI.knight.UI_KnightSkinComp"))
local var_0_2 = g.core.model.User.skinData
local var_0_3 = g.core.model.User.skinGoodsData
local var_0_4 = g.core.model.User
local var_0_5 = g.core.common.Path

function KnightSkinComp:ctor()
	self._showData = nil
	self._knightStruct = nil

	self.m_bgLoader:setURL("pic/base_new/bg_yht_hz_right.png")
	self:addListen(self.m_skinList)
	self.m_operationBtn:addClickListener(handler(self, self._onClickOperation))
	self.m_attrGroup:setVisible(false)
end

function KnightSkinComp:initSkinList(arg_2_1)
	self.m_skinList:initComp({
		skinList = arg_2_1.skinList,
		knightStruct = arg_2_1.knightStruct
	})
end

function KnightSkinComp:updateComp(arg_3_1)
	local var_3_0 = arg_3_1.baseInfo or {}

	self._showData = arg_3_1.showData or {}
	self._knightStruct = arg_3_1.knightStruct

	local var_3_1 = ""
	local var_3_2 = 1

	if self._showData.knightInfo then
		var_3_1 = self._knightStruct:isMain() and var_0_4:getName() or self._showData.knightInfo.name
		var_3_2 = self._knightStruct:getQuality()

		self.m_attrGroup:setVisible(false)
	elseif self._showData.skinInfo then
		var_3_1 = self._showData.skinInfo.name
		var_3_2 = self._showData.skinInfo.quality

		self.m_attrGroup:setVisible(true)
	end

	self.m_skinNameText:setText(var_3_1)
	self.m_knightNameTxt:setText(var_3_0.name, true)
	self.m_knightQualityLoader:setURL(var_0_5:getQualityArtTxtURL(var_3_2))
	self.m_qualityLoader:setURL((var_0_5:getUserIconQualityStarBg(var_3_2)))
	self.m_groupLoader:setURL(var_0_5:getCampURL(self._knightStruct:getGroup(), 1))
	self:_updateBtnState()
end

function KnightSkinComp:_updateBtnState()
	if self._knightStruct and self._showData then
		local var_4_0 = var_0_2:getSkinAllStateForOwnKnight(self._knightStruct, self._showData)

		self.m_stateController:setSelectedIndex(var_4_0)

		local var_4_1 = ""

		if self._showData.skinInfo then
			local var_4_3

			var_4_1, var_4_3 = var_0_3:getSkinTalentSkillBySkinId(self._showData.skinInfo.id)

			if var_4_3 ~= "" then
				var_4_1 = var_4_1 .. "\n" .. var_4_3
			end
		end

		self.m_attrTxt:setText(var_4_1)

		if var_4_0 == 4 or var_4_0 == 5 then
			self.m_activeStatusController:setSelectedIndex(1)
		else
			self.m_activeStatusController:setSelectedIndex(0)
		end
	end
end

function KnightSkinComp:scrollStart()
	self.m_skinList:scrollStart()
end

function KnightSkinComp:_onClickOperation()
	local var_6_0 = self.m_stateController:getSelectedIndex()

	if var_6_0 == 0 then
		g.core.network.GameNetProxy:send_C2S_Skin_TakeOff({
			advance_id = self._showData.knightInfo.advance_id
		})
		KnightVoiceCommon.playVoice({
			voiceType = "skin_sound",
			knightId = self._showData.knightInfo.advance_id
		})
	elseif var_6_0 == 2 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN,
			selectedContentSkinId = self._showData.skinInfo.id
		})
	elseif var_6_0 == 5 then
		g.core.network.GameNetProxy:send_C2S_Skin_Wear({
			book_id = self._showData.skinInfo.id
		})
	elseif var_6_0 == 6 then
		if not self._knightStruct:isOwn() then
			g.core.module.ModuleManager:tip(g.core.lang:get(412027))

			return
		end

		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WEDDING_VOW, nil) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
				advance_id = self._knightStruct:getAdvanceId()
			})
		end
	end
end

function KnightSkinComp:receiveCompEvent(arg_7_1)
	if arg_7_1 == "SKIN_TIME_END" then
		self:_updateBtnState()
	end
end

return KnightSkinComp
