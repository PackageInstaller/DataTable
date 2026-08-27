local base = UIBaseNode
local UINWCSSelectLevelLevelItem = class("UINWCSSelectLevelLevelItem", base)
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINWCSSelectLevelLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.uiColorEnviroName = {}
  UIUtil.LuaUIBindingTable(self.ui.tex_EnviroName.transform, self.uiColorEnviroName)
  self.uiColorEnviroBg = {}
  UIUtil.LuaUIBindingTable(self.ui.img_EnviroBg.transform, self.uiColorEnviroBg)
  self.uiColorImgModeColor = {}
  UIUtil.LuaUIBindingTable(self.ui.img_ModeColor.transform, self.uiColorImgModeColor)
  UIUtil.AddButtonListener(self.ui.btn_levelItem, self, self.__OnClick)
  self.levelRewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount.gameObject:SetActive(false)
end

function UINWCSSelectLevelLevelItem:InitWCSLevelItem(RoomId, BuffId, onclickCallback, resloader, serverRewardDic)
  self.roomId = RoomId
  self.__onclickCallback = onclickCallback
  local seasonLevelCfg = ConfigData.warchess_season_level[RoomId]
  if seasonLevelCfg == nil then
    error("seasonLevelCfg not exist id:" .. tostring(RoomId))
    return
  end
  self.seasonLevelCfg = seasonLevelCfg
  self.ui.tex_levelName.text = LanguageUtil.GetLocaleText(seasonLevelCfg.warchess_level_name)
  self.ui.img_Icon.sprite = CRH:GetSprite(seasonLevelCfg.warchess_level_icon)
  local difficulty = math.clamp(seasonLevelCfg.level_show_difficulty or 1, 1, 3) - 1
  local level_type = math.clamp(seasonLevelCfg.level_type or 1, 1, 4)
  self.ui.tex_SideDiff:SetIndex(difficulty)
  self.ui.tex_ModeDiff:SetIndex(difficulty)
  self.ui.img_Farme.color = self.ui.color_diff[level_type]
  local pressType = math.clamp(seasonLevelCfg.level_stress_show, 1, 3) - 1
  local pressAddNum = seasonLevelCfg.level_stress_add
  self.ui.tex_Pressure:SetIndex(pressType, tostring(pressAddNum))
  local difficultySwitch = {
    [0] = function()
      self.ui.img_ModeColor.color = self.uiColorImgModeColor.color_normal
    end,
    [1] = function()
      self.ui.img_ModeColor.color = self.uiColorImgModeColor.color_hard
    end,
    [2] = function()
      self.ui.img_ModeColor.color = self.uiColorImgModeColor.color_challenge
    end
  }
  if difficultySwitch[difficulty] then
    difficultySwitch[difficulty]()
  end
  local levelPicResName = seasonLevelCfg.level_title_bg
  resloader:LoadABAssetAsync(PathConsts:GetWarChessSeasonPic(levelPicResName), function(texture)
    if not IsNull(self.transform) then
      self.ui.img_BGModePic.texture = texture
    end
  end)
  if BuffId ~= nil and BuffId ~= 0 then
    self.ui.img_EnviroBg.gameObject:SetActive(true)
    self.ui.tex_EnviroDes.gameObject:SetActive(true)
    self.ui.obj_noBuff:SetActive(false)
    local levelBuffData = WarChessBuffData.CrearteBuffById(BuffId)
    self:__RefreshBuffEnv(levelBuffData)
  else
    self.ui.img_EnviroBg.gameObject:SetActive(false)
    self.ui.tex_EnviroDes.gameObject:SetActive(false)
    self.ui.obj_noBuff:SetActive(true)
  end
  self:__RefreshRewardShow(serverRewardDic)
end

function UINWCSSelectLevelLevelItem:__RefreshBuffEnv(levelBuffData)
  if levelBuffData == nil then
    return
  end
  self.__levelBuffData = levelBuffData
  local buffIcon = levelBuffData:GetWCBuffIcon()
  local buffColorType = levelBuffData:GetWCBuffColorType()
  if string.IsNullOrEmpty(buffIcon) then
    return
  end
  self.ui.img_EnvIcon.sprite = CRH:GetSprite(buffIcon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_EnviroName.text = levelBuffData:GetWCBuffName()
  if buffColorType == 1 then
    self.ui.tex_EnviroName.color = self.uiColorEnviroName.color_normal
    self.ui.img_EnviroBg.color = self.uiColorEnviroBg.color_normal
  elseif buffColorType == 2 then
    self.ui.tex_EnviroName.color = self.uiColorEnviroName.color_mid
    self.ui.img_EnviroBg.color = self.uiColorEnviroBg.color_mid
  else
    self.ui.tex_EnviroName.color = self.uiColorEnviroName.color_hard
    self.ui.img_EnviroBg.color = self.uiColorEnviroBg.color_hard
  end
  self.ui.tex_EnviroDes.text = levelBuffData:GetWCBuffDes()
end

function UINWCSSelectLevelLevelItem:__RefreshRewardShow(serverRewardDic)
  local itemList = self.seasonLevelCfg.level_reward_show
  self.levelRewardItemPool:HideAll()
  for itemId, itemNum in pairs(serverRewardDic) do
    local item = self.levelRewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, itemNum)
  end
  for _, itemId in ipairs(itemList) do
    local item = self.levelRewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, nil)
  end
end

function UINWCSSelectLevelLevelItem:WCSSLIPlayFadeTween(index)
  self.ui.canvas.transform.localPosition = Vector2.New(-200, 0)
  self.ui.canvas:DOFade(0, 0.5):From():SetDelay(0.1 * index)
  self.ui.canvas.transform:DOLocalMoveX(0, 0.5):SetDelay(0.1 * index)
end

function UINWCSSelectLevelLevelItem:__OnClick()
  if self.__onclickCallback ~= nil then
    self.__onclickCallback(self)
  end
end

function UINWCSSelectLevelLevelItem:SetClickEnable(enable)
  if enable then
    UIUtil.AddButtonListener(self.ui.btn_levelItem, self, self.__OnClick)
  else
    UIUtil.RemoveButtonListener(self.ui.btn_levelItem)
  end
end

function UINWCSSelectLevelLevelItem:GetWCSRougeBuffData()
  return self.__levelBuffData
end

function UINWCSSelectLevelLevelItem:GetWCSPressAddNum()
  return self.seasonLevelCfg.level_stress_add
end

function UINWCSSelectLevelLevelItem:GetRougeDoorId()
  return self.seasonLevelCfg.warchess_level_id
end

function UINWCSSelectLevelLevelItem:OnDelete()
  self.ui.canvas.transform:DOKill()
  self.ui.canvas:DOKill()
end

return UINWCSSelectLevelLevelItem
