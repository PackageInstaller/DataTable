-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/facade/CharacterSystemFacade.lua

module("logic.extensions.charactersystem.facade.CharacterSystemFacade", package.seeall)

local CharacterSystemFacade = class("CharacterSystemFacade", BaseFacade)

function CharacterSystemFacade:showCharacterDepotView()
	ViewMgr.instance:open(ViewName.CharacterDepotMainViewNew)
end

function CharacterSystemFacade:showCharacterSystem(tabIndex, data, enterByDepot)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterMainSystemViewNew, {
		tabIndex = tabIndex,
		data = data,
		enterByDepot = enterByDepot
	})
end

CharacterSystemFacade.instance = CharacterSystemFacade.New()

return CharacterSystemFacade
