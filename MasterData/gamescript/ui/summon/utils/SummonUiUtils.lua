local SummonUiUtils = {}

function SummonUiUtils.RefreshWeaponJumpButtonInfo(binder, ui, hideDetailBtn, itemTid)
  binder:SetActive(ui.Image_Icon, not hideDetailBtn)
  local itemCfg = DT.Item[itemTid]
  binder:SetActive(ui.Text_Name, true)
  binder:SetText(ui.Text_Name, itemCfg.Name)
  binder:SetActive(ui.Image_Positioning, true)
  binder:SetImage(ui.Image_Positioning, CommonDefine.ItemCommonIcon.Weapon)
  local qualityIcon = CommonDefine.AwakerQualityIcon[itemCfg.Quality]
  if qualityIcon then
    ui.Image_SSR:SetActive(true)
  else
    ui.Image_SSR:SetActive(false)
  end
  binder:SetActive(ui.Image_Up, false)
  binder:SetActive(ui.Image_Bg, true)
  binder:BindButtonClick(ui.uiNode, function()
    if not hideDetailBtn then
      ItemDataUtils.ShowItemDetailTips(binder, ui.uiNode, nil, itemTid, nil, {showWeaponHave = true})
    end
  end)
end

function SummonUiUtils.RefreshAwakerJumpButtonInfo(binder, ui, hideDetailBtn, awakerTid)
  binder:SetActive(ui.Image_Icon, not hideDetailBtn)
  binder:SetActive(ui.Image_Bg, true)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  binder:SetActive(ui.Text_Name, true)
  binder:SetText(ui.Text_Name, awakerCfg.Name)
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  binder:SetActive(ui.Image_Positioning, true)
  binder:SetImage(ui.Image_Positioning, schoolCfg.Icon)
  local qualityIcon = CommonDefine.AwakerQualityIcon[awakerCfg.Quality]
  if qualityIcon then
    ui.Image_SSR:SetActive(true)
  else
    ui.Image_SSR:SetActive(false)
  end
  ui.Image_Up:SetActive(false)
  binder:BindButtonClick(ui.uiNode, function()
    if not hideDetailBtn then
      local function panelOpenFunc()
        local awakerBasePanelData = {}
        
        awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
        awakerBasePanelData.specialAwakerList = {
          AwakerDataUtils.GetAwakerData(awakerTid)
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      end
      
      FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
    end
  end)
end

function SummonUiUtils.ShowAwakerDetail(awakerTid)
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function SummonUiUtils.ShowAwakerDetailByItemTid(itemTid)
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
  if not awakerTid then
    return
  end
  SummonUiUtils.ShowAwakerDetail(awakerTid)
end

local School2WordEffect = {
  [CommonDefine.AwakerSchool.Aequor] = "SummonOrange",
  [CommonDefine.AwakerSchool.Caro] = "SummonRed",
  [CommonDefine.AwakerSchool.Dimension] = "SummonPurple",
  [CommonDefine.AwakerSchool.NewAequor] = "SummonBlue"
}

function SummonUiUtils.GetSummonColorBySchool(school)
  return School2WordEffect[school] or "SummonOrange"
end

SummonUiUtils.isQuickSummon = false

function SummonUiUtils.IsShowQuickSummonItem(itemData)
  if not itemData or not itemData.tid then
    return false
  end
  return DT.Item[itemData.tid].Quality == CommonDefine.CommonQuality.Orange
end

return SummonUiUtils
