local EnergyBattleCtrl = class("EnergyBattleCtrl", BaseCtrl)
local img_Man = "Icon/Head/head_9101_SS"
local img_Female = "Icon/Head/head_9100_SS"
local leftMaxX = 0
local leftMinX = -210.8
local rightMaxX = 210.8
local rightMinX = 0
EnergyBattleCtrl._mapNodeConfig = {
  imgChrIcon = {sComponentName = "Image"},
  imgEnergyFill1 = {
    sComponentName = "RectTransform"
  },
  imgEnergyFillLight1 = {},
  imgEnergyFillGlow1 = {},
  imgEnergyFill2 = {
    sComponentName = "RectTransform"
  },
  imgEnergyFillLight2 = {},
  imgEnergyFillGlow2 = {},
  rtContent = {
    sComponentName = "CanvasGroup"
  }
}
EnergyBattleCtrl._mapEventConfig = {
  MoWangPerfumeChange = "TD_Battle_MoWangEnergyChange",
  BossPerfumeChange = "TD_Battle_BossEnergyChange",
  InputEnable = "OnEvent_InputEnable"
}
EnergyBattleCtrl._mapRedDotConfig = {}

function EnergyBattleCtrl:Awake()
  self._mapNode.rtContent.gameObject:SetActive(false)
  if PlayerData.Base:GetPlayerSex() then
    self:SetPngSprite(self._mapNode.imgChrIcon, img_Man)
  else
    self:SetPngSprite(self._mapNode.imgChrIcon, img_Female)
  end
end

function EnergyBattleCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContent, bEnable == true and 1 or 0)
end

function EnergyBattleCtrl:TD_Battle_MoWangEnergyChange(nCurEnergy, nMaxEnergy)
  self._mapNode.rtContent.gameObject:SetActive(true)
  self._mapNode.imgEnergyFillLight1:SetActive(nCurEnergy == nMaxEnergy)
  self._mapNode.imgEnergyFillGlow1:SetActive(nCurEnergy == nMaxEnergy)
  self._mapNode.imgEnergyFill1.anchoredPosition = Vector2(leftMinX + math.abs(leftMaxX - leftMinX) * (nCurEnergy / nMaxEnergy), self._mapNode.imgEnergyFill1.anchoredPosition.y)
end

function EnergyBattleCtrl:TD_Battle_BossEnergyChange(nCurEnergy, nMaxEnergy)
  self._mapNode.rtContent.gameObject:SetActive(true)
  self._mapNode.imgEnergyFillLight2:SetActive(nCurEnergy == nMaxEnergy)
  self._mapNode.imgEnergyFillGlow2:SetActive(nCurEnergy == nMaxEnergy)
  self._mapNode.imgEnergyFill2.anchoredPosition = Vector2(rightMaxX - math.abs(rightMaxX - rightMinX) * (nCurEnergy / nMaxEnergy), self._mapNode.imgEnergyFill2.anchoredPosition.y)
end

return EnergyBattleCtrl
