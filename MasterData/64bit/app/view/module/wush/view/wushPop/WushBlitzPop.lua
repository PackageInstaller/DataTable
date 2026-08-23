local WushBlitzPop = class("WushBlitzPop", require("app.fairyGUI.wush.UI_WushBlitzPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/wush/wush",
		resName = "WushBlitzPop",
		pkgName = "wush"
	})
end)
local var_0_1 = g.core.config.dead_battle_floor_info

function WushBlitzPop:ctor(arg_2_1)
	self._numCell = 0
	self._curNumCell = 0
	self._addStar = 0
	self._isFinish = false
	self._blitzData = {}
	self._delayTime = 0.4
	self._setTime = 0.4

	if arg_2_1 then
		self._boxData = arg_2_1.boxData or nil
	end

	if arg_2_1 then
		self._dropType = arg_2_1.dropType or {}
	end

	if arg_2_1 then
		self._floorId = arg_2_1.floorId or 1
	end

	if arg_2_1 then
		self._endFloorId = arg_2_1.endFloorId or 1
	end

	if arg_2_1 then
		self._isBoss = arg_2_1.isBoss or false
	end

	if arg_2_1 then
		self._isOnceWipeOut = arg_2_1.isOnceWipeOut or false
	end

	if arg_2_1 then
		self._allAddstar = arg_2_1.allAddstar or 0
	end

	if arg_2_1 then
		self._floorStar = arg_2_1.floor_star or {}
	end

	self.m_clickLoader:setSize(display.width, display.height)
	self.m_btnComp:setTouchable(false)
	self.m_btnComp:addClickListener(handler(self, self._onClickClose))
	self.m_clickLoader:addClickListener(handler(self, self._onClickClose))
	self.m_bgPanel:setCloseBtnShow(false)
	self:getView():center(true)

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.awards or {}
	end

	self._numCell = #var_2_0 + 1

	self:_formatBlitzData(var_2_0)
	self:_updateList()
end

function WushBlitzPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DISPLAY_CLICK_PREVIEW, self._onClickPreview, self)
	self:onScheduleUpdate()
end

function WushBlitzPop:_onClickPreview(arg_4_1, arg_4_2)
	if arg_4_2:getTarget() == self.m_btnComp then
		return
	end

	if self._curNumCell <= self._numCell and self._delayTime == self._setTime then
		self._delayTime = 0.4
	end
end

function WushBlitzPop:_formatBlitzData(arg_5_1)
	self._blitzData = {}

	for iter_5_0 = 1, #arg_5_1 do
		self._blitzData[1] = arg_5_1[iter_5_0].award
	end
end

function WushBlitzPop:_updateList()
	self.m_blitzList:setItemIniter(function(arg_7_0, arg_7_1)
		if arg_7_0 == fgui.UIPackage:normalizeURL("ui://wush/WushBlitzBoxCell") then
			arg_7_1:bindLua("app.view.module.wush.view.uiComp.WushBlitzBoxCell")
		else
			arg_7_1:bindLua("app.view.module.wush.view.uiComp.WushBlitzCell")
		end
	end)
	self.m_blitzList:setItemRenderer(function(arg_8_0, arg_8_1)
		if arg_8_0 + 1 == self._numCell then
			if self._boxData then
				local var_8_0 = g.core.model.User.wushData:getAddedStar()

				if self._isOnceWipeOut then
					arg_8_1:update({
						data = self._boxData,
						floorId = self._floorId,
						allAddstar = self._allAddstar,
						star = var_8_0,
						accelerate = self._delayTime ~= self._setTime
					})
				else
					arg_8_1:update({
						data = self._boxData,
						floorId = self._floorId,
						star = var_8_0,
						accelerate = self._delayTime ~= self._setTime
					})
				end
			end
		else
			local var_8_1 = var_0_1.get(self._floorId)
			local var_8_2 = 0

			var_8_2 = self._isOnceWipeOut and arg_8_0 + var_8_1["stage" .. g.core.model.User.wushData:getBlitzStageIndex() + 1] or self._isBoss and var_8_1.stage1 or var_8_1["stage" .. arg_8_0 + g.core.model.User.wushData:getBlitzStageIndex() + 1]

			arg_8_1:update({
				award = self._blitzData[arg_8_0 + 1],
				stageId = var_8_2,
				dropType = self._dropType[arg_8_0 + 1],
				accelerate = self._delayTime ~= self._setTime
			})
		end
	end)
end

function WushBlitzPop:onScheduleUpdate(arg_9_1, arg_9_2)
	self._curNumCell = self._curNumCell + 1

	if self._curNumCell > self._numCell then
		self:unscheduleUpdate()
		self.m_btnComp:setTouchable(true)

		self._isFinish = true
	elseif self._curNumCell == self._numCell then
		self.m_blitzList:animationAddCell("ui://wush/WushBlitzBoxCell")
		self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(self._delayTime), fgui.FCallFunc:create(handler(self, self.onScheduleUpdate))))
	else
		self.m_blitzList:animationAddCell("ui://wush/WushBlitzCell")
		self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(self._delayTime), fgui.FCallFunc:create(handler(self, self.onScheduleUpdate))))
	end
end

function WushBlitzPop:_onClickClose()
	if self._isOnceWipeOut then
		self:dispatchCompEvent("ONCE_BLITZ_FINISH", {
			endFloorId = self._endFloorId,
			floor_star = self._floorStar
		})
	elseif self._boxData == nil then
		self:dispatchCompEvent("BLITZ_FINISH", {
			isNextFloor = false
		})
	else
		self:dispatchCompEvent("BLITZ_FINISH", {
			isNextFloor = true
		})
	end
end

return WushBlitzPop
