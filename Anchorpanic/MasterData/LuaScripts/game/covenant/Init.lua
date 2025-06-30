covenant = {}

require("game/covenant/manager/CovenantLevelConst")

-- 盟约商店
covenant.CovenantShopItem = require("game/covenant/view/item/CovenantShopItem")
covenant.CovenantShopPanel = require("game/covenant/view/CovenantShopPanel")
covenant.CovenantShopInfoPanel = require("game/covenant/view/CovenantShopInfoPanel")

-- 盟约助手
covenant.CovenantHelperHeroItem = require("game/covenant/view/item/CovenantHelperHeroItem")
covenant.CovenantHelpHeroSelectItem = require("game/covenant/view/item/CovenantHelpHeroSelectItem")
covenant.CovenantHelpHeroSelectPanel = require("game/covenant/view/CovenantHelpHeroSelectPanel")
covenant.CovenantHelperAttrItem = require("game/covenant/view/item/CovenantHelperAttrItem")
covenant.CovenantHelperHeadItem = require("game/covenant/view/item/CovenantHelperHeadItem")

--盟约研究所 -- 替换以前的盟约助手
covenant.CovenantInstitutePanel = require("game/covenant/view/CovenantInstitutePanel")

covenant.CovenantHelperVo = require("game/covenant/manager/vo/CovenantHelperVo")
covenant.CovenantHelperBuildPanel = require("game/covenant/view/CovenantHelperBuildPanel")
covenant.CovenantHelperLvlUpVo = require("game/covenant/manager/vo/CovenantHelperLvlUpVo")
covenant.CovenantHelperInfoVo = require("game/covenant/manager/vo/CovenantHelperInfoVo")
covenant.CovenantInstituteVo = require("game/covenant/manager/vo/CovenantInstituteVo")

-- 盟约选择
covenant.CovenantSelectConfigVo = require("game/covenant/manager/vo/CovenantSelectConfigVo")
-- 盟约声望配置
covenant.CovenantPrestigeConfigVo = require("game/covenant/manager/vo/CovenantPrestigeConfigVo")


covenant.CovenantTalentVo = require("game/covenant/manager/vo/CovenantTalentVo")

covenant.CovenantSkillVo = require("game/covenant/manager/vo/CovenantSkillVo")


convert.CovenantSelectItem = require("game/covenant/view/item/CovenantSelectItem")

-- start 盟约选择界面
convert.CovenantSelectPanel = require("game/covenant/view/CovenantSelectPanel")

-- 盟约选择界面详细信息
convert.CovenantSelectInfoPanel = require("game/covenant/view/CovenantSelectInfoPanel")

-- 盟约选择界面确认加入面板
covenant.CovenantSelectSurePanel = require("game/covenant/view/CovenantSelectSurePanel")

-- 盟约选择界面不能变更界面
covenant.CovenantSelectNotChangePanel = require("game/covenant/view/CovenantSelectNotChangePanel")

covenant.CovenantMainCamera = require("game/covenant/utils/CovenantMainCamera").new()

-- 盟约主界面
covenant.CovenantMainPanel = require("game/covenant/view/CovenantMainPanel")
-- 盟约技能界面
covenant.CovenantSkillPanel = require("game/covenant/view/CovenantSkillPanel")
-- 盟约总部
covenant.CovenantHQPanel = require("game/covenant/view/CovenantHQPanel")

--盟约等级item
covenant.CovenantLevelItem = require("game/covenant/view/item/CovenantLevelItem")

-- 盟约解锁子对象元素
covenant.CovenantLockItem = require("game/covenant/view/item/CovenantLockItem")

covenant.CovenantManager = require("game/covenant/manager/CovenantManager")

covenant.CovenantLvUpView = require("game/covenant/view/CovenantLvUpView")

--盟约任务相关
covenant.CovenantTaskServerVo =  require("game/covenant/manager/vo/CovenantTaskServerVo")
covenant.CovenantTaskVo =  require("game/covenant/manager/vo/CovenantTaskVo")
covenant.CovenantTaskItem = require("game/covenant/view/item/CovenantTaskItem")
covenant.CovenantTaskInfoView = require("game/covenant/view/CovenantTaskInfoView")
covenant.CovenantTaskTabView = require("game/covenant/view/CovenantTaskTabView")

--盟约声望升级弹窗
covenant.CovenantLvUpPanel = require("game/covenant/view/CovenantLvUpPanel")

covenant.CovenantMainSceneController = require("game/covenant/controller/CovenantMainSceneController").new()

local _sc = require("game/covenant/controller/CovenantController").new(covenant.CovenantManager)

local _module = { _sc }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
