_class("UIActivityLevelRecordController", UIController)
UIActivityLevelRecordController = UIActivityLevelRecordController

function UIActivityLevelRecordController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, function()
    GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
  end)
end

function UIActivityLevelRecordController:_Back()
  self:CloseDialog()
end

function UIActivityLevelRecordController:LoadDataOnEnter(TT, res, uiParams)
  self._component = uiParams and uiParams[1]
  self._mission = uiParams and uiParams[2]
  self._num = 1
  self:_LoadData(TT, res)
  self:_CheckErrorCode(TT, res)
end

function UIActivityLevelRecordController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_InitWidget()
  self:_Refresh()
end

function UIActivityLevelRecordController:_LoadData(TT, res)
  local response
  if self._component._className == "LineMissionComponent" then
    response = self._component:HandleLineMissionTeamRecord(TT, res, self._num, self._mission)
  elseif self._component._className == "TreeMissionComponent" then
    response = self._component:HandleTreeMissionTeamRecord(TT, res, self._num, self._mission)
  elseif self._component._className == "SeasonMissionComponent" then
    response = self._component:HandleMissionTeamRecord(TT, res, self._num, self._mission)
  end
  self._records = response and response.info or {}
  self._num = response and response.next_num or self._num
  self._recordPets = {}
  for idx, record in ipairs(self._records) do
    local pets = {}
    for i, data in ipairs(record.team) do
      local pet = SimplePet:New()
      pet:SetData(data)
      pets[i] = pet
    end
    self._recordPets[idx] = pets
  end
end

function UIActivityLevelRecordController:_CheckErrorCode(TT, res)
  if res:GetSucc() then
  else
    Log.error("UIActivityLevelRecordController:_CheckErrorCode() res = ", res.m_result)
  end
end

function UIActivityLevelRecordController:_LoadData_NextPage()
  if self._refreshId then
    return
  end
  local lockName = "UIActivityLevelRecordController:_LoadData_NextPage"
  GameGlobal.UIStateManager():Lock(lockName)
  self._refreshId = GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self:_LoadData(TT, res)
    self:_CheckErrorCode(TT, res)
    GameGlobal.UIStateManager():UnLock(lockName)
    self:_Refresh()
    YIELD(TT, 1000)
    self._refreshId = nil
  end)
end

function UIActivityLevelRecordController:_Refresh()
  local empty = table.count(self._records) == 0
  self:_SetState(not empty)
  self._index = nil
  self:_SetTabBtns()
  if not empty then
    self:_SetTabSelect(1)
  end
end

function UIActivityLevelRecordController:_InitWidget()
  self.player_icon = self:GetUIComponent("RawImageLoader", "player_icon")
  self.headFrameRect = self:GetUIComponent("RectTransform", "headFrame")
  self.headFrame = self:GetUIComponent("RawImageLoader", "headFrame")
  self.player_name = self:GetUIComponent("UILocalizationText", "player_name")
  self.player_id = self:GetUIComponent("UILocalizationText", "player_id")
  self.head_color = self:GetUIComponent("UICircleMaskLoader", "headColor")
  self.head_bg_rect = self:GetUIComponent("RectTransform", "headColor")
  self.head_bg_mask_rect = self:GetUIComponent("RectTransform", "headBgMask")
  self.head_root = self:GetUIComponent("RectTransform", "headRoot")
end

function UIActivityLevelRecordController:_SetState(flag)
  self:GetGameObject("_page"):SetActive(flag)
  self:GetGameObject("_empty"):SetActive(not flag)
end

function UIActivityLevelRecordController:_SetTabBtns()
  local title = {
    "str_tower_record1",
    "str_tower_record2",
    "str_tower_record3",
    "str_tower_record4",
    "str_tower_record5"
  }
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {
        {},
        {},
        {},
        {},
        {}
      },
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {
        {},
        {}
      },
      titleWidgets = {"txtTitle"},
      titleText = StringTable.Get(title[i]),
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end
    })
  end
end

function UIActivityLevelRecordController:_SetTabSelect(index)
  if index > #self._records then
    ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
    return
  end
  if index == self._index then
    return
  end
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_ActivityLevelRecord_Switch", 417)
  self._index = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
  end
  self:_SetHeartItem(self._recordPets[index])
  self:_SetPlayerInfo(self._records[index])
end

function UIActivityLevelRecordController:_SetHeartItem(pets)
  local objs = UIWidgetHelper.SpawnObjects(self, "_heartItem", "UIHeartItem", #pets)
  for i = 1, #pets do
    local pet = pets[i]
    local item = objs[i]
    item:SetData(pet, nil, nil, nil, TeamOpenerType.Tower, PetSkinEffectPath.CARD_TOWER)
  end
end

function UIActivityLevelRecordController:_SetPlayerInfo(record)
  self.player_name:SetText(record.nick)
  self._loginModule = self:GetModule(LoginModule)
  self.player_id:SetText(string.format(StringTable.Get("str_tower_id_title"), self._loginModule:GetShowIdByPstId(record.pstid)))
  local colorCfg = Cfg.cfg_player_head_bg[record.head_head_color]
  local headCfg = Cfg.cfg_role_head_image[record.head_image_id]
  local head, color
  if headCfg == nil then
    Log.exception("UIActivityLevelRecordController:_SetPlayerInfo() 找不到头像配置：", record.head_image_id)
    return
  end
  head = headCfg.Icon
  if colorCfg == nil then
    Log.warn("UIActivityLevelRecordController:_SetPlayerInfo() 找不到头像背景，使用默认1。id：", record.head_head_color)
    color = Cfg.cfg_player_head_bg[1].Icon
  else
    color = colorCfg.Icon
  end
  self.player_icon:LoadImage(head)
  self.head_color:LoadImage(color)
  local headFrame = record.head_frame_id
  if not headFrame or headFrame == 0 then
    Log.warn("UIActivityLevelRecordController:_SetPlayerInfo() 找不到头像框，使用默认1001。id：", record.head_frame_id)
    headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  end
  local cfg_head_frame = Cfg.cfg_role_head_frame[headFrame]
  self.headFrame:LoadImage(cfg_head_frame.Icon)
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self.head_bg_rect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self.head_bg_mask_rect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self.headFrameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self.head_root, RoleHeadFrameSizeType.Size5)
end

function UIActivityLevelRecordController:ChangeBtnOnClick()
  self:_LoadData_NextPage()
end

function UIActivityLevelRecordController:_DebugData()
  local tb = {}
  tb.pstid = 3180667236897739008
  tb.nick = "asszc020314"
  tb.head_image_id = 3751001
  tb.head_head_color = 0
  tb.head_frame_id = 3762000
  tb.team = {}
  tb.team[1] = {
    template_id = 1600191,
    level = 80,
    awakening = 6,
    grade = 3,
    equip_lv = 10,
    skin_id = 0,
    equip_refine_lv = 0
  }
  tb.team[2] = {
    template_id = 1600251,
    level = 80,
    awakening = 6,
    grade = 3,
    equip_lv = 10,
    skin_id = 0,
    equip_refine_lv = 0
  }
  tb.team[3] = {
    template_id = 1600261,
    level = 80,
    awakening = 6,
    grade = 3,
    equip_lv = 10,
    skin_id = 0,
    equip_refine_lv = 0
  }
  tb.team[4] = {
    template_id = 1600301,
    level = 80,
    awakening = 6,
    grade = 3,
    equip_lv = 10,
    skin_id = 0,
    equip_refine_lv = 0
  }
  tb.team[5] = {
    template_id = 1600601,
    level = 80,
    awakening = 6,
    grade = 3,
    equip_lv = 10,
    skin_id = 0,
    equip_refine_lv = 0
  }
  local record = {}
  table.insert(record, tb)
  return record
end
