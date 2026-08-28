---@class Live3D_CustomEvents
local Live3D_CustomEvents = {}
-- 外部调用时使用:
-- ---@type Live3D_CustomEvents
--local Live3D_CustomEvents = import('Game.IdolLive3D.Interactive.Customs.Live3D_CustomEvents')


-- 客制脚本专用 event names



Live3D_CustomEvents.Init_StartTwoIdlesChoose = "Init_StartTwoIdlesChoose" -- 入场阶段, 进入 两idles选择模式; 参数: (1)idle100CB, (2)idle200CB
Live3D_CustomEvents.Init_IntoIdle100 = "Init_IntoIdle100" -- 入场阶段, 第一次进入 idle 100
Live3D_CustomEvents.Init_IntoIdle200 = "Init_IntoIdle200" -- 入场阶段, 第一次进入 idle 200
Live3D_CustomEvents.DoDress         = "Live3D_DoDress" -- 穿脱衣服, 参数: isDress:bool


-- superTimeline 结束流程中会被调用; 参数: {iState,clipJson,leaveInfo}
Live3D_CustomEvents.SuperTimelineEndCB_Before = "Live3D_SuperTimelineEndCB_Before" -- 
Live3D_CustomEvents.SuperTimelineEndCB_After = "Live3D_SuperTimelineEndCB_After" -- 






return Live3D_CustomEvents

