_class("UISeasonMazeUpLv", UIController)
UISeasonMazeUpLv = UISeasonMazeUpLv

function UISeasonMazeUpLv:InitWidget()
  self._lv = self:GetUIComponent("UILocalizedTMP", "lv")
  self._lv1 = self:GetUIComponent("UILocalizedTMP", "lv1")
  self._tex = self:GetGameObject("tex")
  self._tex:SetActive(false)
  self._root = self:GetUIComponent("RectTransform", "Content")
end

function UISeasonMazeUpLv:OnShow(uiParams)
  self:InitWidget()
  self._timerList = {}
  self._lastLv = uiParams[1]
  self._nextLv = uiParams[2]
  self._lv:SetText(tostring(self._lastLv))
  self._lv1:SetText(tostring(self._nextLv))
  local seasonObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  local com = seasonObj:GetMazeComponent()
  local cfgid = com:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_season_maze_lv({
    ComponentID = cfgid,
    Lv = self._nextLv
  })
  if cfgs and next(cfgs) then
    local cfg_lv = cfgs[1]
    local key = cfg_lv.UpLvDesc
    local n = 0
    while true do
      n = n + 1
      local keyHead = StringTable.Has(key .. "_" .. n)
      if not keyHead then
        n = n - 1
        break
      end
    end
    if n <= 0 then
      Log.fatal("###[UISeasonMazeUpLv] no [" .. key .. "_x] in str smaze.xlsx")
      return
    end
    self:ShowDescList(key, n)
  else
    Log.error("###[UISeasonMazeUpLv] cfg_component_season_maze_lv is nil ! lv:", self._nextLv)
  end
end

function UISeasonMazeUpLv:ShowDescList(key, n)
  self:Lock("UISeasonMazeUpLv:ShowDescList")
  self._lockTimer = GameGlobal.Timer():AddEvent(600 + (n - 1) * 50, function()
    self:UnLock("UISeasonMazeUpLv:ShowDescList")
  end)
  for i = 1, n do
    local go = UnityEngine.GameObject.Instantiate(self._tex, self._root)
    go:GetComponent(typeof(UILocalizationText)):SetText(StringTable.Get(key .. "_" .. i))
    local timer = GameGlobal.Timer():AddEvent(600 + (i - 1) * 50, function()
      go:SetActive(true)
    end)
    self._timerList[#self._timerList + 1] = timer
  end
end

function UISeasonMazeUpLv:BgOnClick(go)
  self:CloseDialog()
end

function UISeasonMazeUpLv:OnHide()
  if self._timerList and next(self._timerList) then
    for k, v in pairs(self._timerList) do
      GameGlobal.Timer():CancelEvent(v)
    end
  end
  if self._lockTimer then
    GameGlobal.Timer():CancelEvent(self._lockTimer)
  end
  SMazeAdaptor.OnLvUpDialogClose()
end
