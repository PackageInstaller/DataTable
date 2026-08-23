local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.dress_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.common.Path
local BaseUserIconNew = class("BaseUserIconNew", require("app.fairyGUI.base_new.UI_BaseUserIcon"))

function BaseUserIconNew:ctor()
	self._robotKnights = nil
	self._robotName = ""
	self._userSnapshot = nil

	self:addClickListener(handler(self, self._onClickIcon))

	local var_1_0 = self:getController("button")

	if var_1_0 then
		var_1_0:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	end
end

function BaseUserIconNew:updateAsUser(arg_2_1)
	self._userSnapshot = arg_2_1

	if not arg_2_1 then
		self.m_emptyController:setSelectedIndex(1)

		return
	end

	self.m_emptyController:setSelectedIndex(0)

	self._overrideClick = arg_2_1.overrideClick or false
	self._touchFunc = arg_2_1.touchFunc or self._touchFunc

	local var_2_0 = arg_2_1.hideLevel or false
	local var_2_1 = arg_2_1.hideName or false
	local var_2_2

	self._robotName = ""
	self._monsterShowId = nil

	local var_2_3, var_2_4 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_2_1)

	if var_2_3 then
		self._robotName = var_2_4.robotName
		self._robotKnights = var_2_4.robotKnights
		self._monsterShowId = var_2_4.showId
		var_2_2 = var_2_4.resId == nil and var_0_0.get(var_2_4.showId) or g.core.config.robot_info.get(arg_2_1.base_id)
	else
		self._robotKnights = nil
		var_2_2 = var_0_0.get(arg_2_1.base_id or 210000)
	end

	local var_2_5 = var_0_2.get(var_2_2.res_id).icon_id
	local var_2_6 = 0

	if arg_2_1.dress_id and arg_2_1.dress_id ~= 0 then
		var_2_6 = var_2_2.sex
		var_2_5 = var_0_2.get((var_2_2.sex == 0 or nil) and var_0_1.get(arg_2_1.dress_id).woman_res_id).icon_id
	end

	local var_2_9 = false
	local var_2_10 = arg_2_1.avata_id or 0

	if var_2_10 == 200000 or var_2_10 == 210000 then
		var_2_9 = true
		var_2_5 = var_2_10
	end

	self.m_avataEffNode:setVisible(false)

	if var_2_10 > 0 and not var_2_9 then
		local var_2_11 = g.core.config.avata_info.get(var_2_10)
		local var_2_12 = string.split(var_2_11.res, ",")

		if var_2_11.resEffect ~= "0" then
			self.m_avataEffNode:setVisible(true)
			self.m_avataEffNode:removeAllEffect()
			self.m_avataEffNode:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_2_11.resEffect
			})
			self.m_iconLoader:setVisible(false)
		else
			if #var_2_12 > 1 then
				local var_2_13 = {}

				for iter_2_0, iter_2_1 in ipairs(var_2_12) do
					local var_2_14 = string.split(iter_2_1, "_")

					var_2_13[var_2_14[1]] = var_2_14[2]
				end

				self.m_iconLoader:setURL(var_0_3:getRoleHeadIcon(var_2_13[tostring(var_2_6)]))
			else
				self.m_iconLoader:setURL(var_0_3:getRoleHeadIcon(var_2_11.res))
			end

			self.m_iconLoader:setVisible(true)
		end
	else
		self.m_iconLoader:setURL(var_0_3:getKnightIconById(var_2_5))
		self.m_iconLoader:setVisible(true)
	end

	local var_2_15 = var_2_2.toObject()

	if var_2_15.quality and var_2_15.rare then
		self:setQuality(var_2_2.quality)
	end

	if arg_2_1.level then
		self.m_levelText:setText(g.core.lang:get(109501, {
			level = arg_2_1.level
		}))
	end

	if arg_2_1.name then
		self.m_nameText:setText(arg_2_1.name)
	end

	if var_2_0 then
		self:hideLevel()
	end

	if var_2_1 then
		self:hideName()
	end

	self.m_frameLoader:setVisible(false)
	self.m_effHolder:setVisible(false)

	if arg_2_1.frame_id and arg_2_1.frame_id ~= 0 then
		local var_2_16 = g.core.config.avatar_frame_info.get(arg_2_1.frame_id)

		if var_2_16.resEffect ~= "0" then
			self.m_effHolder:setVisible(true)
			self.m_effHolder:removeAllEffect()
			self.m_effHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_2_16.resEffect
			})
		else
			self.m_frameLoader:setVisible(true)
			self.m_frameLoader:setURL(g.core.common.Path:getRoleHeadFrameIcon(var_2_16.res))
		end
	end
end

function BaseUserIconNew:setTouchCallFunc(arg_3_1)
	self._touchFunc = arg_3_1
end

function BaseUserIconNew:setQuality(arg_4_1)
	if self._quality == arg_4_1 then
		return
	end

	self._quality = arg_4_1
end

function BaseUserIconNew:updateAsSelf()
	self:updateAsUser((g.core.model.User:packUser()))
end

function BaseUserIconNew:hideName()
	self.m_isNameShowController:setSelectedIndex(0)
end

function BaseUserIconNew:hideLevel()
	self.m_isLevelShowController:setSelectedIndex(0)
end

function BaseUserIconNew:hideFrame()
	self.m_frameLoader:setVisible(false)
	self.m_effHolder:setVisible(false)
end

function BaseUserIconNew:hideBgLoader()
	self.m_bgLoader:setVisible(false)
end

function BaseUserIconNew:_onClickIcon(arg_10_1)
	if g.core.battle.BattleProxy:isInBattle() then
		g.core.module.ModuleManager:tip(g.core.lang:get(110061))

		return
	end

	local var_10_0 = {
		y = 0,
		x = 0
	}

	if arg_10_1 then
		local var_10_1 = arg_10_1:getInput():getTouch()

		var_10_0.x = var_10_1:getLocationInView().x
		var_10_0.y = var_10_1:getLocationInView().y
	end

	local var_10_2 = self._userSnapshot

	if self._overrideClick then
		return
	elseif self._touchFunc then
		self:_touchFunc(var_10_2)

		return
	elseif not var_10_2 then
		return
	end

	if g.core.model.User:getId() == var_10_2.id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isSelf = true
		})
	elseif var_10_2.robot_type and var_10_2.robot_type ~= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(2081))
	else
		local var_10_3 = self:_checkAndGetPopInfo(var_10_2)

		var_10_3.clickWorldPos = var_10_0

		self:addPopup(require("app.view.base.infoPop.InfoUserMenuPop").new(var_10_3), {
			isUpdateBlack = false,
			hideContinue = true
		})
	end
end

function BaseUserIconNew:_checkAndGetPopInfo(arg_11_1)
	local var_11_0 = clone(arg_11_1)

	if self._robotKnights then
		var_11_0.knights = self._robotKnights
		var_11_0.name = self._robotName
	end

	var_11_0.knights = self._knights

	if not var_11_0.guild_id or var_11_0.guild_id == 0 then
		var_11_0.guild_id = -1
	end

	if (not var_11_0.show_knight_id or var_11_0.show_knight_id == 0) and self._monsterShowId then
		var_11_0.show_knight_id = self._monsterShowId
	end

	return {
		playerInfo = {
			user = var_11_0
		}
	}
end

function BaseUserIconNew:_onChanged()
	if self._btnChangeFunc then
		self._btnChangeFunc((self.m_buttonController:getSelectedIndex()))
	end
end

function BaseUserIconNew:bindBtnChangeEventFunc(arg_13_1)
	self._btnChangeFunc = arg_13_1
end

function BaseUserIconNew:setOverrideClick(arg_14_1)
	self._overrideClick = arg_14_1
end

function BaseUserIconNew:justSetIcon(arg_15_1)
	self.m_avataEffNode:setVisible(false)
	self.m_avataEffNode:removeAllEffect()
	self.m_iconLoader:setURL(arg_15_1)
	self.m_iconLoader:setVisible(true)
end

return BaseUserIconNew
