local var_0_0 = g.core.model.User.furnitureData
local var_0_1 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local FurnitureMoodsRankCell = class("FurnitureMoodsRankCell", require("app.fairyGUI.furniture.UI_FurnitureMoodsRankCell"))

function FurnitureMoodsRankCell:ctor()
	self._user = nil

	self.m_praiseBtn:addClickListener(handler(self, self._onClickPraiseBtn))
end

function FurnitureMoodsRankCell:onLoad()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_FURNITURE_ROOM_PRAISE, handler(self, self._onRecFurnitureRoomPraise), self)
end

function FurnitureMoodsRankCell:updateCellData(arg_3_1, arg_3_2)
	self.m_haveBgController:setSelectedIndex(arg_3_2 % 2)
	self.m_indexComp:updateRankIndex(arg_3_1)
	self.m_charmTxt:setText(arg_3_1.score)

	self._user = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

	if self._user then
		self.m_headComp:updateAsUser(self._user)
		self.m_headComp:setVisible(true)
		self.m_nameTxt:setText(self._user.name)
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = self._user.level
		}))
	else
		self.m_headComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
	end

	local var_3_0 = var_0_0:getPraiseTimeInfoById(arg_3_1.id)

	self.m_praiseBtn:getController("isPraise"):setSelectedIndex(var_3_0 > 0 and 1 or 0)
	self.m_praiseBtn:setTouchable(var_3_0 == 0)
end

function FurnitureMoodsRankCell:_onRecFurnitureRoomPraise(arg_4_1, arg_4_2, arg_4_3)
	if self._user and self._user.id == arg_4_3.friend_id then
		local var_4_0 = var_0_0:getFriendPraiseData(self._user.id)

		if var_4_0 then
			self.m_charmTxt:setText(var_4_0.sumValue)
			self.m_praiseBtn:getController("isPraise"):setSelectedIndex(var_4_0.time > 0 and 1 or 0)
			self.m_praiseBtn:getTransition("like"):play()
			self.m_praiseBtn:setTouchable(var_4_0.time == 0)
		end
	end
end

function FurnitureMoodsRankCell:_onClickPraiseBtn()
	if table.nums((var_0_0:getPraiseRecord())) >= g.core.config.parameter_info.get(var_0_1.FURNITURE_PARAMETER_MAX).parameter then
		g.core.module.ModuleManager:tip(g.core.lang:get(107082))

		return
	end

	if self._user then
		if self._user.id ~= g.core.model.User:getId() then
			g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Praise({
				num = 1,
				friend_id = self._user.id
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(107081))
		end
	end
end

return FurnitureMoodsRankCell
