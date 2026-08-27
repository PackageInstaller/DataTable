local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbCmderCtrl = class("ActLbCmderCtrl", base)
local ActLbCmderEntity = require("Game.ActivityLobby.Entity.ActLbCmderEntity")
local DormUtil = require("Game.Dorm.DormUtil")

function ActLbCmderCtrl:ctor(actLbCtrl)
end

function ActLbCmderCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
  local cmderGo = self.actLbCtrl.lbComRes.cmderPrefab:Instantiate()
  local headFxPrefab = self.actLbCtrl.lbComRes.cmderHeadFxPrefab:Instantiate(cmderGo.transform)
  self.lbCmderEntity = ActLbCmderEntity.New()
  self.lbCmderEntity:InitActLbCmderEntity(self, headFxPrefab, cmderGo, bind.playerRigidbodyTran)
  local actLbCfg = self.actLbCtrl:GetActLbCfg()
  local moveSpeed = actLbCfg.move_spd
  self.lbCmderEntity:SetActLbCmdMoveSpeed(moveSpeed)
  local bornPos = actLbCfg.born_pos
  local realPos = self.recordTempPos or Vector3.Temp(bornPos[1], 0, bornPos[2])
  self.lbCmderEntity:SetActLbCmdPos(realPos)
  self.lbCmderEntity:SetActLbCmdRotation(self.recordTempRotation)
  self.recordTempPos = nil
  self.recordTempRotation = nil
  self.actLbCtrl.actLbCamCtrl:AddLbCamHideableEntt(cmderGo, self.lbCmderEntity)
  self.actLbCtrl.actLbCamCtrl:SetActLbCamFollowTarget(cmderGo.transform)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActLobbyMain, function(win)
    if win == nil then
      return
    end
    win:SetActLbMainJoyStickFunc(BindCallback(self, self._OnJoystickMove), BindCallback(self, self._OnJoystickUp))
  end)
end

function ActLbCmderCtrl:_OnJoystickMove(moveData)
  if self.lbCmderEntity then
    self.lbCmderEntity:ActLbCmderStartMove(moveData)
  end
end

function ActLbCmderCtrl:_OnJoystickUp()
  if self.lbCmderEntity then
    self.lbCmderEntity:LbCmderEndMove()
  end
end

function ActLbCmderCtrl:HeroGreatLbCmd(heroEntity)
  self.lbCmderEntity:LbCmdStartSmoothLookAtTarget(heroEntity.transform)
  heroEntity.transform:DOLookAt(self.lbCmderEntity.transform.position, 0.5):SetLink(heroEntity.gameObject)
end

function ActLbCmderCtrl:LbHeroAndCmdFace2Face(heroEntity, completeFunc)
  UIUtil.AddOneCover("heroFave2Face")
  
  local function realCompleteFunc()
    UIUtil.CloseOneCover("heroFave2Face")
    if completeFunc then
      completeFunc()
    end
  end
  
  self.lbCmderEntity:LbCmdStartSmoothLookAtTarget(heroEntity.transform)
  heroEntity.transform:DOLookAt(self.lbCmderEntity.transform.position, 0.5):SetLink(heroEntity.gameObject):OnComplete(realCompleteFunc)
end

function ActLbCmderCtrl:LbCmdMoveDestPos(worldPos)
  self.lbCmderEntity:LbCmdEntMoveDestPos(worldPos)
  self._rootBind.fxSearchTarget.gameObject:SetActive(false)
  self._rootBind.fxSearchTarget.gameObject:SetActive(true)
  self._rootBind.fxSearchTarget.position = worldPos
end

function ActLbCmderCtrl:LbCmdMove2Entt(entt)
  local camDir = Quaternion.TempEuler(0, UIManager:GetMainCamera().transform.eulerAngles.y, 0):MulVec3(Vector3.Temp(0, 0, 0.5))
  local targetPos = entt.transform.position - camDir
  self:LbCmdMoveDestPos(targetPos)
end

function ActLbCmderCtrl:GetActLbCmderResPath()
  local preLoadHelper = self.actLbCtrl:GetPreLoadHelper()
  if preLoadHelper.GetCmderResIdFunc then
    local heroId = preLoadHelper.GetCmderResIdFunc()
    if heroId and heroId ~= 0 then
      local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
      local resCfg = skinCtr:GetResModel(heroId, 0)
      if resCfg ~= nil then
        return resCfg.src_id_model
      end
    end
  end
  local lbCfg = self.actLbCtrl:GetActLbCfg()
  if lbCfg.character ~= 0 then
    local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local resCfg = skinCtr:GetResModel(lbCfg.character, lbCfg.character_skin)
    if resCfg ~= nil then
      return resCfg.src_id_model
    end
  end
  return DormUtil.GetDormCmderResName()
end

function ActLbCmderCtrl:RecordCmderEntityPos()
  if self.lbCmderEntity then
    local pos = self.lbCmderEntity:GetActLbCmdPos()
    self.recordTempPos = Vector3.New(pos.x, pos.y, pos.z)
    local qua = self.lbCmderEntity:GetActLbCmdRotation()
    self.recordTempRotation = Quaternion.New(qua.x, qua.y, qua.z, qua.w)
  end
end

function ActLbCmderCtrl:SetLbCmderObj(bool)
  if self.lbCmderEntity then
    self.lbCmderEntity:SetColliderShow(bool)
  end
end

function ActLbCmderCtrl:Delete()
  if self.lbCmderEntity then
    self.lbCmderEntity:OnDelete()
    self.lbCmderEntity = nil
  end
end

return ActLbCmderCtrl
