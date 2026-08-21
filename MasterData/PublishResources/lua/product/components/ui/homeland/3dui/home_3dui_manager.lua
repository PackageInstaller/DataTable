_class("Home3DUIManager", Object)
Home3DUIManager = Home3DUIManager

function Home3DUIManager:Constructor()
  self._talkUnit = nil
  self._talkCount = 10
  self._talkUnitQueue = Home3DUIQueue:New()
  self._nameBoardList = {}
  self._interactList = {}
end

function Home3DUIManager:Init(homelandClient)
  self._homelandClient = homelandClient
  self._3duiReq = nil
  local _3dui
  _3dui = UnityEngine.GameObject.Find("3DUI")
  if not _3dui then
    self._3duiReq = ResourceManager:GetInstance():SyncLoadAsset("UIHome3DUI.prefab", LoadType.GameObject)
    _3dui = self._3duiReq.Obj
    _3dui:SetActive(true)
  end
  _3dui.transform.position = Vector3(0, 0, 0)
  local _3duiCanvas = _3dui.transform:Find("3DUICanvas")
  self._talkRoot = _3duiCanvas:Find("TalkRoot")
  self._talkUnit = self._talkRoot:Find("TalkUnit").gameObject
  self._talkUnit:SetActive(false)
  for i = 1, self._talkCount do
    self:CreateTalkUnit()
  end
  Log.debug("###[Home3DUIManager] Init ! maxCount --> ", self._talkCount)
  Log.debug("###[Home3DUIManager] Init ! queue count --> ", self._talkUnitQueue:Count())
end

function Home3DUIManager:CreateTalkUnit(unit)
  local talkUnit
  if unit then
    talkUnit = unit
  else
    local go = self:Copy(self._talkUnit)
    talkUnit = HomeTalkUnit:New(go)
  end
  talkUnit:Active(false)
  talkUnit:SetUsing(false)
  self._talkUnitQueue:Enqueue(talkUnit)
  Log.debug("###[Home3DUIManager] Enqueue ! queue count --> ", self._talkUnitQueue:Count())
end

function Home3DUIManager:GetTalkUnit()
  local count = self._talkUnitQueue:Count()
  if count <= 0 then
    self:CreateTalkUnit()
    self._talkCount = self._talkCount + 1
    Log.debug("###[Home3DUIManager] maxCount + 1 ! maxCount --> ", self._talkCount)
  end
  local talkUnit = self._talkUnitQueue:Dequeue()
  Log.debug("###[Home3DUIManager] Dequeue ! queue count --> ", self._talkUnitQueue:Count())
  talkUnit:Active(true)
  talkUnit:SetUsing(true)
  return talkUnit
end

function Home3DUIManager:ReturnTalkUnit(unit)
  self:CreateTalkUnit(unit)
end

function Home3DUIManager:Update(deltaTimeMS)
end

function Home3DUIManager:Dispose()
  Log.debug("###[Home3DUIManager] Dispose ! queue count --> ", self._talkUnitQueue:Count())
  if self._3duiReq then
    self._3duiReq:Dispose()
    self._3duiReq = nil
  end
  for i = 1, #self._nameBoardList do
    self._nameBoardList[i]:Dispose()
  end
  self._nameBoardList = nil
  for i = 1, #self._interactList do
    self._interactList[i]:Dispose()
  end
  self._interactList = nil
  if self._nameBoardAtlas then
    self._nameBoardAtlas = nil
    self._nameBoardAtlasResReq:Dispose()
  end
end

function Home3DUIManager:Copy(go)
  local copy = UnityEngine.GameObject.Instantiate(go, Vector3(0, 0, 0), Quaternion.identity, self._talkRoot)
  return copy
end

function Home3DUIManager:AddNameBoard(root, spriteName, stringKey)
  local resReq = ResourceManager:GetInstance():SyncLoadAsset("UIHomelandNameBoard.prefab", LoadType.GameObject)
  local go = resReq.Obj
  local image = go:GetComponentInChildren(typeof(UnityEngine.UI.Image))
  local text = go:GetComponentInChildren(typeof(UILocalizationText))
  if not self._nameBoardAtlas then
    self._nameBoardAtlasResReq = ResourceManager:GetInstance():SyncLoadAsset("UIHomeland3D.spriteatlas", LoadType.SpriteAtlas)
    self._nameBoardAtlas = self._nameBoardAtlasResReq.Obj
  end
  go:SetActive(true)
  go.transform:SetParent(root, false)
  image.sprite = self._nameBoardAtlas:GetSprite(spriteName)
  text:SetText(StringTable.Get(stringKey))
  table.insert(self._nameBoardList, resReq)
  return go
end

function Home3DUIManager:AddInteractBoard(root)
  local resReq = ResourceManager:GetInstance():SyncLoadAsset("UIHomelandInteractBoard.prefab", LoadType.GameObject)
  table.insert(self._interactList, resReq)
  local go = resReq.Obj
  go:SetActive(true)
  go.transform:SetParent(root, false)
  local resReq = ResourceManager:GetInstance():SyncLoadAsset("eff_jy_meme_tanhao.prefab", LoadType.GameObject)
  table.insert(self._interactList, resReq)
  local goEff = resReq.Obj
  goEff:SetActive(true)
  local effRoot = go.transform:Find("effRoot")
  goEff.transform:SetParent(effRoot, false)
  return go
end

_class("HomeTalkUnit", Object)
HomeTalkUnit = HomeTalkUnit

function HomeTalkUnit:Constructor(go)
  self._selfMsgWidth = 565
  self._go = go
  self._tr = go.transform
  self._layout = self._tr:Find("layout")
  self._layoutGroup = self._layout:GetComponent("VerticalLayoutGroup")
  self._tex = self._layout:Find("talkTex").gameObject:GetComponent("UILocalizationText")
  self._texRect = self._layout:Find("talkTex").gameObject:GetComponent("RectTransform")
  self._filter = self._layout:GetComponent("ContentSizeFitter")
  self._layoutRect = self._layout:GetComponent("RectTransform")
end

function HomeTalkUnit:SetPos(pos)
  self._tr.position = pos
end

function HomeTalkUnit:SetRotation(rot)
  self._tr.rotation = rot
end

function HomeTalkUnit:SetTex(tex)
  self:_SetText(tex)
end

function HomeTalkUnit:Active(active)
  self._go:SetActive(active)
end

function HomeTalkUnit:GetUsing()
  return self._using
end

function HomeTalkUnit:SetUsing(using)
  self._using = using
end

function HomeTalkUnit:_SetText(tex)
  self._tex:SetText(tex)
  self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
  self._layoutGroup.childControlWidth = true
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._layoutRect)
  if self._tex.preferredWidth > self._selfMsgWidth then
    self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    self._layoutGroup.childControlWidth = false
    self._layoutRect.sizeDelta = Vector2(self._selfMsgWidth, self._layoutRect.sizeDelta.y)
    self._texRect.sizeDelta = Vector2(self._selfMsgWidth, self._texRect.sizeDelta.y)
  else
    self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    self._layoutGroup.childControlWidth = true
  end
end

_class("Home3DUIQueue", Object)
Home3DUIQueue = Home3DUIQueue

function Home3DUIQueue:Constructor()
  self._queue = {}
end

function Home3DUIQueue:Enqueue(item)
  table.insert(self._queue, item)
end

function Home3DUIQueue:Dequeue()
  if self:Count() > 0 then
    local item = self._queue[1]
    table.remove(self._queue, 1)
    return item
  end
end

function Home3DUIQueue:Count()
  return table.count(self._queue)
end
