_class("UIN25IdolCommonResultItem", UICustomWidget)
UIN25IdolCommonResultItem = UIN25IdolCommonResultItem

function UIN25IdolCommonResultItem:Constructor()
  self.type2data = {
    [UIIdolResultType.Training] = {
      title1 = "str_n25_idol_y_act_result_title",
      title2 = "str_n25_idol_game_training_class_succ",
      title3 = "str_n25_idol_y_act_result_fans",
      showTitle3 = true,
      showValue = true,
      fromto = true
    },
    [UIIdolResultType.Act] = {
      title1 = "str_n25_idol_y_act_result_title",
      title2 = "str_n25_idol_y_act_result_succ",
      title3 = "str_n25_idol_y_act_result_fans",
      showTitle3 = true,
      showValue = true,
      fromto = false
    },
    [UIIdolResultType.ConcertSucc] = {
      title1 = "concert succ title 1",
      title2 = "concert succ title 2",
      title3 = "concert succ title 3",
      showTitle3 = false,
      showValue = false,
      fromto = true,
      desc1 = "concert succ desc 1",
      desc2 = "concert succ desc 2"
    },
    [UIIdolResultType.ConcertFail] = {
      title1 = "concert fail title 1",
      title2 = "concert fail title 2",
      title3 = "concert fail title 3",
      showTitle3 = false,
      showValue = false,
      fromto = true,
      desc1 = "concert succ desc 1",
      desc2 = "concert succ desc 2"
    }
  }
end

function UIN25IdolCommonResultItem:OnShow()
  self:GetComponents()
end

function UIN25IdolCommonResultItem:OnHide()
  if self._res then
    self._res:Dispose()
    self._res = nil
  end
end

function UIN25IdolCommonResultItem:SetData(...)
  self.args = {
    ...
  }
  self:OnValue()
end

function UIN25IdolCommonResultItem:GetComponents()
  self.go = self:GetGameObject("go")
  self.bg = self:GetUIComponent("Image", "bg")
  self.title1 = self:GetUIComponent("UILocalizationText", "title")
  self.title2 = self:GetUIComponent("UILocalizedTMP", "title2")
  self.title3 = self:GetUIComponent("UILocalizationText", "title3")
  self.desc1 = self:GetUIComponent("UILocalizationText", "desc1")
  self.desc2 = self:GetUIComponent("UILocalizationText", "desc2")
  self.valuePlus = self:GetUIComponent("UILocalizationText", "valuePlus")
  self.valueFrom = self:GetUIComponent("UILocalizationText", "valueFrom")
  self.valueTo = self:GetUIComponent("UILocalizationText", "valueTo")
  self.plusGo = self:GetGameObject("modePlus")
  self.changeGo = self:GetGameObject("modeChange")
  self.title3Go = self:GetGameObject("title3Go")
end

function UIN25IdolCommonResultItem:OnValue()
  local type = self.args[1]
  local title1 = self.type2data[type].title1
  local title2 = self.type2data[type].title2
  local title3 = self.type2data[type].title3
  local showTitle3 = self.type2data[type].showTitle3
  local showValue = self.type2data[type].showValue
  local fromto = self.type2data[type].fromto
  local desc1 = self.type2data[type].desc1
  local desc2 = self.type2data[type].desc2
  local valuePlus, valueFrom, valueTo, valueIcon
  if type == UIIdolResultType.Training then
    title1 = self.args[2]
    title3 = self.args[3]
    valueIcon = self.args[4]
    valueFrom = self.args[5]
    valueTo = self.args[6]
    desc1 = self.args[7]
    desc2 = self.args[8]
  elseif type == UIIdolResultType.Act then
    valuePlus = self.args[2]
    desc1 = self.args[3]
    desc2 = self.args[4]
  elseif type == UIIdolResultType.ConcertSucc then
  elseif type == UIIdolResultType.ConcertFail then
  end
  self.title1:SetText(StringTable.Get(title1))
  self.title2:SetText(StringTable.Get(title2))
  self.title3:SetText(StringTable.Get(title3))
  self.title3Go:SetActive(showTitle3)
  self.changeGo:SetActive(fromto and showValue)
  self.plusGo:SetActive(not fromto and showValue)
  self:_SetIcon(fromto, valueIcon)
  if valuePlus then
    self.valuePlus:SetText(valuePlus)
  end
  if valueFrom then
    self.valueFrom:SetText(valueFrom)
  end
  if valueTo then
    self.valueTo:SetText(valueTo)
  end
  self.desc1.gameObject:SetActive(not string.isnullorempty(desc1))
  self.desc2.gameObject:SetActive(not string.isnullorempty(desc2))
  if not string.isnullorempty(desc1) then
    self.desc1:SetText(StringTable.Get(desc1))
  end
  if not string.isnullorempty(desc2) then
    self.desc2:SetText(StringTable.Get(desc2))
  end
  self:SetFontMat(self.title2, "ui_n25idol_common_result_tmp_outline.mat")
end

function UIN25IdolCommonResultItem:_SetIcon(widgetType, iconType)
  local widgetName = widgetType == 1 and "iconPlus" or "iconChange"
  local tbIcon = {
    "n25_ych_icon07",
    "n25_ych_icon05",
    "n25_ych_icon06",
    "n25_ych_icon04"
  }
  UIWidgetHelper.SetImageSprite(self, widgetName, "UIN25Idol.spriteatlas", tbIcon[iconType])
end

function UIN25IdolCommonResultItem:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end
