_class("UIBookCGPreviewCell", UICustomWidget)

function UIBookCGPreviewCell:Constructor()
end

function UIBookCGPreviewCell:OnShow()
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._icon = self:GetUIComponent("RawImageLoader", "diLayer")
  self._lockGO = self:GetGameObject("lock")
  self._unLockGO = self:GetGameObject("unlock")
  self._chooseGO = self:GetGameObject("choose")
  self._chooseGO:SetActive(false)
  self:AttachEvent(GameEventType.OnCgBookListItemClick, self.OnCgBookListItemClick)
end

function UIBookCGPreviewCell:OnCgBookListItemClick(id)
  self:Select(id == self._data.id)
end

function UIBookCGPreviewCell:Select(choose)
  self._chooseGO:SetActive(choose)
end

function UIBookCGPreviewCell:OnHide()
end

function UIBookCGPreviewCell:SetData(data, index, callBack, select)
  self.index = index
  self._chooseGO:SetActive(false)
  self._callBack = callBack
  self._data = data
  local id = data.id
  local active = data.active
  self.active = active
  local cfg = Cfg.cfg_cg_book[id]
  self._icon:LoadImage(cfg.Preview)
  if active then
    self._unLockGO:SetActive(true)
    self._lockGO:SetActive(false)
    self._nameText:SetText(StringTable.Get(cfg.PreviewTitle))
  else
    self._unLockGO:SetActive(false)
    self._lockGO:SetActive(true)
  end
  self:Select(select)
end

function UIBookCGPreviewCell:btnOnClick(go)
  local id = self._data.id
  local cfg = Cfg.cfg_cg_book[id]
  if not self.active then
    local str1 = ""
    local str2 = ""
    local tips = ""
    if cfg.Type == BookCGType.Main then
      str1 = "str_book_cg_main"
      str2 = StringTable.Get(Cfg.cfg_waypoint[cfg.MissionId[1]].Name)
      tips = StringTable.Get("str_book_cg_no_collect_msg", StringTable.Get(str1), str2)
    elseif cfg.Type == BookCGType.Ext then
      local flag = false
      local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
      if time_mod == nil then
        Log.error("UAReportForceGuideEvent time_mod == nil")
        return
      end
      local servertime = math.floor(time_mod:GetServerTime() / 1000)
      if cfg.SideStoryID then
        local clenttime = Cfg.cfg_extra_mission({
          ExtMissionID = cfg.SideStoryID
        })[1].UnlockTime
        local timestamp = 0
        if clenttime ~= nil then
          timestamp = LoginModule:GetTimeStampByTimeStr(clenttime, Enum_DateTimeZoneType.E_ZoneType_GMT)
          if servertime >= timestamp or clenttime == nil then
            flag = true
          else
            flag = false
            tips = StringTable.Get("str_book_not_open")
          end
        else
          flag = true
        end
      end
      if flag == true then
        str1 = "str_book_cg_ext"
        str2 = self:GetStageIdx(cfg.ExtMissionId[1])
        tips = StringTable.Get("str_book_cg_no_collect_msg", StringTable.Get(str1), str2)
      end
    elseif cfg.Type == BookCGType.Pet then
      tips = StringTable.Get("str_book_pet_skin_cell_cg_active")
    end
    ToastManager.ShowToast(tips)
  elseif self._callBack then
    self._callBack(self._data.id, self)
  end
end

function UIBookCGPreviewCell:GetStageIdx(taskId)
  local cfg_extra_mission = Cfg.cfg_extra_mission({})
  local idx1 = 0
  local idx2 = 0
  local extName = ""
  for i, v in HelperProxy:GetInstance():pairsByKeys(cfg_extra_mission) do
    idx1 = idx1 + 1
    if self:In(v.ExtTaskList, taskId) then
      local taskList = v.ExtTaskList
      for j = 1, #taskList do
        if taskList[j] == taskId then
          idx2 = j
          break
        end
      end
      break
    end
  end
  return idx1 .. "-" .. idx2
end

function UIBookCGPreviewCell:In(ExtTaskList, taskId)
  for index, value in ipairs(ExtTaskList) do
    if value == taskId then
      return true
    end
  end
  return false
end
