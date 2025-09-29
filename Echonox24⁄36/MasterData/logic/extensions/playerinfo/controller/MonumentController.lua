-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/controller/MonumentController.lua

module("logic.extensions.playerinfo.controller.MonumentController", package.seeall)

local M = class("MonumentController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._filterType = nil
	self._refreshedOnEnterPlayInfoMainView = false

	GlobalDispatcher:addEventListener(EventType.ENTER_GAME_REQUEST_OVER_EVENT, self._onEnterGame, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_OPEN, self._onEnterPlayInfoMainView, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_DESTROY, self._onQuitPlayInfoMainView, self)
end

function M:_onEnterPlayInfoMainView()
	if not self._refreshedOnEnterPlayInfoMainView then
		self._refreshedOnEnterPlayInfoMainView = true

		MonumentAgent.instance:sendGetAllCupRequest()
	end
end

function M:_onQuitPlayInfoMainView()
	self._refreshedOnEnterPlayInfoMainView = false
end

function M:_onEnterGame()
	MonumentAgent.instance:sendGetAllCupRequest()
	MonumentUtil.loadMaterials()
end

function M:onReset()
	self._filterType = nil

	MonumentUtil.clear()
end

function M:getMonumentFilterType()
	return self._filterType or CommEnum.MonumentFilterType.All
end

function M:handleGetNewMonument(datas)
	local recordId = Astral.LocalStorage.Instance:GetString("MONUMENT_PLAYER_ID")
	local newCup = Astral.LocalStorage.Instance:GetString("NEW_CUP")
	local upgradeCup = Astral.LocalStorage.Instance:GetString("UPGRADE_CUP")

	if recordId ~= PlayerModel.instance:getId() then
		newCup, upgradeCup = "", ""
	end

	for _, CupNO in ipairs(datas) do
		local monumentMo = MonumentModel.instance:getMonumentMoById(CupNO.id)
		local data = {
			mo = monumentMo,
			title = monumentMo:getName(),
			content = monumentMo:getCupDesc(),
			iconName = monumentMo:getStyle(),
			anchor = CommEnum.AnchorEnum.Bottom,
			iconType = CommEnum.TipsIconType.Monument,
			showType = SystemSideTipEnum.SideType.Monument
		}

		GlobalDispatcher:dispatchEvent(EventType.SHOW_SIDE_TIP, data)

		local id = tostring(CupNO.id):sub(1, 6)

		if monumentMo:getLv() > 1 then
			upgradeCup = upgradeCup .. id .. ","
		else
			newCup = newCup .. id .. ","
		end

		self._param = {}
		self._param.type = monumentMo:getLv() > 1 and "upgrade" or "unlock"
		self._param.data = data

		ToolTipsMgr.showTipsBlock(ViewName.MonumentUpgrade, self._param)
	end

	Astral.LocalStorage.Instance:SetString("MONUMENT_PLAYER_ID", PlayerModel.instance:getId())
	Astral.LocalStorage.Instance:SetString("NEW_CUP", newCup)
	Astral.LocalStorage.Instance:SetString("UPGRADE_CUP", upgradeCup)
end

M.instance = M.New()

return M
