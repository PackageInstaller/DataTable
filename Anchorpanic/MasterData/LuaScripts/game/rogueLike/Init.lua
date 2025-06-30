-- 肉鸽玩法
rogueLike = {}

require("game/rogueLike/manager/RogueLikePreDataConst")
rogueLike.RogueLikeConst = require("game/rogueLike/manager/RogueLikeConst")
------------------------------------------------view---------------------------------------------------------
-- 肉鸽面板主界面
rogueLike.RogueLikeMainPanel = require("game/rogueLike/view/RogueLikeMainPanel")

-- 肉鸽面板主界面分数tips
rogueLike.RogueLikeScoreTips = require("game/rogueLike/view/RogueLikeScoreTips")

rogueLike.RogueLikeLevelSelectPanel = require("game/rogueLike/view/RogueLikeLevelSelectPanel")
-- 单个肉鸽地图item
rogueLike.RogueLikeMapItem = require("game/rogueLike/view/RogueLikeMapItem")
-- 地图上展示BUFFitem
rogueLike.RogueLikeShowBuffItem = require("game/rogueLike/view/RogueLikeShowBuffItem")
-- 肉鸽地图面板
rogueLike.RogueLikeMapPanel = require("game/rogueLike/view/RogueLikeMapPanel")
-- 肉鸽战斗详情界面
rogueLike.RogueLikeFightInfoPanel = require("game/rogueLike/view/RogueLikeFightInfoPanel")
-- 手动BUFF单个选择item
rogueLike.RogueLikeBuffSelectItem = require("game/rogueLike/view/RogueLikeBuffSelectItem")
-- 手动BUFF选择界面
rogueLike.RogueLikeBuffSelectPanel = require("game/rogueLike/view/RogueLikeBuffSelectPanel")
-- 结算界面单个BUFFitem
rogueLike.RogueLikeGoodsSelectItem = require("game/rogueLike/view/RogueLikeGoodsSelectItem")
-- 结算界面BUFF选择界面
rogueLike.RogueLikeGoodsSelectPanel = require("game/rogueLike/view/RogueLikeGoodsSelectPanel")
-- 肉鸽事件选择item
rogueLike.RogueLikeEventSelectItem = require("game/rogueLike/view/RogueLikeEventSelectItem")
-- 肉鸽事件选择界面
rogueLike.RogueLikeEventSelectPanel = require("game/rogueLike/view/RogueLikeEventSelectPanel")
-- 肉鸽商店item
rogueLike.RogueLikeShopItem = require("game/rogueLike/view/RogueLikeShopItem")
-- 肉鸽商店界面
rogueLike.RogueLikeShopPanel = require("game/rogueLike/view/RogueLikeShopPanel")
-- 特殊事件选择item
rogueLike.RogueLikeSpecialEventSelectItem = require("game/rogueLike/view/RogueLikeSpecialEventSelectItem")
-- 特殊事件返回item
rogueLike.RogueLikeSpecialEventResultItem = require("game/rogueLike/view/RogueLikeSpecialEventResultItem")
-- 特殊事件界面
rogueLike.RogueLikeSpecialEventSelectPanel = require("game/rogueLike/view/RogueLikeSpecialEventSelectPanel")
-- 特殊事件buff显示
rogueLike.RogueLikeBuffShowPanel =  require("game/rogueLike/view/RogueLikeBuffShowPanel")
-- 肉鸽结算界面
rogueLike.RogueLikeSettPanel = require("game/rogueLike/view/RogueLikeSettPanel")
-- 肉鸽单层结算界面
rogueLike.RogueLikePreDataPanel = require("game/rogueLike/view/RogueLikePreDataPanel")
-- 肉鸽单层结算 buff查看界面
rogueLike.RogueLikePreBuffPanel = require("game/rogueLike/view/RogueLikePreBuffPanel")

rogueLike.RogueLikePreBuffItem = require("game/rogueLike/view/RogueLikePreBuffItem")

rogueLike.RogueLikeTaskItem = require("game/rogueLike/view/RogueLikeTaskItem")
rogueLike.RogueLikeScoreItem = require("game/rogueLike/view/RogueLikeScoreItem")

rogueLike.RogueLikeTaskPanel = require("game/rogueLike/view/RogueLikeTaskPanel")
-- 肉鸽任务界面
rogueLike.RogueLikeTaskPanel = require("game/rogueLike/view/RogueLikeTaskPanel")


rogueLike.RogueLikeTaskTabView = require("game/rogueLike/view/tab/RogueLikeTaskTabView")

rogueLike.RogueLikeTaskTabViewWeek = require("game/rogueLike/view/tab/RogueLikeTaskTabViewWeek")
rogueLike.RogueLikeTaskTabViewFirst = require("game/rogueLike/view/tab/RogueLikeTaskTabViewFirst")
rogueLike.RogueLikeTaskTabViewChallenge = require("game/rogueLike/view/tab/RogueLikeTaskTabViewChallenge")

-- 肉鸽收藏品界面item
rogueLike.RogueLikeBuffItem = require("game/rogueLike/view/RogueLikeBuffItem")

rogueLike.RogueLikeBuffItemResuse = require("game/rogueLike/view/RogueLikeBuffItemResuse")
-- 肉鸽收藏品界面
rogueLike.RogueLikeCollectionPanel = require("game/rogueLike/view/RogueLikeCollectionPanel")

--子页签
rogueLike.RogueLikeCollectionTabView = require("game/rogueLike/view/tab/RogueLikeCollectionTabView")
rogueLike.RogueLikeCollectionTabAttack = require("game/rogueLike/view/tab/RogueLikeCollectionTabAttack")
rogueLike.RogueLikeCollectionTabDefense = require("game/rogueLike/view/tab/RogueLikeCollectionTabDefense")
rogueLike.RogueLikeCollectionTabTreet = require("game/rogueLike/view/tab/RogueLikeCollectionTabTreet")
rogueLike.RogueLikeCollectionTabSpecial = require("game/rogueLike/view/tab/RogueLikeCollectionTabSpecial")
rogueLike.RogueLikeCollectionTabAdverse = require("game/rogueLike/view/tab/RogueLikeCollectionTabAdverse")

--肉鸽收藏品筛选界面
--rogueLike.RogueLikeCollectionFilterPanel = require("game/rogueLike/view/RogueLikeCollectionFilterPanel")
------------------------------------------------manager vo---------------------------------------------------------
-- 肉鸽管理器
rogueLike.RogueLikeManager = require("game/rogueLike/manager/RogueLikeManager").new()
-- 狗鸽角色信息数据
rogueLike.RogueLikeHeroVo = require("game/rogueLike/manager/vo/RogueLikeHeroVo")
-- 狗鸽战斗信息
rogueLike.RogueLikeDupVo = require("game/rogueLike/manager/vo/RogueLikeDupVo")
-- 肉鸽地图数据信息数据
rogueLike.RogueLikeDataMapVo = require("game/rogueLike/manager/vo/RogueLikeDataMapVo")
-- 肉鸽地图buff配置数据
rogueLike.RogueLikeGoodsConfigVo = require("game/rogueLike/manager/vo/RogueLikeGoodsConfigVo")
-- 肉鸽地图event配置数据
rogueLike.RogueLikeEventVo = require("game/rogueLike/manager/vo/RogueLikeEventVo")
-- 肉鸽地图难度配置数据
rogueLike.RogueLikeDifficultyVo = require("game/rogueLike/manager/vo/RogueLikeDifficultyVo")
-- 肉鸽地图统计配置数据
rogueLike.RogueLikeSettPointVo = require("game/rogueLike/manager/vo/RogueLikeSettPointVo")
-- 肉鸽地图任务数据
rogueLike.RogueLikeTaskVo = require("game/rogueLike/manager/vo/RogueLikeTaskVo")
-- 肉鸽地图任务积分数据
rogueLike.RogueLikeTaskScoreVo = require("game/rogueLike/manager/vo/RogueLikeTaskScoreVo")
-- 肉鸽地图积分数据
rogueLike.RogueLikeScoreVo = require("game/rogueLike/manager/vo/RogueLikeScoreVo")
------------------------------------------------controller---------------------------------------------------------
-- 肉鸽控制器
rogueLike.RogueLikeController = require("game/rogueLike/controller/RogueLikeController").new(rogueLike.RogueLikeManager)

local _sc = rogueLike.RogueLikeController
local _module = {_sc}
return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
