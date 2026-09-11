require("game/qworld/bubble/QWorldBubbleInclude")
require("game/qworld/luaBridge/QWorldLuaBridge")
require("game/qworld/story/QWorldStoryConst")
require("game/qworld/QWorldConst")

QWorldEntityMiniMap = import("game.qworld.prefabScript.QWorldEntityMiniMap")
QWorldEntiyScript = import("game.qworld.prefabScript.QWorldEntiyScript")
QWorldPrefab = import("game.qworld.prefabScript.QWorldPrefab")
QWorldMgr = import("game.qworld.gameMgr.QWorldMgr")

QWorldMgr:Init()

QWorldGoto = import("game.qworld.go.QWorldGoto")

QWorldGoto:Init()

QWorldNotifyQueue = import("game.qworld.gameMgr.QWorldNotifyQueue")
QWorldQuanzhouNotify = import("game.qworld.gameMgr.QWorldQuanzhouNotify")
