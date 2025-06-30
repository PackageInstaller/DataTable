selectedHero = {}
selectedHero.SelectedHeroManager = require("game/selectedHero/manager/SelectedHeroManager").new()
selectedHero.SelectedHeroView = "game/selectedHero/view/SelectedHeroView"
selectedHero.SelectedHeroItem = require("game/selectedHero/view/item/SelectedHeroItem")
selectedHero.SelectedPropsView = "game/selectedHero/view/SelectedPropsView"
selectedHero.SelectedPropsItem = require("game/selectedHero/view/item/SelectedPropsItem")

local _c = require('game/selectedHero/controller/SelectedHeroViewController').new()

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
