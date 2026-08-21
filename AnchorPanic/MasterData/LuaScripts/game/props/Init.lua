-- const
require("game/props/manager/PropsConst")

props = {}
-- vo
props.PropsConfigVo = require('game/props/manager/vo/PropsConfigVo')
props.ItemRuleVo = require('game/props/manager/vo/ItemRuleVo')
props.ItemChildRuleVo = require('game/props/manager/vo/ItemChildRuleVo')
props.PropsVo = require('game/props/manager/vo/PropsVo')
-- manager
props.PropsManager = require("game/props/manager/PropsManager").new()
-- view
ShowAwardEmptyItem = require('game/props/view/item/ShowAwardEmptyItem')
ShowAwardItem = require('game/props/view/item/ShowAwardItem')
ShowAwardPanel = require('game/props/view/ShowAwardPanel')
ShowAwardPanel_New = require('game/props/view/ShowAwardPanel_New')
-- controller
local _c = require('game/props/controller/PropsController').new(props.PropsManager)

local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
