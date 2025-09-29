-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/controller/RogueJudgeController.lua

module("logic.extensions.roguelike.controller.RogueJudgeController", package.seeall)

local ShowTipsType = {
	SelectProp = 2,
	SelectEndOption = 4,
	SelectCard = 3,
	SelectRole = 1
}
local M = class("RogueJudgeController", BaseController)

function M:onInit()
	self:setEvent(true)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_END_OPTION_SELECT, self._onCurScriptInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._onGainItemClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_END_OPTION_SELECT, self._onCurScriptInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._onGainItemClose, self)
	end
end

function M:_onCurScriptInfoRefresh(sender)
	self:checkEndSelect()
end

function M:checkEndSelect(ignoreDelay)
	if ViewMgr.instance:isOpen(ViewName.RogueMap) or ViewMgr.instance:isOpen(ViewName.RogueSecondaryMap) then
		if RogueExploreModel.instance:getIsGameFinish() then
			local info = RogueExploreModel.instance:getCurScriptNO()

			if not info then
				return
			end

			if info and #info.options > 0 then
				if info.startSelectId and info.startSelectId ~= 0 and false then
					-- block empty
				else
					ViewMgr.instance:open(ViewName.RogueSelectTips, {
						RoguelikeConst.SHOW_TIPS_TYPE.SelectEndOption,
						info.options,
						#info.options == 1 and lang("恭喜通关") or lang("失败抉择")
					})
				end
			elseif info.startCard and #info.startCard == 3 then
				ViewMgr.instance:open(ViewName.RogueSelectTips, {
					RoguelikeConst.SHOW_TIPS_TYPE.SelectCard,
					info.startCard,
					lang("请选择卡牌")
				})
			elseif ignoreDelay then
				GlobalDispatcher:dispatchEvent(EventType.ROGUE_QUIT_SUCCESS)
			else
				settimer(0.5, function()
					if not ViewMgr.instance:isOpen(ViewName.GainItemView) then
						GlobalDispatcher:dispatchEvent(EventType.ROGUE_QUIT_SUCCESS)
					end
				end, self, false)
			end
		elseif RogueExploreModel.instance:getNeedSelectRole() then
			local info = RogueExploreModel.instance:getCurScriptNO()

			if ViewMgr.instance:isOpen(ViewName.RogueMap) or ViewMgr.instance:isOpen(ViewName.RogueSecondaryMap) then
				ViewMgr.instance:open(ViewName.RogueSelectTips, {
					RoguelikeConst.SHOW_TIPS_TYPE.SelectRole,
					info.startCard,
					lang("请选择守秘人携带卡牌")
				})
			end
		end
	end
end

function M:getIsNeedSelectOption()
	if RogueExploreModel.instance:getIsGameFinish() then
		local info = RogueExploreModel.instance:getCurScriptNO()

		if not info then
			return false
		end

		if info and #info.options > 0 then
			return true
		elseif info.startCard and #info.startCard == 3 then
			return true
		end
	elseif RogueExploreModel.instance:getNeedSelectRole() then
		return true
	end

	return false
end

function M:_onGainItemClose()
	self:checkEndSelect(true)
end

M.instance = M.New()

return M
