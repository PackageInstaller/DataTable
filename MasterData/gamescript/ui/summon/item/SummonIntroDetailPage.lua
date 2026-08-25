local SummonIntroDetailPage, Super = System.NewComponent("SummonIntroDetailPage")
local DetailTags = {
  Foundation = 1,
  Rule = 2,
  SSR = 3,
  SR = 4,
  R = 5
}

function SummonIntroDetailPage:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Detail_TipResource(uiNode)
  self.model = model
end

function SummonIntroDetailPage:OnBind(binder)
  self.binder = binder
  self:CreateDetailTableView()
  self._detailDataList = self:GetDetailDataList()
  self:SetFoundation(self._detailDataList[1])
  self:SetRule(self._detailDataList[2])
  self._detailTableView:ReloadData()
end

function SummonIntroDetailPage:GetDetailDataList()
  local list = {
    self:GetFoundationTextData(),
    self:GetRuleTextData()
  }
  local ssr = self:GetSSRData()
  if ssr then
    table.insert(list, ssr)
  end
  local sr = self:GetSRData()
  if sr then
    table.insert(list, sr)
  end
  local r = self:GetRData()
  if r then
    table.insert(list, r)
  end
  return list
end

function SummonIntroDetailPage:GetFoundationTextData()
  local detail = self.model:GetDetail()
  return {
    title_1 = detail.title_1,
    name_1 = detail.name_1,
    desc_1 = detail.desc_1,
    detailTag = DetailTags.Foundation,
    gameObj = self.ui.Image_Foundation,
    height = nil
  }
end

function SummonIntroDetailPage:GetRuleTextData()
  local detail = self.model:GetDetail()
  local desc_2 = detail.desc_2
  local langKey = LT.ParseTextCfg(desc_2)
  local summonType = detail.SummonType
  local curCnt = SummonDataUtils.GetNotSSRUpNum(summonType)
  if summonType == CommonDefine.SummonPoolType.NormalWeapon then
    desc_2 = LT.Textf(desc_2, curCnt)
  elseif table.contains({
    CommonDefine.SummonPoolType.ChooseUp,
    CommonDefine.SummonPoolType.TargetedAwakerWeapon
  }, summonType) then
    local compensation = SummonDataUtils.GetHistoryCorrectNum(summonType)
    local s1 = compensation > 0 and LT.Text("SummonRulesExtraTxt1") or ""
    local s3 = compensation > 0 and LT.Textf("SummonRulesExtraTxt2", compensation) or ""
    local s4 = self:GetChooseUpAwakerComboNum(summonType)
    local s5 = self:GetChooseUpWeaponComboNum(summonType)
    desc_2 = LT.Textf(desc_2, s1, curCnt, s3, s4, s5)
  elseif summonType == CommonDefine.SummonPoolType.AwakerWeapon then
    local compensation = SummonDataUtils.GetHistoryCorrectNum(summonType)
    local s1 = compensation > 0 and LT.Text("SummonRulesExtraTxt1") or ""
    local s3 = compensation > 0 and LT.Textf("SummonRulesExtraTxt2", compensation) or ""
    local s4 = self:GetChooseUpAwakerComboNum(summonType)
    local s5 = self:GetChooseUpWeaponComboNum(summonType)
    desc_2 = LT.Textf(desc_2, s1, curCnt, s3, s4, s5)
  elseif summonType == cd.SummonPoolType.MixPool or summonType == cd.SummonPoolType.MultiAwakerWeapon then
    local compensation = SummonDataUtils.GetHistoryCorrectNum(summonType)
    local s1 = compensation > 0 and LT.Text("SummonRulesExtraTxt1") or ""
    local s2 = self:GetAwakerCommboNum(summonType)
    local s3 = compensation > 0 and LT.Textf("SummonRulesExtraTxt2", compensation) or ""
    local s4 = self:GetWeaponCommboNum(summonType)
    desc_2 = LT.Textf(desc_2, s1, s2, s3, s4)
  elseif summonType == CommonDefine.SummonPoolType.CategorySelect then
    local s1 = self:GetAwakerCommboNum(summonType)
    local s2 = self:GetWeaponCommboNum(summonType)
    desc_2 = LT.Textf(desc_2, s1, s2)
  else
    local compensation = SummonDataUtils.GetHistoryCorrectNum(summonType)
    local s1 = compensation > 0 and LT.Text("SummonRulesExtraTxt1") or ""
    local s3 = compensation > 0 and LT.Textf("SummonRulesExtraTxt2", compensation) or ""
    desc_2 = LT.Textf(desc_2, s1, curCnt, s3)
  end
  LT.InsertTextAndKey(desc_2, langKey)
  return {
    title_2 = detail.title_2,
    desc_2 = desc_2,
    detailTag = DetailTags.Rule,
    gameObj = self.ui.UI_Summon_Item_Rules,
    height = nil
  }
end

function SummonIntroDetailPage:GetAwakerCommboNum(poolType)
  do return SummonDataUtils.GetSSRTypeComboNum, poolType end
  return SummonDataUtils.GetSSRTypeComboNum, poolType, cd.SummonItemTypeName.AwakerItem
end

function SummonIntroDetailPage:GetWeaponCommboNum(poolType)
  do return SummonDataUtils.GetSSRTypeComboNum, poolType end
  return SummonDataUtils.GetSSRTypeComboNum, poolType, cd.SummonItemTypeName.Weapon
end

function SummonIntroDetailPage:GetSSRData()
  local inventoryDict = self.model:GetInventoryDict()
  local inventoryData = inventoryDict.SSR
  if inventoryData then
    return {
      inventoryData = inventoryData,
      detailTag = DetailTags.SSR,
      gameObj = self.ui.UI_Summon_Item_Inventory_SSR,
      height = math.ceil(#inventoryData.cells / 9) * 204 + 172
    }
  end
end

function SummonIntroDetailPage:GetSRData()
  local inventoryDict = self.model:GetInventoryDict()
  local inventoryData = inventoryDict.SR
  if inventoryData then
    return {
      inventoryData = inventoryData,
      detailTag = DetailTags.SR,
      gameObj = self.ui.UI_Summon_Item_Inventory_SR,
      height = math.ceil(#inventoryData.cells / 9) * 204 + 172
    }
  end
end

function SummonIntroDetailPage:GetRData()
  local inventoryDict = self.model:GetInventoryDict()
  local inventoryData = inventoryDict.R
  if inventoryData then
    return {
      inventoryData = inventoryData,
      detailTag = DetailTags.R,
      gameObj = self.ui.UI_Summon_Item_Inventory_R,
      height = math.ceil(#inventoryData.cells / 9) * 204 + 172
    }
  end
end

function SummonIntroDetailPage:CreateDetailTableView()
  if self._detailTableView then
    return
  end
  self._detailTableView = self:CreateTableview(self.ui.ScrollView_Detail, function()
    return #self._detailDataList
  end, function(view, index)
    local data = self._detailDataList[index]
    local cell = self:GetCell(view, data)
    self:SetDataToCellGameObj(data, cell.gameObject)
    return cell
  end, function(tableView, index)
    local tableWidth = 1550
    local data = self._detailDataList[index]
    if data.height then
      return tableWidth, data.height
    end
    return tableWidth, 500
  end)
  self._detailTableView.positionedActived = false
end

function SummonIntroDetailPage:GetCell(view, data)
  local tag = data.detailTag
  local cell = view:DequeueCellByTag(tag)
  cell = cell or view:AddChildToParent(data.gameObj, tag)
  return cell
end

function SummonIntroDetailPage:SetDataToCellGameObj(data, gameObj)
  if data.detailTag == DetailTags.Foundation then
    self:SetFoundation(data)
  elseif data.detailTag == DetailTags.Rule then
    self:SetRule(data)
  else
    self:SetInventoryData(data, gameObj)
  end
end

function SummonIntroDetailPage:SetFoundation(data)
  if not data.height then
    self.binder:SetText(self.ui.Text_Detail_Title_1, data.title_1)
    self.binder:SetText(self.ui.Text_Detail_Name_1, data.name_1)
    self.binder:SetText(self.ui.Text_Detail_Desc_1, data.desc_1)
    local _, h = self.binder:GetTextPreferredWH(self.ui.Text_Detail_Desc_1)
    data.height = h + 100
  end
end

function SummonIntroDetailPage:SetRule(data)
  if not data.height then
    self.binder:SetText(self.ui.Text_Detail_Title_2, data.title_2)
    self.binder:SetText(self.ui.Text_Detail_Desc_2, data.desc_2)
    local _, h = self.binder:GetTextPreferredWH(self.ui.Text_Detail_Desc_2)
    data.height = h + 100
  end
end

function SummonIntroDetailPage:SetInventoryData(data, gameObj)
  if data.comp then
    return
  end
  local inventoryData = data.inventoryData
  local comp = self.binder:BindComponent(SummonIntroInventoryPageItem(gameObj, inventoryData))
  data.comp = comp
end

function SummonIntroDetailPage:GetChooseUpAwakerComboNum(poolType)
  if poolType == CommonDefine.SummonPoolType.AwakerWeapon then
    return 0
  end
  local lastDropChooseUpItemType = SummonDataUtils.GetLastDropChooseUpItemType(poolType)
  if lastDropChooseUpItemType == cd.SummonItemTypeName.AwakerItem then
    do return SummonDataUtils.GetChooseUpComboNum end
    return SummonDataUtils.GetChooseUpComboNum, poolType
  end
  return 0
end

function SummonIntroDetailPage:GetChooseUpWeaponComboNum(poolType)
  if poolType == CommonDefine.SummonPoolType.AwakerWeapon then
    return 0
  end
  local lastDropChooseUpItemType = SummonDataUtils.GetLastDropChooseUpItemType(poolType)
  if lastDropChooseUpItemType == cd.SummonItemTypeName.Weapon then
    do return SummonDataUtils.GetChooseUpComboNum end
    return SummonDataUtils.GetChooseUpComboNum, poolType
  end
  return 0
end

return SummonIntroDetailPage
