_class("UIN27LotteryAward", UICustomWidget)
UIN27LotteryAward = UIN27LotteryAward
_class("UIN27LotteryAwardCell", UICustomWidget)
UIN27LotteryAwardCell = UIN27LotteryAwardCell

function UIN27LotteryAward:Constructor()
end

function UIN27LotteryAward:OnShow(uiParams)
  self._uiBig = self:GetUIComponent("UISelectObjectPath", "uiBig")
  self._uiNormal = self:GetUIComponent("UISelectObjectPath", "uiNormal")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN27LotteryAward:OnHide()
end

function UIN27LotteryAward:Flush(parent, dataItem)
  self._parent = parent
  self._dataItem = dataItem
  if self._uiBigSpawn ~= nil then
    self._uiBigSpawn:View().gameObject:SetActive(false)
  end
  if self._uiNormalSpawn ~= nil then
    self._uiNormalSpawn:View().gameObject:SetActive(false)
  end
  if self._dataItem.m_is_big_reward then
    self:ResetCellSize(self._uiBig.dynamicInfoOfEngine.transform.sizeDelta)
    self._uiBigSpawn = self._uiBig:SpawnObject("UIN27LotteryAwardCell")
    self._uiBigSpawn:View().gameObject:SetActive(true)
  else
    self:ResetCellSize(self._uiNormal.dynamicInfoOfEngine.transform.sizeDelta)
    self._uiNormalSpawn = self._uiNormal:SpawnObject("UIN27LotteryAwardCell")
    self._uiNormalSpawn:View().gameObject:SetActive(true)
  end
  self:FlushSpawn()
end

function UIN27LotteryAward:FlushSpawn()
  if self._uiBigSpawn ~= nil then
    self._uiBigSpawn:Flush(self._parent, self._dataItem)
  end
  if self._uiNormalSpawn ~= nil then
    self._uiNormalSpawn:Flush(self._parent, self._dataItem)
  end
end

function UIN27LotteryAward:ResetCellSize(cellSize)
  local view = self:View()
  local rt = view.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2.one * 0.5
  rt.anchorMax = Vector2.one * 0.5
  rt.sizeDelta = cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIN27LotteryAward:PlayAnimation(animName)
  self._animation:Play(animName)
end

function UIN27LotteryAward:SetActive(inActive)
  if self._uiBigSpawn ~= nil then
    self._uiBigSpawn:View().gameObject:SetActive(false)
  end
  if self._uiNormalSpawn ~= nil then
    self._uiNormalSpawn:View().gameObject:SetActive(false)
  end
  if self._dataItem.m_is_big_reward then
    self._uiBigSpawn:View().gameObject:SetActive(inActive)
  else
    self._uiNormalSpawn:View().gameObject:SetActive(inActive)
  end
end

function UIN27LotteryAwardCell:Constructor()
end

function UIN27LotteryAwardCell:OnShow(uiParams)
  self._itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self._itemNumText = self:GetUIComponent("UILocalizationText", "itemNumText")
  self._restNumText = self:GetUIComponent("UILocalizationText", "restNumText")
  self._imgEmptyMask = self:GetUIComponent("RectTransform", "imgEmptyMask")
  self._imgStar = self:GetUIComponent("RectTransform", "imgStar")
end

function UIN27LotteryAwardCell:OnHide()
end

function UIN27LotteryAwardCell:Flush(parent, dataItem)
  self._parent = parent
  self._dataItem = dataItem
  local itemCfg = Cfg.cfg_item[self._dataItem.m_item_id]
  if itemCfg then
    local res = itemCfg.Icon
    self._itemIcon:LoadImage(res)
  end
  self._itemNumText:SetText(string.format("x%d", self._dataItem.m_count))
  local remain = self._dataItem.m_lottery_count
  local total = self._dataItem.m_lottery_limit_count
  self._restNumText:SetText(string.format("%d/%d", remain, total))
  self._imgEmptyMask.gameObject:SetActive(self._dataItem.m_lottery_count == 0)
  self._imgStar.gameObject:SetActive(self._dataItem.m_is_big_reward and self._dataItem.m_lottery_count > 0)
end

function UIN27LotteryAwardCell:ButtonOnClick(go)
  if self._parent ~= nil then
    self._parent:ShowAwardTips(self._dataItem, go.transform.position)
  end
end
