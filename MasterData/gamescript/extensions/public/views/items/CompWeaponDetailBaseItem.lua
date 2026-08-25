local REFINE_STAGE_1_MAXLEVEL = DT.GetConstant("WeaponRefineSkillParaNum")
local MAX_STAR_NUM = 3
local CompWeaponDetailBaseItem, Super = NewViewComponent("CompWeaponDetailBaseItem")

function CompWeaponDetailBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_WeaponResource(uiNode)
  self.data = data
end

function CompWeaponDetailBaseItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, self.data.clickFunc)
end

function CompWeaponDetailBaseItem:OnEnterComponent()
  self:_InitWeaponUIElement()
  self:_InitOtherUIElement()
end

function CompWeaponDetailBaseItem:_InitWeaponUIElement()
  self.ui.Image_Weapon:SetActive(false)
  local weaponData = self.data.weaponData
  if not weaponData then
    return
  end
  local weaponTid = weaponData.tid
  local weaponCfg = DT.Item[weaponTid]
  if not weaponCfg then
    return
  end
  self:SetImage(self.ui.Weapon_Icon_1, weaponCfg.SpIcon)
  local level = weaponData.level
  local showStars = math.min(level, REFINE_STAGE_1_MAXLEVEL)
  self.ui.Image_Weapon:SetActive(weaponCfg.SpIcon)
  for i = 1, MAX_STAR_NUM do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= showStars)
    end
  end
  if level > REFINE_STAGE_1_MAXLEVEL then
    self.ui.Image_Max_1:SetActive(true)
    self:SetText(self.ui.Text_Max_1, level - REFINE_STAGE_1_MAXLEVEL)
  else
    self.ui.Image_Max_1:SetActive(false)
  end
end

function CompWeaponDetailBaseItem:_InitOtherUIElement()
  local data = self.data
  if data.showImageAdd ~= nil then
    self.ui.Image_Add:SetActive(data.showImageAdd)
  end
  if nil ~= data.showImageLock then
    self.ui.Image_Lock_1:SetActive(data.showImageLock)
  end
  if nil ~= data.showImageDisable then
    self.ui.Image_Disable:SetActive(data.showImageDisable)
  end
  if nil ~= data.showImageBan then
    self.ui.Image_Ban_1:SetActive(data.showImageBan)
  end
  if nil ~= data.showImageSelect then
    self.ui.Image_Selected:SetActive(data.showImageSelect)
  end
end

function CompWeaponDetailBaseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompWeaponDetailBaseItem
