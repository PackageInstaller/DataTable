local UISpring23Misson = class("UISpring23Misson", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UISpring23Misson:OnInit()
  self._resloader = CS.ResLoader.Create()
  self.ui.btn_task.gameObject:SetActive(false)
  self.btnClickSpecialFuncDic = {}
  self.redDotFuncDic = {}
  for i, btn in pairs(self.ui.btn_list) do
    UIUtil.AddButtonListenerWithArg(btn, self, self.ClickLeftBtn, i)
  end
  UIUtil.AddButtonListener(self.ui.Btn_QuickJump, self, self.OnClickQuickJump)
  UIUtil.AddButtonListener(self.ui.Btn_Get, self, self.OnClickBtnGet)
end

function UISpring23Misson:InitJumpFuncByActivityFrameId(activityFrameId, actData)
  local cfgDic = ConfigData.activity_general_jump[activityFrameId]
  self.cfgDic = cfgDic or {}
  self.actData = actData or nil
  self.activityFrameId = activityFrameId
  self._aniPlayStart = false
  self:CheckBtnOpen()
  self:LoadBtnBottomImg()
  if self._timer then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  self._timer = TimerManager:StartTimer(1, BindCallback(self, self.CheckBtnOpen), nil, false, false, false)
  self:RefreshTipBoard()
end

function UISpring23Misson:RefreshTipBoard()
  if self.actData == nil then
    self.ui.TipBoard:SetActive(false)
    return
  end
  local taskData, isMainLine = self.actData:GetActivitySpecialTaskData()
  if taskData == nil then
    self.ui.TipBoard:SetActive(false)
    return
  end
  self.ui.TipBoard:SetActive(true)
  self._tipTaskData = taskData
  self.ui.tip_Title:SetIndex(isMainLine and 1 or 0)
  local intro = taskData:GetTaskFirstStepIntro()
  local isComplete = taskData:CheckComplete()
  local rateStr = ConfigData:GetTipContent(40003)
  if not isComplete then
    rateStr = ConfigData:GetTipContent(40002, tostring(taskData.schedule), tostring(taskData.aim))
  end
  self.ui.tip_TexDex:SetIndex(0, intro, rateStr)
  local flag, jumpId, jumpArgs = self._tipTaskData:GetTaskJumpArg()
  if not isComplete then
    self.ui.Btn_QuickJump.gameObject:SetActive(flag)
    self.ui.Btn_Get.gameObject:SetActive(false)
  else
    self.ui.Btn_QuickJump.gameObject:SetActive(false)
    self.ui.Btn_Get.gameObject:SetActive(true)
  end
end

function UISpring23Misson:CheckBtnOpen()
  for id, btnObj in pairs(self.ui.btn_list) do
    self:__SetJumpBtnState(id, btnObj)
  end
end

function UISpring23Misson:LoadBtnBottomImg()
  for id, bottom in pairs(self.ui.btn_img_list) do
    if bottom and not IsNull(bottom.gameObject) and self.cfgDic[id] then
      self._resloader:LoadABAssetAsync(PathConsts:GetActivityPath(self.cfgDic[id].jump_res), function(texture)
        if IsNull(self.transform) then
          return
        end
        bottom.texture = texture
      end)
    end
  end
end

function UISpring23Misson:__SetJumpBtnState(id, btnObj)
  if self.cfgDic[id] == nil then
    btnObj.gameObject:SetActive(false)
    return
  end
  local isActivityStart = PlayerDataCenter.timestamp >= self.cfgDic[id].open_time
  local isActClose = false
  if self.cfgDic[id].jump_id == JumpManager.eJumpTarget.DynActivity then
    local targetActFrameId = self.cfgDic[id].jumpArgs[1]
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local actFrameData = actFrameCtrl:GetActivityFrameData(targetActFrameId)
    if actFrameData == nil then
      isActClose = true
    end
  end
  local isActivityEnd = PlayerDataCenter.timestamp >= self.cfgDic[id].close_time
  btnObj.gameObject:SetActive(not isActivityEnd and self._aniPlayStart and not isActClose)
  local isLocked = false
  if not isLocked and not isActivityStart then
    if self.__tip426 == nil then
      local timeDate = TimeUtil:TimestampToDate(self.cfgDic[id].open_time, nil, true)
      self.__tip426 = ConfigData:GetTipContent(426, timeDate.month, timeDate.day)
    end
    self.ui.btn_obj_lock_text[id].text = self.__tip426
    isLocked = true
  end
  if not isLocked and isActivityEnd then
    self.ui.btn_obj_lock_text[id].text = ConfigData:GetTipContent(6033)
    isLocked = true
  end
  if not isLocked then
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    if activityFrameCtrl ~= nil and self.cfgDic[id].jump_id == JumpManager.eJumpTarget.DynActivity and self.cfgDic[id].jumpArgs ~= nil and #self.cfgDic[id].jumpArgs > 0 then
      local activityId = self.cfgDic[id].jumpArgs[1]
      local activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
      if activityFrameData ~= nil and activityFrameData:GetIsActivityLocked() then
        isLocked = true
        local des = activityFrameData:GetLockTip()
        self.ui.btn_obj_lock_text[id].text = des
      end
    end
  end
  self.ui.btn_obj_lock[id]:SetActive(isLocked)
end

function UISpring23Misson:PlayMissionAni()
  if self._taskOpenFunc and self._taskRedFunc then
    self.ui.btn_task.gameObject:SetActive(true)
  end
  self._aniPlayStart = true
  self:CheckBtnOpen()
  self.ui.ani_misson:Play()
  self._aniCompleteFlag = true
end

function UISpring23Misson:SetTaskFunc(openFunc, reddotFunc)
  self._taskOpenFunc = openFunc
  self._taskRedFunc = reddotFunc
  UIUtil.AddButtonListener(self.ui.btn_task, self, self.OnClickTask)
end

function UISpring23Misson:SetBtnClickFunc(index, callback)
  self.btnClickSpecialFuncDic[index] = callback
end

function UISpring23Misson:SetBtnReddotFunc(index, callback)
  self.redDotFuncDic[index] = callback
end

function UISpring23Misson:SetSpecialTaskJumpFunc(func)
  self.specialTaskFunc = func
end

function UISpring23Misson:ClickLeftBtn(index)
  if self.btnClickSpecialFuncDic[index] then
    self.btnClickSpecialFuncDic[index]()
    return
  end
  if not self.cfgDic then
    return
  end
  local cfg = self.cfgDic[index]
  if not cfg then
    return
  end
  local isActivityStart = PlayerDataCenter.timestamp >= self.cfgDic[index].open_time
  local isActivityEnd = PlayerDataCenter.timestamp >= self.cfgDic[index].close_time
  if not isActivityStart then
    local timeDate = TimeUtil:TimestampToDate(self.cfgDic[index].open_time, nil, true)
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(426, timeDate.month, timeDate.day))
    return
  end
  if isActivityEnd then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
    return
  end
  local jumpArgs = cfg.jumpArgs
  if jumpArgs ~= nil then
    if jumpArgs[1] == 40002 then
      PlayerClickCollectManager:BtnClickNumCollect(1028)
    elseif jumpArgs[1] == 51001 then
      PlayerClickCollectManager:BtnClickNumCollect(1029)
    end
  end
  JumpManager:Jump(cfg.jump_id, nil, nil, jumpArgs)
end

function UISpring23Misson:OnClickTask(isFirstSelectTermTask)
  if self._taskOpenFunc ~= nil then
    self._taskOpenFunc(isFirstSelectTermTask)
  end
end

function UISpring23Misson:OnClickQuickJump()
  if self._tipTaskData == nil then
    return
  end
  local flag, jumpId, jumpArgs = self._tipTaskData:GetTaskJumpArg()
  if flag then
    if self.specialTaskFunc ~= nil and self.specialTaskFunc(jumpArgs) then
      return
    end
    JumpManager:Jump(jumpId, nil, nil, jumpArgs)
  else
    self:OnClickTask(true)
  end
end

function UISpring23Misson:OnClickBtnGet()
  if self._tipTaskData == nil then
    return
  end
  self:OnClickTask(true)
end

function UISpring23Misson:RefreshMissonReddot()
  if self._taskRedFunc ~= nil then
    self.ui.redDot_task:SetActive(self._taskRedFunc())
  end
  for id, redObj in pairs(self.ui.btn_reddot_list) do
    local active = self.redDotFuncDic[id] and self.redDotFuncDic[id]() or false
    redObj:SetActive(active)
  end
end

function UISpring23Misson:OnShow()
  if self._aniCompleteFlag then
    local aniLength = self.ui.ani_misson.clip.length
    local item = self.ui.ani_misson:get_Item("UI_Spring23Misson")
    item.enabled = true
    item.time = aniLength
    self.ui.ani_misson:Sample()
    self._aniCompleteFlag = false
  end
end

function UISpring23Misson:OnCloseSpring23Misson()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UISpring23Misson:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self._timer then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  base.OnDelete(self)
end

return UISpring23Misson
