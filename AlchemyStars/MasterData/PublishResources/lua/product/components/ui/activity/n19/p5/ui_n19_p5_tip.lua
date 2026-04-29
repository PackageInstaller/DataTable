_class("UIN19P5Tip", UIController)
UIN19P5Tip = UIN19P5Tip

function UIN19P5Tip:OnShow(uiParams)
  self.awardInfo = uiParams[1]
  self.hideCount = uiParams[2]
  self.itemid = self.awardInfo.m_item_id
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self:GetComponents()
  self:OnValue()
end

function UIN19P5Tip:GetComponents()
  self.nameTex = self:GetUIComponent("UILocalizationText", "name")
  self.descTex = self:GetUIComponent("UILocalizationText", "desc")
  self.countTex = self:GetUIComponent("UILocalizationText", "count")
  self.awardPool = self:GetUIComponent("UISelectObjectPath", "award")
end

function UIN19P5Tip:OnHide()
end

function UIN19P5Tip:OnValue()
  local cfg = Cfg.cfg_item[self.itemid]
  if not cfg then
    Log.error("###[UIN19P5Tip] cfg is nil ! id --> ", self.itemid)
  end
  local desc = StringTable.Get(cfg.Intro)
  local name = StringTable.Get(cfg.Name)
  self.descTex:SetText(desc)
  self.nameTex:SetText(name)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local count = roleModule:GetAssetCount(self.itemid)
  local countStr = HelperProxy:GetInstance():FormatItemCount(count)
  self.countTex:SetText(countStr)
  local widget = self.awardPool:SpawnObject("UIN19P5AwardItem")
  widget:SetData(self.awardInfo, function()
  end, self.hideCount)
end

function UIN19P5Tip:BgOnClick(go)
  self:CloseDialog()
end
