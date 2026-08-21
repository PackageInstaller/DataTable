_class("UIBattleWordAffixCell", UICustomWidget)
UIBattleWordAffixCell = UIBattleWordAffixCell

function UIBattleWordAffixCell:OnShow(uiParams)
  self:InitWidget()
end

function UIBattleWordAffixCell:InitWidget()
  self._atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._mazeAffixName = self:GetUIComponent("UILocalizationText", "mazeAffixName")
  self._mazeAffixDesc = self:GetUIComponent("UILocalizationText", "mazeAffixDesc")
  self._mazeAffixDescLayout = self:GetUIComponent("LayoutElement", "mazeAffixDesc")
  self._mazeAffixBg = self:GetUIComponent("Image", "mazeAffixShowBtn")
  self._arrowGo = self:GetGameObject("mazeRollArrowDown")
  self._arrowGo:SetActive(false)
end

function UIBattleWordAffixCell:SetData(index, clickCb, name, desc, isRollCell, showArrow)
  self._mazeAffixName:SetText(name)
  self._mazeAffixDesc:SetText(desc)
  self._mazeAffixDesc.gameObject:SetActive(false)
  self._clickCb = clickCb
  self._index = index
  if showArrow then
    self._arrowGo:SetActive(showArrow)
  end
  self._isRoolCell = isRollCell or false
  self:_FillBg()
end

function UIBattleWordAffixCell:ShowDesc(bShow)
  self._mazeAffixDesc.gameObject:SetActive(bShow)
  if bShow then
    self:StartTask(function(TT)
      YIELD(TT)
      local textWidth = self._mazeAffixDesc.preferredWidth
      local maxWidth = 1000
      if textWidth > maxWidth then
        self._mazeAffixDescLayout.preferredWidth = maxWidth
      else
        self._mazeAffixDescLayout.preferredWidth = -1
      end
    end, self)
  end
end

function UIBattleWordAffixCell:mazeAffixShowBtnOnClick(go)
  if self._clickCb then
    self._clickCb()
  end
end

function UIBattleWordAffixCell:_FillBg()
  if self._isRoolCell then
    if self._index == 1 then
      self._rollBgIndex = 1
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame")
    else
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame02")
    end
  else
    local tmpIdx = self._index
    local md = math.fmod(tmpIdx, 2)
    if md == 1 then
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame")
    else
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame01")
    end
  end
end

function UIBattleWordAffixCell:SetDataForRoll(name, switchBg)
  self._mazeAffixName:SetText(name)
  if switchBg and self._rollBgIndex then
    self._rollBgIndex = self._rollBgIndex + 1
    if self._rollBgIndex > 2 then
      self._rollBgIndex = 1
    end
    if self._rollBgIndex == 1 then
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame")
    else
      self._mazeAffixBg.sprite = self._atlas:GetSprite("thread_cizhui_frame01")
    end
  end
end
