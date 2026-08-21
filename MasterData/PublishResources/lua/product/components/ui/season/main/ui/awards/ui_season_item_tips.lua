_class("UISeasonItemTips", UIController)
UISeasonItemTips = UISeasonItemTips

function UISeasonItemTips:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
end

function UISeasonItemTips:OnShow(uiParams)
  self.itemTplId = uiParams[1]
  self.go = uiParams[2]
  self.showItemCount = uiParams[3]
  self.bg = self:GetGameObject("bg")
  local passEvent = self.bg:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:CloseOnClick()
  end)
  self.black_mask = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/black_mask"):GetComponent(typeof(UnityEngine.UI.Image))
  self.black_mask.raycastTarget = false
  self.c = self:GetUIComponent("RectTransform", "c")
  self.itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self:Flush()
  self:FlushPos()
end

function UISeasonItemTips:OnHide()
  self.black_mask.raycastTarget = true
end

function UISeasonItemTips:Flush()
  local cfg = Cfg.cfg_item[self.itemTplId]
  local c = self.mRole:GetAssetCount(self.itemTplId) or 0
  local ra = RoleAsset:New()
  ra.assetid = self.itemTplId
  ra.count = c
  local ui = self.itemPool:SpawnObject("UIItemHomeland")
  ui:Flush(ra, nil)
  self.txtName:SetText(StringTable.Get(cfg.Name))
  self.txtCount:SetText(c)
  self.txtCount.gameObject:SetActive(self.showItemCount)
  self.txtDesc:SetText(StringTable.Get(cfg.Intro))
end

function UISeasonItemTips:FlushPos()
  if self.go then
    local pos = self.go.transform.position
    local posSelf = self.bg.transform.position
    local n = 1
    local step = 5
    local half = step * 0.5
    while posSelf.y - half > pos.y + step * n do
      n = n + 1
    end
    local targetPos = Vector3(pos.x, pos.y + step * n, 0)
    if targetPos.x > 0 then
      if targetPos.y > posSelf.y then
        self.c.pivot = Vector2.one
      else
        self.c.pivot = Vector2(1, 0)
      end
    elseif targetPos.y > posSelf.y then
      self.c.pivot = Vector2(0, 1)
    else
      self.c.pivot = Vector2.zero
    end
    self.c.position = targetPos
  end
end

function UISeasonItemTips:CloseOnClick()
  self:CloseDialog()
end
