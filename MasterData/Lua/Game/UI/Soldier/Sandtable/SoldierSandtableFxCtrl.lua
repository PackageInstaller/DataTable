local SoldierSandtableFxCtrl = class("SoldierSandtableFxCtrl", BaseCtrl)
local nTime = 0.5
local fxType = {
  Gray = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Gold = 5,
  Coin = 99
}
SoldierSandtableFxCtrl._mapNodeConfig = {
  RoleSlide_Coin = {},
  RoleSlide_Blue = {nCount = 5},
  RoleSlide_Gold = {nCount = 5},
  RoleSlide_Gray = {nCount = 6},
  RoleSlide_Green = {nCount = 5},
  RoleSlide_Purple = {nCount = 5}
}
SoldierSandtableFxCtrl._mapEventConfig = {}
SoldierSandtableFxCtrl._mapRedDotConfig = {}

function SoldierSandtableFxCtrl:Awake()
end

function SoldierSandtableFxCtrl:OnEnable()
  self:InitFx()
end

function SoldierSandtableFxCtrl:InitFx()
  self._mapNode.RoleSlide_Coin:SetActive(false)
  self.tbUnUseNode = {
    [fxType.Coin] = {},
    [fxType.Blue] = {},
    [fxType.Gold] = {},
    [fxType.Gray] = {},
    [fxType.Green] = {},
    [fxType.Purple] = {}
  }
  self.tbUseNode = {
    [fxType.Coin] = {},
    [fxType.Blue] = {},
    [fxType.Gold] = {},
    [fxType.Gray] = {},
    [fxType.Green] = {},
    [fxType.Purple] = {}
  }
  table.insert(self.tbUnUseNode[fxType.Coin], self._mapNode.RoleSlide_Coin)
  for _, v in ipairs(self._mapNode.RoleSlide_Blue) do
    v:SetActive(false)
    table.insert(self.tbUnUseNode[fxType.Blue], v)
  end
  for _, v in ipairs(self._mapNode.RoleSlide_Gold) do
    v:SetActive(false)
    table.insert(self.tbUnUseNode[fxType.Gold], v)
  end
  for _, v in ipairs(self._mapNode.RoleSlide_Gray) do
    v:SetActive(false)
    table.insert(self.tbUnUseNode[fxType.Gray], v)
  end
  for _, v in ipairs(self._mapNode.RoleSlide_Green) do
    v:SetActive(false)
    table.insert(self.tbUnUseNode[fxType.Green], v)
  end
  for _, v in ipairs(self._mapNode.RoleSlide_Purple) do
    v:SetActive(false)
    table.insert(self.tbUnUseNode[fxType.Purple], v)
  end
end

function SoldierSandtableFxCtrl:PlayFx(tbfx, callback)
  for nType, v in pairs(tbfx) do
    if nType == fxType.Coin then
      local go = self:GetUnUseNode(nType)
      self:PlayFxItem(go, v[1].from, v[1].to, nType)
    elseif nType == fxType.Blue then
      for i = 1, #v do
        local go = self:GetUnUseNode(nType)
        self:PlayFxItem(go, v[i].from, v[i].to, nType)
      end
    elseif nType == fxType.Gold then
      for i = 1, #v do
        local go = self:GetUnUseNode(nType)
        self:PlayFxItem(go, v[i].from, v[i].to, nType)
      end
    elseif nType == fxType.Gray then
      for i = 1, #v do
        local go = self:GetUnUseNode(nType)
        self:PlayFxItem(go, v[i].from, v[i].to, nType)
      end
    elseif nType == fxType.Green then
      for i = 1, #v do
        local go = self:GetUnUseNode(nType)
        self:PlayFxItem(go, v[i].from, v[i].to, nType)
      end
    elseif nType == fxType.Purple then
      for i = 1, #v do
        local go = self:GetUnUseNode(nType)
        self:PlayFxItem(go, v[i].from, v[i].to, nType)
      end
    end
  end
  self:AddTimer(1, nTime - 0.2, function()
    if callback ~= nil then
      callback()
    end
  end, true, true, true)
end

function SoldierSandtableFxCtrl:PlayFxItem(go, from, to, nType)
  if go == nil then
    return
  end
  go:SetActive(true)
  go.transform.position = from.position
  local boomfx = go.transform:Find("P_Ecplor_Cbess")
  boomfx.gameObject:SetActive(true)
  local trail = go.transform:Find("P_Slide_Cbess")
  
  local function animaFunc()
    local beginPos = from.position
    local endPos = to.position
    local controlPos = Vector3((beginPos.x + endPos.x) / 2.0, (beginPos.y + endPos.y) / 2.0, 0)
    
    local function wait()
      local totalMoveTime = nTime - 0.2
      local moveTime = 0
      local normalizedTime = 0
      while normalizedTime < 1 do
        moveTime = moveTime + CS.UnityEngine.Time.unscaledDeltaTime
        normalizedTime = moveTime / totalMoveTime
        normalizedTime = normalizedTime <= 1 and normalizedTime or 1
        local x, y, z = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
        local angleZ = 100 * normalizedTime * 2
        angleZ = angleZ <= 100 and angleZ or 100
        go.transform.localEulerAngles = Vector3(0, 0, angleZ)
        go.transform.position = Vector3(x, y, z)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      end
      go:SetActive(false)
      self:BackUseNode(nType, go)
    end
    
    cs_coroutine.start(wait)
  end
  
  self:AddTimer(1, 0.2, function()
    boomfx.gameObject:SetActive(false)
    animaFunc()
  end, true, true, true)
end

function SoldierSandtableFxCtrl:GetUnUseNode(nType)
  if self.tbUnUseNode[nType] == nil then
    return nil
  end
  local go = table.remove(self.tbUnUseNode[nType], 1)
  if go == nil then
    return nil
  end
  table.insert(self.tbUseNode[nType], go)
  return go
end

function SoldierSandtableFxCtrl:BackUseNode(nType, go)
  if self.tbUseNode[nType] == nil then
    return nil
  end
  local index = table.indexof(self.tbUseNode[nType], go)
  table.remove(self.tbUseNode[nType], index)
  table.insert(self.tbUnUseNode[nType], go)
end

function SoldierSandtableFxCtrl:OnEvent_AAA()
end

return SoldierSandtableFxCtrl
