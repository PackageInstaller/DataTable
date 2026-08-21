_class("UIChainItem", UICustomWidget)

function UIChainItem:Constructor()
end

function UIChainItem:OnShow(uiParams)
  self._brightGo = self:GetGameObject("imgSelect")
  self._chainNumText = self:GetUIComponent("UILocalizationText", "txtId")
  self._brightGo:SetActive(false)
  self._index = 0
  self._itemIndex = 0
  self._isMoreThanOne = false
end

function UIChainItem:SetData(skillID, curIndex, itemIndex, isMoreThanOne)
  self._itemIndex = itemIndex
  self._index = curIndex
  self._isMoreThanOne = isMoreThanOne
  local cfg = BattleSkillCfg(skillID)
  if cfg ~= nil then
    self._chainNumText:SetText(cfg.TriggerParam)
    self:HideBright(curIndex)
  end
end

function UIChainItem:HideBright(curIndex)
  self._index = curIndex
  if self._isMoreThanOne then
    if curIndex ~= self._itemIndex then
      self._brightGo:SetActive(false)
    else
      self._brightGo:SetActive(true)
    end
  end
end
