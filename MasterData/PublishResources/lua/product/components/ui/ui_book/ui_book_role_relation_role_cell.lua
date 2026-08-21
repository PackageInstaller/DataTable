_class("UIBookRoleRelationRoleCell", UICustomWidget)

function UIBookRoleRelationRoleCell:OnShow()
  self._sizePos = {
    [1] = {
      [1] = 0,
      [2] = -8,
      [3] = 183,
      [4] = 225.7
    },
    [2] = {
      [1] = 0,
      [2] = -30,
      [3] = 156,
      [4] = 266
    }
  }
  self.nameTxt = self:GetUIComponent("UILocalizationText", "txt1")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self.iconGO = self:GetGameObject("icon")
  self.logo = self:GetUIComponent("RawImageLoader", "logo")
  self.chooseGO = self:GetGameObject("choose")
  self.chooseGO:SetActive(false)
  self.lockGO = self:GetGameObject("lock")
  self.lockImage = self:GetUIComponent("Image", "lock")
  self.showGO = self:GetGameObject("show")
  self.lineGO = self:GetGameObject("line")
  self.lineShuGO = self:GetGameObject("lineshu")
  self.lineShuGO:SetActive(false)
  self.lineGO:SetActive(false)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.iconGO), UIEvent.Press, function(go)
    self.chooseGO:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self.iconGO), UIEvent.Release, function(go)
    self.chooseGO:SetActive(false)
  end)
  self._animation = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UIBookRoleRelationRoleCell:SetClickCallBack(clickCallBack)
  self.clickCallBack = clickCallBack
end

function UIBookRoleRelationRoleCell:IsActive()
  if self.bookRoleType == BookRoleType.Pet then
    if self.data.isMonster then
      return self.data.monsterId > 0
    else
      return 0 < self.data.petPsdId
    end
  elseif self.bookRoleType == BookRoleType.Monster then
    return self.data.monsterId > 0
  end
  return true
end

function UIBookRoleRelationRoleCell:OnHide()
end

function UIBookRoleRelationRoleCell:Refresh(bookRoleType, data, showLine, showShuLine)
  self.bookRoleType = bookRoleType
  self.data = data
  local atlas = self:GetAsset("UIBook.spriteatlas", LoadType.SpriteAtlas)
  local sizePos
  if self.bookRoleType == BookRoleType.Pet then
    self.lineGO:SetActive(showLine)
    self.lineShuGO:SetActive(showShuLine)
    if not self.data.isMonster then
      local cfg = Cfg.cfg_pet[self.data.petTempId]
      local petModule = self:GetModule(PetModule)
      local petData = petModule:GetPetByTemplateId(self.data.petTempId)
      local body
      if petData then
        sizePos = self._sizePos[2]
        local grade = petData:GetPetGrade()
        body = HelperProxy:GetInstance():GetPetTeamBody(self.data.petTempId, grade, petData:GetSkinId(), PetSkinEffectPath.CARD_ROLE_RELATION)
      else
        sizePos = self._sizePos[1]
        body = HelperProxy:GetInstance():GetPetTeamBody(self.data.petTempId, 0, 0, PetSkinEffectPath.CARD_ROLE_RELATION)
      end
      self.icon:LoadImage(body)
      if 0 < self.data.petPsdId then
        self.showGO:SetActive(true)
        self.lockGO:SetActive(false)
        self.iconGO:SetActive(true)
        self.logo:LoadImage(cfg.Logo)
        self.nameTxt:SetText(StringTable.Get(cfg.Name))
        self.nameTxt.color = Color.white
      else
        self.showGO:SetActive(false)
        self.lockGO:SetActive(true)
        self.iconGO:SetActive(false)
        self.lockImage.sprite = atlas:GetSprite("tujian_xiaozu_frame10")
        self.nameTxt:SetText(StringTable.Get("str_book_btn_lock"))
        self.nameTxt.color = Color(0.45098039215686275, 0.45098039215686275, 0.45098039215686275, 1)
      end
    else
      sizePos = self._sizePos[1]
      self.lineGO:SetActive(showLine)
      self.lineShuGO:SetActive(showShuLine)
      local cfgMonsterClass = Cfg.cfg_monster_class[self.data.monsterClassId]
      self.icon:LoadImage(cfgMonsterClass.EnemyStaticBody)
      if 0 < self.data.monsterId then
        self.showGO:SetActive(false)
        self.lockGO:SetActive(false)
        self.iconGO:SetActive(true)
        self.nameTxt:SetText(StringTable.Get(cfgMonsterClass.Name))
        self.nameTxt.color = Color.white
      else
        self.showGO:SetActive(false)
        self.lockGO:SetActive(true)
        self.iconGO:SetActive(false)
        self.lockImage.sprite = atlas:GetSprite("tujian_xiaozu_frame10")
        self.nameTxt:SetText(StringTable.Get("str_book_btn_monster_lock"))
        self.nameTxt.color = Color(0.45098039215686275, 0.45098039215686275, 0.45098039215686275, 1)
      end
    end
  elseif self.bookRoleType == BookRoleType.Monster then
    sizePos = self._sizePos[1]
    self.lineGO:SetActive(showLine)
    self.lineShuGO:SetActive(showShuLine)
    local cfgMonsterClass = Cfg.cfg_monster_class[self.data.monsterClassId]
    if cfgMonsterClass then
      self.icon:LoadImage(cfgMonsterClass.EnemyStaticBody)
      if 0 < self.data.monsterId then
        self.showGO:SetActive(false)
        self.lockGO:SetActive(false)
        self.iconGO:SetActive(true)
        self.nameTxt:SetText(StringTable.Get(cfgMonsterClass.Name))
        self.nameTxt.color = Color.white
      else
        self.showGO:SetActive(false)
        self.lockGO:SetActive(true)
        self.iconGO:SetActive(false)
        self.lockImage.sprite = atlas:GetSprite("tujian_xiaozu_frame10")
        self.nameTxt:SetText(StringTable.Get("str_book_btn_monster_lock"))
        self.nameTxt.color = Color(0.45098039215686275, 0.45098039215686275, 0.45098039215686275, 1)
      end
    end
  end
  self._iconRect.sizeDelta = Vector2(sizePos[3], sizePos[4])
  self._iconRect.anchoredPosition = Vector2(sizePos[1], sizePos[2])
end

function UIBookRoleRelationRoleCell:iconOnClick(go)
  if self.clickCallBack then
    self.clickCallBack(self)
    if not self:IsActive() then
      self._animation:Play("uieff_RoleCell_Shake")
    end
  end
end
