local UI_HBCampInfo = class("UI_HBCampInfo", UIBaseWindow)
local base = UIBaseWindow

function UI_HBCampInfo:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
end

function UI_HBCampInfo:InitHBCampInfo(campId, resloader, backCallback)
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self.backCallback = backCallback
  local name = ConfigData:GetTipContent(8303)
  self.handBookCtrl:SetHBViewSetLayer(2, name)
  local campCfg = ConfigData.camp[campId]
  self.ui.tex_Camp.text = LanguageUtil.GetLocaleText(campCfg.name)
  self.ui.tex_CampDescribtion.text = LanguageUtil.GetLocaleText(campCfg.camp_info)
  local collectRate, totalNum = self.handBookCtrl:GetCampHeroCollectNum(campId)
  self.ui.tex_Count:SetIndex(0, tostring(collectRate), tostring(totalNum))
  resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_CampIcon.texture = texture
  end)
end

function UI_HBCampInfo:__OnClickBack()
  self.handBookCtrl:SetHBViewSetLayer(1)
  if self.backCallback ~= nil then
    self.backCallback()
  end
  self:Delete()
end

function UI_HBCampInfo:OnDelete()
end

return UI_HBCampInfo
