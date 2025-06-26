cycle = {}
---------------------------------------------------------------- 定义 ----------------------------------------------------------------
require("game/cycle/manager/CycleConst")

---------------------------------------------------------------- 数据 ----------------------------------------------------------------

-- 难度
cycle.CycleDifficultyVo = require("game/cycle/manager/vo/CycleDifficultyVo")
-- 层数
cycle.CycleLayerVo = require("game/cycle/manager/vo/CycleLayerVo")
-- 经验
cycle.CycleExpVo = require("game/cycle/manager/vo/CycleExpVo")
-- 策略
cycle.CycleStrategyVo = require("game/cycle/manager/vo/CycleStrategyVo")
-- 组合
cycle.CycleComboVo = require("game/cycle/manager/vo/CycleComboVo")
-- 招募
cycle.CycleRecruitVo = require("game/cycle/manager/vo/CycleRecruitVo")
-- 线路
cycle.CycleLineVo = require("game/cycle/manager/vo/CycleLineVo")
-- 格子
cycle.CycleCellVo = require("game/cycle/manager/vo/CycleCellVo")
-- 事件
cycle.CycleEventVo = require("game/cycle/manager/vo/CycleEventVo")
-- 副本
cycle.CycleDupVo = require("game/cycle/manager/vo/CycleDupVo")
-- 收藏品
cycle.CycleCollageVo = require("game/cycle/manager/vo/CycleCollageVo")
-- 格子信息
cycle.CycleCellMsgVo = require("game/cycle/manager/vo/CycleCellMsgVo")
-- 物品信息
cycle.CycleGoodMsgVo = require("game/cycle/manager/vo/CycleGoodMsgVo")
-- 商店
cycle.CycleShopVo = require("game/cycle/manager/vo/CycleShopVo")
-- 积分
cycle.CyclePointVo = require("game/cycle/manager/vo/CyclePointVo")
-- 等级
cycle.CycleLvVo = require("game/cycle/manager/vo/CycleLvVo")

-- 任务
cycle.CycleTaskVo = require("game/cycle/manager/vo/CycleTaskVo")
-- 无限投资
cycle.CycleInvestVo = require("game/cycle/manager/vo/CycleInvestVo")

--剧情数据
cycle.CycleStoryVo = require("game/cycle/manager/vo/CycleStoryVo")
--收藏品奖励数据
cycle.CycleCollageAwardVo= require("game/cycle/manager/vo/CycleCollageAwardVo")

---------------------------------------------------------------- 界面子元素 ----------------------------------------------------------------

cycle.CycleHeroCard = require("game/cycle/view/item/CycleHeroCard")

cycle.CycleHeroSelectItem = require("game/cycle/view/item/CycleHeroSelectItem")

-- 组合
cycle.CycleComboItem = require("game/cycle/view/item/CycleComboItem")
-- 招募
cycle.CycleRecruitItem = require("game/cycle/view/item/CycleRecruitItem")
-- 组合
cycle.CycleGroupItem = require("game/cycle/view/item/CycleGroupItem")
-- 格子
cycle.CycleNodeItem = require("game/cycle/view/item/CycleNodeItem")
-- 地图
cycle.CycleMapItem = require("game/cycle/view/item/CycleMapItem")

-- BUFF
cycle.CycleBuffItem = require("game/cycle/view/item/CycleBuffItem")
-- 战后
cycle.CyclePostwarItem = require("game/cycle/view/item/CyclePostwarItem")

-- 收藏品
cycle.CycleCollectionItem = require("game/cycle/view/item/CycleCollectionItem")

-- 任务
cycle.CycleTaskItem = require("game/cycle/view/item/CycleTaskItem")

-- 战员技能
cycle.CycleHeroSkillItem = require("game/cycle/view/item/CycleHeroSkillItem")
-- 等级界面itemRender
cycle.CycleLevelItem= require("game/cycle/view/item/CycleLevelItem")
--剧情item
cycle.CycleStoryItem = require("game/cycle/view/item/CycleStoryItem")
--事件item
cycle.CycleEventItem = require("game/cycle/view/item/CycleEventItem")


--结算界面buff
cycle.CyclePassCollItem = require("game/cycle/view/item/CyclePassCollItem")
--结算界面战员
cycle.CyclePassHeroItem = require("game/cycle/view/item/CyclePassHeroItem")
--收藏品目标item
cycle.CycleCollectionTargetItem = require("game/cycle/view/item/CycleCollectionTargetItem")
--剧情目标item
cycle.CycleStoryTargetItem = require("game/cycle/view/item/CycleStoryTargetItem")
---------------------------------------------------------------- 界面 ----------------------------------------------------------------

cycle.CycleTaskPanel = require("game/cycle/view/CycleTaskPanel")

cycle.CycleTopPanel = require("game/cycle/view/CycleTopPanel")
cycle.CycleMainPanel = require("game/cycle/view/CycleMainPanel")
cycle.CycleLevelPanel = require("game/cycle/view/CycleLevelPanel")

cycle.CycleStoryPanel = require("game/cycle/view/CycleStoryPanel")

-- 无限投资商店
cycle.CycleInvestPanel =  require("game/cycle/view/CycleInvestPanel")

cycle.CycleShowAwardPanel = require("game/cycle/view/CycleShowAwardPanel")

-- 0 难度选择
-- 1 选择BUFF
-- 2 招募组合
-- 3 细分招募组合选择
-- 4 我选战员
-- 5 完成
-- 6 进入地图

-- 步骤界面0
cycle.CycleLevelSelectPanel = require("game/cycle/view/CycleLevelSelectPanel")
-- 步骤界面1
cycle.CycleBuffSelectPanel = require("game/cycle/view/CycleBuffSelectPanel")
-- 步骤界面2
cycle.CycleComboPanel = require("game/cycle/view/CycleComboPanel")
-- 步骤界面3
cycle.CycleRecruitPanel = require("game/cycle/view/CycleRecruitPanel")
-- 步骤界面4
cycle.CycleHeroSelectPanel = require("game/cycle/view/CycleHeroSelectPanel")

-- 战员招募确认页面
cycle.CycleHeroSurePanel = require("game/cycle/view/CycleHeroSurePanel")

-- 展示一个招募的战员
cycle.CycleShowOnePanel = require("game/cycle/view/CycleShowOnePanel")

-- 正式进入了
cycle.CycleMapPanel = require("game/cycle/view/CycleMapPanel")

-- 结算界面
cycle.CycleResultWinPanel = require("game/cycle/view/CycleResultWinPanel")

-- 结算界面
cycle.CyclePreviewPanel = require("game/cycle/view/CycleFightPreviewPanel")

-- 事件界面
cycle.CycleEventPanel = require("game/cycle/view/CycleEventPanel")

-- 事件结束界面
cycle.CycleEventEndPanel = require("game/cycle/view/CycleEventEndPanel")

-- 战后界面
cycle.CyclePostwarPanel = require("game/cycle/view/CyclePostwarPanel")

-- 商店界面
cycle.CycleShopPanel = require("game/cycle/view/CycleShopPanel")

-- 商店内无限投资商店
--cycle.CycleShopInvestPanel =  require("game/cycle/view/CycleShopInvestPanel")

-- 总计分界面
cycle.CycleSettPanel = require("game/cycle/view/CycleSettPanel")
-- 通关界面
cycle.CyclePassPanel = require("game/cycle/view/CyclePassPanel")


cycle.CycleCollectionPanel = require("game/cycle/view/CycleCollectionPanel")
cycle.CycleCollectionTabView = require("game/cycle/view/tab/CycleCollectionTabView")
cycle.CycleCollectionTabAttack = require("game/cycle/view/tab/CycleCollectionTabAttack")
cycle.CycleCollectionTabDefense = require("game/cycle/view/tab/CycleCollectionTabDefense")
cycle.CycleCollectionTabSpecial = require("game/cycle/view/tab/CycleCollectionTabSpecial")

--收藏品奖励界面
cycle.CycleCollectionTargetPanel= require("game/cycle/view/CycleCollectionTargetPanel")
--剧情奖励界面
cycle.CycleStoryTargetPanel= require("game/cycle/view/CycleStoryTargetPanel")

-- 难度展示界面
cycle.CycleShowLayerPanel = require("game/cycle/view/CycleShowLayerPanel")

--------------------------------------------------- 天赋 ----------------------------------------------------------------
cycle.CycleTalentPanel = require("game/cycle/view/CycleTalentPanel")
cycle.CycleTalentCongnitionPanel = require("game/cycle/view/CycleTalentCongnitionPanel")
cycle.CycleTalentManager = require("game/cycle/manager/CycleTalentManager").new()
cycle.CycleTalentController = require("game/cycle/controller/CycleTalentController").new(cycle.CycleTalentManager)
cycle.CycleTalentVo = require("game/cycle/manager/vo/CycleTalentVo")
--------------------------------------------------- 控制管理 ----------------------------------------------------------------
cycle.CycleManager = require("game/cycle/manager/CycleManager").new()
cycle.CycleController = require("game/cycle/controller/CycleController").new(cycle.CycleManager)

local _model = {cycle.CycleController, cycle.CycleTalentController}
return _model
 
--[[ 替换语言包自动生成，请勿修改！
]]
