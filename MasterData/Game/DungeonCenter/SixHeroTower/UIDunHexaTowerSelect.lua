local UIDunHexaTowerSelect = class("UIDunHexaTowerSelect", UIBaseWindow)
local base = UIBaseWindow
local HexaTowerData = require("Game.DungeonCenter.SixHeroTower.HexaTowerData")
local UIDunHexaTowerSelectItem = require("Game.DungeonCenter.SixHeroTower.UINDunHexaTowerSelectNodeItem")
local UINDunHexaTowerSelectNodeLockItem = require("Game.DungeonCenter.SixHeroTower.UINDunHexaTowerSelectNodeLockItem")
local ImgColor_ns = Color.New(0.1803922, 0.1803922, 0.1803922, 1)
local ImgColor_s = Color.New(1, 1, 1, 0.8)
local textColor_ns = Color.New(0.4431373, 0.4431373, 0.4431373, 1)
local textColor_s = Color.New(0.1372549, 0.1372549, 0.1372549, 1)
local cs_DoTween = CS.DG.Tweening.DOTween

function UIDunHexaTowerSelect:OnInit()
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Period, self, self.HexaTowerSelectTag, true)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Normal, self, self.HexaTowerSelectTag, false)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_bg, self, UIUtil.OnClickBackByUiTab, self)
  self.towerItemPool = UIItemPool.New(UIDunHexaTowerSelectItem, self.ui.ThemeItem, false)
  self.lockItemPool = UIItemPool.New(UINDunHexaTowerSelectNodeLockItem, self.ui.LockItem, false)
  self.itemList = {}
  self.__onSelectTower = BindCallback(self, self._OnClick)
end

function UIDunHexaTowerSelect:RefreshSelectNode(dunSixHeroCtrl, isHavePeriodic, normalList, periodicList, curTowerId)
  self.dunSixHeroCtrl = dunSixHeroCtrl
  self.normalList = normalList
  self.periodicList = periodicList
  self.isHavePeriodic = isHavePeriodic
  self.curTowerId = curTowerId
  if not isHavePeriodic then
    self.ui.TogGroup:SetActive(false)
  end
  UIUtil.SetTopStatus(self, self.Hide, nil, nil, nil, true)
end

function UIDunHexaTowerSelect:HexaTowerSelectTag(isPeriodic)
  self.towerItemPool:HideAll()
  self.lockItemPool:HideAll()
  self.itemList = {}
  if isPeriodic then
    for index, towerId in ipairs(self.periodicList) do
      local towerCfg = ConfigData.env_dungeon_tower[towerId]
      local isUnlock = CheckCondition.CheckLua(towerCfg.pre_condition, towerCfg.pre_para1, towerCfg.pre_para2)
      if isUnlock then
        local levelItem = self.towerItemPool:GetOne(true)
        levelItem:InitHexaLevelItem(towerCfg, true, self.dunSixHeroCtrl, self.curTowerId, self.__onSelectTower)
        table.insert(self.itemList, levelItem)
      else
        local lockItem = self.lockItemPool:GetOne(true)
        lockItem:InitHexaLockedItem(towerCfg)
      end
    end
  else
    for index, towerId in ipairs(self.normalList) do
      local towerCfg = ConfigData.env_dungeon_tower[towerId]
      local isUnlock = CheckCondition.CheckLua(towerCfg.pre_condition, towerCfg.pre_para1, towerCfg.pre_para2)
      if isUnlock then
        local levelItem = self.towerItemPool:GetOne(true)
        levelItem:InitHexaLevelItem(towerCfg, false, self.dunSixHeroCtrl, self.curTowerId, self.__onSelectTower)
        table.insert(self.itemList, levelItem)
      else
        local lockItem = self.lockItemPool:GetOne(true)
        lockItem:InitHexaLockedItem(towerCfg)
      end
    end
  end
  if not self.isHavePeriodic then
    return
  end
  if isPeriodic then
    self.ui.Img_BgPer.color = ImgColor_s
    self.ui.Tex_TitlePer.color = textColor_s
    self.ui.Img_BgNor.color = ImgColor_ns
    self.ui.Tex_TitleNor.color = textColor_ns
  else
    self.ui.Img_BgPer.color = ImgColor_ns
    self.ui.Tex_TitlePer.color = textColor_ns
    self.ui.Img_BgNor.color = ImgColor_s
    self.ui.Tex_TitleNor.color = textColor_s
  end
  self:PlaySwitchTween(isPeriodic)
end

function UIDunHexaTowerSelect:PlaySwitchTween(isPeriodic)
  if self.__switchQueue ~= nil then
    self.__switchQueue:Kill()
    self.__switchQueue = nil
  end
  local sequence = cs_DoTween.Sequence():SetAutoKill(true):SetLink(self.gameObject)
  for index, item in ipairs(self.itemList) do
    item.ui.cg_ItemHolder.alpha = 1
    item.ui.trans_item.anchoredPosition = Vector2.zero
  end
  sequence:AppendInterval(0.1)
  for index, item in ipairs(self.itemList) do
    sequence:Insert((index - 1) * 0.1, item.ui.cg_ItemHolder:DOFade(0, 0.15):From())
    sequence:Insert((index - 1) * 0.1, item.ui.trans_item:DOLocalMoveY(-25, 0.3):From(true))
    if isPeriodic then
      item.ui.trans_PeriodTime.anchoredPosition = Vector2.Temp(0, -252)
      sequence:Insert((index - 1) * 0.1, item.ui.trans_PeriodTime:DOLocalMoveY(-25, 0.3):From(true))
    end
  end
  self.__switchQueue = sequence
end

function UIDunHexaTowerSelect:_OnClick(towerId)
  UIUtil.OnClickBackByUiTab(self)
  if towerId == self.curTowerId then
    return
  end
  local towerTypeData = HexaTowerData.New(towerId)
  local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
    if window == nil then
      return
    end
    window:CloseLevelDetailWindow()
    window:InitDungeonTowerLevel4HexaTower(self.dunSixHeroCtrl, towerTypeData, completeLevel)
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userDataCache:SetTwinTowerNewReaded(towerId, true)
    local hexaTowerWin = UIManager:GetWindow(UIWindowTypeID.DungeonHexaTower)
    if hexaTowerWin ~= nil then
      hexaTowerWin:__InitRedDot()
    end
  end)
end

return UIDunHexaTowerSelect
