_class("HomelandRoad", Object)
HomelandRoad = HomelandRoad

function HomelandRoad:Constructor()
  self._brick = {}
  self._connect = {}
  self:Init()
end

function HomelandRoad:Init()
  for i = 1, 10 do
    local go = UnityEngine.GameObject.Instantiate(UnityEngine.Resources.Load("Brick"))
    go.transform.position = Vector3(i, 0, 0)
    if i < 4 then
      go.transform.eulerAngles = Vector3(0, 1, 0)
    end
    local left = HomelandBrickEdge:New(go.transform:Find("Left").gameObject)
    local right = HomelandBrickEdge:New(go.transform:Find("Right").gameObject)
    local forward = HomelandBrickEdge:New(go.transform:Find("Forward").gameObject)
    local after = HomelandBrickEdge:New(go.transform:Find("After").gameObject)
    local brick = HomelandBrick:New(go, forward, after, left, right)
    self:AddBrick(brick)
  end
  local brick = self._brick[7]
  self:RemoveBrick(self._brick[7])
  UnityEngine.GameObject.Destroy(brick._build)
end

function HomelandRoad:AddBrick(brick)
  for i = 1, #self._brick do
    if brick:Equal(self._brick[i]) then
      return
    end
  end
  for i = 1, #self._brick do
    local tmp = self._brick[i]
    local isConnect, firstEdge, secondEdge = tmp:IsConnect(brick)
    if isConnect then
      self._connect[#self._connect + 1] = HomelandBrickConnect:New(tmp, firstEdge, brick, secondEdge)
    end
  end
  self._brick[#self._brick + 1] = brick
end

function HomelandRoad:RemoveBrick(brick)
  for i = #self._connect, 1, -1 do
    local connect = self._connect[i]
    if connect:Contain(brick) then
      connect:Destroy()
      table.remove(self._connect, i)
    end
  end
  for i = 1, #self._brick do
    if brick:Equal(self._brick[i]) then
      brick:Destroy()
      table.remove(self._brick, i)
      return
    end
  end
end

function HomelandRoad:ChangeBrick(brick)
  for i = #self._connect, 1, -1 do
    local connect = self._connect[i]
    if connect:Contain(brick) then
      connect:Destroy()
      table.remove(self._connect, i)
    end
  end
  for i = 1, #self._brick do
    local tmp = self._brick[i]
    if not tmp:Equal(brick) then
      local isConnect, firstEdge, secondEdge = tmp:IsConnect(brick)
      if isConnect then
        self._connect[#self._connect + 1] = HomelandBrickConnect:New(tmp, firstEdge, brick, secondEdge)
      end
    end
  end
end
