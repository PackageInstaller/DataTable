local UIChangeDressUp = class("UIChangeDressUp", UIBaseNode)
local UINDressUpItem = require("Game.User.Dialogs.UINDressUpItem")
local base = UIBaseNode

function UIChangeDressUp:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.onDressUpItemClick = BindCallback(self, self.OnDressUpItemClick)
end

function UIChangeDressUp:RefreshChangeDressUp(onCloseCallback)
  self._onCloseCallback = onCloseCallback
  self.dressUpItemDic = {}
  self.cfgList = self:_GetDressUpData()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self._resLoader = CS.ResLoader.Create()
  local iconPath = PathConsts:GetSpriteAtlasPath("PreviewDressUp")
  self._atlas = self._resLoader:LoadABAsset(iconPath)
  self:_ShowUI()
end

function UIChangeDressUp:_ShowUI()
  self:Show()
  if #self.cfgList < 0 then
    return
  end
  self.ui.scrollRect.totalCount = #self.cfgList
  self.ui.scrollRect:RefillCells(0)
end

function UIChangeDressUp:__OnInstantiateItem(go)
  local dressUpItem = UINDressUpItem.New()
  dressUpItem:Init(go)
  self.dressUpItemDic[go] = dressUpItem
end

function UIChangeDressUp:__OnChangeItem(go, index)
  local dressUpItem = self.dressUpItemDic[go]
  if dressUpItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local cfg = self.cfgList[index + 1]
  if self._resLoader == nil then
    self._resLoader = UIManager:GetWindow(UIWindowTypeID.UserInfo).userInfoNode.dressUpResloader
  end
  local sprite = AtlasUtil.GetResldSprite(self._atlas, cfg.icon)
  dressUpItem:InitDressUpItem(cfg, self.onDressUpItemClick, sprite, cfg.id)
end

function UIChangeDressUp:_GetDressUpData()
  local cfgList = {}
  for id, cfg in pairs(ConfigData.portrait_card) do
    if not cfg.is_hide then
      local count = PlayerDataCenter:GetItemCount(id)
      if 0 < count then
        table.insert(cfgList, cfg)
      end
    end
  end
  return cfgList
end

function UIChangeDressUp:OnDressUpItemClick(cfg)
  local infoWin = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if infoWin ~= nil then
    infoWin.userInfoNode:RefreshDressUp(cfg.id)
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_BGPlateMod(cfg.id)
  end
  if self._onCloseCallback ~= nil then
    self._onCloseCallback()
  end
end

function UIChangeDressUp:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  base.OnDelete(self)
end

return UIChangeDressUp
