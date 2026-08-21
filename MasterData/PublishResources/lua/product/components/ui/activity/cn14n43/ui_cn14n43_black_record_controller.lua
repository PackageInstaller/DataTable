_class("UICN14N43BlackRecordController", UIController)
UICN14N43BlackRecordController = UICN14N43BlackRecordController

function UICN14N43BlackRecordController:OnShow(uiParams)
  self._stageInfo = uiParams[1]
  self:InitChildStageIDs()
  self._records = uiParams[2]
  self._exitGame = uiParams[3]
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end, nil, function()
    if self._exitGame then
      GameGlobal:GetInstance():ExitCoreGame()
    end
    self:SwitchState(UIStateType.UIMain)
  end)
  self:InitWidget()
  self._recordPets = {}
  self.ChildBtnsNodeH = {
    [1] = 20,
    [2] = 80,
    [3] = 130
  }
  table.sort(self._records, function(a, b)
    return a.pass_time > b.pass_time
  end)
  for idx, record in ipairs(self._records) do
    local infos = record.formation_info
    for key, value in pairs(infos) do
      local pets = {}
      for i, data in ipairs(value) do
        if data.template_id > 0 then
          local pet = SimplePet:New()
          pet:SetData(data)
          table.insert(pets, pet)
        end
      end
      if not self._recordPets[idx] then
        self._recordPets[idx] = {}
      end
      self._recordPets[idx][key] = pets
    end
  end
  local len = table.count(self._recordPets)
  self.pageMax = math.ceil(len / 5)
  self.currPage = 1
  self.lastPage = 0
  self.currSelectRecordIndex = nil
  self.currSelectChildRecordIndex = nil
  self._loginModule = self:GetModule(LoginModule)
  self:InitChildBtns()
  self:OnSelect(1, 1)
end

function UICN14N43BlackRecordController:InitWidget()
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
  self.ChildBtnsNode = self:GetUIComponent("RectTransform", "ChildBtns")
  self.ChildBtnsNodeParent = self.ChildBtnsNode.parent
  self.ChildBtnNode1 = self:GetUIComponent("RectTransform", "ChildBtnNode1")
  self.ChildBtnNode2 = self:GetUIComponent("RectTransform", "ChildBtnNode2")
  self.ChildBtnNode3 = self:GetUIComponent("RectTransform", "ChildBtnNode3")
  self.ChildBtnText1 = self:GetUIComponent("UILocalizationText", "ChildBtnText1")
  self.ChildBtnText2 = self:GetUIComponent("UILocalizationText", "ChildBtnText2")
  self.ChildBtnText3 = self:GetUIComponent("UILocalizationText", "ChildBtnText3")
  self._childBtns = {
    self:GetUIComponent("Button", "ChildBtn1"),
    self:GetUIComponent("Button", "ChildBtn2"),
    self:GetUIComponent("Button", "ChildBtn3")
  }
  self._buttons = {
    self:GetUIComponent("Button", "Button1"),
    self:GetUIComponent("Button", "Button2"),
    self:GetUIComponent("Button", "Button3"),
    self:GetUIComponent("Button", "Button4"),
    self:GetUIComponent("Button", "Button5")
  }
  self._underlines = {
    [1] = self:GetUIComponent("RectTransform", "Underline1"),
    [2] = self:GetUIComponent("RectTransform", "Underline2"),
    [3] = self:GetUIComponent("RectTransform", "Underline3"),
    [4] = self:GetUIComponent("RectTransform", "Underline4"),
    [5] = self:GetUIComponent("RectTransform", "Underline5")
  }
  self._anim = self:GetUIComponent("Animation", "UITowerRecord")
end

function UICN14N43BlackRecordController:OnSelect(idx, childIndex)
  if self.lastPage == self.currPage and idx == self.currSelectRecordIndex and childIndex == self.currSelectChildRecordIndex then
    return
  end
  local selectRecordIndex = idx + (self.currPage - 1) * 5
  if selectRecordIndex > #self._records or childIndex > #self.childStageIDs then
    ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
    return
  end
  self.lastPage = self.currPage
  local childStageID = self.childStageIDs[childIndex]
  local pets = self._recordPets[selectRecordIndex][childStageID]
  if not pets then
    ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
    return
  end
  self._anim.enabled = true
  self._anim:Play("uieff_TowerRecord_Switch")
  if self.currSelectRecordIndex then
    self._buttons[self.currSelectRecordIndex].interactable = true
  end
  self.currSelectRecordIndex = idx
  self.currSelectChildRecordIndex = childIndex
  self._buttons[self.currSelectRecordIndex].interactable = false
  self:RefchildBtnNode()
  self.list:SpawnObjects("UIHeartItem", #pets)
  self._petList = self.list:GetAllSpawnList()
  for i = 1, #pets do
    local pet = pets[i]
    local item = self._petList[i]
    item:SetData(pet, nil, nil, nil, TeamOpenerType.Tower, PetSkinEffectPath.CARD_TOWER)
  end
  local record = self._records[selectRecordIndex]
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

function UICN14N43BlackRecordController:Record1OnClick(go)
  self:SelectRecordIndex(1, 1)
end

function UICN14N43BlackRecordController:Record2OnClick(go)
  self:SelectRecordIndex(2, 1)
end

function UICN14N43BlackRecordController:Record3OnClick(go)
  self:SelectRecordIndex(3, 1)
end

function UICN14N43BlackRecordController:Record4OnClick(go)
  self:SelectRecordIndex(4, 1)
end

function UICN14N43BlackRecordController:Record5OnClick(go)
  self:SelectRecordIndex(5, 1)
end

function UICN14N43BlackRecordController:SelectRecordIndex(idx)
  if self.currSelectRecordIndex == idx then
    self:SetChildBtnNodeActive()
    return
  end
  local go = self.ChildBtnsNode.gameObject
  go:SetActive(true)
  self:OnSelect(idx, 1)
end

function UICN14N43BlackRecordController:RefchildBtnNode()
  self.ChildBtnsNode.transform:SetSiblingIndex(self.currSelectRecordIndex)
  for i = 1, 3 do
    self._childBtns[i].interactable = self.currSelectChildRecordIndex ~= i
  end
  for i = 1, #self._underlines do
    if i == self.currSelectRecordIndex then
      local stages = self._stageInfo
      self._underlines[i].localPosition = Vector3(0, 0 - 55 * #stages, 0)
    else
      self._underlines[i].localPosition = Vector3(0, 0, 0)
    end
  end
end

function UICN14N43BlackRecordController:SetChildBtnNodeActive()
  local go = self.ChildBtnsNode.gameObject
  local isShow = not go.activeSelf
  go:SetActive(isShow)
  if isShow then
    local stages = self._stageInfo
    self._underlines[self.currSelectRecordIndex].localPosition = Vector3(0, 0 - 55 * #stages, 0)
  else
    self._underlines[self.currSelectRecordIndex].localPosition = Vector3(0, 0, 0)
  end
end

function UICN14N43BlackRecordController:ChildBtn1OnClick(go)
  self:OnSelect(self.currSelectRecordIndex, 1)
end

function UICN14N43BlackRecordController:ChildBtn2OnClick(go)
  self:OnSelect(self.currSelectRecordIndex, 2)
end

function UICN14N43BlackRecordController:ChildBtn3OnClick(go)
  self:OnSelect(self.currSelectRecordIndex, 3)
end

function UICN14N43BlackRecordController:InitChildBtns()
  local stages = self._stageInfo
  local stageLen = #stages
  local x = self.ChildBtnsNode.sizeDelta.x
  self.ChildBtnsNode.sizeDelta = Vector2(x, self.ChildBtnsNodeH[stageLen])
  for i = 1, 3 do
    local stage = stages[i]
    local isShow = stageLen >= i
    self["ChildBtnNode" .. i].gameObject:SetActive(isShow)
    if isShow then
      self["ChildBtnText" .. i]:SetText(stage:GetName())
    end
  end
end

function UICN14N43BlackRecordController:InitChildStageIDs()
  self.childStageIDs = {}
  local stages = self._stageInfo
  for index, value in ipairs(stages) do
    self.childStageIDs[index] = value:GetID()
  end
end

function UICN14N43BlackRecordController:ChangePageBtnOnClick(go)
  self.currPage = self.currPage + 1
  if self.currPage > self.pageMax then
    self.currPage = 1
  end
  self:OnSelect(1, 1)
end

_class("UICN14N43BlackRecordSatgeData", Object)
UICN14N43BlackRecordSatgeData = UICN14N43BlackRecordSatgeData

function UICN14N43BlackRecordSatgeData:Constructor()
  self._name = ""
  self._id = ""
end

function UICN14N43BlackRecordSatgeData:InitData(n, i)
  self._name = n
  self._id = i
end

function UICN14N43BlackRecordSatgeData:GetID()
  return self._id
end

function UICN14N43BlackRecordSatgeData:GetName()
  return self._name
end
