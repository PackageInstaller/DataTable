local RelicBattleDetailItemComponent, Super = System.NewComponent("Func_Creation_TipsResource")

function RelicBattleDetailItemComponent:ctor(res, maskNode, relic)
  Super.ctor(self)
  self.ui = Func_Creation_TipsResource(res)
  self.maskNode = maskNode
  self.relic = relic
  self.tipList = Vue.ref({})
end

function RelicBattleDetailItemComponent:OnBind(binder)
  self.binder = binder
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  local relicConfig = DT.RelicConfig[self.relic.value.relicTid]
  binder:BindToImage(self.ui.Image_D_Relic_Icon, function()
    return relicConfig.Icon
  end)
  binder:BindToImage(self.ui.Image_Create, function()
    return DT.ItemQuality[relicConfig.Quality].RelicFrame
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    return DT.ItemQuality[relicConfig.Quality].ItemQualityFrame
  end)
  binder:BindToText(self.ui.Text_Create, function()
    return relicTypeMap[relicConfig.Quality]
  end)
  binder:BindToText(self.ui.Text_Relic_Name, function()
    do return LT.Text end
    return LT.Text, relicConfig.Name
  end)
  local desc = RelicDataUtils.GetRelicDesc(self.relic.value.relicTid)
  binder:SetText(self.ui.TextMeshPro_Desc, desc)
  binder:BindToVisible(self.ui.TextMeshPro_Task, function()
    return 0
  end)
  self.tipList.value = DT.RelicConfig[self.relic.value.relicTid].TipList or {}
  binder:BindToCircularListView(self.ui.ScrollView_Tips_List, function()
    return self.tipList.value
  end, function(itemBinder, item, index)
    local str = LT.Text(self.tipList.value[index])
    itemBinder:BindComponent(KeyWordTipComponent(item, str))
  end)
end

function RelicBattleDetailItemComponent:SetItemPosition(pos)
  pos.x = pos.x + self.ui.uiNode.transform.sizeDelta.x / 2 - 107.8
  pos.y = pos.y - 11.5
  self.ui.uiNode.transform.anchoredPosition = pos
end

function RelicBattleDetailItemComponent:SetItemPos2(pos)
  local sizeDelta = self.ui.uiNode.transform.sizeDelta
  local halfWidth, halfHeight = sizeDelta.x * 0.5, sizeDelta.y * 0.5
  local uiTransform = self.ui.uiNode.transform.parent
  local uiPos = uiTransform:InverseTransformPoint(pos)
  local screenWidth = 1920
  local tipsX = uiPos.x + halfWidth - 105
  local keyWordTipOffset = #self.tipList.value > 0 and 660 or 0
  tipsX = math.min(math.max(-screenWidth * 0.5 + halfWidth, tipsX), screenWidth * 0.5 - halfWidth - keyWordTipOffset)
  local tipsY = uiPos.y - halfHeight - 70
  local itemPos = CS.UnityEngine.Vector3(tipsX, tipsY, pos.z)
  self.ui.uiNode.transform.localPosition = itemPos
end

function RelicBattleDetailItemComponent:OnMaskClicked()
  self.binder:teardown()
end

return RelicBattleDetailItemComponent
