-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RogueEndOptionUtil.lua

module("logic.extensions.roguelike.util.RogueEndOptionUtil", package.seeall)

local M = class("RogueEndOptionUtil")

function M:getOptionDesc(co)
	local descFormat = co.desc

	if co.type == "RecycleGold" then
		local goldCount = RogueExploreModel.instance:getRoundGoldCount() or 0
		local nextCount = math.ceil(tonumber(co.param) * goldCount / 100)
		local desc = string.format(descFormat, nextCount)

		return desc
	elseif co.type == "GetItem" then
		local params = string.split(co.param, "#")
		local cfg = BackpackConfig.instance:getItemInfoByItemId(tonumber(params[1]))
		local curScriptInfo = RogueExploreModel.instance:getCurScriptNO()
		local isWin = RogueExploreModel.instance:getIsExploreWin()
		local curCount = 0
		local totalLimit = RoguelikeConfig.instance:getConstByName("TotalSelectItemLimit").numValue
		local failLimit = RoguelikeConfig.instance:getConstByName("FailSelectItemLimit").numValue
		local maxGetCount = math.max(curScriptInfo.totalCount, curScriptInfo.failCount)

		if isWin then
			curCount = maxGetCount
		else
			curCount = totalLimit - maxGetCount > failLimit - curScriptInfo.failCount and curScriptInfo.failCount or failLimit - (totalLimit - maxGetCount)
		end

		local maxCount = isWin and RoguelikeConfig.instance:getConstByName("TotalSelectItemLimit").numValue or RoguelikeConfig.instance:getConstByName("FailSelectItemLimit").numValue
		local desc = string.format(descFormat, params[2], cfg.name, curCount, maxCount)

		return desc
	end

	return descFormat
end

M.instance = M.New()

return M
