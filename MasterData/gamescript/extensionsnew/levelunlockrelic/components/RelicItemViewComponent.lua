local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local RelicItemViewComponent, Super = NewViewComponent("RelicItemViewComponent")

function RelicItemViewComponent:ctor(uiNode, view, relicTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dbgcopy_Item_Select_Creation_QuoteResource(uiNode)
  self._relicTid = relicTid
  self._cfg = RelicCfgUtils.GetCfg(relicTid)
end

function RelicItemViewComponent:OnEnterComponent()
  if not self._cfg then
    return
  end
  local cfg = self._cfg
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  self:SetText(self.ui.Text_Creation_Name, cfg.Name or "")
  self:SetText(self.ui.Text_Creation_Creation, relicTypeMap[cfg.Quality])
  local desc = RelicDataUtils.GetRelicDesc(cfg.ID) or ""
  desc = self:_EnsureEnding(desc)
  desc = LT.ReplaceSpecialChineseChar(desc)
  local setOk, setErr = pcall(function()
    self:SetText(self.ui.Text_Creation_Desc, desc, false, nil, {banKeywordBtn = true})
  end)
  if not setOk then
    Logger.Warn("RelicItemViewComponent.SetText failed tid=%s err=%s", tostring(cfg.ID), tostring(setErr))
    self:SetRawText(self.ui.Text_Creation_Desc, desc or "")
  end
  self:SetImage(self.ui.Image_Icon, cfg.SmallIcon or "")
  self:SetImage(self.ui.Image_D_Quality, DT.ItemQuality[cfg.Quality].BigRelicFrame)
  self.ui.Btn_Selected:SetActive(false)
  self:_SetupAutoAdaptionText()
end

function RelicItemViewComponent:_EnsureEnding(desc)
  local ending1 = "。"
  local lastChar1 = desc:sub(-#ending1)
  if lastChar1 ~= ending1 then
    local ending2 = "."
    local lastChar2 = desc:sub(-#ending2)
    if lastChar2 ~= ending2 then
      if LT.IsEndofWithChinesePeriod() then
        desc = desc .. ending1
      else
        desc = desc .. ending2
      end
    end
  end
  return desc
end

function RelicItemViewComponent:_SetupAutoAdaptionText()
  if not self.ui.Text_Creation_Desc then
    return
  end
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Creation_Desc, 0, 0, 40, nil, true)
  if not comp then
    return
  end
  if self.ui.Btn_Click then
    comp:SetBtn(self.ui.Btn_Click)
  end
  local cfgInit = {
    fontSize = 34,
    autoSizeCN = true,
    autoSizeOther = true,
    alignmentCN = TextAlignmentOptions.Top,
    alignmentOther = TextAlignmentOptions.Top,
    widthCN = 280,
    widthOther = 280,
    height = 268,
    x = 0,
    y = 0,
    pivotX = 0.5,
    pivotY = 1,
    anchorX = 0.5,
    anchorY = 1
  }
  comp:ForceUpdate({
    limitPercent = 0.8,
    lineLimit = 4,
    miniFontSize = 22,
    maxFontSize = 28,
    initCfg = cfgInit
  })
end

function RelicItemViewComponent:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnBtnClick))
end

function RelicItemViewComponent:_OnBtnClick()
  local desc = RelicDataUtils.GetRelicDesc(self._cfg.ID) or ""
  if StrUtils.CheckDescContainKeywords(LT.Text(desc)) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {
      LT.Text(desc)
    }, self.ui.uiNode)
  end
end

return RelicItemViewComponent
