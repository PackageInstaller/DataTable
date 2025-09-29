-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonEventType.lua

module("logic.extensions.dungeon.model.DungeonEventType", package.seeall)

local DungeonEventType = {}

DungeonEventType.ON_SCENE_PICKER_HIT = UIDUtil.getEventUID()
DungeonEventType.ON_SCENE_PICKER_BEGIN_DRAG = UIDUtil.getEventUID()
DungeonEventType.ON_SCENE_PICKER_DRAG = UIDUtil.getEventUID()
DungeonEventType.ON_SCENE_PICKER_END_DRAG = UIDUtil.getEventUID()
DungeonEventType.ON_PICK_Dungeon_Node = UIDUtil.getEventUID()
DungeonEventType.ON_CLICK_ANY = UIDUtil.getEventUID()
DungeonEventType.OnExitDungeonSceneFinish = UIDUtil.getEventUID()
DungeonEventType.OnPlotFinish = UIDUtil.getEventUID()
DungeonEventType.OnPassPlotDungeonReply = UIDUtil.getEventUID()
DungeonEventType.OnBattleFinish = UIDUtil.getEventUID()
DungeonEventType.DUNGEON_SCENE_CLICK_DOWN = UIDUtil.getEventUID()
DungeonEventType.Reward_Detail_Click_Close = UIDUtil.getEventUID()
DungeonEventType.CLOSE_DUNGEON_PANEL = UIDUtil.getEventUID()
DungeonEventType.DUNGEON_DATA_UPDATE = UIDUtil.getEventUID()

return DungeonEventType
