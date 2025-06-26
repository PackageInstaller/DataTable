battleMap = {}

--base
require("game/battleMapHall/base/manager/BattleMapHallConst")
battleMap.BattleMapHallManager = require("game/battleMapHall/base/manager/BattleMapHallManager").new()
battleMap.BattleMapHallPanel = require("game/battleMapHall/base/view/BattleMapHallPanel")
battleMap.BattleMapHallItem = require("game/battleMapHall/base/view/BattleMapHallItem")
battleMap.BattleMapHallController = require("game/battleMapHall/base/controller/BattleMapHallController").new(battleMap.BattleMapHallManager)

--主线关卡
require("game/battleMapHall/mainMap/manager/MainMapConst")
battleMap.MainMapManager = require("game/battleMapHall/mainMap/manager/MainMapManager").new()
battleMap.MainMapStageVo = require("game/battleMapHall/mainMap/manager/vo/MainMapStageVo")
battleMap.MainMapChapterVo = require("game/battleMapHall/mainMap/manager/vo/MainMapChapterVo")
battleMap.MainMapController = require("game/battleMapHall/mainMap/controller/MainMapController").new(battleMap.MainMapManager)

battleMap.MainMapChapterItem = require("game/battleMapHall/mainMap/view/item/MainMapChapterItem")
battleMap.MainMapStageAwardItem = require("game/battleMapHall/mainMap/view/item/MainMapStageAwardItem")
battleMap.MainMapSmallChapterItem = require("game/battleMapHall/mainMap/view/item/MainMapSmallChapterItem")
battleMap.MainMapStageItem = require("game/battleMapHall/mainMap/view/item/MainMapStageItem")
battleMap.MainMapStageListPanel = require("game/battleMapHall/mainMap/view/MainMapStageListPanel")
battleMap.MainMapTabView = require("game/battleMapHall/mainMap/view/MainMapTabView")
battleMap.MainMapStyleView = require("game/battleMapHall/mainMap/view/MainMapStyleView")
battleMap.MainMapStageAwardView = require("game/battleMapHall/mainMap/view/MainMapStageAwardView")
battleMap.MainMapFinishView = require("game/battleMapHall/mainMap/view/MainMapFinishView")
battleMap.MainMapFinish01View = require("game/battleMapHall/mainMap/view/MainMapFinish01View")
battleMap.MainMapFinish02View = require("game/battleMapHall/mainMap/view/MainMapFinish02View")
battleMap.MainMapFinish03View = require("game/battleMapHall/mainMap/view/MainMapFinish03View")
battleMap.MainMapFinish04View = require("game/battleMapHall/mainMap/view/MainMapFinish04View")
battleMap.MainMapFinish05View = require("game/battleMapHall/mainMap/view/MainMapFinish05View")
battleMap.MainMapFinish06View = require("game/battleMapHall/mainMap/view/MainMapFinish06View")
battleMap.MainMapFinish07View = require("game/battleMapHall/mainMap/view/MainMapFinish07View")
battleMap.MainMapFinish08View = require("game/battleMapHall/mainMap/view/MainMapFinish08View")
battleMap.MainMapFinish09View = require("game/battleMapHall/mainMap/view/MainMapFinish09View")
battleMap.MainMapFinish10View = require("game/battleMapHall/mainMap/view/MainMapFinish10View")
battleMap.MainMapFinish11View = require("game/battleMapHall/mainMap/view/MainMapFinish11View")
battleMap.MainMapFinish12View = require("game/battleMapHall/mainMap/view/MainMapFinish12View")
--战员传记
require("game/battleMapHall/biography/manager/BiographyConst")
battleMap.HeroBiographyDataRo = require('rodata/HeroBiographyDataRo')
battleMap.HeroBiographyChapterDataRo = require('rodata/HeroBiographyChapterDataRo')
battleMap.HeroBiographyDupDataRo = require('rodata/HeroBiographyDupDataRo')
battleMap.BiographyVo = require("game/battleMapHall/biography/manager/vo/BiographyVo")

battleMap.BiographyManager = require("game/battleMapHall/biography/manager/BiographyManager").new()
battleMap.BiographyController = require("game/battleMapHall/biography/controller/BiographyController").new(battleMap.BiographyManager)
battleMap.BiographyTabView = require("game/battleMapHall/biography/view/BiographyTabView")
battleMap.HeroBiographyPanel = require("game/battleMapHall/biography/view/HeroBiographyPanel")
battleMap.BiographyItem = require("game/battleMapHall/biography/view/item/BiographyItem")
battleMap.HeroBiographyDupItem = require("game/battleMapHall/biography/view/item/HeroBiographyDupItem")
battleMap.HeroBiographyDupInfoView = require("game/battleMapHall/biography/view/HeroBiographyDupInfoView")

--支线
require("game/battleMapHall/fragmentMap/manager/FragmentMapConst")
battleMap.FragmentMapTabView = require('game/battleMapHall/fragmentMap/view/FragmentMapTabView')
battleMap.FragmentChapterItem = require('game/battleMapHall/fragmentMap/view/item/FragmentChapterItem')
battleMap.FragmentStageAwardItem = require('game/battleMapHall/fragmentMap/view/item/FragmentStageAwardItem')
battleMap.FragmentStageItem = require('game/battleMapHall/fragmentMap/view/item/FragmentStageItem')
battleMap.FragmentStageListPanel = require('game/battleMapHall/fragmentMap/view/FragmentStageListPanel')
-- battleMap.FragmentStageAwardView = require('game/battleMapHall/fragmentMap/view/FragmentStageAwardView')
battleMap.FragmentMapManager = require("game/battleMapHall/fragmentMap/manager/FragmentMapManager").new()
battleMap.FragmentMapController = require("game/battleMapHall/fragmentMap/controller/FragmentMapController").new(battleMap.FragmentMapManager)
battleMap.FragmentMapStageVo = require("game/battleMapHall/fragmentMap/manager/vo/FragmentMapStageVo")
battleMap.FragmentMapChapterVo = require("game/battleMapHall/fragmentMap/manager/vo/FragmentMapChapterVo")
battleMap.FragmentMapMsgChapterVo = require("game/battleMapHall/fragmentMap/manager/vo/FragmentMapMsgChapterVo")

local module = { battleMap.BattleMapHallController, battleMap.MainMapController, battleMap.BiographyController, battleMap.FragmentMapController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]