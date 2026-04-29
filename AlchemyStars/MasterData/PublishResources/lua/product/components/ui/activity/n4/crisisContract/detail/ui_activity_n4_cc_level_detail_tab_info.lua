_class("UIActivityN4CCLevelDetailTabInfo", UICustomWidget)
UIActivityN4CCLevelDetailTabInfo = UIActivityN4CCLevelDetailTabInfo

function UIActivityN4CCLevelDetailTabInfo:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnCCAffixChanged, self._Refresh)
end

function UIActivityN4CCLevelDetailTabInfo:OnHide()
  self:DetachEvent(GameEventType.OnCCAffixChanged, self._Refresh)
end

function UIActivityN4CCLevelDetailTabInfo:InitWidget()
  self.txtAff = self:GetUIComponent("UILocalizationText", "txtAff")
  self.txtEff = self:GetUIComponent("UILocalizationText", "txtEff")
  local effPool = self:GetUIComponent("UISelectObjectPath", "effPool")
  self.effItems = effPool:SpawnObjects("UIActivityN4CCLevelDetailEffItem", 3)
end

function UIActivityN4CCLevelDetailTabInfo:Init(context)
  self._context = context
end

function UIActivityN4CCLevelDetailTabInfo:SetData(cfg)
  self._cfg = cfg
  self._maxAffixNum = self._cfg.AffixNum
  local desc = {}
  for k, subDescKey in pairs(self._cfg.BossDesc) do
    table.insert(desc, StringTable.Get(subDescKey))
  end
  self.txtAff:SetText(table.concat(desc, "\n"))
  self:_Refresh()
end

function UIActivityN4CCLevelDetailTabInfo:_Refresh()
  local affixArray = self._context:GetAffix(self._cfg.CampaignMissionId)
  local num = 0
  if affixArray then
    num = #affixArray
  end
  self.txtEff:SetText(num .. "/" .. self._maxAffixNum)
  for i, v in ipairs(self.effItems) do
    local bLock, effId
    if i > self._maxAffixNum then
      bLock = true
    elseif num >= i then
      effId = affixArray[i]
    end
    v:SetData(effId, bLock, function()
      self:ShowDialog("UIActivityN4CCAffixSelectController", self._context, self._cfg)
    end)
  end
end
