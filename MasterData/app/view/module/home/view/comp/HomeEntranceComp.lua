local var_0_0 = g.core.model.User.AuctionData
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.config.dungeon_chapter_info
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local HomeBottomActivityCollect = require("app.view.module.home.common.HomeBottomActivityCollect")
local var_0_5 = g.core.common.ModuleUnlock
local HomeModuleBtnCfg = require("app.view.module.home.const.HomeModuleBtnCfg")
local var_0_7 = g.core.config.expirable_item_info
local HomeEntranceComp = class("HomeEntranceComp", require("app.fairyGUI.home.UI_HomeEntranceComp"))

function HomeEntranceComp:ctor()
	self._auctionSchedule = nil

	local var_1_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_1_0.x > 0 then
		self:setWidth(self:getWidth() - var_1_0.x)
	end

	self:_initBtn()
	self.m_homelandRedPointComp:initComp()

	self._bottomActivityData = {}

	self.m_h5ActivityList:setVirtual()
	self.m_h5ActivityList:setItemRenderer(handler(self, self._onH5ActivityRenderer))
end

function HomeEntranceComp:onLoad()
	self:updateBtn()
	self:updateDungeonCurChapter()
	self.m_homelandRedPointComp:updateComp()
	self:onUpdateBottomInfoView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_knightBagBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lineUpBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_uniteTokenBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_homeLandBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_campaignBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_guildBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_petBagBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bagBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_dungeonBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_auctionBtn
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, handler(self, self._onQuarterMinuteUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_H5_ACTIVITY_GETINFO, handler(self, self.onUpdateBottomInfoView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, handler(self, self.updateBtn), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self.updateBtn), self)
end

function HomeEntranceComp:_initBtn()
	local var_3_0 = {
		[var_0_3.HOME_LAND_MAIN] = self.m_homeLandBtn,
		[var_0_3.GUILD] = self.m_guildBtn,
		[var_0_3.KNIGHT_LINE_UP_1] = self.m_lineUpBtn,
		[var_0_3.KNIGHT_BAG] = self.m_knightBagBtn,
		[var_0_3.UNITE_TOKEN] = self.m_uniteTokenBtn,
		[var_0_3.BAG] = self.m_bagBtn,
		[var_0_3.PVP_MAIN] = self.m_campaignBtn,
		[var_0_3.DUNGEON_SWEEPING_1] = self.m_dungeonBtn,
		[var_0_3.PEI_ZI] = self.m_petBagBtn
	}

	for iter_3_0, iter_3_1 in pairs(HomeModuleBtnCfg.ENTRANCE_BTN_CFG) do
		if var_3_0[iter_3_0] then
			fgui.UIPackage.bindUIComponent(var_3_0[iter_3_0], "app.view.module.home.view.comp.HomeModuleBtn", self)
			var_3_0[iter_3_0]:updateFunctionId(iter_3_0)
			var_3_0[iter_3_0]:updateBtnCfg(iter_3_1)
		end
	end

	self._btnCfg = var_3_0

	self.m_dungeonBtn:setSound()
	self.m_auctionBtn:addClickListener(handler(self, self._onAuctionActivityBtnClick))
end

function HomeEntranceComp:_onAuctionActivityBtnClick()
	if var_0_5:isModuleUnlock(var_0_3.AUCTION_COMPANY) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.AUCTION)
		var_0_0:setActSaveInfo()
	end
end

function HomeEntranceComp:updateBtn()
	for iter_5_0, iter_5_1 in pairs(self._btnCfg) do
		iter_5_1:updateBtnCfg()

		if iter_5_0 == var_0_3.BAG then
			local var_5_0 = 0
			local var_5_1 = g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.EXPIRABLE_ITEM)

			for iter_5_2 = 1, #var_5_1 do
				if var_0_7.get(var_5_1[iter_5_2].base_id).item_type == 1 and g.core.common.ServerTime:getLeftSeconds(var_5_1[iter_5_2].expire_time) > 0 then
					var_5_0 = 1

					break
				end
			end

			iter_5_1:setDiscountTick(var_5_0)

			if var_5_0 == 1 then
				iter_5_1.m_specialRedLoader:setVisible(false)

				if iter_5_1.m_specialRedTxt then
					iter_5_1.m_specialRedTxt:setVisible(false)
				end
			end
		end
	end

	if var_0_5:isModuleUnlock(var_0_3.AUCTION_COMPANY) then
		self:onUpdateAuctionBtn()
	else
		self.m_auctionBtn:setVisible(false)
	end
end

function HomeEntranceComp:onUpdateAuctionBtn()
	local var_6_0 = var_0_0:getIsHaveGoods()

	self.m_auctionBtn:setVisible(var_6_0)

	if var_6_0 and var_0_0:getAuctionTime() > 0 then
		self.m_auctionBtn:getChild("time"):setVisible(true)

		if not self._auctionSchedule then
			self._auctionSchedule = self:newSchedule(handler(self, self._onUpdateAuctionTime), 1)

			self:_onUpdateAuctionTime()
		end
	end
end

function HomeEntranceComp:_onUpdateAuctionTime()
	local var_7_0 = var_0_0:getAuctionTime()

	if var_7_0 > 0 then
		self.m_auctionBtn:getChild("time"):setText(var_0_1:_secondToString(var_7_0))
	else
		if self._auctionSchedule then
			self:cancelSchedule(self._auctionSchedule)

			self._auctionSchedule = nil
		end

		self.m_auctionBtn:setVisible(false)
	end
end

function HomeEntranceComp:updateDungeonCurChapter()
	local var_8_0 = var_0_2.get((g.core.model.User.dungeonData:getLastUnlockChapter()))

	self.m_dungeonBtn:setTitle(var_8_0.name .. " " .. var_8_0.land_id .. "-" .. var_8_0.id)

	local var_8_1 = g.core.model.User.bioData:isBioChapterNew()

	self.m_newBioBubbleComp:setVisible(var_8_1)

	if var_8_1 then
		self.m_newBioBubbleComp:getTransition("enter"):play()

		local var_8_2 = self.m_newBioBubbleComp:getChild("eff")

		var_8_2:removeAllEffect()

		self._spine = var_8_2:addEffectSpine({
			anim = "play",
			name = "eff_ui_baseNew_bubble",
			isLoop = false,
			eventHandler = handler(self, self._onSpineEnd)
		})
	end
end

function HomeEntranceComp:_onSpineEnd(arg_9_1, arg_9_2)
	if arg_9_1.type == "complete" and self._spine then
		self._spine:setAnimation(0, "play2", true)
	end
end

function HomeEntranceComp:onUpdateBottomInfoView()
	self._bottomActivityData = HomeBottomActivityCollect.calHomeBottomShowActivitys()

	self.m_h5ActivityList:setNumItems(#self._bottomActivityData)
end

function HomeEntranceComp:_onH5ActivityRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateH5Btn(self._bottomActivityData[arg_11_1 + 1])
end

function HomeEntranceComp:_onQuarterMinuteUpdate()
	self:onUpdateBottomInfoView()

	if var_0_5:isModuleUnlock(var_0_3.AUCTION_COMPANY) then
		g.core.network.GameNetProxy:send_C2S_Auction_GetInfo({})
	end
end

return HomeEntranceComp
