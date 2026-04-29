_class("UIHomelandBreed", UIController)
UIHomelandBreed = UIHomelandBreed

function UIHomelandBreed:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._curBreedUIType = nil
  self._breedWidget = {}
  self._breedTypeState = {}
  self._breedTypeState[HomelandBreedUIType.Mutation] = HomelandBreedState.None
  self._breedTypeState[HomelandBreedUIType.Clone] = HomelandBreedState.None
  self._breedTypeState[HomelandBreedUIType.StateChg] = HomelandBreedState.None
  self._atlas = self:GetAsset("UIHomelandBreed.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandBreed:OnShow(uiParams)
  self.breedLand = uiParams[1]
  self.buildingPstId = self.breedLand:GetArchitecture().pstid
  self._landCultivationInfo = self:_GetCurBuildBreedInfo(self.buildingPstId)
  self:_GetComponents()
  self:_OnValue()
  self:_CheckGuide()
  self:_AttachEvents()
end

function UIHomelandBreed:_AttachEvents()
  self:AttachEvent(GameEventType.HomelandCloseBreedUI, self.OnHomelandCloseBreedUI)
  self:AttachEvent(GameEventType.HomelandFriendSpeed, self.OnHomelandFriendSpeed)
end

function UIHomelandBreed:OnHomelandCloseBreedUI()
  self:_Close()
end

function UIHomelandBreed:_GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonBackBtn = self._backBtn:SpawnObject("UIHomeCommonCloseBtn")
  self._commonBackBtn:SetData(function()
    self:_Close()
  end, function()
    self:ShowDialog("UIHomeHelpController", "UIHomelandBreed")
  end)
  self._breed = {}
  self._breed[HomelandBreedUIType.Mutation] = self:GetGameObject("Mutation")
  self._breed[HomelandBreedUIType.Clone] = self:GetGameObject("Clone")
  self._breed[HomelandBreedUIType.StateChg] = self:GetGameObject("StateChg")
  self._breed[HomelandBreedUIType.Manual] = self:GetGameObject("Manual")
  self._breedBtnImg = {}
  self._breedBtnImg[HomelandBreedUIType.Mutation] = self:GetUIComponent("Image", "MutationBtn")
  self._breedBtnImg[HomelandBreedUIType.Clone] = self:GetUIComponent("Image", "CloneBtn")
  self._breedBtnImg[HomelandBreedUIType.StateChg] = self:GetUIComponent("Image", "StateChgBtn")
  self._breedBtnImg[HomelandBreedUIType.Manual] = self:GetUIComponent("Image", "ManualBtn")
  self._breedUI = {}
  self._breedUI[HomelandBreedUIType.Mutation] = self:GetUIComponent("UISelectObjectPath", "Mutation")
  self._breedUI[HomelandBreedUIType.Clone] = self:GetUIComponent("UISelectObjectPath", "Clone")
  self._breedUI[HomelandBreedUIType.StateChg] = self:GetUIComponent("UISelectObjectPath", "StateChg")
  self._breedUI[HomelandBreedUIType.Manual] = self:GetUIComponent("UISelectObjectPath", "Manual")
  self._mutationBgObj = self:GetGameObject("MutationBg")
end

function UIHomelandBreed:_OnValue()
  local defaultType = HomelandBreedUIType.Mutation
  self._breedState = HomelandBreedState.None
  if self._landCultivationInfo then
    local remainTime = self._homelandModule:GetLandEndTime(self._landCultivationInfo) - self._svrTimeModule:GetServerTime() * 0.001
    if #self._landCultivationInfo.client_info.mutation_cultivation > 0 then
      defaultType = HomelandBreedUIType.Mutation
      if remainTime <= 0 then
        self._breedState = HomelandBreedState.MutationReap
      else
        self._breedState = HomelandBreedState.Mutationing
      end
      self._breedTypeState[defaultType] = self._breedState
    end
    if 0 < #self._landCultivationInfo.client_info.directional_cultivation then
      defaultType = HomelandBreedUIType.Clone
      if remainTime <= 0 then
        self._breedState = HomelandBreedState.CloneReap
      else
        self._breedState = HomelandBreedState.Cloning
      end
      self._breedTypeState[defaultType] = self._breedState
    end
  end
  self:_ChangeBreedUIType(defaultType)
end

function UIHomelandBreed:_ChangeBreedUIType(breedUIType)
  if self._curBreedUIType == breedUIType then
    return
  end
  if self:_BreedMutex(breedUIType) then
    return
  end
  self._curBreedUIType = breedUIType
  for _, _type in pairs(HomelandBreedUIType) do
    self._breed[_type]:SetActive(_type == self._curBreedUIType)
    local spriteName = "n17_plant_di3"
    if _type == HomelandBreedUIType.Manual then
      spriteName = "n17_plant_di5"
    end
    if _type == self._curBreedUIType then
      spriteName = "n17_plant_di2"
    end
    self._breedBtnImg[_type].sprite = self._atlas:GetSprite(spriteName)
  end
  if not self._breedWidget[self._curBreedUIType] then
    self._breedWidget[self._curBreedUIType] = self._breedUI[self._curBreedUIType]:SpawnObject(HomelandBreedUIWidget[self._curBreedUIType])
  end
  self._breedWidget[self._curBreedUIType]:SetData(self._landCultivationInfo)
  self._mutationBgObj:SetActive(self._curBreedUIType == HomelandBreedUIType.Mutation or self._curBreedUIType == HomelandBreedUIType.StateChg)
end

function UIHomelandBreed:Update(deltaTime)
  if self._breedWidget[self._curBreedUIType] then
    self._breedWidget[self._curBreedUIType]:Update(deltaTime)
  end
end

function UIHomelandBreed:_Close()
  self:CloseDialog()
end

function UIHomelandBreed:MutationBtnOnClick(go)
  self:_ChangeBreedUIType(HomelandBreedUIType.Mutation)
end

function UIHomelandBreed:CloneBtnOnClick(go)
  self:_ChangeBreedUIType(HomelandBreedUIType.Clone)
end

function UIHomelandBreed:StateChgBtnOnClick(go)
  self:_ChangeBreedUIType(HomelandBreedUIType.StateChg)
end

function UIHomelandBreed:ManualBtnOnClick(go)
  self:_ChangeBreedUIType(HomelandBreedUIType.Manual)
end

function UIHomelandBreed:_GetCurBuildBreedInfo(pstId)
  self._cultivationInfo = self._homelandModule:GetHomelandInfo().cultivation_info
  return self._cultivationInfo.land_cultivation_infos[pstId]
end

function UIHomelandBreed:_BreedMutex(uiType)
  if uiType == HomelandBreedUIType.Manual then
    return false
  end
  if self._breedTypeState[uiType] ~= self._breedState then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_breeding", StringTable.Get(HomelandBreedTypeStr[self._breedState])))
    return true
  end
  return false
end

function UIHomelandBreed:GetCurBreedState()
  return self._breedState
end

function UIHomelandBreed:SetCurBreedState(state)
  self._breedState = state
  self._breedTypeState[self._curBreedUIType] = self._breedState
end

function UIHomelandBreed:RefreshCultivationInfo()
  self._landCultivationInfo = self:_GetCurBuildBreedInfo(self.buildingPstId)
  return self._landCultivationInfo
end

function UIHomelandBreed:OnHomelandFriendSpeed(pstId)
  if self.buildingPstId ~= pstId then
    return
  end
  if self._breedWidget[self._curBreedUIType] then
    self._breedWidget[self._curBreedUIType]:RefreshBreedInfo(self:RefreshCultivationInfo())
  end
end

function UIHomelandBreed:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandBreed)
end
