_class("AircraftStorySmallPointHolder", Object)
AircraftStorySmallPointHolder = AircraftStorySmallPointHolder

function AircraftStorySmallPointHolder:Constructor(trans, floor)
  self._point = {}
  if trans == nil then
    Log.fatal("###父节点空")
  end
  if trans.childCount > 0 then
    for i = 1, trans.childCount do
      local petCount = i
      local petCountRoot = trans:GetChild(i - 1)
      if petCountRoot.childCount <= 0 then
        Log.fatal("###[AircraftStorySmallPointHolder]  petCountRoot.childCount <= 0 !")
      end
      self._point[i] = {}
      for j = 1, petCountRoot.childCount do
        local point = petCountRoot:GetChild(j - 1)
        point.gameObject:SetActive(false)
        self._point[i][j] = {}
        self._point[i][j].occupy = false
        self._point[i][j].floor = floor
        self._point[i][j].point = point
      end
    end
  else
    Log.fatal("###[AircraftStorySmallPointHolder] :AddPoint --> trans.childCount <= 0 !")
  end
end

function AircraftStorySmallPointHolder:GetPoint(petCount)
  if self._point[petCount] then
    for i = 1, #self._point[petCount] do
      if not self._point[petCount][i].occupy then
        self._point[petCount][i].occupy = true
        return self._point[petCount][i].point
      end
    end
  else
    Log.debug("###[AircraftStorySmallPointHolder] 没有找到该人数的点 , petCount --> ", petCount)
  end
  return nil
end

function AircraftStorySmallPointHolder:ReleasePoint()
  for i = 1, #self._point do
    for j = 1, #self._point[i] do
      self._point[i][j].occupy = false
    end
  end
end
