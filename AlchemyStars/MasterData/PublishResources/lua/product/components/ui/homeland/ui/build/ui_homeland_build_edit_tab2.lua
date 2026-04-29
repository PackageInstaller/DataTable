_class("UIHomelandBuildEditTab2", UICustomWidget)
UIHomelandBuildEditTab2 = UIHomelandBuildEditTab2

function UIHomelandBuildEditTab2:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.lockState = false
  self.colorText = {
    Color(0.4117647058823529, 0.40784313725490196, 0.40784313725490196),
    Color(0.984313725490196, 0.984313725490196, 0.984313725490196)
  }
end

function UIHomelandBuildEditTab2:OnShow()
  self.imgTab = self:GetUIComponent("Image", "imgTab")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  self.new = self:GetGameObject("new")
  self.new:SetActive(false)
  self.lock = self:GetGameObject("lock")
  self.atlas = self:GetAsset("UIHomelandBuildInfo.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.HomelandBuildFilterTab2, self.HomelandBuildFilterTab2)
end

function UIHomelandBuildEditTab2:OnHide()
  self:DetachEvent(GameEventType.HomelandBuildFilterTab2, self.HomelandBuildFilterTab2)
end

function UIHomelandBuildEditTab2:Flush(id, childId, filterID2SubType)
  self.id = id
  self.childId = childId
  local filter = UIHomelandBuildEdit.GetBuildFilterBy2Id(id, childId)
  self.txtFilter:SetText(filter.name)
  self.lockState = false
  local subType = filterID2SubType[childId]
  if subType then
    local homeBuildManager = GameGlobal.GetUIModule(HomelandModule):GetClient():BuildManager()
    local building = homeBuildManager:GetBuildingBySubType(subType)
    if building:IsShabby() then
      self.lockState = true
    end
  end
  self.lock:SetActive(self.lockState)
end

function UIHomelandBuildEditTab2:SetNew(new)
  if new then
    self.new:SetActive(true)
  else
    self.new:SetActive(false)
  end
end

function UIHomelandBuildEditTab2:HomelandBuildFilterTab2(id, childId)
  if self.childId == childId then
    self.imgTab.sprite = self.atlas:GetSprite("n17_layout_btn04")
    self.txtFilter.color = self.colorText[2]
  elseif self.lockState then
    self.imgTab.sprite = self.atlas:GetSprite("n17_layout_btn10")
    self.txtFilter.color = self.colorText[2]
  else
    self.imgTab.sprite = self.atlas:GetSprite("n17_layout_btn03")
    self.txtFilter.color = self.colorText[1]
  end
end

function UIHomelandBuildEditTab2:imgTabOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBuildFilterTab2, self.id, self.childId)
end

function UIHomelandBuildEditTab2:lockOnClick(go)
  ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_architecture_lock"))
end
