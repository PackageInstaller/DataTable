_class("UIForgeOneKeyUnlock", UIController)
UIForgeOneKeyUnlock = UIForgeOneKeyUnlock

function UIForgeOneKeyUnlock:OnShow(uiParams)
  self:InitWidget()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
  self._items = self.data:GetAllUnlockableItem()
  table.sort(self._items, function(a, b)
    local colora = Cfg.cfg_item[a.id].Color
    local colorb = Cfg.cfg_item[b.id].Color
    if colora ~= colorb then
      return colora > colorb
    end
    return a.id < b.id
  end)
  local widgets = self.content:SpawnObjects("UIItemHomeland", #self._items)
  for i = 1, #self._items do
    local asset = RoleAsset:New()
    asset.assetid = self._items[i].id
    asset.count = 1
    widgets[i]:Flush(asset)
  end
  UIHelper.RefreshLayout(self.contentRect)
  self.scroll.horizontalNormalizedPosition = 0
end

function UIForgeOneKeyUnlock:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.contentRect = self:GetUIComponent("RectTransform", "Content")
  self.scroll = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UIForgeOneKeyUnlock:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UIForgeOneKeyUnlock:ConfirmBtnOnClick(go)
  self:StartTask(self._Req, self)
end

function UIForgeOneKeyUnlock:CloseOnClick(go)
  self:CloseDialog()
end

function UIForgeOneKeyUnlock:_Req(TT)
  local ids = {}
  for _, item in ipairs(self._items) do
    ids[#ids + 1] = item.id
  end
  Log.notice("一键解锁:", table.concat(ids, ","))
  self:Lock(self:GetName())
  local res, _ = self.mHomeland:HandleOneClickUnlock(TT, ids)
  self:UnLock(self:GetName())
  if not res:GetSucc() then
    return
  end
  local oldSort = self.data.tSort
  self.data:Init(self.mHomeland:GetHomelandInfo())
  self.data.tSort = oldSort
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
  self:CloseDialog()
  ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_unlock_once_success"))
end
