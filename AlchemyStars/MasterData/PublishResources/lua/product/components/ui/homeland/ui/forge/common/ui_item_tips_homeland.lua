_class("UIItemTipsHomeland", UIController)
UIItemTipsHomeland = UIItemTipsHomeland

function UIItemTipsHomeland:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
end

function UIItemTipsHomeland:OnShow(uiParams)
  self.itemTplId = uiParams[1]
  self.go = uiParams[2]
  self.showItemCount = uiParams[3]
  self.bg = self:GetGameObject("bg")
  local passEvent = self.bg:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:closeOnClick()
  end)
  self._black_mask = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/black_mask"):GetComponent(typeof(UnityEngine.UI.Image))
  self._black_mask.raycastTarget = false
  self.c = self:GetUIComponent("RectTransform", "c")
  self.itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.txtUseDesc = self:GetUIComponent("UILocalizationText", "txtUseDesc")
  self.line1 = self:GetGameObject("Line1")
  self.txtWay = self:GetUIComponent("UILocalizationText", "txtWay")
  self.svRect = self:GetUIComponent("RectTransform", "svRect")
  self.content = self:GetUIComponent("RectTransform", "content")
  self:ResolveScrollRectJittering(self.svRect, self.content)
  self:Flush()
  self:FlushPos()
end

function UIItemTipsHomeland:ResolveScrollRectJittering(rect, content)
  if rect.sizeDelta.y < content.sizeDelta.y then
    return
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    local layout = content:GetComponent("VerticalLayoutGroup")
    layout.padding.bottom = math.floor(rect.sizeDelta.y - content.sizeDelta.y + 2)
  end)
end

function UIItemTipsHomeland:OnHide()
  self._black_mask.raycastTarget = true
end

function UIItemTipsHomeland:Flush()
  local cfg = Cfg.cfg_item[self.itemTplId]
  local c = self.mRole:GetAssetCount(self.itemTplId) or 0
  local ra = RoleAsset:New()
  ra.assetid = self.itemTplId
  ra.count = c
  local ui = self.itemPool:SpawnObject("UIItemHomeland")
  ui:Flush(ra, nil)
  ui:ClearTextCount()
  self.txtName:SetText(StringTable.Get(cfg.Name))
  self.txtCount:SetText(c)
  self.txtDesc:SetText(StringTable.Get(cfg.Intro))
  if cfg.UseDesc then
    self.txtUseDesc.gameObject:SetActive(true)
    self.txtUseDesc:SetText(StringTable.Get(cfg.UseDesc))
    self.line1:SetActive(true)
  else
    self.txtUseDesc.gameObject:SetActive(false)
    self.line1:SetActive(false)
  end
  local ways = self:GetHomelandPathItemDataListByTplId(self.itemTplId)
  local len = table.count(ways)
  if len == 0 then
    self.txtWay:SetText(StringTable.Get("str_item_public_no_path"))
  else
    local strTable = {}
    for index, way in ipairs(ways) do
      local desc = StringTable.Get(way.desc)
      table.insert(strTable, desc)
    end
    self.txtWay:SetText(table.concat(strTable, "\n"))
  end
end

function UIItemTipsHomeland:GetHomelandPathItemDataListByTplId(tplId)
  local ways = {}
  self:InsertGiftWay(ways, tplId)
  local cfg = Cfg.cfg_item_getway[tplId]
  if cfg then
    local count = table.count(cfg)
    for i = 1, count - 1 do
      local id = cfg["Getway" .. tostring(i)]
      if id then
        local t = UIItemGetWayData:New()
        t:SetData(id)
        if t:CheckChapter() then
          table.insert(ways, t)
        end
      end
    end
  end
  self:InsertCommonEC(ways, tplId)
  return ways
end

function UIItemTipsHomeland:InsertGiftWay(ways, tplId)
  local cfg_item_gift = Cfg.cfg_item_gift({
    ItemGiftType = ItemGiftType.ItemGiftType_Choose
  })
  if cfg_item_gift and 0 < #cfg_item_gift then
    for i = 1, #cfg_item_gift do
      local cfg = cfg_item_gift[i]
      local itemid = cfg.ID
      local count = self._itemModule:GetItemCount(itemid)
      if 0 < count then
        local itemList = cfg.ItemList
        for j = 1, #itemList do
          local itemListData = itemList[j]
          local openItemId = itemListData[1]
          if openItemId == tplId then
            local t = UIItemGetWayData:New()
            t:SetGiftWay(itemid)
            table.insert(ways, t)
            break
          end
        end
      end
    end
  end
end

function UIItemTipsHomeland:InsertCommonEC(ways, tplId)
  local cfg = Cfg.cfg_petawakening_common_exchange[tplId]
  if cfg then
    local needRoleAsset = cfg.NeedRoleAsset
    if needRoleAsset and table.count(needRoleAsset) > 0 then
      for i = 1, #needRoleAsset do
        local data = needRoleAsset[i]
        local id = data[1]
        local count = data[2]
        local t = UIItemGetWayData:New()
        t:SetECWay(id, count)
        table.insert(ways, t)
      end
    end
  end
end

function UIItemTipsHomeland:FlushPos()
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
    local size = self.c.sizeDelta
    local pos = self.c.anchoredPosition
    local oldPivot = self.c.pivot
    self.c.pivot = Vector2(0.5, 0.5)
    pos.x = pos.x + (0.5 - oldPivot.x) * size.x
    pos.y = pos.y + (0.5 - oldPivot.y) * size.y
    local halfScreenH = UnityEngine.Screen.height * 0.5
    local halfH = size.y * 0.5
    if pos.y > 0 then
      local dh = pos.y + halfH - halfScreenH
      if 0 < dh then
        pos.y = pos.y - dh
      end
    elseif pos.y < 0 then
      local dh = pos.y - halfH + halfScreenH
      if dh < 0 then
        pos.y = pos.y - dh
      end
    end
    self.c.anchoredPosition = pos
  end
end

function UIItemTipsHomeland:closeOnClick()
  self:CloseDialog()
end
