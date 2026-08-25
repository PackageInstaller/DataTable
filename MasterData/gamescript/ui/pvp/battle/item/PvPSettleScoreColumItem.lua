local TEXT_HEIGHT = 40
local PvPSettleScoreColumItem, Super = System.NewComponent("PvPSettleScoreColumItem")

function PvPSettleScoreColumItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_ScoreResource(uiNode)
  self.damage = data.damage
  self.heal = data.heal
  self.shield = data.shield
  self.totalVal = self.damage + self.heal + self.shield
  self.columPercent = data.columPercent
end

function PvPSettleScoreColumItem:OnBind(binder)
  self:CalculateColumHeight()
  binder:BindToText(self.ui.Text_Shield, function()
    return self.shield
  end)
  binder:BindToText(self.ui.Text_Damage, function()
    return self.damage
  end)
  binder:BindToText(self.ui.Text_Heal, function()
    return self.heal
  end)
end

function PvPSettleScoreColumItem:CalculateColumHeight()
  local rt = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local damageRt = self.ui.Image_Damage:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local healRt = self.ui.Image_Heal:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local shieldRt = self.ui.Image_Shield:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local columnHeight = rt.sizeDelta.y * self.columPercent
  rt.sizeDelta = CS.UnityEngine.Vector2(rt.sizeDelta.x, columnHeight)
  local damageShowPercent = self.damage / self.totalVal
  local healShowPercent = self.heal / self.totalVal
  local shieldShowPercent = 1 - damageShowPercent - healShowPercent
  if 0 == self.totalVal then
    damageShowPercent, healShowPercent, shieldShowPercent = 0, 0, 0
  end
  local damageShowHeight = damageShowPercent * columnHeight
  local healShowHeight = healShowPercent * columnHeight
  local shieldShowHeight = shieldShowPercent * columnHeight
  local damageBottom, damageTop = 0, damageShowHeight
  local healBottom, healTop = damageShowHeight, damageShowHeight + healShowHeight
  local shieldBottom, shieldTop = damageShowHeight + healShowHeight, damageShowHeight + healShowHeight + shieldShowHeight
  damageRt.sizeDelta = CS.UnityEngine.Vector2(damageRt.sizeDelta.x, damageShowHeight)
  damageRt.anchoredPosition = CS.UnityEngine.Vector2(damageRt.anchoredPosition.x, damageBottom)
  healRt.sizeDelta = CS.UnityEngine.Vector2(healRt.sizeDelta.x, healShowHeight)
  healRt.anchoredPosition = CS.UnityEngine.Vector2(healRt.anchoredPosition.x, healBottom)
  shieldRt.sizeDelta = CS.UnityEngine.Vector2(shieldRt.sizeDelta.x, shieldShowHeight)
  shieldRt.anchoredPosition = CS.UnityEngine.Vector2(shieldRt.anchoredPosition.x, shieldBottom)
  local damageTextCompHeight = self.ui.Text_Damage:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.y
  local healTextCompHeight = self.ui.Text_Heal:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.y
  local shieldTextCompHeight = self.ui.Text_Shield:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.y
  self.ui.Text_Damage:SetActive(damageShowHeight > TEXT_HEIGHT)
  self.ui.Text_Heal:SetActive(healShowHeight > TEXT_HEIGHT)
  self.ui.Text_Shield:SetActive(shieldShowHeight > TEXT_HEIGHT)
  local showWireImg = damageShowHeight > 0 or healShowHeight > 0 or shieldShowHeight > 0
  self.ui.Image_Wire:SetActive(showWireImg)
end

return PvPSettleScoreColumItem
