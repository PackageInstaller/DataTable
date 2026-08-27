local UIEventFestivalSignIn = class("UIEventFestivalSignIn", UIBaseWindow)
local base = UIBaseWindow
local UINEventFestivalSignList = require("Game.EventFestivalSignIn.UI.UINEventFestivalSignList")

local function clearTimerAndMask(self)
  if self._cantClickTimer ~= nil then
    TimerManager:StopTimer(self._cantClickTimer)
    self._cantClickTimer = nil
  end
  self.ui.obj_Mask:SetActive(false)
end

function UIEventFestivalSignIn:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.OnClickClose)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.resloader = CS.ResLoader.Create()
end

function UIEventFestivalSignIn:InitEventFestivalSignIn(id, isShowCloseBtn)
  self.ui.btn_Background.gameObject:SetActive(isShowCloseBtn or false)
  self._isPop = isShowCloseBtn
  self.signData = PlayerDataCenter.eventNoviceSignData.dataDic[id]
  self.signData:SetPoped()
  local signCfg = self.signData:GetSignCfg()
  local avgID = signCfg.sign_avg
  self:_LoadSignList(self.signData, signCfg.list_style, isShowCloseBtn)
  local path = PathConsts:GetFestivalSignPath(signCfg.sign_prefab)
  self.resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    local go = prefab:Instantiate(self.ui.reHolder)
    local bind = {}
    UIUtil.LuaUIBindingTable(go.transform, bind)
    if IsNull(bind.tex_Time) then
      error("bind.tex_Time is nil, path:" .. path)
      return
    end
    local dateFormat = bind.tex_Time.text
    local startTs = self.signData:GetActivityBornTime()
    local endTs = self.signData:GetActivityDestroyTime()
    local startTimeStr = os.date(dateFormat, startTs)
    local endTimeStr = os.date(dateFormat, endTs)
    local text = startTimeStr .. "-" .. endTimeStr
    bind.tex_Time.text = text
    if not IsNull(bind.btn_Review) then
      UIUtil.AddButtonListener(bind.btn_Review, self, self.PlaySignInAvg)
      bind.btn_Review.gameObject:SetActive(avgID ~= 0)
    end
  end)
  self:_LoadBackgroundPic(signCfg)
  if self._isPop then
    clearTimerAndMask(self)
    local canPlayeAvg = false
    if avgID ~= 0 then
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
      if not avgPlayCtrl:IsAvgPlayed(avgID) then
        canPlayeAvg = true
      end
    end
    if canPlayeAvg then
      self.ui.obj_Mask:SetActive(true)
      self._cantClickTimer = TimerManager:StartTimer(0.5, function()
        clearTimerAndMask(self)
        self:PlaySignInAvg(true)
      end)
    end
  end
end

function UIEventFestivalSignIn:_LoadSignList(signData, prefabName, isShowCloseBtn)
  local path = PathConsts:GetFestivalSignPath(prefabName)
  self.resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    local go = prefab:Instantiate(self.ui.rightHolder)
    local signListNode = UINEventFestivalSignList.New()
    signListNode:Init(go)
    signListNode:InitEventFestivalSignList(signData, isShowCloseBtn, BindCallback(self, self.OnClickClose))
    self.signListNode = signListNode
  end)
end

function UIEventFestivalSignIn:UpdUIFestivalSignIn()
  if self.signListNode ~= nil then
    self.signListNode:UpdUIFestivalSignInList()
  end
end

function UIEventFestivalSignIn:SetCloseCallback(callback)
  self.closeCallback = callback
end

function UIEventFestivalSignIn:FestivalSignOutOfDate()
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithConfirm(ConfigData:GetTipContent(6033), function()
      if self._isPop then
        self:OnClickClose()
      else
        UIUtil.OnClickBackByWinId(UIWindowTypeID.ActivityFrameMain)
      end
    end)
  end)
end

function UIEventFestivalSignIn:_LoadBackgroundPic(signCfg)
  local path = PathConsts:GetFestivalBgPath(signCfg.BG_name)
  self.ui.img_Bg.enabled = false
  self.resloader:LoadABAssetAsync(path, function(texture)
    if texture ~= nil and not IsNull(self.gameObject) then
      self.ui.img_Bg.enabled = true
      self.ui.img_Bg.texture = texture
      local x = signCfg.BG_pos[1] or 0
      local y = signCfg.BG_pos[2] or 0
      local z = signCfg.BG_pos[3] or 0
      self.ui.img_Bg.transform.anchoredPosition = Vector3.New(x, y, z)
      local w = signCfg.BG_size[1] or 0
      local h = signCfg.BG_size[2] or 0
      self.ui.img_Bg.transform.sizeDelta = Vector2.New(w, h)
    end
  end)
end

function UIEventFestivalSignIn:PlaySignInAvg(isAutoPlay)
  local avgID = self.signData:GetSignCfg().sign_avg
  if avgID == 0 then
    return
  end
  if not isAutoPlay then
    PlayerClickCollectManager:BtnClickNumCollect(1004)
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, avgID, nil)
end

function UIEventFestivalSignIn:BackAction()
  self:Delete()
end

function UIEventFestivalSignIn:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventFestivalSignIn:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  clearTimerAndMask(self)
  if self.signListNode ~= nil then
    self.signListNode:Delete()
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  base.OnDelete(self)
end

return UIEventFestivalSignIn
