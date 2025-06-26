organizeBackpacks = {}
organizeBackpacks.OrganizeBackpacksVo = require("game/organizeBackpacks/manager/vo/OrganizeBackpacksVo")
organizeBackpacks.OrganizeBackpacksPanel = require("game/organizeBackpacks/view/OrganizeBackpacksPanel")
organizeBackpacks.OrganizeBackpacksConst = require("game/organizeBackpacks/manager/OrganizeBackpacksConst")
organizeBackpacks.OrganizeBackpacksDupView = require("game/organizeBackpacks/view/OrganizeBackpacksDupView")
organizeBackpacks.OrganizeBackpacksSettlementPanel = require("game/organizeBackpacks/view/OrganizeBackpacksSettlementPanel")
organizeBackpacks.OrganizeBackpacksItemVo = require("game/organizeBackpacks/manager/vo/OrganizeBackpacksItemVo")
organizeBackpacks.OrganizeBackpacksTypeVo = require("game/organizeBackpacks/manager/vo/OrganizeBackpacksTypeVo")
organizeBackpacks.OrganizeBackpacksLevelVo = require("game/organizeBackpacks/manager/vo/OrganizeBackpacksLevelVo")
organizeBackpacks.OrganizeBackpacksStageItem = require("game/organizeBackpacks/view/item/OrganizeBackpacksStageItem")
organizeBackpacks.OrganizeBackpacksManager = require("game/organizeBackpacks/manager/OrganizeBackpacksManager").new()

local _c = require('game/organizeBackpacks/controller/OrganizeBackpacksController').new(organizeBackpacks.OrganizeBackpacksManager)

local module = {_c}

return module

--[[ 替换语言包自动生成，请勿修改！
]]
