local DungeonStatisticsView, Super = NewClass("DungeonStatisticsView", BaseView)
DungeonStatisticsView.uiResCls = UI_Dungeons_Popup_BattleStatisticsResource

function DungeonStatisticsView:ctor(dungeonStatisticMO)
  Super.ctor(self)
  self:_InitViewData(dungeonStatisticMO)
end

function DungeonStatisticsView:OnBuildView()
end

function DungeonStatisticsView:OnEnterView()
  self:_RefreshView()
end

function DungeonStatisticsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function DungeonStatisticsView:_InitViewData(dungeonStatisticMO)
  self._dungeonStatisticMO = dungeonStatisticMO
end

function DungeonStatisticsView:_GetPercentNum(num)
  return math.floor(num * 100) .. "%"
end

function DungeonStatisticsView:_RefreshView()
  local statisticDataList = self._dungeonStatisticMO:GetStatisticDataList()
  local parentTransform = self.ui.Group_Statistics.transform
  self:ReserveChildren(parentTransform, #statisticDataList)
  for i = 1, #statisticDataList do
    local go = parentTransform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local statisticData = statisticDataList[i]
    self:_RefreshStatisticItem(go, statisticData)
  end
end

function DungeonStatisticsView:_RefreshStatisticItem(go, statisticData)
  local ui = UI_Dungeous_Item_BattleStatisticsResource(go)
  self:LoadAllLangFont(ui.Text_Name)
  local awakerData = statisticData.awakerData
  local playerUid = statisticData.playerUid
  if awakerData then
    self:SetText(ui.Text_Name, LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerData.tid)))
    self:SetText(ui.Text_Level, string.format("Lv.%s", awakerData.level))
    self:AddViewComponentOnce(ui.UI_Common_Head, CompHeadItem, {
      headIcon = AwakerDataUtils.GetLittleIcon(awakerData.tid, nil, awakerData.curSkin),
      hideFrame = true
    })
    self:SetActive(ui.Image_Bg, false)
  end
  if playerUid then
    self:SetText(ui.Text_Name, PlayerDataUtils.GetName())
    self:SetText(ui.Text_Level, string.format("Lv.%s", PlayerDataUtils.GetLevel()))
    self:AddViewComponentOnce(ui.UI_Common_Head, CompHeadItem, {
      headIcon = PlayerDataUtils.GetRoleHeadImg()
    })
    self:SetActive(ui.Image_Bg, true)
  end
  self:SetText(ui.Text_Damage, statisticData.damage)
  self:SetText(ui.Text_Heal, statisticData.heal)
  self:SetText(ui.Text_Shield, statisticData.shield)
  local maxDamage = self._dungeonStatisticMO:GetMaxDamage()
  self:SetImageFillAmount(ui.Image_Damage, 0 == maxDamage and 0 or statisticData.damage / maxDamage)
  local maxHeal = self._dungeonStatisticMO:GetMaxHeal()
  self:SetImageFillAmount(ui.Image_Heal, 0 == maxHeal and 0 or statisticData.heal / maxHeal)
  local maxShield = self._dungeonStatisticMO:GetMaxShield()
  self:SetImageFillAmount(ui.Image_Shield, 0 == maxShield and 0 or statisticData.shield / maxShield)
  local totalDamage = self._dungeonStatisticMO:GetTotalDamage()
  local totalHeal = self._dungeonStatisticMO:GetTotalHeal()
  local totalShield = self._dungeonStatisticMO:GetTotalShield()
  self:SetText(ui.Text_DamageRate, 0 == totalDamage and "0%" or self:_GetPercentNum(statisticData.damage / totalDamage))
  self:SetText(ui.Text_HealRate, 0 == totalHeal and "0%" or self:_GetPercentNum(statisticData.heal / totalHeal))
  self:SetText(ui.Text_ShieldRate, 0 == totalShield and "0%" or self:_GetPercentNum(statisticData.shield / totalShield))
end

return DungeonStatisticsView
