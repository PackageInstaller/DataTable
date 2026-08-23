local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User
local var_0_3 = g.core.model.User.skinGoodsData
local KnightSkinBookShowComp = class("KnightSkinBookShowComp", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookShowComp"))

function KnightSkinBookShowComp:ctor()
	self._info = nil
	self._skinGoodData = nil
	self._canBuy = false

	self.m_knightNameTxt:enableRich()
	self:addListen(self.m_skinList)
	self.m_operationBtn:addClickListener(handler(self, self._onClickOperation))
end

function KnightSkinBookShowComp:initSkinList(arg_2_1)
	self.m_skinList:initComp({
		skinBookList = arg_2_1.skinBookList,
		knight = arg_2_1.knight,
		curSkin = arg_2_1.curSkin
	})
end

function KnightSkinBookShowComp:updateComp(arg_3_1)
	local var_3_0 = arg_3_1.baseInfo or {}

	self._info = arg_3_1.info or {}

	self.m_skinNameText:setText(self._info.name)
	self.m_knightNameTxt:setText(var_3_0.name, true)
	self.m_knightQualityLoader:setURL(var_0_1:getQualityArtTxtURL(self._info.quality))
	self.m_qualityLoader:setURL((var_0_1:getUserIconQualityStarBg(self._info.quality)))
	self.m_groupLoader:setURL(var_0_1:getCampURL(arg_3_1.knight:getGroup(), 1))
	self:_updateBtnState()
end

function KnightSkinBookShowComp:scrollStart()
	self.m_skinList:scrollStart()
end

function KnightSkinBookShowComp:_onClickOperation()
	local var_5_0 = self.m_stateController:getSelectedIndex()

	if var_5_0 == 0 then
		g.core.module.ModuleManager:popToRootAndPush(g.view.entrance.RECHARGE, {
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN,
			selectedContentSkinId = self._info.id
		})
	elseif var_5_0 == 1 then
		if self._info then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_KNIGHT,
				value = self._info.knight_advance_id
			})
		end
	elseif var_5_0 == 4 then
		g.core.network.GameNetProxy:send_C2S_Skin_Wear({
			book_id = self._info.id
		})
	elseif var_5_0 == 5 then
		if not g.core.model.User.knightsData:getKnight({
			advance_id = self._info.knight_advance_id
		}):isOwn() then
			g.core.module.ModuleManager:tip(g.core.lang:get(412027))

			return
		end

		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WEDDING_VOW, nil) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
				advance_id = self._info.knight_advance_id
			})
		end
	end
end

function KnightSkinBookShowComp:_updateBtnState()
	if self._info and self._info.id then
		local var_6_0 = var_0_2.skinData:getSkinAllStateAtSkinShop(self._info.id)

		self.m_stateController:setSelectedIndex(var_6_0)

		local var_6_1, var_6_2 = var_0_3:getSkinTalentSkillBySkinId(self._info.id)

		self.m_attrTxt:setText((var_6_2 ~= "" or nil) and var_6_1 .. "\n" .. var_6_2)

		if var_6_0 == 1 or var_6_0 == 3 or var_6_0 == 4 then
			self.m_activeStatusController:setSelectedIndex(1)
		else
			self.m_activeStatusController:setSelectedIndex(0)
		end
	end
end

function KnightSkinBookShowComp:receiveCompEvent(arg_7_1)
	if arg_7_1 == "SKIN_TIME_END" then
		self:_updateBtnState()
	end
end

return KnightSkinBookShowComp
