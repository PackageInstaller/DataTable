_class("UIBreakPromotionItem", UICustomWidget)
UIBreakPromotionItem = UIBreakPromotionItem

function UIBreakPromotionItem:OnShow(uiParams)
  self:InitWidget()
end

function UIBreakPromotionItem:InitWidget()
  self.attackIcon = self:GetGameObject("attackIcon")
  self.defenseIcon = self:GetGameObject("defenseIcon")
  self.hpIcon = self:GetGameObject("hpIcon")
  self.skillIcon = self:GetGameObject("skillIcon")
  self.attack = self:GetUIComponent("RectTransform", "attack")
  self.defense = self:GetUIComponent("RectTransform", "defense")
  self.hp = self:GetUIComponent("RectTransform", "hp")
  self.skill = self:GetUIComponent("RectTransform", "skill")
  self.skillLoader = self:GetUIComponent("RawImageLoader", "skill")
  self.space = self:GetGameObject("space")
  self.iconsRight = self:GetGameObject("iconsRight")
  self.iconsLeft = self:GetGameObject("iconsLeft")
  self.attackIconLeft = self:GetGameObject("attackIconLeft")
  self.defenseIconLeft = self:GetGameObject("defenseIconLeft")
  self.hpIconLeft = self:GetGameObject("hpIconLeft")
  self.skillIconLeft = self:GetGameObject("skillIconLeft")
  self.attackLeft = self:GetUIComponent("RectTransform", "attackLeft")
  self.defenseLeft = self:GetUIComponent("RectTransform", "defenseLeft")
  self.hpLeft = self:GetUIComponent("RectTransform", "hpLeft")
  self.skillLeft = self:GetUIComponent("RectTransform", "skillLeft")
  self.skillLoaderLeft = self:GetUIComponent("RawImageLoader", "skillLeft")
  self.spaceLeft = self:GetGameObject("spaceLeft")
end

function UIBreakPromotionItem:SetData(datas, leftorright)
  self._datas = datas
  self:Flush(leftorright)
end

function UIBreakPromotionItem:Flush(leftorright)
  self._leftorright = leftorright
  self.iconsRight:SetActive(leftorright == 2)
  self.iconsLeft:SetActive(leftorright == 1)
  self.attackIcon:SetActive(false)
  self.defenseIcon:SetActive(false)
  self.hpIcon:SetActive(false)
  self.skillIcon:SetActive(false)
  self.attackIconLeft:SetActive(false)
  self.defenseIconLeft:SetActive(false)
  self.hpIconLeft:SetActive(false)
  self.skillIconLeft:SetActive(false)
  if self._leftorright == 1 then
    for i = 1, #self._datas do
      local data = self._datas[i]
      if data.type == UIBreakPromoteType.Attack then
        self.attackIconLeft:SetActive(true)
      elseif data.type == UIBreakPromoteType.Defence then
        self.defenseIconLeft:SetActive(true)
      elseif data.type == UIBreakPromoteType.HP then
        self.hpIconLeft:SetActive(true)
      else
        self.skillLoaderLeft:LoadImage(data.icon_bianse)
        self.skillIconLeft:SetActive(true)
      end
    end
  else
    for i = 1, #self._datas do
      local data = self._datas[i]
      if data.type == UIBreakPromoteType.Attack then
        self.attackIcon:SetActive(true)
      elseif data.type == UIBreakPromoteType.Defence then
        self.defenseIcon:SetActive(true)
      elseif data.type == UIBreakPromoteType.HP then
        self.hpIcon:SetActive(true)
      else
        self.skillLoader:LoadImage(data.icon_bianse)
        self.skillIcon:SetActive(true)
      end
    end
  end
  self:UnSelect()
end

function UIBreakPromotionItem:Select()
  if self._leftorright == 1 then
    if self.attackIconLeft.activeSelf then
      self.attackLeft.sizeDelta = Vector2(76, 76)
    end
    if self.defenseIconLeft.activeSelf then
      self.defenseLeft.sizeDelta = Vector2(76, 76)
    end
    if self.hpIconLeft.activeSelf then
      self.hpLeft.sizeDelta = Vector2(76, 76)
    end
    if self.skillIconLeft.activeSelf then
      self.skillLeft.sizeDelta = Vector2(70, 70)
    end
    self.spaceLeft:SetActive(true)
  else
    if self.attackIcon.activeSelf then
      self.attack.sizeDelta = Vector2(76, 76)
    end
    if self.defenseIcon.activeSelf then
      self.defense.sizeDelta = Vector2(76, 76)
    end
    if self.hpIcon.activeSelf then
      self.hp.sizeDelta = Vector2(76, 76)
    end
    if self.skillIcon.activeSelf then
      self.skill.sizeDelta = Vector2(70, 70)
    end
    self.space:SetActive(true)
  end
end

function UIBreakPromotionItem:UnSelect()
  if self._leftorright == 1 then
    if self.attackIconLeft.activeSelf then
      self.attackLeft.sizeDelta = Vector2(61, 61)
    end
    if self.defenseIconLeft.activeSelf then
      self.defenseLeft.sizeDelta = Vector2(61, 61)
    end
    if self.hpIconLeft.activeSelf then
      self.hpLeft.sizeDelta = Vector2(61, 61)
    end
    if self.skillIconLeft.activeSelf then
      self.skillLeft.sizeDelta = Vector2(60, 60)
    end
    self.spaceLeft:SetActive(false)
  else
    if self.attackIcon.activeSelf then
      self.attack.sizeDelta = Vector2(61, 61)
    end
    if self.defenseIcon.activeSelf then
      self.defense.sizeDelta = Vector2(61, 61)
    end
    if self.hpIcon.activeSelf then
      self.hp.sizeDelta = Vector2(61, 61)
    end
    if self.skillIcon.activeSelf then
      self.skill.sizeDelta = Vector2(60, 60)
    end
    self.space:SetActive(false)
  end
end
