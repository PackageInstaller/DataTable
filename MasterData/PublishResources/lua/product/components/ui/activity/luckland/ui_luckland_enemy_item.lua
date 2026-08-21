_class("UILuckLandEnemyItem", UICustomWidget)
UILuckLandEnemyItem = UILuckLandEnemyItem

function UILuckLandEnemyItem:OnShow(uiParams)
  self:InitWidget()
end

function UILuckLandEnemyItem:InitWidget()
  self.singleatkIcon = self:GetUIComponent("Image", "SingleatkIcon")
  self.enemyAtkText = self:GetUIComponent("UILocalizationText", "EnemyAtkText")
  self.singleHeartIcon = self:GetUIComponent("Image", "SingleHeartIcon")
  self.enemyHeartText = self:GetUIComponent("UILocalizationText", "EnemyHeartText")
  self.enemyIcon = self:GetUIComponent("RawImageLoader", "EnemyIcon")
  self.skillIcon = self:GetUIComponent("RawImageLoader", "SkillIcon")
  self.countBg = self:GetUIComponent("Image", "CountBg")
  self.timeCountDown = self:GetUIComponent("Image", "TimeCountDown")
  self.lifeCountDownText = self:GetUIComponent("UILocalizationText", "LifeCountDownText")
  self.rootRectTf = self:GetUIComponent("RectTransform", "Root")
  self.enemyRawIcon = self:GetUIComponent("RawImage", "EnemyIcon")
  self.readybg = self:GetGameObject("readybg")
  self.readybg:SetActive(false)
  self.countDownRawImgLoader = self:GetUIComponent("RawImageLoader", "EnemyIcon")
  self.tipsBg = self:GetGameObject("TipsBg")
  self.tipsBg:SetActive(false)
  self.tipsBgtTf = self:GetUIComponent("RectTransform", "TipsBg")
  self.skillNameText = self:GetUIComponent("UILocalizationText", "SkillNameText")
  self.skillTipsText = self:GetUIComponent("UILocalizationText", "SkillTipsText")
  self.BigEnemyTIPSText = self:GetUIComponent("UILocalizationText", "BigEnemyTIPSText")
  if self.BigEnemyTIPSText then
    self.tipsRectTf = self:GetUIComponent("RectTransform", "TipsRect")
  end
end

function UILuckLandEnemyItem:SetData(data, index, parentTf, closeCB)
  self.closeCB = closeCB
  self.data = data
  self.getedDemand = 1
  self.getedDemand = 0
  self.enemyAtkText:SetText(self:GetDemandMoney())
  self.enemyHeartText:SetText(self.data:GetEnemyEntity():GetDemandRound() + 1)
  self.enemyAtkText.gameObject.transform.parent.gameObject:SetActive(false)
  self.enemyAtkText.gameObject.transform.parent.gameObject:SetActive(true)
  if self.tipsRectTf then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsRectTf)
  end
  self.rootRectTf.transform:SetParent(parentTf)
  self.rootRectTf.gameObject:SetActive(true)
  local buffArray = self.data:GetEnemyEntity():GetBuffArray()
  if 0 < #buffArray then
    self.mainSkill = buffArray[1]
  else
    self.mainSkill = nil
  end
  self:SetIndexPos(index)
  if self:GetDead() then
    self.rootRectTf.gameObject:SetActive(false)
  else
    self.rootRectTf.gameObject:SetActive(true)
  end
  self:RefreshSkill()
  if self.BigEnemyTIPSText then
    self.BigEnemyTIPSText:SetText(StringTable.Get("str_luckland_attack_warning", self.data:GetEnemyEntity():GetDemandRound() + 1, self:GetDemandMoney()))
    if self.tipsRectTf then
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsRectTf)
    end
    self.enemyIcon:LoadImage(self.data:GetEnemyBigIcon())
  else
    self.enemyIcon:LoadImage(self.data:GetEnemyIcon())
  end
end

function UILuckLandEnemyItem:RefreshSkill()
  if self.mainSkill then
    local configData = self.mainSkill:BuffConfigData()
    local name = configData:GetName()
    local icon = configData:GetIcon()
    local desc = configData:GetDesc()
    self.skillNameText:SetText(StringTable.Get(name))
    self.skillTipsText:SetText(StringTable.Get(desc))
    self.skillIcon:LoadImage(icon)
    self.skillIcon.gameObject:SetActive(true)
  else
    self.skillIcon.gameObject:SetActive(false)
  end
end

function UILuckLandEnemyItem:SetReadyEnemy()
  self.singleHeartIcon.gameObject:SetActive(false)
  self.enemyHeartText.gameObject:SetActive(false)
  self.readybg:SetActive(true)
  local anchorPos = self.tipsBgtTf.anchoredPosition
  anchorPos.x = -30
  self.tipsBgtTf.anchoredPosition = anchorPos
end

function UILuckLandEnemyItem:SetIndexPos(index)
  if index == -1 then
    return
  end
  local singleSize = Vector2(314, 162)
  local originSize = Vector2(singleSize.x / 2, 0)
  local targetPos = originSize + (index - 1) * Vector2(singleSize.x, 0)
  self.rootRectTf.anchoredPosition = targetPos
end

function UILuckLandEnemyItem:CastSkill()
  local pos = self.rootRectTf.anchoredPosition
  pos.y = pos.y - 100
  self.rootRectTf:DOPunchAnchorPos(pos, 0.25, 1)
end

function UILuckLandEnemyItem:DeadShow()
  self.rootRectTf.transform:DOPunchScale(Vector3(-0.1, -0.1, -0.1), 0.8, 1)
end

function UILuckLandEnemyItem:EnemyBeAtkShow()
  if self.BigEnemyTIPSText then
    self.BigEnemyTIPSText:SetText(StringTable.Get("str_luckland_attack_warning", self.data:GetEnemyEntity():GetDemandRound() + 1, self:GetDemandMoney()))
    if self.tipsRectTf then
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsRectTf)
    end
  end
end

function UILuckLandEnemyItem:GetEnemyAtk()
  if self:GetDead() then
    return 0
  end
  return self.data:GetEnemyAtk()
end

function UILuckLandEnemyItem:CloseTipsBg()
  self.tipsBg:SetActive(false)
end

function UILuckLandEnemyItem:GetDead()
  return self.data:GetEnemyEntity():IsDead()
end

function UILuckLandEnemyItem:GetHP()
  return self.data:GetEnemyHp()
end

function UILuckLandEnemyItem:SetGetedDemand(geted)
  self.getedDemand = geted
  self.enemyAtkText:SetText(self:GetDemandMoney())
end

function UILuckLandEnemyItem:SetBeAtkDemand(beAtk)
  local demand = self.data:GetEnemyEntity():GetDemandMoney()
  if beAtk < demand then
    demand = demand - beAtk
  else
    demand = 0
  end
  self.data:GetEnemyEntity():SetDemandMoney(demand)
  self:EnemyBeAtkShow()
end

function UILuckLandEnemyItem:GetDemandMoney()
  return self.data:GetEnemyEntity():GetDemandMoney() - self.getedDemand
end

function UILuckLandEnemyItem:GetDemandRound()
  return self.data:GetEnemyEntity():GetDemandRound()
end

function UILuckLandEnemyItem:RefreshUI()
  self.enemyAtkText:SetText(self:GetDemandMoney())
  self.enemyHeartText:SetText(self.data:GetEnemyEntity():GetDemandRound() + 1)
end

function UILuckLandEnemyItem:BgOnClick()
  if self.closeCB then
    self.closeCB()
  end
  if self.mainSkill ~= nil then
    self.tipsBg:SetActive(true)
  end
end

function UILuckLandEnemyItem:TipsBgOnClick()
  self.tipsBg:SetActive(false)
end
