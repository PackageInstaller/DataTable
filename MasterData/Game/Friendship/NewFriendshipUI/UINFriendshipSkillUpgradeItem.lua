local UINFriendshipSkillUpgradeItem = class("UINFriendshipSkillUpgradeItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINFriendshipSkillUpgradeItem:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.couldUnlcok = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_skillUpgradeItem, self, self.OnItemClick)
  UIUtil.AddButtonListener(self.ui.btn_CanLevelUp, self, self.OnItemClick)
end

function UINFriendshipSkillUpgradeItem:InitSkillItem(heroId, fosterCfg, OpenInfoNodeCallback)
  self.heroId = heroId
  self.fosterCfg = fosterCfg
  self.fosterId = self.fosterCfg[1].id
  self.OpenInfoNodeCallback = OpenInfoNodeCallback
  self:Refresh()
end

function UINFriendshipSkillUpgradeItem:Refresh()
  self:RefreshIsUnlock()
  self:RefreshLevel()
  self:RefreshCouldUpgrade()
end

function UINFriendshipSkillUpgradeItem:RefreshIsUnlock()
  local isUnlock = PlayerDataCenter.allFriendshipData:IsForestLineUnlock(self.heroId, self.fosterId)
  self.ui.obj_lock:SetActive(not isUnlock)
  self.ui.obj_skill_lock:SetActive(not isUnlock)
  self.ui.obj_skill_unlock:SetActive(isUnlock)
end

function UINFriendshipSkillUpgradeItem:RefreshLevel()
  local level = PlayerDataCenter.allFriendshipData:GetForestLineLevel(self.heroId, self.fosterId)
  self.ui.tex_Lv:SetIndex(0, tostring(level))
  self:RefreshNameDesIcon(level)
end

function UINFriendshipSkillUpgradeItem:RefreshNameDesIcon(level)
  if level <= 0 then
    level = 1
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.fosterCfg[level].name)
  local des = LanguageUtil.GetLocaleText(self.fosterCfg[level].describe)
  for index, attrID in ipairs(self.fosterCfg[level].attributeIds) do
    local _, value = ConfigData:GetAttribute(self.fosterCfg[level].attributeIds[index], self.fosterCfg[level].attributeNums[index])
    if string.endswith(value, "%", true) then
      value = value .. "%"
    end
    if des == nil then
      error("can't read Friendship foster descripition")
    else
      des = string.gsub(des, "{" .. tostring(index - 1) .. "}", value)
    end
  end
  self.ui.tex_Descr.text = des
  self.ui.img_SkillIcon.sprite = CRH:GetSprite(self.fosterCfg[level].icon)
end

function UINFriendshipSkillUpgradeItem:RefreshCouldUpgrade()
  self.ui.btn_CanLevelUp.gameObject:SetActive(false)
  self.couldUnlcok = false
  local could, isUnlock, requireFriendshipLevel, requireHeroLevel, boolFL, boolHL = PlayerDataCenter.allFriendshipData:GetCouldUnlockOrUpgrade(self.heroId, self.fosterId)
  if could then
    if isUnlock then
      self.couldUnlcok = true
      self.ui.image_lockOpen.gameObject:SetActive(true)
      self.ui.image_lock.gameObject:SetActive(false)
    else
      self.ui.btn_CanLevelUp.gameObject:SetActive(true)
    end
  elseif isUnlock then
    self.ui.image_lockOpen.gameObject:SetActive(false)
    self.ui.image_lock.gameObject:SetActive(true)
    self.ui.text_unlock_c0:SetIndex(0, tostring(requireFriendshipLevel))
    self.ui.text_unlock_c1:SetIndex(1, tostring(requireHeroLevel))
    if boolFL then
      self.ui.img_marker_c0:SetIndex(1)
    else
      self.ui.img_marker_c0:SetIndex(0)
    end
    if boolHL then
      self.ui.img_marker_c1:SetIndex(1)
    else
      self.ui.img_marker_c1:SetIndex(0)
    end
  end
  self:RefreshRedDot(could, isUnlock)
end

function UINFriendshipSkillUpgradeItem:RefreshRedDot(could, isUnlock)
  self.ui.obj_RedDot:SetActive(could and isUnlock)
  self.ui.obj_blueDot:SetActive(could and not isUnlock)
end

function UINFriendshipSkillUpgradeItem:OnItemClick()
  if self.couldUnlcok then
    local heroData = PlayerDataCenter:GetHeroData(self.heroId)
    if heroData == nil then
      error("Can't find HeroData By id:" .. tostring(self.heroId))
      return
    end
    local oldHeroPower = heroData:GetFightingPower()
    self.networkCtrl:CS_INTIMACY_UpgradeLine(self.heroId, self.fosterCfg[1].id, function()
      local newPower = heroData:GetFightingPower()
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
        if win ~= nil then
          win:InitHeroPowerUpSuccess(oldHeroPower, newPower)
        end
      end)
    end)
    self.couldUnlcok = false
    return
  end
  if not PlayerDataCenter.allFriendshipData:IsForestLineUnlock(self.heroId, self.fosterId) then
    return
  end
  if self.OpenInfoNodeCallback ~= nil then
    self.OpenInfoNodeCallback(self.heroId, self.fosterCfg)
  end
end

function UINFriendshipSkillUpgradeItem:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipSkillUpgradeItem
