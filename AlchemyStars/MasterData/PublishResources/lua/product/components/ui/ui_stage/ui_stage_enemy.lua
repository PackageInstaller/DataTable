_class("UIStageEnemy", UICustomWidget)
UIStageEnemy = UIStageEnemy

function UIStageEnemy:OnShow()
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self._enemyTitleTex = self:GetUIComponent("UILocalizationText", "enemyTitleTex")
  self._enemyTitleBg = self:GetUIComponent("Image", "btnEnemy")
  self._enemyTitleBg2 = self:GetUIComponent("Image", "btnEnemy2")
  self._enemyTitleBg1go = self:GetGameObject("btnEnemy")
  self._enemyTitleBg2go = self:GetGameObject("GameObjecte2")
  self._recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self._recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self._recommend = self:GetGameObject("GameObject")
end

function UIStageEnemy:Flush(recommendAwaken, recommendLV, levelId, color, titleBgSprite, titleBg2Sprite, isChess, noLv, noTitle)
  if isChess then
    self._recommend:SetActive(false)
  else
    self._recommend:SetActive(false)
  end
  local enemy = self._enemyMsg:SpawnObject("UIEnemyMsg")
  enemy:SetData(levelId, nil, isChess, noLv)
  self._enemyTitleTex.color = color
  if titleBgSprite == nil and titleBgSprite == nil then
    if not noLv then
      self._enemyTitleBg1go.gameObject:SetActive(false)
      self._enemyTitleBg2go.gameObject:SetActive(false)
    else
      self._enemyTitleBg2go.gameObject:SetActive(true)
    end
  else
    if not noLv then
      self._enemyTitleBg1go.gameObject:SetActive(true)
      self._enemyTitleBg.sprite = titleBgSprite
    end
    self._enemyTitleBg2go.gameObject:SetActive(true)
    self._enemyTitleBg2.sprite = titleBg2Sprite
  end
  if noTitle then
    self._enemyTitleBg1go.gameObject:SetActive(false)
    self._enemyTitleBg2go.gameObject:SetActive(false)
  end
  if not noLv then
    if recommendAwaken == 0 then
      self._recommendLV.gameObject:SetActive(false)
    else
      self._recommendLV.gameObject:SetActive(true)
      self._recommendLV:SetText(StringTable.Get("str_pet_config_common_advance") .. "<size=29>" .. recommendAwaken .. "</size>")
    end
    if recommendLV then
      self._recommendLV2:SetText("LV." .. recommendLV)
    end
  end
end
