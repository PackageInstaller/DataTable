_class("UINxIntrBase", UIController)
UINxIntrBase = UINxIntrBase

function UINxIntrBase:Constructor()
end

function UINxIntrBase:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UINxIntrBase] self._cfg is nil. param --> ", self._param)
  end
  self:GetComponents()
  self:OnValue()
end

function UINxIntrBase:GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._poolGo = self:GetGameObject("Pool")
  self._contentGo = self:GetGameObject("Content")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
end

function UINxIntrBase:V_ItemName()
  return "UINxIntrItemBase"
end

function UINxIntrBase:OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  local content = self._cfg.Intro
  self._poolGo:SetActive(content == nil)
  self._contentGo:SetActive(content ~= nil)
  if content then
    self._desc:SetText(StringTable.Get(self._cfg.Intro))
  else
    local n = 0
    local key = self._cfg.Title
    while true do
      n = n + 1
      local keyHead = StringTable.Has(key .. "head_" .. n)
      if not keyHead then
        n = n - 1
        break
      end
    end
    if n <= 0 then
      Log.fatal("###[UINxIntrBase] no [" .. key .. "head_n] in str_nx.xlsx")
      return
    end
    self._pool:SpawnObjects(self:V_ItemName(), n)
    local pools = self._pool:GetAllSpawnList()
    for i = 1, n do
      local item = pools[i]
      if item then
        local head = StringTable.Get(key .. "head_" .. i)
        local body = StringTable.Get(key .. "body_" .. i)
        item:Flush(head, body)
      end
    end
  end
end

function UINxIntrBase:BgOnClick(go)
  self:CloseDialog()
end

function UINxIntrBase:CloseBtnOnClick(go)
  self:CloseDialog()
end
