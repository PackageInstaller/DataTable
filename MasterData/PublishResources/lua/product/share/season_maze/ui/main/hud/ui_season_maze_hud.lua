_class("UISeasonMazeHud", UICustomWidget)
UISeasonMazeHud = UISeasonMazeHud

function UISeasonMazeHud:InitWidget()
  self._root = self:GetUIComponent("RectTransform", "UISeasonMazeHud")
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMazeHud:OnShow()
  self:InitWidget()
end

function UISeasonMazeHud:SetData()
  self._isPlaying = false
  self._uiCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self._worldCamera = SMazeAdaptor.MainCam()
  self._reqList = {}
  self._unitPool = {}
  self._unitName = "UISeasonMazeHudObj.prefab"
  self._sp_exp = self._atlas:GetSprite("season_maze_map_toptoon_attr_02")
  self._sp_ms = self._atlas:GetSprite("season_maze_map_toptoon_attr_03")
  self._sp_add = self._atlas:GetSprite("season_maze_map_toptoon_attr_06")
  self._sp_money = self._atlas:GetSprite("season_maze_map_toptoon_attr_01")
  self._sp_card = self._atlas:GetSprite("season_maze_map_toptoon_attr_11")
  self._sp_auto = self._atlas:GetSprite("season_maze_map_toptoon_item_02")
  self._sp_item_tab = {}
  local obj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local cfgid = obj:GetMazeComponent():GetComponentCfgId()
  local cfgs = Cfg.cfg_component_season_maze_once({ComponentID = cfgid})
  for k, v in pairs(cfgs) do
    local spname = v.ToptoonIcon
    local sp = self._atlas:GetSprite(spname)
    self._sp_item_tab[v.OnceID] = sp
  end
end

function UISeasonMazeHud:OnHide()
  if self._reqList then
    for k, v in pairs(self._reqList) do
      v:Dispose()
    end
  end
end

function UISeasonMazeHud:GetHudUnit()
  local ret
  for k, v in pairs(self._unitPool) do
    if not v:GetUsing() then
      ret = v
    end
  end
  if not ret then
    local req = ResourceManager:GetInstance():SyncLoadAsset(self._unitName, LoadType.GameObject)
    table.insert(self._reqList, req)
    local go = req.Obj
    go:SetActive(false)
    go.transform:SetParent(self._root)
    go.transform.localScale = Vector3(1, 1, 1)
    go.transform.localRotation = Quaternion.identity
    go.transform.localPosition = Vector3(0, 0, 0)
    ret = UISeasonMazeHudObj:New(go, self._uiCamera, self._root, function(asset)
      return self:GetSpriteByType(asset)
    end)
    table.insert(self._unitPool, ret)
  end
  ret:SetUsing(true)
  return ret
end

function UISeasonMazeHud:GetSpriteByType(asset)
  if asset._type == SeasonMazeEffectType.SMET_Pro then
    if asset._subParam == SeasonMazeAttrType.SMAT_Gold then
      return self._sp_money
    elseif asset._subParam == SeasonMazeAttrType.SMAT_Exp then
      return self._sp_exp
    elseif asset._subParam == SeasonMazeAttrType.SMAT_Ms then
      return self._sp_ms
    elseif asset._subParam == SeasonMazeAttrType.SMAT_Gold_Round_Add then
      return self._sp_add
    end
  elseif asset._type == SeasonMazeEffectType.SMET_Bead then
    return self._sp_auto
  elseif asset._type == SeasonMazeEffectType.SMET_Relic then
    return nil
  elseif asset._type == SeasonMazeEffectType.SMET_Hand then
    return self._sp_card
  elseif asset._type == SeasonMazeEffectType.SMET_Once then
    return self._sp_item_tab[asset._subParam]
  end
end

function UISeasonMazeHud:StackAssets(assets_p)
  local assets = {}
  local beadList, handList
  for i, v in ipairs(assets_p) do
    if v._type == SeasonMazeEffectType.SMET_Bead then
      if not beadList then
        beadList = v
      else
        beadList._count = beadList._count + v._count
      end
    elseif v._type == SeasonMazeEffectType.SMET_Hand then
      if not handList then
        handList = v
      else
        handList._count = handList._count + v._count
      end
    elseif v._type == SeasonMazeEffectType.SMET_Relic or v._type == SeasonMazeEffectType.SMET_Once or v._type == SeasonMazeEffectType.SMET_Pro and (v._subParam == SeasonMazeAttrType.SMAT_Gold or v._subParam == SeasonMazeAttrType.SMAT_Exp or v._subParam == SeasonMazeAttrType.SMAT_Ms or v._subParam == SeasonMazeAttrType.SMAT_Gold_Round_Add) then
      table.insert(assets, v)
    end
    if v._subParam == SeasonMazeAttrType.SMAT_Gold then
      Log.error("todo:llldd")
    end
  end
  if handList then
    table.insert(assets, handList)
  end
  if beadList then
    table.insert(assets, beadList)
  end
  if table.count(assets) > 0 then
    SeasonMazeTool:GetInstance():SortAsset(assets)
  end
  return assets
end

function UISeasonMazeHud:CheckCacheList()
  if self._cacheList and table.count(self._cacheList) > 0 then
    local tmp = self._cacheList[1]
    table.remove(self._cacheList, 1)
    self:GetToastTimeline(tmp)
  end
end

function UISeasonMazeHud:InsertCacheList(assets_p)
  if not self._cacheList then
    self._cacheList = {}
  end
  table.insert(self._cacheList, assets_p)
end

function UISeasonMazeHud:GetToastTimeline(assets_p)
  if self._isPlaying then
    self:InsertCacheList(assets_p)
    return
  end
  local assets = self:StackAssets(assets_p)
  if table.count(assets) == 0 then
    return
  end
  local tls = {}
  local lock = EZTL_Callback:New(function()
    self._isPlaying = true
  end, "播放中开始")
  table.insert(tls, lock)
  for idx, asset in ipairs(assets) do
    local tmp_tls = {}
    local wait = EZTL_Wait:New((idx - 1) * 300, "smaze wait anim")
    table.insert(tmp_tls, wait)
    local unit = self:GetHudUnit()
    unit:SetUI(asset)
    local tl = EZTL_SMaze_PlayerToast:New(unit, 1000)
    table.insert(tmp_tls, tl)
    local seq = EZTL_Sequence:New(tmp_tls)
    table.insert(tls, seq)
  end
  local endTls = {}
  local waitTime = #assets * 300
  local waitEnd = EZTL_Wait:New(waitTime, "smaze wait anim end")
  local unlock = EZTL_Callback:New(function()
    self._isPlaying = false
    self:CheckCacheList()
  end, "播放中结束")
  table.insert(endTls, waitEnd)
  table.insert(endTls, unlock)
  local endSeq = EZTL_Sequence:New(endTls)
  table.insert(tls, endSeq)
  local playTl = EZTL_Parallel:New(tls, nil, nil, "赛季秘境头顶飘字总时间线串行")
  GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():PlayEZTL(playTl)
end

_class("UISeasonMazeHudObj", Object)
UISeasonMazeHudObj = UISeasonMazeHudObj

function UISeasonMazeHudObj:Constructor(go, uiCamera, parent, getSpriteCb)
  self._using = false
  self._uiCamera = uiCamera
  self._worldCamera = SMazeAdaptor.MainCam()
  self._parent = parent
  self._go = go
  self._getSpriteCb = getSpriteCb
  self._pos = self._go:GetComponent(typeof(UnityEngine.RectTransform))
  self._img = self._go:GetComponentInChildren(typeof(UnityEngine.UI.Image))
  self._tex = self._go:GetComponentInChildren(typeof(UILocalizationText))
end

function UISeasonMazeHudObj:SetUI(asset)
  local sp = self._getSpriteCb(asset)
  self._img.gameObject:SetActive(sp ~= nil)
  if sp then
    self._img.sprite = sp
  end
  if asset._type == SeasonMazeEffectType.SMET_Relic then
    self._tex:SetText(StringTable.Get(asset._name))
  else
    self._tex:SetText(asset._count)
  end
end

function UISeasonMazeHudObj:SetPos()
  local pos = SMazeAdaptor.PlayerHeadPos()
  local screenPos = self._worldCamera:WorldToScreenPoint(pos)
  local res, uipos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._parent, screenPos, self._uiCamera, nil)
  self._pos.anchoredPosition = uipos
end

function UISeasonMazeHudObj:Update(dms)
  self:SetPos()
end

function UISeasonMazeHudObj:GetUsing()
  return self._using
end

function UISeasonMazeHudObj:SetUsing(using)
  self._using = using
end

function UISeasonMazeHudObj:Start()
  self._using = true
  self._go:SetActive(true)
  self:SetPos()
end

function UISeasonMazeHudObj:Stop()
  self._using = false
  self._go:SetActive(false)
end
