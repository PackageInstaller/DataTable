_class("UIExtraMissionPetHeaderItem", UICustomWidget)
UIExtraMissionPetHeaderItem = UIExtraMissionPetHeaderItem

function UIExtraMissionPetHeaderItem:Constructor()
  self._bigSize = Vector2(216, 181)
  self._smallSize = Vector2(181, 152)
  self:AttachEvent(GameEventType.CancelRedPoint, self.CancelRedPoint)
end

function UIExtraMissionPetHeaderItem:OnHide()
  self:DetachEvent(GameEventType.HideNew, self.HideNew)
end

function UIExtraMissionPetHeaderItem:Dispose()
  self:DetachEvent(GameEventType.CancelRedPoint, self.CancelRedPoint)
end

function UIExtraMissionPetHeaderItem:OnShow(uiParams)
  self._extraMissionModule = GameGlobal.GetModule(ExtMissionModule)
  self._petIcon = self:GetUIComponent("RawImageLoader", "header")
  self._finish = self:GetGameObject("finish")
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._idxTex = self:GetUIComponent("UILocalizationText", "indexTex")
  self._select = self:GetGameObject("select")
  self._rect = self:GetUIComponent("LayoutElement", "rect")
  self._finishTex = self:GetUIComponent("UILocalizationText", "finishTex")
  self._starGo = self:GetGameObject("star")
  self._starCountTex = self:GetUIComponent("UILocalizationText", "starCount")
  self:AttachEvent(GameEventType.HideNew, self.HideNew)
end

function UIExtraMissionPetHeaderItem:SetData(index, petID, callback)
  self._index = index
  self._petID = petID
  self._callback = callback
  local starCount = 0
  local cfg_ext_misison = Cfg.cfg_extra_mission[self._petID]
  if cfg_ext_misison then
    for i = 1, #cfg_ext_misison.ExtTaskList do
      local stars = self._extraMissionModule:UI_GetExtTaskState(self._petID, cfg_ext_misison.ExtTaskList[i])
      if stars <= 0 then
        break
      end
      starCount = starCount + stars
    end
    if starCount < 0 then
      starCount = 0
    end
    self._starCount = starCount
  end
  self:CheckPetState()
  self:CheckAward()
end

function UIExtraMissionPetHeaderItem:CheckAward()
  local state = self._extraMissionModule:UI_GetExtAwardRed(self._petID)
  self._red:SetActive(state)
end

function UIExtraMissionPetHeaderItem:CancelRedPoint(extraMissionID)
  if extraMissionID == self._petID then
    self:CheckAward()
  end
end

function UIExtraMissionPetHeaderItem:CheckPetState()
  self._new:SetActive(false)
  self._finish:SetActive(false)
  self._starGo:SetActive(true)
  local starStr = tostring(self._starCount) .. "/<color=#d5d5d5>18</color>"
  self._starCountTex:SetText(starStr)
  local key = tostring(GameGlobal.GameLogic():GetOpenId()) .. tostring(self._petID)
  local newState = UnityEngine.PlayerPrefs.HasKey(key)
  local newValue = UnityEngine.PlayerPrefs.GetInt(key)
  if newState and newValue == 1 then
    self._state = EnumExtMissionState.New
  else
    self._state = self._extraMissionModule:UI_GetExtMissionState(self._petID)
  end
  local petCfg = Cfg.cfg_extra_mission[self._petID]
  if petCfg == nil then
    Log.fatal("###ui ext misison -- cfg_extra_mission is nil ! id --> ", self._petID)
  end
  local iconAsset = ""
  if self._state == EnumExtMissionState.Down then
    iconAsset = petCfg.ExtHeaderImg
    self._finish:SetActive(true)
  elseif self._state == EnumExtMissionState.Disable then
    self._starGo:SetActive(false)
    iconAsset = petCfg.ExtHeaderGrayImg
  elseif self._state == EnumExtMissionState.New then
    self._new:SetActive(true)
    iconAsset = petCfg.ExtHeaderImg
  elseif self._state == EnumExtMissionState.Open then
    iconAsset = petCfg.ExtHeaderImg
  end
  self._petIcon:LoadImage(iconAsset)
  local idxStr = ""
  if self._index < 10 then
    idxStr = "0" .. self._index
  else
    idxStr = tostring(self._index)
  end
  self._idxTex:SetText(idxStr)
  self._select:SetActive(false)
end

function UIExtraMissionPetHeaderItem:Select(select)
  if self._tweener then
    self._tweener:Kill()
  end
  local endValue = Vector2(0, 0)
  if select then
    endValue = self._bigSize
    self._finishTex.fontSize = 35
  else
    endValue = self._smallSize
    self._finishTex.fontSize = 30
  end
  self._select:SetActive(select)
  self._tweener = self._rect:DOPreferredSize(endValue, 0.2, true)
end

function UIExtraMissionPetHeaderItem:HideNew(hideID)
  if hideID == self._petID and self._index ~= 0 then
    self._new:SetActive(false)
  end
end

function UIExtraMissionPetHeaderItem:btnOnClick()
  if self._callback then
    self._callback(self._index)
  end
end
