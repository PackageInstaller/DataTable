local UINDailyDgLvListItem = class("UINDailyDgLvListItem", UIBaseNode)
local base = UIBaseNode
local UINDailyDgListItemBossTag = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgListItemBossTag")

function UINDailyDgLvListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  if not IsNull(self.ui.img_Boss) then
    self._imgBossUvDefaultPos = self.ui.img_Boss.uvRect.position
  end
end

function UINDailyDgLvListItem:InitDailyDgLvListItem(lvIndex, isComplete, isLock, isCurrent, bossId, resloader, clickFunc)
  self.lvIndex = lvIndex
  self.clickFunc = clickFunc
  self.resloader = resloader
  self.ui.isComplete:SetActive(isComplete)
  self.ui.tex_Level.text = string.format("%02d", lvIndex)
  self.ui.lineItem:SetActive(lvIndex ~= 1)
  self.ui.img_LineItem:SetIndex(isLock and 1 or 0)
  self.ui.isLock:SetActive(isLock)
  if isLock then
    if lvIndex == 1 then
      self.ui.tex_Unlcok:SetIndex(1)
    else
      self.ui.tex_Unlcok:SetIndex(0, tostring(lvIndex - 1))
    end
  end
  self.ui.isCurStage:SetActive(isCurrent)
  local alpha = isCurrent and 1 or 0.2
  local col = Color.New(1, 1, 1, alpha)
  self.ui.img_title.color = col
  if bossId ~= nil then
    self:_InitBoss(bossId)
  end
end

function UINDailyDgLvListItem:_InitBoss(bossId)
  local monsterCfg = ConfigData.monster[bossId]
  if monsterCfg == nil then
    error("neutral Cfg is null,id:" .. tostring(bossId))
    return
  end
  local resCfg = ConfigData.resource_model[monsterCfg.src_id]
  if resCfg == nil then
    error("resource model cfg is null,id:" .. tostring(monsterCfg.src_id))
    return
  end
  self.ui.tex_BossName.text = LanguageUtil.GetLocaleText(monsterCfg.name)
  local uvRect = self.ui.img_Boss.uvRect
  local bossUvCfgName = "bossUvCfg_" .. tostring(bossId)
  if self.ui[bossUvCfgName] ~= nil then
    uvRect.position = self.ui[bossUvCfgName]
  else
    uvRect.position = self._imgBossUvDefaultPos
  end
  self.ui.img_Boss.uvRect = uvRect
  local path
  if string.IsNullOrEmpty(resCfg.boss_lpic) then
    path = PathConsts:GetCharacterPicPath(resCfg.res_Name)
  else
    path = PathConsts:GetCharacterTexturePath(resCfg.boss_lpic)
  end
  self.ui.img_Boss.enabled = false
  self.resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Boss.texture = texture
    self.ui.img_Boss.enabled = true
  end)
  self.ui.bossTagItem:SetActive(false)
  if self.bossTagItemPool == nil then
    self.bossTagItemPool = UIItemPool.New(UINDailyDgListItemBossTag, self.ui.bossTagItem)
  end
  self.bossTagItemPool:HideAll()
  for k, tagId in ipairs(monsterCfg.monster_tag) do
    local tagCfg = ConfigData.monster_tag[tagId]
    if tagCfg == nil then
      error("Can't find tagCfg id=" .. tostring(tagId))
    else
      local bossItem = self.bossTagItemPool:GetOne()
      bossItem:InitDailyDgListItemBossTag(tagCfg)
    end
  end
end

function UINDailyDgLvListItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.lvIndex)
  end
end

function UINDailyDgLvListItem:OnDelete()
  if self.bossTagItemPool ~= nil then
    self.bossTagItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINDailyDgLvListItem
