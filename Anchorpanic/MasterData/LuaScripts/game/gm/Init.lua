gm ={}
gm.GmCommandVo = require('game/gm/manager/vo/GmCommandVo')
gm.GmManager = require('game/gm/manager/GmManager')
gm.GmTabView = require('game/gm/view/tabView/GmTabView')
gm.LuaTabView = require('game/gm/view/tabView/LuaTabView')
gm.VideoTabView = require('game/gm/view/tabView/VideoTabView')
gm.TestDeltaListTabView = require('game/gm/view/tabView/TestDeltaListTabView')
gm.TestDeltaListItem = require('game/gm/view/tabView/item/TestDeltaListItem')
gm.DownLoadTabView = require('game/gm/view/tabView/DownLoadTabView')
gm.GmFightReplayItem = require('game/gm/view/tabView/GmFightReplayItem')
gm.GmFightPostItem = require('game/gm/view/tabView/GmFightPostItem')
gm.GmFightSettingItem = require('game/gm/view/tabView/GmFightSettingItem')
gm.FightTabView = require('game/gm/view/tabView/FightTabView')
gm.GuideTabView = require('game/gm/view/tabView/GuideTabView')
gm.FlyTextTabView = require('game/gm/view/tabView/FlyTextTabView')
gm.GmPropsView = require('game/gm/view/tabView/GmPropsView')
gm.GmPropsItem = require('game/gm/view/tabView/GmPropsItem')
gm.GmPanel = require('game/gm/view/GmPanel')
gm.GmController = require('game/gm/controller/GmController').new(gm.GmManager)
local module = {gm.GmController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
