local UIHeroDungeonItem = class("UIHeroDungeonItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_text = CS.UnityEngine.UI.Text

function UIHeroDungeonItem:OnInit()
  self.index = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.button_HeroItem, self, self.OnItemClick)
end

function UIHeroDungeonItem:InjectResLoaderAndClickEvent(resLoader, clickEvent)
  self.resLoader = resLoader
  self.clickEvent = clickEvent
end

function UIHeroDungeonItem:OnItemClick()
  if not self.data:UnlockAndHasStageOpen() then
    local cfg = self.data:GetDungeonCfg()
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.PlotDungeon_DungeonLocked))
    return
  end
  if self.clickEvent ~= nil then
    self.clickEvent()
  end
end

function UIHeroDungeonItem:OnUpdateWithData(dungeonData)
  self.data = dungeonData
  local name, name_en = dungeonData:GetDungeonName()
  self.ui.tex_Name.text = name
  self.ui.tex_ENName.text = name_en
  self.gameObject.name = name_en
  if self.resLoader ~= nil then
    local friendshipHeroCfg = ConfigData.friendship_hero[dungeonData.itemId]
    if friendshipHeroCfg == nil then
      error("can't reda friendshipHeroCfg with HeroId:" .. tostring(dungeonData.itemId))
    else
      local path = PathConsts:GetFriendshipDungeonPicPath(friendshipHeroCfg.dungeon_img)
      if not string.IsNullOrEmpty(path) then
        self.img_StoryBg = self.resLoader:LoadABAsset(path)
      end
    end
    local path = PathConsts:GetCharacterPicPath(dungeonData:GetDungeonHeroData().resCfg.res_Name)
    if not string.IsNullOrEmpty(path) then
      local itemData = self.data
      self.resLoader:LoadABAssetAsync(path, function(texture)
        if itemData ~= self.data then
          return
        end
        self.ui.img_Hero.texture = texture
      end)
    end
  end
  if not self.data:UnlockAndHasStageOpen() then
    if self.blackCover == nil then
      self.blackCover = self.ui.obj_HeroItemLock:Instantiate()
      self.ui.tex_Condition = self.blackCover.transform:GetComponentInChildren(typeof(cs_text))
    end
    self.blackCover.transform:SetParent(self.transform)
    self.blackCover.transform.anchoredPosition = Vector2.zero
    self.blackCover.gameObject:SetActive(true)
    local stageCfg = self.data:GetNewLockStage()
    if stageCfg ~= nil then
      self.ui.tex_Condition.text = CheckCondition.GetUnlockInfoLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
    end
  elseif self.blackCover ~= nil then
    self.blackCover.gameObject:SetActive(false)
  end
  self:UpdateAndSetProgress(dungeonData)
  self:RefreshIsFavourite()
end

function UIHeroDungeonItem:UpdateAndSetProgress(dungeonData)
  if not self.data:GetIsUnlock() then
    self.ui.tex_CompleteNum.transform.parent.gameObject:SetActive(false)
    return
  else
    self.ui.tex_CompleteNum.transform.parent.gameObject:SetActive(true)
  end
  local progress = dungeonData:GetDungeonStageCompletedCount() * 100 // dungeonData:GetDungeonStageCount()
  self.ui.tex_CompleteNum:SetIndex(0, tostring(progress))
end

function UIHeroDungeonItem:RefreshIsFavourite()
  local heroData = self.data:GetDungeonHeroData()
  self.ui.obj_img_Favourite:SetActive(heroData:IsFavouriteHero())
end

function UIHeroDungeonItem:OnDelete()
  base.OnDelete(self)
end

return UIHeroDungeonItem
