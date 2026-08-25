local PvPSelectCreationItem, Super = System.NewComponent("PvPSelectCreationItem")

function PvPSelectCreationItem:ctor(uiNode, relicTid, isShowSelect, callback)
  Super.ctor(self)
  self.ui = UIBaseResource(uiNode)
  self.relicTid = relicTid
  self.callback = callback
  self.selectIndex = 0
  self.isShowSelect = isShowSelect
  local config = DT.RelicConfig[relicTid]
  if not config then
    Logger.Error("造物配置没找到,Id为:" .. relicTid)
    return
  end
  self.cfg = config
  self.textName = config.Name or ""
  self.imageIcon = config.SmallIcon or config.Icon or ""
  self.textDesc = RelicDataUtils.GetRelicDesc(relicTid) or ""
end

function PvPSelectCreationItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Creation_Name, function()
    do return LT.Text end
    return LT.Text, self.textName
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.imageIcon
  end)
  binder:BindToImage(self.ui.Image_D_Quality, function()
    if self.cfg and self.cfg.Quality then
      return DT.ItemQuality[self.cfg.Quality].BigRelicFrame or ""
    end
    return ""
  end)
  binder:BindToRaw(function(_, desc, _)
    if desc then
      self:SetDesc(binder, desc)
    end
  end, function()
    return self.textDesc
  end)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  self.ui.Image_Selected:SetActive(self.isShowSelect)
end

function PvPSelectCreationItem:SetDesc(binder, desc)
  if not self.ui or not self.ui.Text_Creation_Desc then
    return
  end
  desc = LT.EnsureDescEndsWithPeriod(desc)
  desc = LT.ReplaceSpecialChineseChar(desc)
  binder:SetText(self.ui.Text_Creation_Desc, desc, false, nil, {banKeywordBtn = true})
  binder:RemoveUnderline(self.ui.Text_Creation_Desc)
end

function PvPSelectCreationItem:OnBtnClick()
  if self.callback then
    self.callback(self, self.relicTid)
  end
end

function PvPSelectCreationItem:EnableSelectShow(enable)
  self.isShowSelect = enable
  if self.ui and self.ui.Image_Selected then
    self.ui.Image_Selected:SetActive(self.isShowSelect)
  end
end

function PvPSelectCreationItem:GetIsShow()
  return self.isShowSelect
end

return PvPSelectCreationItem
