_class("UIStageEnemyNew", UICustomWidget)
UIStageEnemyNew = UIStageEnemyNew

function UIStageEnemyNew:OnShow()
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self._enemyTitleTex = self:GetUIComponent("UILocalizationText", "enemyTitleTex")
  self._enemyTitleBg2go = self:GetGameObject("GameObjecte2")
end

function UIStageEnemyNew:Flush(recommendAwaken, recommendLV, levelId, color, titleBgSprite, titleBg2Sprite, isChess, noLv, noTitle)
  local enemy = self._enemyMsg:SpawnObject("UIEnemyMsgStageNew")
  enemy:SetData(levelId, nil, isChess, noLv)
  self._enemyTitleTex.color = color
  if titleBgSprite == nil and titleBgSprite == nil then
    if not noLv then
      self._enemyTitleBg2go.gameObject:SetActive(false)
    else
      self._enemyTitleBg2go.gameObject:SetActive(true)
    end
  else
    if not noLv then
      self._enemyTitleBg.sprite = titleBgSprite
    end
    self._enemyTitleBg2go.gameObject:SetActive(true)
  end
  if noTitle then
    self._enemyTitleBg2go.gameObject:SetActive(false)
  end
end
