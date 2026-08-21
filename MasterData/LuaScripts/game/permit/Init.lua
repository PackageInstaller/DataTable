permit = {}

permit.PermitPanel = require("game/permit/view/PermitPanel")
permit.PermitBuyView = require("game/permit/view/PermitBuyView")
permit.PermitVo = require("game/permit/manager/vo/PermitVo")
permit.PermitItem = require("game/permit/view/item/PermitItem")
permit.PermitBuyShowView = require("game/permit/view/PermitBuyShowView")
permit.PermitManager = require("game/permit/manager/PermitManager").new()
local _sc = require("game/permit/controller/PermitController").new(permit.PermitManager)

local module = { _sc }
return module

--[[ 替换语言包自动生成，请勿修改！
]]