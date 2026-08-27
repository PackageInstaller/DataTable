local UINPlotDungeonArm = class("UiNPlotDungeonArm", UIBaseNode)
local base = UIBaseNode
local CampEnum = require("Game.Common.Camp.CampEnum")

function UINPlotDungeonArm:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Arma, self, self.OnClickSpecWeapon)
end

function UINPlotDungeonArm:InitPlotDungeonArm(heroData, callback)
  self.heroData = heroData
  self.callback = callback
  self:RefreshSpecWeaponState()
end

function UINPlotDungeonArm:RefreshSpecWeaponState()
  self.ui.blueDot_Arm:SetActive(false)
  local sys_unlock = PlayerDataCenter.allSpecWeaponData:IsUnlockSpecWeaponSystem()
  if not sys_unlock then
    self:Hide()
    return
  end
  local isHasSpecWeapon = PlayerDataCenter.allSpecWeaponData:ContainHeroSpecWeapon(self.heroData.dataId)
  if not isHasSpecWeapon then
    self:Hide()
    return
  else
    self:Show()
  end
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(self.heroData.dataId)
  local weaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  if weaponData == nil then
    PlayerDataCenter.allSpecWeaponData:CreateOrUpdateHeroWeapon(self.heroData, weaponId, 0, 0)
    weaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  end
  if isHasSpecWeapon and weaponData ~= nil then
    if self.heroData.camp == CampEnum.eCampTaype.entropy then
      self.ui.tex_Arma:SetIndex(1)
    else
      self.ui.tex_Arma:SetIndex(0)
    end
    local step = weaponData:GetSpecWeaponCurStep()
    local isUnlock = 0 < step
    self.ui.tex_Lock.gameObject:SetActive(not isUnlock)
    self.ui.unlocked:SetActive(isUnlock)
    if isUnlock then
      self.ui.tex_ArmaLv.text = "LV." .. tostring(weaponData:GetSpecWeaponCurLevel())
      self.ui.tex_Lv.text = LanguageUtil.GetRomanNumber(step)
    end
    local isMaxLevel = weaponData:IsSpecWeaponFullLevel()
    self.ui.obj_RankMax:SetActive(isMaxLevel)
    self.ui.obj_img_Chip:SetActive(not isMaxLevel)
    self.ui.Tex_ChipCount.gameObject:SetActive(not isMaxLevel)
    if not isMaxLevel then
      local costIds, costNums, hasNext = weaponData:GetSpecWeaponUprageCost()
      local isHaveFragId = false
      for i, costId in ipairs(costIds) do
        if self.heroData.fragId == costId then
          isHaveFragId = true
          local needNum = costNums[i]
          local curNum = PlayerDataCenter:GetItemCount(costId)
          self.ui.Tex_ChipCount:SetIndex(0, tostring(curNum), tostring(needNum))
          break
        end
      end
      if not isHaveFragId then
        error("hero spec arma not need Frag?,pls check. heroId:" .. tostring(self.heroData.dataId))
      end
    end
  end
  self:RefreshhSpecWeaponBlueDot(sys_unlock and isHasSpecWeapon, weaponData)
end

function UINPlotDungeonArm:RefreshhSpecWeaponBlueDot(unlockSpecWeapon, weaponData)
  local isShowBlue = unlockSpecWeapon and weaponData ~= nil and weaponData:IsSpecWeaponCouldUprage()
  self.ui.blueDot_Arm:SetActive(isShowBlue)
end

function UINPlotDungeonArm:OnClickSpecWeapon()
  if self.callback then
    self.callback(self.heroData)
  end
end

function UINPlotDungeonArm:OnDelete()
end

return UINPlotDungeonArm
