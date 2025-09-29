-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallController.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallController", package.seeall)

local M = class("CharacterPreinstallController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	return
end

function M:updateHeroPreinstallList(onepreinstallData, handleType)
	if onepreinstallData and handleType then
		CharacterPreinstallModle.instance:updateHeroPreinstallList(onepreinstallData, handleType)

		return true
	end

	return false
end

function M:onHeroPreinstallListReply(msg, rt, isNew)
	if not msg then
		printWarn("角色预设数据没有传送成功")

		return
	end

	local PreinstallList = msg

	if rt == true then
		CharacterPreinstallModle.instance:updateDelCharPreinstall(PreinstallList)
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_PREINSTALLS_CHANGE)
	elseif rt == false and isNew == true then
		CharacterPreinstallModle.instance:updateCharPreinstall(PreinstallList)
	else
		CharacterPreinstallModle.instance:updateCharPreinstall(PreinstallList)
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_PREINSTALLS_CHANGE)
	end
end

function M:onHeroSavePreinstallReply(isNew)
	if isNew == true then
		GlobalDispatcher:dispatchEvent(EventType.ChARACTER_PREINSTALLS_SAVE, true)
	else
		GlobalDispatcher:dispatchEvent(EventType.ChARACTER_PREINSTALLS_SAVE, false)
	end
end

function M:onHeroApplyPreinstallReply()
	GlobalDispatcher:dispatchEvent(EventType.ChARACTER_PREINSTALLS_CURRENT)
end

function M:getItemList(echoId)
	return CharacterPreinstallModle.instance:getItemPreinstallList(echoId)
end

function M:getHeroPreinstallList(heroId)
	if heroId then
		local heroPrinstallList = CharacterPreinstallModle.instance:getHeroPreinstallList(heroId)

		if heroPrinstallList then
			return heroPrinstallList
		end
	end

	return nil
end

function M:getHeroPreinstallNum(heroId)
	if heroId then
		local heroPrinstallList = CharacterPreinstallModle.instance:getHeroPreinstallList(heroId)

		if heroPrinstallList then
			return #heroPrinstallList
		end
	end

	return nil
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	return viewPageMo and viewPageMo.hero or false
end

function M:getPreInAllById(id)
	return CharacterPreinstallModle.instance:getPreInAllById(id)
end

M.instance = M.New()

return M
