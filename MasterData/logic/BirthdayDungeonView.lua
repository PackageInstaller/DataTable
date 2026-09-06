-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/birthday/BirthdayDungeonView.lua

module("logic.extensions.scenariocopy.view.birthday.BirthdayDungeonView", package.seeall)

local BirthdayDungeonView = class("BirthdayDungeonView", FatherDungeonView)

function BirthdayDungeonView:_getChapterMaxNum()
	return 3
end

function BirthdayDungeonView:_getStageMaxNum()
	return 6
end

function BirthdayDungeonView:_getIndexRange()
	return 1, 3
end

function BirthdayDungeonView:_getStageViewName()
	return ViewName.BirthdayStageView
end

function BirthdayDungeonView:_getBgEffectPath(index)
	local bgEffectPaths = {
		"20211126/xiaonuoshengrihui/fx_ui_mianban_fuben.prefab",
		"20211126/xiaonuoshengrihui/fx_ui_mianban_fuben.prefab",
		"20211126/xiaonuoshengrihui/fx_ui_mianban_fuben.prefab"
	}

	return bgEffectPaths[index]
end

function BirthdayDungeonView:_getBgPicturePath(index)
	local bgPicturePaths = {
		BirthdayDungeonViewPresentor.bgPicturePaths[1],
		BirthdayDungeonViewPresentor.bgPicturePaths[2],
		BirthdayDungeonViewPresentor.bgPicturePaths[3]
	}

	return bgPicturePaths[index]
end

function BirthdayDungeonView:_getChapterSelectEffectPath()
	return "20211126/xiaonuoshengrihui/fx_ui_kuang_fuben.prefab"
end

function BirthdayDungeonView:_getLevelSelectEffectPath(isPurePlot)
	if isPurePlot == true then
		return "20211126/xiaonuoshengrihui/fx_ui_anniu1_fuben.prefab"
	elseif isPurePlot == false then
		return "20211126/xiaonuoshengrihui/fx_ui_anniu1_fuben.prefab"
	else
		return nil
	end
end

return BirthdayDungeonView
