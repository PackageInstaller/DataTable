_class("UIHomePetInviteItemEnable", UICustomWidget)
UIHomePetInviteItemEnable = UIHomePetInviteItemEnable

function UIHomePetInviteItemEnable:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomePetInviteItemEnable:OnShow(uiParams)
  self:GetComponent()
end

function UIHomePetInviteItemEnable:OnHide()
end

function UIHomePetInviteItemEnable:GetComponent()
  self._stateTips = {
    [1] = "str_homeland_invite_enable",
    [2] = "str_homeland_invite_skinneed",
    [3] = "str_homeland_invite_eventneed",
    [4] = "str_homeland_invite_nothave"
  }
  self._stateImgs = {
    [1] = "N17_hudong_icon09",
    [2] = "N17_hudong_icon08",
    [3] = "N17_hudong_icon07",
    [4] = "N17_hudong_icon10"
  }
  self._titleImg = {
    [1] = "N17_hudong_di09",
    [2] = "N17_hudong_di08",
    [3] = "N17_hudong_di08",
    [4] = "N17_hudong_di010"
  }
  self._atlas = self:GetAsset("UIHomelandInvite.spriteatlas", LoadType.SpriteAtlas)
  self._tipText = self:GetUIComponent("UILocalizationText", "tip")
  self._petName = self:GetUIComponent("UILocalizationText", "name")
  self._stateImg = self:GetUIComponent("Image", "state")
  self._petskinImg = self:GetUIComponent("Image", "petskin")
  self._mask = self:GetGameObject("mask")
  self._petskin = self:GetUIComponent("UILocalizationText", "petskin")
  self._headimg = self:GetUIComponent("RawImageLoader", "head")
  self._nameImage = self:GetUIComponent("Image", "nameImage")
end

function UIHomePetInviteItemEnable:SetData(index, data, inviteManager, callback)
  self._index = index
  self._data = data
  self._inviteManager = inviteManager
  self._callback = callback
  self:RefreshUI()
end

function UIHomePetInviteItemEnable:RefreshUI()
  self._petskin = self._data:GetSkin()
  local cfg = self._data:GetPetCfg()
  self._petName:SetText(StringTable.Get(cfg.Name))
  self:CheckCondition()
  self:PlayAni()
end

function UIHomePetInviteItemEnable:CheckCondition()
  local condi = false
  local conditionstr = ""
  self._state = 1
  if self._data:GetNeedCheckSkin() then
    local skins = self._data:GetSkin()
    local skinneed = false
    for i = 1, #skins do
      if self._inviteManager:CheckHadSkin(skins[i].id) then
        skinneed = true
        break
      end
    end
    self._state = skinneed and self._state or 2
  end
  local petId
  local skindata = self._data:GetSkin()
  petId = skindata[1].Head
  conditionstr = skindata[1].SkinName
  self._headimg:LoadImage(petId)
  condi = self._inviteManager:CheckEventFinish(self._data:GetInteractId(), self._data:GetPetId())
  if not condi then
    self._state = 3
    local eventId
    local cfgs = Cfg.cfg_homeland_event({
      PetID = self._data:GetPetId()
    })
    for _, cfg in pairs(cfgs) do
      if cfg.RewardsInteractID and table.icontains(cfg.RewardsInteractID, self._data:GetInteractId()) then
        eventId = cfg.ID
        break
      end
    end
    cfgs = Cfg.cfg_homeland_dairy_item({EventId = eventId})
    conditionstr = cfgs[1] ~= nil and cfgs[1].DairyTitle or ""
    if self._data:GetUsingSkin() then
      self._headimg:LoadImage(self._data:GetUsingSkin())
    else
      self._headimg:LoadImage(self._data:GetOriginalSkin())
    end
  end
  condi = self._inviteManager:CheckHadPet(self._data:GetPetId())
  if not condi then
    self._headimg:LoadImage(self._data:GetOriginalSkin())
    self._state = 4
  end
  self._mask:SetActive(not condi)
  local str = StringTable.Get(self._stateTips[self._state])
  str = string.format(str, StringTable.Get(conditionstr))
  self._tipText:SetText(str)
  local sp = self._titleImg[self._state]
  self._nameImage.sprite = self._atlas:GetSprite(sp)
  self._stateImg.sprite = self._atlas:GetSprite(self._stateImgs[self._state])
end

function UIHomePetInviteItemEnable:BtnOnClick(go)
  if self._callback then
    self._callback(self._index)
  end
end

function UIHomePetInviteItemEnable:PlayAni()
  self.anim = self:GetUIComponent("Animation", "ani")
  self:StartTask(function(TT)
    local lockName = "UIHomePetInviteItemEnable:PlayAni"
    self:Lock(lockName)
    YIELD(TT, 25 * math.modf(self._index / 2))
    self.anim:Play("uieffanim_UIHomePetInviteItemEnable_in")
    self:UnLock(lockName)
  end, self)
end
