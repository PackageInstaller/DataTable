CaptureGame = CaptureGame or {}
CaptureGameConst = import("game.captureGame.CaptureGameConst")

require("game/captureGame/logic/CaptureTask/Conditions/CaptureConditionInclude")

CaptureGameBridge = import("game.captureGame.CaptureGameBridge")
CaptureGameMgr = import("game.captureGame.logic.CaptureGameMgr")

CaptureGameMgr:Init()

CaptureGameHelper = import("game.captureGame.CaptureGameHelper")
CaptureEntityBase = import("game.captureGame.Entity.CaptureEntityBase")
CaptureRoleEntity = import("game.captureGame.Entity.CaptureRoleEntity")
CapturePlaceHolderEntity = import("game.captureGame.Entity.CapturePlaceHolderEntity")
CaptureDecoratorEntity = import("game.captureGame.Entity.CaptureDecoratorEntity")
CaptureLogicMgrBase = import("game.captureGame.logic.CaptureLogicMgrBase")
EntityMgr = import("game.captureGame.Entity.EntityMgr")
CapturePlaceHolderMgr = import("game.captureGame.logic.PlaceHolderMgr.CapturePlaceHolderMgr")
CaptureTaskMgr = import("game.captureGame.logic.CaptureTask.CaptureTaskMgr")
CaptureCameraMgr = import("game.captureGame.logic.CameraLogic.CaptureCameraMgr")
CaptureRoleMgr = import("game.captureGame.logic.CaptureRole.CaptureRoleMgr")
