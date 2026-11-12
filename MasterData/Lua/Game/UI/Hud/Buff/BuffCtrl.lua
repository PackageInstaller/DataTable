local BuffCtrl = class("BuffCtrl", BaseCtrl)
BuffCtrl._mapNodeConfig = {
  goBuffGrid = {},
  rtPool = {sComponentName = "Transform"},
  buffContent = {sComponentName = "Transform"}
}
BuffCtrl._mapEventConfig = {}

function BuffCtrl:Awake()
  self.mapBuff = {}
  self.tbPool = {}
  self.tbAllCtrl = {}
end

function BuffCtrl:FadeIn()
end

function BuffCtrl:FadeOut()
end

function BuffCtrl:OnEnable()
  self.nActiveCount = 0
end

function BuffCtrl:OnDisable()
  if self.nEntityId ~= nil then
    self:UnbindEntity()
  end
end

function BuffCtrl:OnDestroy()
end

function BuffCtrl:OnRelease()
end

function BuffCtrl:AddShield()
  if self.buffGrid ~= nil then
    return
  end
  local shieldGrid = self:GetBuffGrid()
  shieldGrid.gameObject.transform:SetAsFirstSibling()
  self.buffGrid = shieldGrid
  self.buffGrid:SetShield()
end

function BuffCtrl:RemoveShield()
  if self.buffGrid == nil then
    return
  end
  if self.buffGrid ~= nil then
    local buffGrid = self.buffGrid
    self.buffGrid = nil
    
    local function animCallback()
      self:RecycleBuffGrid(buffGrid)
    end
    
    buffGrid:CancelBuff(animCallback)
  end
end

function BuffCtrl:OnEvent_BuffUI(nUid, nBuffId, nTime, nCount)
  local mapBuff = ConfigTable.GetData_Buff(nBuffId)
  if mapBuff == nil then
    printError("Buff Data Missing:" .. nBuffId)
    return
  end
  if not mapBuff.IsShow then
    return
  end
  if nTime == 0 or nCount == 0 then
    if self.mapBuff[nUid] == nil then
      print("0时间或层数buff 不处理")
      return
    else
      local removedCtrl = self.mapBuff[nUid]
      self.mapBuff[nUid] = nil
      
      local function animCallback()
        self:RecycleBuffGrid(removedCtrl)
      end
      
      removedCtrl:CancelBuff(animCallback)
      self.nActiveCount = self.nActiveCount - 1
    end
  else
    if self.nActiveCount > 40 then
      printError("buff数量过多本次不处理")
      return
    end
    if self.mapBuff[nUid] == nil then
      self.mapBuff[nUid] = self:GetBuffGrid()
      self.nActiveCount = self.nActiveCount + 1
    end
    self.mapBuff[nUid]:SetBuff(nBuffId, nCount, nTime)
  end
end

function BuffCtrl:GetBuffGrid()
  if #self.tbPool > 0 then
    local mapGoCtrl = table.remove(self.tbPool)
    mapGoCtrl.gameObject.transform:SetParent(self._mapNode.buffContent)
    local rtGo = mapGoCtrl.gameObject:GetComponent("RectTransform")
    mapGoCtrl:InterrputAnim()
    rtGo.localPosition = Vector3.zero
    rtGo.localScale = Vector3.one
    rtGo.sizeDelta = Vector2(46, 64)
    mapGoCtrl.gameObject:SetActive(true)
    return mapGoCtrl
  else
    local goGrid = instantiate(self._mapNode.goBuffGrid)
    goGrid.transform:SetParent(self._mapNode.buffContent)
    local rtGo = goGrid.gameObject:GetComponent("RectTransform")
    rtGo.localPosition = Vector3.zero
    rtGo.localScale = Vector3.one
    rtGo.sizeDelta = Vector2(46, 64)
    goGrid:SetActive(true)
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Hud.Buff.BuffGridCtrl")
    table.insert(self.tbAllCtrl, mapCtrl)
    return mapCtrl
  end
end

function BuffCtrl:RecycleBuffGrid(mapGridCtrl)
  table.insert(self.tbPool, mapGridCtrl)
  mapGridCtrl:InterrputAnim()
  mapGridCtrl.gameObject:SetActive(false)
  mapGridCtrl.gameObject.transform:SetParent(self._mapNode.rtPool)
end

function BuffCtrl:BindEntity(nEntityId)
  if self.nEntityId ~= nil then
    printError(string.format("buff已被绑定 当前:%d,绑定:%d", self.nEntityId, nEntityId))
    return
  end
  self.nEntityId = nEntityId
  EventManager.AddEntityEvent("BuffUIEvent", nEntityId, self, self.OnEvent_BuffUI)
  self:ClearAllBuffGrid()
  local AdventureModuleHelper = CS.AdventureModuleHelper
  local tbBuffInfo = AdventureModuleHelper.GetEntityBuffList(self.nEntityId)
  if tbBuffInfo ~= nil then
    local nBuffCount = tbBuffInfo.Count - 1
    for l = 0, nBuffCount do
      local eftInfo = tbBuffInfo[l]
      local nUid = eftInfo:GetUid()
      local nTime = eftInfo:GetBuffLeftTime():AsInt()
      self:OnEvent_BuffUI(nUid, eftInfo.buffConfig.Id, nTime, eftInfo:GetBuffNum())
    end
  end
end

function BuffCtrl:UnbindEntity()
  EventManager.RemoveEntityEvent("BuffUIEvent", self.nEntityId, self, self.OnEvent_BuffUI)
  self.nEntityId = nil
  self:ClearAllBuffGrid()
end

function BuffCtrl:ClearAllBuffGrid()
  self.mapBuff = {}
  self.tbPool = {}
  self.nActiveCount = 0
  for _, mapCtrl in ipairs(self.tbAllCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.buffGrid = nil
  self.tbAllCtrl = {}
  if self._mapNode.rtPool and type(self._mapNode.rtPool) ~= "number" then
    delChildren(self._mapNode.rtPool)
  end
  if self._mapNode.buffContent and type(self._mapNode.buffContent) ~= "number" then
    delChildren(self._mapNode.buffContent)
  end
end

return BuffCtrl
