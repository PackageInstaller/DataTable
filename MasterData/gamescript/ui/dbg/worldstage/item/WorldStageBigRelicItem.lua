local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local WorldStageBigRelicItem, Super = System.NewComponent("WorldStageBigRelicItem")

function WorldStageBigRelicItem:ctor(uiNode, data, callback, isOnlyShow)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Select_Creation_QuoteResource(uiNode)
  self.callback = callback
  self.data = data
  local tid = data.tid
  self.cfg = DT.RelicConfig[tid]
  self.uid = data.uid
  self.schoolCfg = DT.SchoolConfig[self.cfg.SchoolID]
  assert(self.cfg ~= nil, "cfg没找到" .. tid)
  self.isOnlyShow = isOnlyShow
  self.isBanBtnClick = false
  self:InitData()
end

function WorldStageBigRelicItem:OnBind(binder)
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  binder:SetText(self.ui.Text_Creation_Name, self.textName)
  binder:BindToRaw(function(_, desc, _)
    if desc then
      self:SetDesc(binder, desc)
    end
  end, function()
    return self.textDesc
  end)
  binder:SetText(self.ui.Text_Creation_Creation, relicTypeMap[self.cfg.Quality])
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.imageIcon
  end)
  binder:BindToImage(self.ui.Image_D_Quality, function()
    return DT.ItemQuality[self.cfg.Quality].BigRelicFrame
  end)
  self.ui.Btn_Selected:SetActive(self.isShowSelect)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
end

function WorldStageBigRelicItem:InitData()
  self.textName = self.cfg.Name or ""
  self.textDesc = RelicDataUtils.GetRelicDesc(self.cfg.ID)
  self.imageIcon = self.cfg.SmallIcon or ""
  self.isShowSelect = false
  self:RefreshData()
end

function WorldStageBigRelicItem:SetDesc(binder, desc)
  if not self.ui or IsNil(self.ui.Text_Creation_Desc) then
    return
  end
  desc = LT.EnsureDescEndsWithPeriod(desc)
  desc = LT.ReplaceSpecialChineseChar(desc)
  local setOk, setErr = pcall(function()
    binder:SetText(self.ui.Text_Creation_Desc, desc, false, nil, {banKeywordBtn = true})
  end)
  if not setOk then
    Logger.Warn("WorldStageBigRelicItem.SetDesc SetText failed tid=%s err=%s", tostring(self.cfg and self.cfg.ID), tostring(setErr))
    binder:SetRawText(self.ui.Text_Creation_Desc, desc or "")
  end
  binder:RemoveUnderline(self.ui.Text_Creation_Desc)
  if self.ui.Text_Creation_Desc then
    local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Creation_Desc, 0, 0, 40, nil, true)
    if comp and self.ui.Btn_Click then
      comp:SetBtn(self.ui.Btn_Click)
    end
    if comp then
      local cfg_init = {
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
      if self.OnDrag and self.OnBeginDrag then
        comp:SetDragDelegate(self)
      end
      comp:ForceUpdate({
        limitPercent = 0.8,
        lineLimit = 4,
        miniFontSize = 22,
        maxFontSize = 28,
        initCfg = cfg_init
      })
    end
  end
end

function WorldStageBigRelicItem:RefreshData()
end

function WorldStageBigRelicItem:OnBtnClick()
  Logger.Info("BtnClick>>>>>", self.isBanBtnClick, self.isOnlyShow)
  if StrUtils.CheckDescContainKeywords(LT.Text(self.textDesc)) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {
      LT.Text(self.textDesc)
    }, self.ui.uiNode)
  end
  if self.isBanBtnClick == true or self.isOnlyShow then
    return
  end
  if self.callback then
    self.callback(self, self.data)
  end
end

function WorldStageBigRelicItem:EnableSelectShow(enable)
  self.isShowSelect = enable
  self.ui.Btn_Selected:SetActive(self.isShowSelect)
end

function WorldStageBigRelicItem:GetIsShow()
  return self.isShowSelect
end

function WorldStageBigRelicItem:EnableBtnClick(enable)
  self.isBanBtnClick = enable
end

return WorldStageBigRelicItem
