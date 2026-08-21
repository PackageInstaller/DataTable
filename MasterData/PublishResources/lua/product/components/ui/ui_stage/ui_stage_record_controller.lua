_class("UIStageRecordController", UIController)
UIStageRecordController = UIStageRecordController

function UIStageRecordController:OnShow(uiParams)
  self._records = uiParams[1]
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self:InitWidget()
  self._recordPets = {}
  table.sort(self._records, function(a, b)
    return a.pass_time > b.pass_time
  end)
  for idx, record in ipairs(self._records) do
    local pets = {}
    for i, data in ipairs(record.formation_info) do
      local pet = SimplePet:New()
      pet:SetData(data)
      pets[i] = pet
    end
    self._recordPets[idx] = pets
  end
  self._index = nil
  self._loginModule = self:GetModule(LoginModule)
  self:OnSelect(1)
end

function UIStageRecordController:InitWidget()
  self.player_icon = self:GetUIComponent("RawImageLoader", "player_icon")
  self.headFrameRect = self:GetUIComponent("RectTransform", "headFrame")
  self.headFrame = self:GetUIComponent("RawImageLoader", "headFrame")
  self.player_name = self:GetUIComponent("UILocalizationText", "player_name")
  self.player_id = self:GetUIComponent("UILocalizationText", "player_id")
  self.list = self:GetUIComponent("UISelectObjectPath", "list")
  self.head_color = self:GetUIComponent("UICircleMaskLoader", "headColor")
  self.head_bg_rect = self:GetUIComponent("RectTransform", "headColor")
  self.head_bg_mask_rect = self:GetUIComponent("RectTransform", "headBgMask")
  self.head_root = self:GetUIComponent("RectTransform", "headRoot")
  self._buttons = {
    self:GetUIComponent("Button", "Button1"),
    self:GetUIComponent("Button", "Button2"),
    self:GetUIComponent("Button", "Button3"),
    self:GetUIComponent("Button", "Button4"),
    self:GetUIComponent("Button", "Button5")
  }
  self._anim = self:GetUIComponent("Animation", "UITowerRecord")
  self.tmp = {}
end

function UIStageRecordController:OnSelect(idx)
  if idx > #self._records then
    ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
    return
  end
  local notChange
  if #self.tmp ~= 0 then
    notChange = self.tmp[idx].nick == self._records[idx].nick
  else
    notChange = true
  end
  if idx == self._index and notChange then
    return
  end
  self._anim.enabled = true
  self._anim:Play("uieff_TowerRecord_Switch")
  if self._index then
    self._buttons[self._index].interactable = true
  end
  self._index = idx
  self._buttons[self._index].interactable = false
  local pets = self._recordPets[idx]
  self.list:ClearWidgets()
  self.list:SpawnObjects("UIHeartItem", #pets)
  self._petList = self.list:GetAllSpawnList()
  for i = 1, #pets do
    local pet = pets[i]
    local item = self._petList[i]
    item:SetData(pet, nil, nil, nil, TeamOpenerType.Tower, PetSkinEffectPath.CARD_TOWER)
  end
  local record = self._records[idx]
  self.player_name:SetText(record.nick)
  self.player_id:SetText(string.format(StringTable.Get("str_tower_id_title"), self._loginModule:GetShowIdByPstId(record.pstid)))
  local colorCfg = Cfg.cfg_player_head_bg[record.head_bg]
  local headCfg = Cfg.cfg_role_head_image[record.head]
  local head, color
  if headCfg == nil then
    Log.exception("[Tower] 找不到头像配置：", record.head)
    return
  end
  head = headCfg.Icon
  if colorCfg == nil then
    Log.warn("[Tower] 找不到头像背景，使用默认1。id：", record.head_bg)
    color = Cfg.cfg_player_head_bg[1].Icon
  else
    color = colorCfg.Icon
  end
  self.player_icon:LoadImage(head)
  self.head_color:LoadImage(color)
  local headFrame = record.frame_id
  if not headFrame or headFrame == 0 then
    Log.warn("[Tower] 找不到头像框，使用默认1001。id：", record.frame_id)
    headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  end
  local cfg_head_frame = Cfg.cfg_role_head_frame[headFrame]
  self.headFrame:LoadImage(cfg_head_frame.Icon)
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self.head_bg_rect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self.head_bg_mask_rect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self.headFrameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self.head_root, RoleHeadFrameSizeType.Size5)
end

function UIStageRecordController:Record1OnClick(go)
  self:OnSelect(1)
end

function UIStageRecordController:Record2OnClick(go)
  self:OnSelect(2)
end

function UIStageRecordController:Record3OnClick(go)
  self:OnSelect(3)
end

function UIStageRecordController:Record4OnClick(go)
  self:OnSelect(4)
end

function UIStageRecordController:Record5OnClick(go)
  self:OnSelect(5)
end

function UIStageRecordController:ChangeOnClick()
  self.tmp = table.shallowcopy(self._records)
  self.petTmp = table.shallowcopy(self._recordPets)
  if #self._records > 5 then
    for i, value in ipairs(self.tmp) do
      if i <= 5 then
        table.remove(self._records, 1)
        table.insert(self._records, value)
      end
    end
    for i, value in ipairs(self.petTmp) do
      if i <= 5 then
        table.remove(self._recordPets, 1)
        table.insert(self._recordPets, value)
      end
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
    return
  end
  self:OnSelect(1)
end
