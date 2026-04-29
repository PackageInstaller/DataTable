_class("FindTreasureSkill", Object)
FindTreasureSkill = FindTreasureSkill

function FindTreasureSkill:Constructor(id)
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  self._minDistance = cfg.SkillMinDistance / 1000
  self._maxDistance = cfg.SkillMaxDistance / 1000
  self._maxEffect = cfg.MaxDistanceEffect
  self._middleEffect = cfg.MiddleDistanceEffect
  self._minEffect = cfg.MinDistanceEffect
  self._maxAngle = cfg.MaxAngle / 1000
  self._middleAngle = cfg.MiddleAngle / 1000
  self._minAngle = cfg.MinAngle / 1000
  self._effectModelReq = nil
  self._forwardDis = cfg.ForwardDistance / 1000
end

function FindTreasureSkill:ReleaseSkill(personTran, targetPos)
  local dis = Vector3.Distance(personTran.position, targetPos)
  local model
  local angle = 0
  if dis >= self._maxDistance then
    model = self._maxEffect
    angle = self._maxAngle
  elseif dis > self._minDistance and dis < self._maxDistance then
    model = self._middleEffect
    angle = self._middleAngle
  else
    model = self._minEffect
    angle = self._minAngle
  end
  self._effectModelReq = ResourceManager:GetInstance():SyncLoadAsset(model, LoadType.GameObject)
  local go = self._effectModelReq.Obj
  go:SetActive(true)
  local tran = go.transform
  local pos = personTran.position + personTran.forward * self._forwardDis
  local dir = Quaternion.LookRotation((targetPos - personTran.position).normalized)
  tran.position = pos
  tran.rotation = dir
  local rotateAngle = math.random(-angle, angle)
  tran:Rotate(Vector3.up, rotateAngle)
end

function FindTreasureSkill:Destroy()
  if self._effectModelReq then
    self._effectModelReq:Dispose()
    self._effectModelReq = nil
  end
end
