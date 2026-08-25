local DBGActorIconItem, Super = System.NewComponent("DBGActorIconItem")

function DBGActorIconItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Team_Char_DbgResource(res)
  self.data = data
  self.selected = Vue.ref(false)
  self.cannotUse = Vue.ref(false)
end

function DBGActorIconItem:OnBind(binder)
  self.binder = binder
  self:UpdateUI()
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Group_Selected_Awaker, function()
    return self.selected.value
  end)
  binder:BindToVisible(self.ui.Bg_Fight, function()
    return self.data.fighting
  end)
  binder:SetImage(self.ui.Group_Selected_Awaker.transform:Find("Image_Icon").gameObject, "UIResources/AtlasSource/UI_Common_Image/UI_Common_Tick_1.png", false)
  binder:BindToVisible(self.ui.Group_Disabled, function()
    return self.cannotUse.value
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.data.configId
    local config = DT.AwakerConfig[tid]
    if not config then
      return ""
    end
    do return LT.Text end
    return LT.Text, config.Title
  end)
  binder:BindToText(self.ui.Text_Fight, function()
    local fighting = self.data.fighting or 0
    local fightingTitle = LT.Text("CombatEffectiveness")
    do return string.format, "%s %s", fightingTitle end
    return string.format, "%s %s", fightingTitle, fighting
  end)
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

function DBGActorIconItem:UpdateUI()
  if not self.data then
    return
  end
  local isEmpty = 0 == self.data.configId
  self.binder:SetActive(self.ui.Group_None, isEmpty)
  self.binder:SetActive(self.ui.Group_Awaker, not isEmpty and not self.data.isMonster)
  self.binder:SetActive(self.ui.Group_Monster, not isEmpty and self.data.isMonster)
  self.binder:SetActive(self.ui.Text_Recommend, false)
  if isEmpty then
    return
  end
  local config
  if self.data.isMonster then
    config = CopyDataUtils.GetMonsterConfig(self.data.configId)
  else
    config = DT.AwakerConfig[self.data.configId]
  end
  if not config then
    local typeStr = self.data.isMonster and "怪物" or "唤醒体"
    Logger.Info("找不到%s配置 ==> %s", typeStr, tostring(self.data.configId))
    return
  end
  if self.data.isMonster then
    self:UpdateMonsterUI(config)
    return
  end
  self:UpdateAwakerUI(config)
end

function DBGActorIconItem:UpdateAwakerUI(config)
  if not config or not self.data then
    return
  end
  self.binder:SetText(self.ui.Text_Level, LT.Textf("Team_AwakerLevel", self.data.lv))
  local iconPath = AwakerDataUtils.GetLittleIcon(self.data.configId)
  self.binder:SetImage(self.ui.Image_Awaker, iconPath)
  local star = self.data.star or AwakerDataUtils.GetAwakerStar(self.data.configId)
  for i = 1, 6 do
    self.binder:SetActive(self.ui["Image_Star_" .. i], i <= star)
  end
  local schoolConfig = DT.SchoolConfig[config.School]
  if not schoolConfig then
    Logger.Info("找不到职业配置 ==> ", tostring(config.School))
    return
  end
  self.binder:SetImage(self.ui.Image_Icon, schoolConfig.Icon)
  local bgPath = AwakerDataUtils.GetAwakerListBg() .. schoolConfig.AwakeListBg
  self.binder:SetImage(self.ui.Image_Bg, bgPath)
  local framePath = GetQualityBgFramePath(config.Quality)
  if framePath then
    self.binder:SetImage(self.ui.Image_Bg, framePath)
  end
end

function DBGActorIconItem:UpdateMonsterUI(config)
  if not config or not self.data then
    return
  end
  self.binder:SetImage(self.ui.Image_Monster, config.MiniIcon)
  local show = false
  local showFrame = false
  local str = ""
  local path = ""
  if config.MonsterClass == CommonDefine.MonsterClass.Boss then
    show = true
    showFrame = true
    str = "Battle_Boss_Tips"
    path = DT.Constant.BattleHard_Boss.Data[1]
  end
  if config.MonsterClass == CommonDefine.MonsterClass.Elite then
    show = true
    showFrame = true
    str = "Battle_Elite_Tips"
    path = DT.Constant.BattleHard_Elite.Data[1]
  end
  if config.MonsterClass == CommonDefine.MonsterClass.Common then
    show = true
    showFrame = true
    str = ""
    path = DT.Constant.BattleHard_Common.Data[1]
  end
  self.binder:SetActive(self.ui.Group_Boss_Show, show)
  self.binder:SetActive(self.ui.Image_Boss_Frame, showFrame)
  self.binder:SetImage(self.ui.Image_Boss_Frame, path)
  self.binder:SetText(self.ui.Text_Boss, LT.Text(str))
  self.binder:SetText(self.ui.Text_Monster_Level, LT.Textf("ActorString_42", config.Level))
end

function DBGActorIconItem:SetSelected(selected)
  self.selected.value = selected
end

function DBGActorIconItem:SetCannotUse(cannotUse)
  self.cannotUse.value = cannotUse
end

function DBGActorIconItem:OnClick()
  if self.cannotUse.value then
    if self.data.failedCallback then
      self.data.failedCallback(self.data.configId)
    end
    return
  end
  if not self.data or not self.data.callback then
    return
  end
  self.data.callback(self.data.configId)
end

function DBGActorIconItem:ResetData(data)
  self.data = data
  self:UpdateUI()
end

function DBGActorIconItem:SetDisableText(str)
  self.binder:SetText(self.ui.Text_Disabled, str)
end

return DBGActorIconItem
