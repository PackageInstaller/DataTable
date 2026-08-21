_class("SeasonNavTransPoint", Object)
SeasonNavTransPoint = SeasonNavTransPoint

function SeasonNavTransPoint:Constructor(id, baseEventPoint)
  self._zoneID = id
  self._baseEventPoint = baseEventPoint
end

function SeasonNavTransPoint:PlayTransAni()
  if self._baseEventPoint then
    self._baseEventPoint:PlayAnimationSeq("effanim_S4_pfb_chuansongzhu_release", "effanim_S4_pfb_chuansongzhu_idle")
  end
end

function SeasonNavTransPoint:GetZoneID()
  return self._zoneID
end

function SeasonNavTransPoint:GetPosition()
  if not self._showPos then
    self._showPos = self._baseEventPoint:Position()
  end
  return self._showPos
end

function SeasonNavTransPoint:GetNavPosition()
  if not self._navPos then
    local showPos = self:GetPosition()
    local offset
    local cfg = self._baseEventPoint:GetEventPointCfg()
    if cfg then
      offset = cfg.TransportPointSkew
    end
    self._navPos = SeasonNavTransPoint.CalcNavPosition(showPos, offset)
  end
  return self._navPos
end

function SeasonNavTransPoint.CalcNavPosition(position, offset)
  if not offset then
    return position
  end
  if not SeasonNavTransPoint._dirCfg then
    SeasonNavTransPoint._dirCfg = {
      [1] = Vector3(0, 0, -1),
      [2] = Vector3(-1, 0, 0),
      [3] = Vector3(0, 0, 1),
      [4] = Vector3(1, 0, 0)
    }
  end
  local dir = SeasonNavTransPoint._dirCfg[offset]
  if dir then
    return position + dir * 0.5
  end
  return position
end

function SeasonNavTransPoint:IsUnLock()
  return self._baseEventPoint:IsUnlock()
end
