require("ui_season_maze_room_base")
_class("UISeasonMazeRoom_DirectionalRecruit", UISeasonMazeRoomBase)
UISeasonMazeRoom_DirectionalRecruit = UISeasonMazeRoom_DirectionalRecruit

function UISeasonMazeRoom_DirectionalRecruit:InitWidget()
  self._chooseColorArea = self:GetUIComponent("UISelectObjectPath", "ChooseColorArea")
  self._chooseColorAreaGo = self:GetGameObject("ChooseColorArea")
  self._choosePetArea = self:GetUIComponent("UISelectObjectPath", "ChoosePetArea")
  self._choosePetAreaGo = self:GetGameObject("ChoosePetArea")
  self._colorChoosed = false
end

function UISeasonMazeRoom_DirectionalRecruit:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self:InitWidget()
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.OnUISeasonMazeAttChanged)
  self._colorIndexs = {
    [1] = ElementType.ElementType_Blue,
    [2] = ElementType.ElementType_Red,
    [3] = ElementType.ElementType_Green,
    [4] = ElementType.ElementType_Yellow
  }
  self.ElementNameTable = {
    [ElementType.ElementType_Blue] = "str_pet_element_name_blue",
    [ElementType.ElementType_Red] = "str_pet_element_name_red",
    [ElementType.ElementType_Green] = "str_pet_element_name_green",
    [ElementType.ElementType_Yellow] = "str_pet_element_name_yellow"
  }
  self:InitData()
  self:InitChooseColor()
  self:SwitchState()
end

function UISeasonMazeRoom_DirectionalRecruit:InitData()
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  self._com = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._comInfo = self._com:GetComponentInfo()
  local petList = self._comInfo.m_recruit_room_pet_list
  if #petList == 0 then
    self._colorChoosed = false
  else
    self._colorChoosed = true
  end
end

function UISeasonMazeRoom_DirectionalRecruit:GetReflushCnt()
  local cnt = self._comInfo.m_recruit_room_reflush_cnt
  return cnt
end

function UISeasonMazeRoom_DirectionalRecruit:InitChooseColor()
  self._chooseColorWidget = self._chooseColorArea:SpawnObject("UISeasonMazeRoom_DirectionalRecruitChooseColor")
  self._chooseColorWidget:SetData(function()
    self:OnBackBtnOnClick()
  end, function(idx)
    self:OnChooseColor(idx)
  end, function()
    self:OnExit()
  end)
end

function UISeasonMazeRoom_DirectionalRecruit:OnChooseColor(idx)
  local color = self._colorIndexs[idx]
  if not color then
    return
  end
  local colorStr = StringTable.Get(self.ElementNameTable[color])
  local msgStr = StringTable.Get("str_season_maze_room_recruit_choose_color_tips1", colorStr)
  UISeasonMazeModule.PopMsgBox(nil, msgStr, SeasonMazeMsgBoxType.OkCancel, function()
    self:ReqSelectProp(color)
  end)
end

function UISeasonMazeRoom_DirectionalRecruit:SwitchState()
  if self._colorChoosed then
    self:InitChoosePet()
  end
  self._chooseColorAreaGo:SetActive(not self._colorChoosed)
  self._choosePetAreaGo:SetActive(self._colorChoosed)
end

function UISeasonMazeRoom_DirectionalRecruit:InitChoosePet()
  self._choosePetWidget = self._choosePetArea:SpawnObject("UISeasonMazeRoom_DirectionalRecruitChoosePet")
  self._choosePetWidget:SetData(function()
    self:OnBackBtnOnClick()
  end, function(petID)
    self:OnChoosePetFinish(petID)
  end)
end

function UISeasonMazeRoom_DirectionalRecruit:GetPets()
end

function UISeasonMazeRoom_DirectionalRecruit:LoadDataOnEnter(TT, res, uiParams)
  res:SetSucc(true)
end

function UISeasonMazeRoom_DirectionalRecruit:OnUISeasonMazeAttChanged()
end

function UISeasonMazeRoom_DirectionalRecruit:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
end

function UISeasonMazeRoom_DirectionalRecruit:OnBackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end

function UISeasonMazeRoom_DirectionalRecruit:ReqSelectProp(color)
  self:Lock("UISeasonMazeRoom_DirectionalRecruit:ReqSelectProp")
  GameGlobal.TaskManager():StartTask(self.TaskReqSelectProp, self, color)
end

function UISeasonMazeRoom_DirectionalRecruit:TaskReqSelectProp(TT, color)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeRecruitRoomSelectProp(TT, res, color)
  self:UnLock("UISeasonMazeRoom_DirectionalRecruit:ReqSelectProp")
  if res:GetSucc() then
    local randomPetIDList = response.cur_pets
    local selectedPet = response.select_pet
    if 0 < #randomPetIDList then
      self._colorChoosed = true
      self:SwitchState()
    else
      self._colorChoosed = false
      local tips = StringTable.Get("str_season_maze_room_recruit_choose_color_tips2")
      ToastManager.ShowToast(tips)
      return
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_DirectionalRecruit] HandleSeasonMazeRecruitRoomSelectProp fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_DirectionalRecruit:OnChoosePetFinish(petID)
  self:OnHideUI(petID)
  do return end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(3000, function()
    self:OnHideUI(petID)
  end)
end

function UISeasonMazeRoom_DirectionalRecruit:OnExit()
  local msgStr = StringTable.Get("str_season_maze_room_recruit_exit_tips")
  UISeasonMazeModule.PopMsgBox(nil, msgStr, SeasonMazeMsgBoxType.OkCancel, function()
    self:OnHideUI()
  end)
end
