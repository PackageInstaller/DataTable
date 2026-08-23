local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.InfoConst
local var_0_2 = g.core.const.ConstMgr.DungeonConst
local DungeonCommonInteractComp = class("DungeonCommonInteractComp", require("app.fairyGUI.dungeon.UI_DungeonCommonInteractComp"))

function DungeonCommonInteractComp:ctor()
	self._posInfo = {}
	self._interactCfgInfo = {}
	self._interactType = nil
	self._effectNode = nil

	self:addClickListener(handler(self, self._onClick))
end

function DungeonCommonInteractComp:onLoad()
	return
end

function DungeonCommonInteractComp:updateComp(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._posInfo = arg_3_1.posInfo or {}
	self._interactCfgInfo = arg_3_1.cfgInfo or {}
	self._interactType = self._interactCfgInfo.type

	self:setName("commonInteractComp" .. self._interactCfgInfo.id)
	self:setIcon((g.core.common.Path:getDungeonInteractResByType(self._interactType)))
end

function DungeonCommonInteractComp:_onClick()
	if self._interactType == var_0_2.INTERACT_TYPE.INTERACT_SCAN_FULL_SCENE then
		self:dispatchCompEvent("DUNGEON_SCAN_FULL_SCENE")
	elseif self._interactType == var_0_2.INTERACT_TYPE.INTERACT_INFO_REMIND then
		self:_showInfoPop()
	elseif self._interactType == var_0_2.INTERACT_TYPE.INTERACT_VIDEO then
		self:_showMovie()
	end
end

function DungeonCommonInteractComp:_showInfoPop()
	local var_5_0 = {
		title = "",
		typeValue = self._interactCfgInfo.pop_type,
		desc = self._interactCfgInfo.des
	}

	if self._interactCfgInfo.pop_type ~= 0 then
		if self._interactCfgInfo.pop_type == var_0_1.InfoTipPopType.BASE_TIP then
			var_5_0.title = self._interactCfgInfo.res
		elseif self._interactCfgInfo.pop_type == var_0_1.InfoTipPopType.PAPER_TIP then
			var_5_0.title = ""
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoFullTipPop").new(var_5_0), {
			touchDisappear = true,
			hideContinue = false
		})
	end
end

function DungeonCommonInteractComp:_showMovie()
	if self._interactCfgInfo.movie ~= "" then
		local var_6_0 = string.split(self._interactCfgInfo.movie, ".")

		if var_6_0 and var_6_0[1] then
			local var_6_1

			if not cc.FileUtils:getInstance():isFileExist("movie/" .. "pv" .. "/" .. var_6_0[1] .. ".usm") then
				g.core.module.ModuleManager:tip(g.core.lang:get(300036, {
					name = var_6_0[1]
				}))

				do return end

				var_6_1 = require("app.view.module.login.view.PvPlayLayer").new
			end

			g.core.module.ModuleManager:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
				pvName = var_6_0[1],
				bgPVSound = var_0_0.SoundConst.BGM.MUSIC_BATTLE_PVP
			}))
		end
	end
end

return DungeonCommonInteractComp
