_class("SeasonMazePlayerFollower", Object)
SeasonMazePlayerFollower = SeasonMazePlayerFollower

function SeasonMazePlayerFollower:Constructor(player, mazeID)
  self._player = player
  self._req = ResourceManager:GetInstance():SyncLoadAsset("S1000012.prefab", LoadType.GameObject)
  self._gameObject = self._req.Obj
  self._gameObject:SetActive(true)
  self._transform = self._gameObject.transform
  local cfg = Cfg.cfg_season_maze_client[mazeID]
  self._deltaPos = Vector3(cfg.FollowerOffset[1], cfg.FollowerOffset[2], cfg.FollowerOffset[3])
  self._followParam = cfg.FollowParam
  self._targetPos = self._player:Position() + self._deltaPos
  self._curPos = self._targetPos
  self._transform.position = self._curPos
  self._transform.rotation = Quaternion.Euler(-43.6, 2.7, -2.4)
  self._transform.localScale = Vector3.one * 1
  self._anim = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._effectRes = ResourceManager:GetInstance():SyncLoadAsset("pfb_S1000012_main_Bone009S.prefab", LoadType.GameObject)
  local effectObj = self._effectRes.Obj
  effectObj:SetActive(true)
  local effectTr = effectObj.transform
  effectTr:SetParent(GameObjectHelper.FindChild(self._transform, "Bone009-S"))
  effectTr.localPosition = Vector3.zero
  effectTr.localRotation = Quaternion.identity
  effectTr.localScale = Vector3.one
  self._shadow = SeasonMazePlayerShadow:New(self._transform:Find("Root"), -0.35)
end

function SeasonMazePlayerFollower:Update(dtMS)
  self._targetPos = self._player:Position() + self._deltaPos
  self._curPos = Vector3.Lerp(self._curPos, self._targetPos, dtMS / 1000 * self._followParam)
  self._transform.position = self._curPos
  self._transform.rotation = self._player:ModelRotation()
  if self._shadow then
    self._shadow:Update(dtMS)
  end
end

function SeasonMazePlayerFollower:Dispose()
  self._effectRes:Dispose()
  self._effectRes = nil
  self._transform = nil
  self._gameObject = nil
  self._req:Dispose()
  self._req = nil
  if self._shadow then
    self._shadow:Dispose()
    self._shadow = nil
  end
end

function SeasonMazePlayerFollower:FollowImmidiately()
  self._targetPos = self._player:Position() + self._deltaPos
  self._curPos = self._targetPos
  self._transform.position = self._curPos
end

function SeasonMazePlayerFollower:Animation()
  return self._anim
end
