_class("UIChooseAssistantNewPetSkinCard", UICustomWidget)
UIChooseAssistantNewPetSkinCard = UIChooseAssistantNewPetSkinCard

function UIChooseAssistantNewPetSkinCard:Constructor()
  self._checkIsCurSkinCallBack = nil
end

function UIChooseAssistantNewPetSkinCard:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.ChangeAssistantNewPetSkinCard, self.SelectItem)
end

function UIChooseAssistantNewPetSkinCard:InitWidget()
  self._cardAreaGo = self:GetGameObject("CardArea")
  self.bg = self:GetUIComponent("Image", "BottomBg")
  self._bgGo = self:GetGameObject("BottomBg")
  self._headImg = self:GetUIComponent("RawImageLoader", "HeadImg")
  self._curUseArea = self:GetGameObject("CurUseArea")
  self._skinNameText = self:GetUIComponent("UILocalizationText", "SkinNameText")
  self.selectFrame = self:GetUIComponent("Image", "SelectFrame")
  self._frameImgGo = self:GetGameObject("SelectFrame")
  self._funcLayerGo = self:GetGameObject("FuncLayer")
  self._grayCoverGo = self:GetGameObject("GrayCoverImg")
  self._grayCoverGo:SetActive(false)
  self._red = self:GetGameObject("red")
  self:AttachEvent(GameEventType.OnRemoveAsCardNew, self.RemoveAsNew)
end

function UIChooseAssistantNewPetSkinCard:RemoveAsNew(asid)
  if asid == self._asid then
    self._red:SetActive(false)
  end
end

function UIChooseAssistantNewPetSkinCard:SetCheckIsCurSkinCallBack(callBack)
  self._checkIsCurSkinCallBack = callBack
end

function UIChooseAssistantNewPetSkinCard:SetData(skinData, idx, callbcak)
  local skinCfg = MatchPet.GetPetSkinCfg(skinData.petid, skinData.grade, skinData.skinid, PetSkinEffectPath.HEAD_ICON_CHANGE_ASSIST)
  self._idx = idx
  self._callback = callbcak
  self._asid = 0
  local resData = {}
  if skinData.asid and skinData.asid ~= 0 then
    local cfg = Cfg.cfg_only_assistant[skinData.asid]
    resData.icon = cfg.Icon
    self._asid = skinData.asid
  else
    resData.icon = skinCfg.AircraftBody
  end
  if self._curUseArea and self._checkIsCurSkinCallBack then
    local isCur = self._checkIsCurSkinCallBack(skinData.petid, skinData.grade, skinData.skinid, skinData.asid)
    self._curUseArea:SetActive(isCur)
  end
  if self._headImg and skinCfg then
    self._headImg:LoadImage(resData.icon)
  end
  self:SetRed()
end

function UIChooseAssistantNewPetSkinCard:SetRed()
  self._redState = false
  if self._asid ~= 0 then
    local itemModule = GameGlobal.GetModule(ItemModule)
    local itemDatas = itemModule:GetItemByTempId(self._asid)
    if itemDatas and 0 < table.count(itemDatas) then
      local item_data
      for key, value in pairs(itemDatas) do
        item_data = value
        break
      end
      local isNew = item_data:IsNewOverlay()
      self._redState = isNew
      self._pstid = item_data:GetID()
    end
  end
  self._red:SetActive(self._redState)
end

function UIChooseAssistantNewPetSkinCard:BottomBgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UIChooseAssistantNewPetSkinCard:SetIsOnTop(isOnTop)
  if self._lastOnTop ~= isOnTop then
    self._lastOnTop = isOnTop
  else
    return
  end
  if isOnTop then
    self._cardAreaGo.transform:DOLocalMoveX(-5.5, 0.2)
  else
    self._cardAreaGo.transform:DOLocalMoveX(0, 0.2)
  end
  self._funcLayerGo:SetActive(isOnTop)
end

function UIChooseAssistantNewPetSkinCard:SelectItem(id)
  local select = self._idx == id
  self._frameImgGo:SetActive(select)
end
