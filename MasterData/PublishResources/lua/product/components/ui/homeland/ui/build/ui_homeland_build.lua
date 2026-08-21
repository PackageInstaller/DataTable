_class("UIHomelandBuild", UIController)
UIHomelandBuild = UIHomelandBuild

function UIHomelandBuild:OnShow(uiParams)
  self._topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self._mobileBuildControlGO = self:GetGameObject("MobileBuildControl")
  self._mobileBuildConWidgetPool = self:GetUIComponent("UISelectObjectPath", "MobileBuildControl")
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self:Init()
end

function UIHomelandBuild:OnHide()
end

function UIHomelandBuild:Init()
  self._mobileBuildControlGO:SetActive(true)
  self._uiWidgetBuildCtrl = self._mobileBuildConWidgetPool:SpawnObject("UIWidgetHomelandBuildController")
  local poolEdit = self:GetUIComponent("UISelectObjectPath", "edit")
  self._uiEdit = poolEdit:SpawnObject("UIHomelandBuildEdit")
  self._uiEdit:SetUIWidgetHomelandBuildController(self._uiWidgetBuildCtrl)
end

function UIHomelandBuild:GetGuideItem()
  return self._uiEdit:GetFirstItem()
end

function UIHomelandBuild:GetSpecialTag()
  return self._uiEdit:GetSpecialTag()
end

function UIHomelandBuild:GetSpecialLand()
  return self._uiEdit:GetSpecialLand()
end
