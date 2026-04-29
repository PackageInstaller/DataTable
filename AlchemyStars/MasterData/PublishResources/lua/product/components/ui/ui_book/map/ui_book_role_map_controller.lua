_class("UIBookRoleMapController", UIController)
UIBookRoleMapController = UIBookRoleMapController

function UIBookRoleMapController:Constructor()
  self._mapStatue = BookRoleMapStatue.Normal
  self._mapList = {
    "n9_rsqb_big_map1",
    "n9_rsqb_big_map2",
    "n9_rsqb_big_map3",
    "n9_rsqb_big_map4",
    "n9_rsqb_big_map5",
    "n9_rsqb_big_map6",
    "n9_rsqb_big_map7",
    "n9_rsqb_big_map8"
  }
  self._classAPointGroup = {}
  self._classBPointGroup = {}
  self._curSelectMapPoint = nil
  self._forceMoveSpeed = 1
end

function UIBookRoleMapController:OnShow(uiParams)
  self:_GetComponents()
  self:_InitComponents()
  self:_InitButtonClickAnim()
end

function UIBookRoleMapController:OnHide()
end

function UIBookRoleMapController:_GetComponents()
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UINewCommonTopButton")
  self.topButtonWidget:SetData(function()
    self:_Close()
  end)
  self._mapContent = self:GetUIComponent("UISelectObjectPath", "MapContent")
  self._scaleBtn = self:GetUIComponent("Image", "ScaleBtn")
  self._overviewContent = self:GetUIComponent("UISelectObjectPath", "OverviewContent")
  self._forceContent = self:GetUIComponent("UISelectObjectPath", "ForceContent")
  self._detailIcon = self:GetUIComponent("Image", "DetailIcon")
  self._detailName = self:GetUIComponent("UILocalizedTMP", "DetailName")
  self._detailIntro = self:GetUIComponent("UILocalizationText", "DetailIntro")
  self._representContent = self:GetUIComponent("UISelectObjectPath", "RepresentContent")
  self._mapPointContent = self:GetUIComponent("UISelectObjectPath", "MapPointContent")
  self._secondMapPointContent = self:GetUIComponent("UISelectObjectPath", "SecondMapPointContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._mapScroll = self:GetUIComponent("ScrollRect", "MapScroll")
  self._overviewBtn = self:GetUIComponent("Image", "OverviewBtn")
  self._overViewBg = self:GetUIComponent("Image", "OverviewBg")
  self._overViewName = self:GetUIComponent("UILocalizationText", "OverviewName")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._overViewScroll = self:GetUIComponent("ScrollRect", "OverviewScroll")
  self._mainMapObj = self:GetGameObject("MainMap")
  self._mapScrollObj = self:GetGameObject("MapScroll")
  self._overviewScrollObj = self:GetGameObject("OverviewScroll")
  self._forceScrollObj = self:GetGameObject("ForceScroll")
  self._fullBtnObj = self:GetGameObject("FullBtn")
  self._representObj = self:GetGameObject("Represent")
  self._detailArea = self:GetGameObject("DetailArea")
  self._secondMapPointContentObj = self:GetGameObject("SecondMapPointContent")
  self._overviewBtnObj = self:GetGameObject("OverviewBtn")
  self.altas = self:GetAsset("UIBookMap.spriteatlas", LoadType.SpriteAtlas)
  self._req = ResourceManager:GetInstance():SyncLoadAsset("ui_book_role_map_font.mat", LoadType.Mat)
  if self._req and self._req.Obj then
    self.material = self._req.Obj
  end
end

function UIBookRoleMapController:_Close()
  self:CloseDialog()
end

function UIBookRoleMapController:_InitComponents()
  local mapItems = self._mapContent:SpawnObjects("UIMapSubItem", #self._mapList)
  for i, mapItem in pairs(mapItems) do
    mapItem:Flush(i, self._mapList[i])
  end
  self._secondMapPointContentObj.transform:SetAsLastSibling()
  local tempACfgs = Cfg.cfg_force_book({})
  local classACfgs = {}
  local classBCfgs = Cfg.cfg_force_book_second({})
  for _, v in pairs(tempACfgs) do
    if v.Pos then
      table.insert(classACfgs, v)
    end
  end
  self._classAPointGroup = self._mapPointContent:SpawnObjects("UIBookRoleMapPointItem", table.count(classACfgs))
  self._classBPointGroup = self._secondMapPointContent:SpawnObjects("UIBookRoleMapPointItem", table.count(classBCfgs))
  for i, point in pairs(self._classAPointGroup) do
    local pointData = {}
    pointData.id = classACfgs[i].ID
    pointData.type = BookRoleMapPointType.ClassA
    point:SetData(pointData, function(cfg)
      if cfg.Tags then
        self:ShowDialog("UIBookRoleRelationController", cfg.Tags)
      else
        ToastManager.ShowToast(StringTable.Get("str_book_force_noinfo"))
        return
      end
    end)
  end
  local index = 1
  for _, cfg in pairs(classBCfgs) do
    local point = self._classBPointGroup[index]
    local pointData = {}
    pointData.id = cfg.ID
    pointData.type = BookRoleMapPointType.ClassB
    point:SetData(pointData, function(cfg, item)
      self:_InitDetailNodeInfo(cfg, item)
    end)
    index = index + 1
  end
  local overViewCfgs = Cfg.cfg_force_book({IsActive = 1})
  local forceCfgs = Cfg.cfg_force_book({IsActivePos = 1})
  self._overviewItems = self._overviewContent:SpawnObjects("UIBookRoleMapOverviewItem", table.count(overViewCfgs))
  local forceItems = self._forceContent:SpawnObjects("UIBookRoleMapForceItem", table.count(forceCfgs))
  for i, item in pairs(self._overviewItems) do
    item:SetData(overViewCfgs[i], i, function(tagID)
      if tagID then
        self:ShowDialog("UIBookRoleRelationController", tagID)
      else
        ToastManager.ShowToast(StringTable.Get("str_book_force_noinfo"))
        return
      end
    end)
  end
  for i, item in pairs(forceItems) do
    item:SetData(forceCfgs[i], function(cfg)
      self:OnForceClicked(cfg)
    end)
  end
end

function UIBookRoleMapController:_InitButtonClickAnim()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self:GetGameObject("ScaleBtn")), UIEvent.Press, function(go)
    if self._mapStatue == BookRoleMapStatue.Normal then
      self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon04")
    else
      self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon06")
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self:GetGameObject("ScaleBtn")), UIEvent.Release, function(go)
    if self._mapStatue == BookRoleMapStatue.Normal then
      self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon03")
    else
      self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon05")
    end
  end)
end

function UIBookRoleMapController:ChangeStatue(TT, statue)
  if statue == self._mapStatue then
    return
  end
  self._mapStatue = statue
  self:Lock("UIBookRoleMapController_ChangeStatue")
  if self._mapStatue == BookRoleMapStatue.Normal then
    self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon03")
    self._forceScrollObj:SetActive(false)
    self._mainMapObj:SetActive(true)
    self._overviewBtnObj:SetActive(true)
    self._anim:Play("uianim_UIBookRoleMapController_big_out")
    YIELD(TT, 1000)
    self._mapScrollObj:SetActive(false)
  else
    self._scaleBtn.sprite = self.altas:GetSprite("n9_rsqb_icon05")
    self._forceScrollObj:SetActive(true)
    self._mapScrollObj:SetActive(true)
    self._overviewBtnObj:SetActive(false)
    self._mapScroll:DONormalizedPos(Vector2(0.5, 0.5), 0, false)
    self._anim:Play("uianim_UIBookRoleMapController_big_in")
    YIELD(TT, 500)
    self._mainMapObj:SetActive(false)
  end
  self._detailArea:SetActive(false)
  if self._curSelectMapPoint then
    self._curSelectMapPoint:SetSelect(false)
    self._curSelectMapPoint = nil
  end
  self:UnLock("UIBookRoleMapController_ChangeStatue")
end

function UIBookRoleMapController:_InitDetailNodeInfo(cfg, item)
  self._detailArea:SetActive(true)
  if self._curSelectMapPoint then
    self._curSelectMapPoint:SetSelect(false)
  end
  self._curSelectMapPoint = item
  self._curSelectMapPoint:SetSelect(true)
  self._detailIcon.sprite = self.altas:GetSprite(cfg.ForceIcon)
  self._detailName:SetText(StringTable.Get(cfg.Name))
  self._detailIntro:SetText(StringTable.Get(cfg.SecondIntro))
  local oldMaterial = self._detailName.fontMaterial
  self._detailName.fontMaterial = self.material
  self._detailName.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  self:StartTask(function(TT)
    if cfg.PetList then
      self._representObj:SetActive(true)
      local representItems = self._representContent:SpawnObjects("UIBookRoleMapRepresentItem", table.count(cfg.PetList))
      for i, item in pairs(representItems) do
        item:SetData(cfg.PetList[i], cfg.PetHeadList[i], function(petID)
          local petModule = self:GetModule(PetModule)
          if petModule:HasPet(petID) then
            self:ShowDialog("UIPetIntimacyMainController", petID, PetIntimacyWindowType.FilesPanel)
          else
            ToastManager.ShowToast(StringTable.Get("str_book_force_ungotten"))
            return
          end
        end)
      end
    else
      self._representObj:SetActive(false)
    end
    self:Lock("uianim_UIBookRoleMapController_illustrate_in")
    self._anim:Play("uianim_UIBookRoleMapController_illustrate_in")
    YIELD(TT, 500)
    self:UnLock("uianim_UIBookRoleMapController_illustrate_in")
  end)
end

function UIBookRoleMapController:OnForceClicked(cfg)
  local targetPos = Vector2(cfg.CenterPos[1] / 100, cfg.CenterPos[2] / 100)
  local mapContentSize = self._mapContentRect.sizeDelta
  local constNumX = 300 * ((targetPos.x + mapContentSize.x / 2) / mapContentSize.x - 1)
  local constNumY = 300 * ((targetPos.y + mapContentSize.y / 2) / mapContentSize.y - 0.5)
  local compensateWidth = constNumX * ResolutionManager.ScreenHeight() / ResolutionManager.ScreenWidth()
  local compensateHeight = constNumY * ResolutionManager.ScreenWidth() / ResolutionManager.ScreenHeight()
  local horizontalPercent = (targetPos.x + mapContentSize.x / 2 + compensateWidth) / mapContentSize.x
  local verticalPercent = (targetPos.y + mapContentSize.y / 2 + compensateHeight) / mapContentSize.y
  local percent = Vector2(horizontalPercent, verticalPercent)
  local verticalTime = math.abs(self._mapScroll.verticalNormalizedPosition - verticalPercent) / self._forceMoveSpeed
  local horizontalTime = math.abs(self._mapScroll.horizontalNormalizedPosition - horizontalPercent) / self._forceMoveSpeed
  local lockTime = verticalTime > horizontalTime and verticalTime or horizontalTime
  self._mapScroll:DONormalizedPos(percent, lockTime, false)
  if self._curSelectMapPoint then
    self._curSelectMapPoint:SetSelect(false)
    self._curSelectMapPoint = nil
  end
  self:StartTask(function(TT)
    self._anim:Play("uianim_UIBookRoleMapController_illustrate_out")
    self:Lock("UIBookRoleMapController:OnForceClicked")
    lockTime = 500 < lockTime and lockTime or 500
    YIELD(TT, lockTime)
    self:UnLock("UIBookRoleMapController:OnForceClicked")
    self._detailArea:SetActive(false)
  end)
end

function UIBookRoleMapController:ScaleBtnOnClick()
  if self._mapStatue == BookRoleMapStatue.Normal then
    self:StartTask(self.ChangeStatue, self, BookRoleMapStatue.Detail)
  else
    self:StartTask(self.ChangeStatue, self, BookRoleMapStatue.Normal)
  end
end

function UIBookRoleMapController:OverviewBtnOnClick()
  self._fullBtnObj:SetActive(true)
  self._overviewScrollObj:SetActive(true)
  self._overviewBtn.sprite = self.altas:GetSprite("n9_rsqb_icon02")
  self._overViewBg.sprite = self.altas:GetSprite("n9_rsqb_di02")
  self._overViewName.color = Color(0.1411764705882353, 0.1450980392156863, 0.17254901960784313)
  self._overViewScroll.verticalNormalizedPosition = 1
  self:StartTask(function(TT)
    self:Lock("uianim_UIBookRoleMapController_list_in")
    self._anim:Play("uianim_UIBookRoleMapController_list_in")
    for _, item in pairs(self._overviewItems) do
      item:PlayInAnimation()
    end
    YIELD(TT, 334)
    self:UnLock("uianim_UIBookRoleMapController_list_in")
  end)
end

function UIBookRoleMapController:FullBtnOnClick()
  self._overviewBtn.sprite = self.altas:GetSprite("n9_rsqb_icon01")
  self._overViewBg.sprite = self.altas:GetSprite("n9_rsqb_di01")
  self._overViewName.color = Color(0.8274509803921568, 0.8274509803921568, 0.8274509803921568)
  self:StartTask(function(TT)
    self:Lock("uianim_UIBookRoleMapController_list_out")
    self._anim:Play("uianim_UIBookRoleMapController_list_out")
    YIELD(TT, 334)
    for _, item in pairs(self._overviewItems) do
      item:ResetAnim()
    end
    self._fullBtnObj:SetActive(false)
    self._overviewScrollObj:SetActive(false)
    self:UnLock("uianim_UIBookRoleMapController_list_out")
  end)
end

local BookRoleMapStatue = {Normal = 1, Detail = 2}
_enum("BookRoleMapStatue", BookRoleMapStatue)
local BookRoleMapPointType = {ClassA = 1, ClassB = 2}
_enum("BookRoleMapPointType", BookRoleMapPointType)
