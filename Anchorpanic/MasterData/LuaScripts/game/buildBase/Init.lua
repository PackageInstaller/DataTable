buildBase = {}
---------------------------------------------------------------- 定义 ----------------------------------------------------------------
require("game/buildBase/manager/BuildBaseConst")

---------------------------------------------------------------- 数据 ----------------------------------------------------------------
buildBase.BuildBasePosVo =  require("game/buildBase/manager/vo/BuildBasePosVo")
buildBase.BuildBaseLevelVo = require("game/buildBase/manager/vo/BuildBaseLevelVo")
buildBase.BuildBaseLevelsVo = require("game/buildBase/manager/vo/BuildBaseLevelsVo")
buildBase.BuildBaseHeroMsgVo = require("game/buildBase/manager/vo/BuildBaseHeroMsgVo")
buildBase.BuildBaseMsgVo = require("game/buildBase/manager/vo/BuildBaseMsgVo")
buildBase.BuildBaseFacVo = require("game/buildBase/manager/vo/BuildBaseFacVo")
buildBase.BuildBaseFacItemVo = require("game/buildBase/manager/vo/BuildBaseFacItemVo")
buildBase.BuildBaseHeroSkillVo = require("game/buildBase/manager/vo/BuildBaseHeroSkillVo")
buildBase.BuildBaseSkillAttrVo = require("game/buildBase/manager/vo/BuildBaseSkillAttrVo")
--派遣坞任务配置表 Vo
buildBase.DispatchTaskConfigVo = require("game/buildBase/manager/vo/DispatchTaskConfigVo")
--派遣坞 派遣区域Msg Vo
buildBase.DispatchExploreMsgVo = require("game/buildBase/manager/vo/DispatchExploreMsgVo")
--派遣坞冒险区域 Vo
buildBase.DispatchAreaConfigVo = require("game/buildBase/manager/vo/DispatchAreaConfigVo")
---------------------------------------------------------------- 界面 ----------------------------------------------------------------
buildBase.BuildBaseMainPanel = require("game/buildBase/view/BuildBaseMainPanel")
buildBase.BuildBaseCreatePanel = require("game/buildBase/view/BuildBaseCreatePanel")
buildBase.BuildBaseRoomUI = require("game/buildBase/view/BuildBaseRoomUI")
buildBase.BuildBaseRoomInfo = require("game/buildBase/view/BuildBaseRoomInfo")
buildBase.BuildBaseSettleInListPanel = require("game/buildBase/view/BuildBaseSettleInListPanel")
buildBase.BuildBaseFacListPanel = require("game/buildBase/view/BuildBaseFacListPanel")
buildBase.BuildBaseFacProducePanel = require("game/buildBase/view/BuildBaseFacProducePanel")
buildBase.BuildBasePowerPlantView = require("game/buildBase/view/BuildBasePowerPlantView")
buildBase.DispatchDockPanel = require("game/buildBase/view/DispatchDockPanel")
buildBase.DispatchDroneView = require("game/buildBase/view/DispatchDroneView")
buildBase.DispatchDockIncompleteView = require("game/buildBase/view/DispatchDockIncompleteView")
buildBase.DispatchDockAvailableView = require("game/buildBase/view/DispatchDockAvailableView")
buildBase.BuildBasePowerTipsView = require("game/buildBase/view/BuildBasePowerTipsView")
buildBase.BuildBaseChargeTimerInfo = require("game/buildBase/view/BuildBaseChargeTimerInfo")
buildBase.BuildBaseOverviewPanel = require("game/buildBase/view/BuildBaseOverviewPanel")
buildBase.BuildBaseHeroSelectPanel = require("game/buildBase/view/BuildBaseHeroSelectPanel")
---------------------------------------------------------------- Item ----------------------------------------------------------------
buildBase.BuildBaseFacProduceItem = require("game/buildBase/view/item/BuildBaseFacProduceItem")
buildBase.BuildBaseListItem = require("game/buildBase/view/item/BuildBaseListItem")
buildBase.DisPatchTaskItem= require("game/buildBase/view/item/DisPatchTaskItem")
buildBase.DispatchHeroSelectItem = require("game/buildBase/view/item/DispatchHeroSelectItem")
buildBase.BuildBaseOverviewItem = require("game/buildBase/view/item/BuildBaseOverviewItem")
buildBase.BuildBaseHeroSelectItem = require("game/buildBase/view/item/BuildBaseHeroSelectItem")
buildBase.BuildBaseStateGrid = require("game/buildBase/view/item/BuildBaseStateGrid")
---------------------------------------------------------------- 管理器 -------------------------------------------------------------
buildBase.BuildBaseManager = require("game/buildBase/manager/BuildBaseManager").new()
buildBase.DispatchDockManager = require("game/buildBase/manager/DispatchDockManager").new()
buildBase.BuildBaseHeroManager  = require("game/buildBase/manager/BuildBaseHeroManager").new()
buildBase.BuildBaseRedPointManager = require("game/buildBase/manager/BuildBaseRedPointManager").new()
--管理器列表 
local mMgrList = {}
table.insert(mMgrList, buildBase.BuildBaseManager )
table.insert(mMgrList, buildBase.DispatchDockManager)
table.insert(mMgrList, buildBase.BuildBaseHeroManager)
table.insert(mMgrList, buildBase.BuildBaseRedPointManager)
---------------------------------------------------------------- 控制器 -------------------------------------------------------------
buildBase.BuildBaseSceneController = require("game/buildBase/controller/BuildBaseSceneController").new()
buildBase.BuildBaseController = require("game/buildBase/controller/BuildBaseController").new(mMgrList)
--------------------------------------------------------------小房间场景Q版人物AI
buildBase.BuildBaseQLive = require("game/buildBase/manager/BuildBaseQLive")
buildBase.BuildBaseRoomScene = require("game/buildBase/manager/BuildBaseRoomScene").new()
buildBase.BuildBaseCamera = require("game/buildBase/manager/BuildBaseCamera")
buildBase.BuildBaseRoomCamera = require("game/buildBase/manager/BuildBaseRoomCamera")

local _model = {buildBase.BuildBaseController, buildBase.BuildBaseSceneController,buildBase.BuildBaseRoomScene}
return _model