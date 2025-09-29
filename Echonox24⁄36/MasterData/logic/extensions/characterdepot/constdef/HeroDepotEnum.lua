-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/constdef/HeroDepotEnum.lua

module("logic.extensions.characterdepot.constdef.HeroDepotEnum", package.seeall)

local HeroDepotEnum = {}

HeroDepotEnum.ViewType = {
	Overview = 0,
	Equips = 2,
	Attributes = 1,
	SixDim = 3
}
HeroDepotEnum.SortType = {
	Descending = 1,
	Ascending = 2
}

return HeroDepotEnum
