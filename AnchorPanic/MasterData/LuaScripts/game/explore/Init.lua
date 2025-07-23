--探索

explore = {}

require("game/explore/manager/ExploreTypeConst")

--服务器下发的探索信息
explore.ExploreArenaVo = require("game/explore/manager/vo/ExploreArenaVo")

--配置表中的探索信息
explore.ExploreDataVo = require("game/explore/manager/vo/ExploreDataVo")
--配置表中的事件信息
explore.ExploreEventDataVo = require("game/explore/manager/vo/ExploreEventDataVo")

--探索界面角色头像元素
explore.exploreHeadItem = require("game/explore/view/item/ExploreHeadSelectItem")

--探索战员选择界面
explore.exploreSelectPanel = require("game/explore/view/ExploreSelectPanel")

--探索界面
explore.explorePanel = require("game/explore/view/ExplorePanel")

--探索准备界面
explore.explorePreparePanel = require("game/explore/view/ExplorePreparePanel")

--探索详情界面
explore.exploreInfoPanel = require("game/explore/view/ExploreInfoPanel")

explore.exploreManager = require("game/explore/manager/ExploreManager")
local _sc = require("game/explore/controller/ExploreController").new()
local _module = { _sc }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
