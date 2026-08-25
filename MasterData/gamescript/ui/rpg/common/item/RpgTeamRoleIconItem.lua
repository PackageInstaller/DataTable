local RpgTeamRoleIconItem, Super = System.NewComponent("RpgTeamRoleIconItem")

function RpgTeamRoleIconItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Team_Awaker_RpgResource(res)
  self.data = data
  self.selected = Vue.ref(false)
end

local function GetQualityBgFramePath(quality)
  local path
  if "Orange" == quality then
    path = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_D_Image_Quality_Color_Orange.png"
  elseif "Purple" == quality then
    path = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_D_Image_Quality_Color_Pink.png"
  elseif "Blue" == quality then
    path = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_D_Image_Quality_Color_Blue.png"
  end
  return path
end

function RpgTeamRoleIconItem:OnBind(binder)
  self.binder = binder
  self:UpdateUI()
  binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self.OnLongPress), System.fn(self, self.OnClick), tonumber(DT.GetConstant("Role_Press_Time")))
  binder:BindPressUp(self.ui.Btn_Click, System.fn(self, self.OnPressUp))
  binder:BindToVisible(self.ui.Group_Selected_Awaker, function()
    return self.selected.value
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    if not self.data then
      return
    end
    local tid = self.data.configId
    local config = DT.AwakerConfig[tid]
    if not config then
      return ""
    end
    do return LT.Text end
    return LT.Text, config.Title
  end)
end

function RpgTeamRoleIconItem:UpdateUI()
  if not self.data then
    return
  end
  local isEmpty = 0 == self.data.configId
  self.binder:SetActive(self.ui.Group_None, isEmpty)
  self.binder:SetActive(self.ui.Group_Awaker, not isEmpty and not self.data.isMonster)
  self.binder:SetActive(self.ui.Group_Monster, not isEmpty and self.data.isMonster)
  if isEmpty then
    return
  end
  local config
  config = DT.AwakerConfig[self.data.configId]
  if not config then
    local typeStr = self.data.isMonster and "怪物" or "唤醒体"
    Logger.Info("找不到%s配置 ==> %s", typeStr, tostring(self.data.configId))
    return
  end
  if self.data.isMonster then
    self:UpdateMonsterUI(config)
    return
  end
  self:UpdateRouseUI(config)
end

function RpgTeamRoleIconItem:UpdateRouseUI(config)
  if not config or not self.data then
    return
  end
  self.binder:SetText(self.ui.Text_Level, LT.Textf("Team_AwakerLevel", self.data.lv))
  local iconPath = config.Item_LittleIcon
  self.binder:SetImage(self.ui.Image_Awaker, iconPath)
  for i = 1, 6 do
    self.binder:SetActive(self.ui["Image_Star_" .. i], false)
  end
  local schoolConfig = DT.SchoolConfig[config.School]
  if not schoolConfig then
    Logger.Info("找不到职业配置 ==> ", tostring(config.School))
    return
  end
  self.binder:SetImage(self.ui.Image_Icon, schoolConfig.Icon)
  local framePath = GetQualityBgFramePath(config.Quality)
  if framePath then
    self.binder:SetImage(self.ui.Image_Bg, framePath)
  end
end

function RpgTeamRoleIconItem:UpdateMonsterUI(config)
  if not config or not self.data then
    return
  end
  local monsterClass = string.lower(config.MonsterClass)
  self.binder:SetActive(self.ui.Group_Boss_Show, "boss" == monsterClass)
end

function RpgTeamRoleIconItem:SetSelected(selected)
  self.selected.value = selected
end

function RpgTeamRoleIconItem:OnLongPress()
  if not self.data or not self.data.longPressCallback then
    return
  end
  self.data.longPressCallback(self.data.configId)
end

function RpgTeamRoleIconItem:OnPressUp()
  if not self.data or not self.data.longPressCancelCallback then
    return
  end
  self.data.longPressCancelCallback(self.data.configId)
end

function RpgTeamRoleIconItem:OnClick()
  if not self.data or not self.data.callback then
    return
  end
  self.data.callback(self.data.configId)
end

function RpgTeamRoleIconItem:ResetData(data)
  self.data = data
  self:UpdateUI()
end

return RpgTeamRoleIconItem
