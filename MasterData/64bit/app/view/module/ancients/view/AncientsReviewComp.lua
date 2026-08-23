local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.knightsData
local DrawKnight = require("app.view.common.DrawKnight")
local AncientsReviewComp = class("AncientsReviewComp", require("app.fairyGUI.ancients.UI_AncientsReviewComp"))

function AncientsReviewComp:ctor()
	self._rankUnits = {}

	self.m_Btn_shop:addClickListener(handler(self, self._onClickShopBtn))
	self.m_Btn_rank:addClickListener(handler(self, self._onClickRankBtn))
	self.m_Btn_guess:addClickListener(handler(self, self._onClickGuessBtn))
	self:setVisible(false)

	self._isEnterTrans = false
end

function AncientsReviewComp:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Btn_guess
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALRANKLIST, handler(self, self._onGetFinalRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetUserSnapShot), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetFinalRankList({})
end

function AncientsReviewComp:updateComp()
	local var_3_0 = 0
	local var_3_1

	for iter_3_0 = 1, 4 do
		local var_3_2 = self["m_rank" .. iter_3_0]
		local var_3_3 = self["m_userHeadComp" .. iter_3_0]
		local var_3_4

		if self._rankUnits[iter_3_0] then
			var_3_4 = g.core.common.GlobalFunc.rankUnit_param(self._rankUnits[iter_3_0].param, "AncientFinalRankUnit", true)
		end

		if var_3_4 then
			local var_3_5 = var_3_4.captain or 0

			if var_3_5 > 0 then
				local var_3_6 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_3_5)

				if var_3_6 then
					var_3_0 = var_3_0 + 1

					if iter_3_0 == 1 then
						var_3_1 = var_3_6
					end

					var_3_2:updateUserInfo(var_3_6)
					var_3_3:updateAsUser(var_3_6)
				end

				goto label_3_0
			end
		end

		var_3_2:setVisible(false)
		var_3_3:setVisible(false)

		::label_3_0::
	end

	self.m_knightSpineDad:removeChildren()

	if var_3_1 then
		self.m_userName:setText(var_3_1.name)

		local var_3_7 = var_3_1.show_knight_id or 0
		local var_3_8

		if var_3_7 < 1 then
			var_3_7 = var_3_1.base_id
			var_3_8 = {
				isShowBg = true
			}
		end

		var_3_8.resId = var_0_2:getKnightResInfo({
			knightId = var_3_7,
			skinId = var_3_1.show_knight_dress
		}).painted_id

		self.m_knightSpineDad:addChild((DrawKnight.new(var_3_8)))
	end

	if var_3_0 == #self._rankUnits or var_3_0 == 4 then
		self:setVisible(true)

		if #self._rankUnits == 0 then
			self:getChild("n23"):setVisible(false)
		end

		if not self._isEnterTrans then
			self._isEnterTrans = true

			self.m_enterTransition:play()
		end
	end
end

function AncientsReviewComp:_onClickGuessBtn()
	var_0_1:pushModule(g.view.entrance.ANCIENTS_GUESS_POP)
end

function AncientsReviewComp:_onClickRankBtn()
	var_0_1:pushModule(g.view.entrance.ANCIENTS_FINAL_RANK_LAYER)
end

function AncientsReviewComp:_onClickShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.ShopConst.SHOP_TYPE.ANCIENTS
	})
end

function AncientsReviewComp:_onGetFinalRankList(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._rankUnits = arg_7_4.rank_units or {}

	self:updateComp()
end

function AncientsReviewComp:_onGetUserSnapShot()
	self:updateComp()
end

return AncientsReviewComp
