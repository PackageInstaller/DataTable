seabed = {}

require("game/seabed/manager/SeabedConst")

-- 引入海床商店数据对象模块
seabed.SeabedShopVo = require("game/seabed/manager/vo/SeabedShopVo")
-- 引入海床关卡数据对象模块
seabed.SeabedDupVo = require("game/seabed/manager/vo/SeabedDupVo")
-- 引入海床任务数据对象模块
seabed.SeabedTaskVo = require("game/seabed/manager/vo/SeabedTaskVo")
-- 引入海床天赋数据对象模块
seabed.SeabedTalentVo = require("game/seabed/manager/vo/SeabedTalentVo")
-- 引入海床展示室数据对象模块
seabed.SeabedShowroomVo = require("game/seabed/manager/vo/SeabedShowroomVo")
-- 引入海床点数据对象模块
seabed.SeabedPointVo = require("game/seabed/manager/vo/SeabedPointVo")
-- 引入海床增益数据对象模块
seabed.SeabedBuffVo = require("game/seabed/manager/vo/SeabedBuffVo")
-- 引入海床事件数据对象模块
seabed.SeabedEventVo = require("game/seabed/manager/vo/SeabedEventVo")
-- 引入海床收藏品数据对象模块
seabed.SeabedCollectionVo = require("game/seabed/manager/vo/SeabedCollectionVo")
-- 引入海床难度配置类
seabed.SeabedDifficultyVo = require("game/seabed/manager/vo/SeabedDifficultyVo")
-- 引入海床难题配置类
seabed.SeabedTeaserVo = require("game/seabed/manager/vo/SeabedTeaserVo")
-- 引入海床技能配置类
seabed.SeabedSkillVo = require("game/seabed/manager/vo/SeabedSkillVo")
-- 引入海床关卡配置类
seabed.SeabedVo = require("game/seabed/manager/vo/SeabedVo")
-- 引入海床线段配置类
seabed.SeabedLineVo = require("game/seabed/manager/vo/SeabedLineVo")
-- 引入海床单个格子配置类
seabed.SeabedSingleCellVo = require("game/seabed/manager/vo/SeabedSingleCellVo")
-- 引入海床收藏品奖励配置类
seabed.SeabedCollectionRewardVo = require("game/seabed/manager/vo/SeabedCollectionRewardVo")
-- 加载海床主面板视图类
seabed.SeabedMainPanel = require("game/seabed/view/SeabedMainPanel")
-- 加载海床顶部视图类
seabed.SeabedTopPanel = require("game/seabed/view/SeabedTopPanel")
-- 加载海床关卡面板视图类
seabed.SeabedLevelPanel = require("game/seabed/view/SeabedLevelPanel")
-- 加载英雄选择项初始化模块
seabed.SeabedHeroSelectInitItem = require("game/seabed/view/item/SeabedHeroSelectInitItem")
-- 加载英雄选择项模块
seabed.SeabedHeroSelectItem = require("game/seabed/view/item/SeabedHeroSelectItem")
-- 加载英雄选择面板模块
seabed.SeabedHeroSelectPanel = require("game/seabed/view/SeabedHeroSelectPanel")
-- 加载技能面板模块
seabed.SeabedSkillPanel = require("game/seabed/view/SeabedSkillPanel")
-- 加载地图面板模块
seabed.SeabedMapPanel = require("game/seabed/view/SeabedMapPanel")
-- 加载商店面板模块
seabed.SeabedShopPanel = require("game/seabed/view/SeabedShopPanel")
-- 加载增益变化面板模块
seabed.SeabedBuffChangePanel = require("game/seabed/view/SeabedBuffChangePanel")
-- 加载海床战斗buff面板
seabed.SeabedBattleBuffPanel = require("game/seabed/view/SeabedBattleBuffPanel")
-- 加载海床设置面板
seabed.SeabedSettPanel = require("game/seabed/view/SeabedSettPanel")
-- 加载海床任务项
seabed.SeabedTaskItem = require("game/seabed/view/item/SeabedTaskItem")
-- 加载海床任务定义标签页视图
seabed.SeabedTaskDefTabView = require("game/seabed/view/tab/SeabedTaskDefTabView")
-- 加载海床任务高级标签页视图
seabed.SeabedTaskHighTabView = require("game/seabed/view/tab/SeabedTaskHighTabView")
-- 加载海床任务面板
seabed.SeabedTaskPanel = require("game/seabed/view/SeabedTaskPanel")
-- 加载海床天赋面板
seabed.SeabedTalentPanel = require("game/seabed/view/SeabedTalentPanel")
-- 加载海床全部天赋面板
seabed.SeabedTalentAllPanel = require("game/seabed/view/SeabedTalentAllPanel")
-- 加载海床收集标签页视图
seabed.SeabedCollectionTabView = require("game/seabed/view/tab/SeabedCollectionTabView")
-- 加载海床buff标签页视图
seabed.SeabedBuffTabView = require("game/seabed/view/tab/SeabedBuffTabView")
-- 加载海床收集项
seabed.SeabedCollectionItem = require("game/seabed/view/item/SeabedCollectionItem")
-- 加载海床收集面板
seabed.SeabedCollectionPanel = require("game/seabed/view/SeabedCollectionPanel")
-- 加载海床收集奖励项
seabed.SeabedCollectionAwardItem = require("game/seabed/view/item/SeabedCollectionAwardItem")
-- 加载海床收集奖励面板
seabed.SeabedCollectionAwardPanel = require("game/seabed/view/SeabedCollectionAwardPanel")  
-- 加载海床故事项
seabed.SeabedStoryItem = require("game/seabed/view/item/SeabedStoryItem")
-- 加载海床故事面板
seabed.SeabedStoryPanel = require("game/seabed/view/SeabedStoryPanel")  
-- 加载海床故事奖励项
seabed.SeabedStoryAwardItem = require("game/seabed/view/item/SeabedStoryAwardItem")
-- 加载海床故事奖励面板
seabed.SeabedStoryAwardPanel = require("game/seabed/view/SeabedStoryAwardPanel")  
-- 加载海床排名项
seabed.SeabedRankItem = require("game/seabed/view/item/SeabedRankItem")
-- 加载海床排名面板
seabed.SeabedRankPanel = require("game/seabed/view/SeabedRankPanel")

seabed.SeabedShowLayerPanel = require("game/seabed/view/SeabedShowLayerPanel")


----------------------------------------------------------end(结局相关界面)-----------------------------------------------
seabed.SeabedMainPanel_end = require("game/seabed/view/SeabedMainPanel_end")
seabed.SeabedBattleBuffPanel_end = require("game/seabed/view/SeabedBattleBuffPanel_end")
seabed.SeabedHeroSelectPanel_end = require("game/seabed/view/SeabedHeroSelectPanel_end")
seabed.SeabedLevelPanel_end = require("game/seabed/view/SeabedLevelPanel_end")
seabed.SeabedSkillPanel_end = require("game/seabed/view/SeabedSkillPanel_end")
seabed.SeabedShopPanel_end = require("game/seabed/view/SeabedShopPanel_end")
seabed.SeabedStoryPanel_end = require("game/seabed/view/SeabedStoryPanel_end")
seabed.SeabedTalentPanel_end = require("game/seabed/view/SeabedTalentPanel_end")
seabed.SeabedTaskPanel_end = require("game/seabed/view/SeabedTaskPanel_end")
seabed.SeabedRankPanel_end = require("game/seabed/view/SeabedRankPanel_end")
seabed.SeabedBuffChangePanel_end = require("game/seabed/view/SeabedBuffChangePanel_end")

-- 创建并初始化海床管理器实例
seabed.SeabedManager = require("game/seabed/manager/SeabedManager").new()
-- 创建并初始化海床控制器实例，传入海床管理器
seabed.SeabedController = require("game/seabed/controller/SeabedController").new(seabed.SeabedManager)

local module = { seabed.SeabedController }
return module