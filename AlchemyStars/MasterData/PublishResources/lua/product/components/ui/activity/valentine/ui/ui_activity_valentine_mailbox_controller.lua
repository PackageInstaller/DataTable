_class("UIActivityValentineMailboxController", UIController)
UIActivityValentineMailboxController = UIActivityValentineMailboxController

function UIActivityValentineMailboxController:Constructor()
end

function UIActivityValentineMailboxController:LoadDataOnEnter(TT, res, uiParams)
  res:SetSucc(true)
  self._activityData = ActivityValentineData:New()
  self._activityData:LoadData(TT, res)
end

function UIActivityValentineMailboxController:OnShow()
  self:_GetComponent()
  self:InitMailList()
end

function UIActivityValentineMailboxController:OnHide()
end

function UIActivityValentineMailboxController:_Close(TT)
  self:Lock("UIActivityValentineMailboxController_Close")
  self._anim:Play("uieff_UIActivityValentineMailboxController_SafeArea_out")
  YIELD(TT, 500)
  self:UnLock("UIActivityValentineMailboxController_Close")
  self:CloseDialog()
end

function UIActivityValentineMailboxController:_GetComponent()
  self._mailContent = self:GetUIComponent("UISelectObjectPath", "mailContent")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIActivityValentineMailboxController:InitMailList()
  local spawnTb = self:_Sort()
  if #spawnTb == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n27_valentine_y_empty_letter"))
  end
  self._mailWidgets = self._mailContent:SpawnObjects("UIActivityValentineMailboxItem", #spawnTb)
  for i, v in pairs(self._mailWidgets) do
    v:SetData(spawnTb[i], self._activityData)
  end
end

function UIActivityValentineMailboxController:_Sort()
  local resTb = {}
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local mailCompInfo = self._activityData:GetMailComponent()
  local infos = mailCompInfo.m_component_info.infos
  local readTb = {}
  local unReadTb = {}
  if not infos then
    Log.fatal("获取邮箱数据为空")
    return resTb
  end
  for _, v in pairs(infos) do
    if curTime > v.unlock_time then
      if v.state == MiniMailStateType.MMST_Unread then
        table.insert(unReadTb, v)
      elseif v.state == MiniMailStateType.MMST_Read then
        table.insert(readTb, v)
      end
    end
  end
  for _, v in pairs(unReadTb) do
    table.insert(resTb, v)
  end
  for _, v in pairs(readTb) do
    table.insert(resTb, v)
  end
  return resTb
end

function UIActivityValentineMailboxController:BackBtnOnClick()
  self:StartTask(self._Close, self)
end
