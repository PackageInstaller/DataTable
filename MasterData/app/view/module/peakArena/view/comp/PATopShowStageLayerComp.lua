local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.peakArenaData
local var_0_4 = g.core.model.User.knightsData
local DrawKnight = require("app.view.common.DrawKnight")
local PATopShowStageLayerComp = class("PATopShowStageLayerComp", require("app.fairyGUI.peakArena.UI_PATopShowStageLayerComp"))

function PATopShowStageLayerComp:ctor()
	self._rankCompMap = {}

	self.m_scheduleBtn:addClickListener(handler(self, self._onClickScheduleBtn))
	self.m_previousRankingBtn:addClickListener(handler(self, self._onClickPreviousRankingBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecordBtn))
end

function PATopShowStageLayerComp:updateComp()
	local var_2_0 = var_0_3:getGroupStruct(var_0_1.FINAL_GROUP_ID):getUserIdArrSortByRank()

	for iter_2_0 = 1, var_0_1.SHOW_TOP_USER_COUNT do
		local var_2_1 = self["m_rankChest" .. iter_2_0]

		if var_2_0[iter_2_0] and var_2_0[iter_2_0] > 0 then
			local var_2_2 = var_0_3:getUserSnapshotWithId(var_2_0[iter_2_0])

			var_2_1:setVisible(false)

			if var_2_2 then
				self._rankCompMap[var_2_2.id] = {
					rankUserComp = self["m_rank" .. iter_2_0],
					rankChest = var_2_1
				}

				if var_2_2 then
					self["m_rank" .. iter_2_0]:updateUserInfo(var_2_2)

					if var_0_3:isChestActive() then
						local var_2_3 = g.core.model.User:getAllianceId()

						if not var_0_3:isRankAwardRecv(var_2_2.id) and var_2_3 > 0 and var_2_3 == var_2_2.alliance_id then
							var_2_1:updateChest(var_2_2)
							var_2_1:setVisible(true)
						end
					end

					self["m_userHeadComp" .. iter_2_0]:updateAsUser(var_2_2)
				end
			end
		else
			self["m_rank" .. iter_2_0]:setVisible(false)
			var_2_1:setVisible(false)
			self["m_userHeadComp" .. iter_2_0]:setVisible(false)
		end
	end

	self.m_knightSpineDad:removeChildren()

	local var_2_4 = var_0_3:getUserSnapshotWithId(var_2_0[1])

	if var_2_4 then
		self.m_userName:setText(var_2_4.name)

		local var_2_5 = var_2_4.show_knight_id or 0
		local var_2_6

		if var_2_5 < 1 then
			var_2_5 = var_2_4.base_id
			var_2_6 = {
				isShowBg = true
			}
		end

		var_2_6.resId = var_0_4:getKnightResInfo({
			knightId = var_2_5,
			skinId = var_2_4.show_knight_dress
		}).painted_id

		self.m_knightSpineDad:addChild((DrawKnight.new(var_2_6)))
	end
end

function PATopShowStageLayerComp:updateRankAwardView(arg_3_1)
	if self._rankCompMap[arg_3_1] and self._rankCompMap[arg_3_1].rankChest then
		self._rankCompMap[arg_3_1].rankChest:setVisible(false)
	end
end

function PATopShowStageLayerComp:_onClickRankBtn()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaRankLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PATopShowStageLayerComp:_onClickShopBtn()
	var_0_2:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.ShopConst.SHOP_TYPE.PEAK_ARENA
	})
end

function PATopShowStageLayerComp:_onClickPreviousRankingBtn()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaSeasonLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PATopShowStageLayerComp:_onClickScheduleBtn()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaScheduleLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PATopShowStageLayerComp:_onClickRecordBtn()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaMatchRecordLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PATopShowStageLayerComp:playEnterAni()
	self.m_enterTransition:play()
end

return PATopShowStageLayerComp
