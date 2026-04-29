_class("UIRugueLikeRestRoomController", UIController)
UIRugueLikeRestRoomController = UIRugueLikeRestRoomController

function UIRugueLikeRestRoomController:OnShow(uiParam)
  self._roomInfo = uiParam[1]
  self._isLife = 0
  self._rested = false
  self._rest_pets = {}
  if self._roomInfo == nil then
    Log.fatal("[error] maze --> _roomInfo == nil !")
    return
  end
  self._module = GameGlobal.GetModule(MazeModule)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._original = Vector2(0, 300)
  self.powerAddValue = 0
  self:GetComponents()
  self:OnValue()
end

function UIRugueLikeRestRoomController:OnHide()
  if self._tweener and self._tweener:IsPlaying() then
    self._tweener:Kill()
  end
  self._tweener = nil
end

function UIRugueLikeRestRoomController:GetComponents()
  self._toastRootHp = self:GetUIComponent("RectTransform", "toastHp")
  self._toastTextHp = self:GetUIComponent("UILocalizationText", "toastMsgHp")
  self._toastRootPower = self:GetUIComponent("RectTransform", "toastPower")
  self._toastTextPower = self:GetUIComponent("UILocalizationText", "toastMsgPower")
  self._toastPowerIcon = self:GetUIComponent("Image", "toastIcon")
  self._videoPlayer = self:GetUIComponent("VideoPlayer", "video")
  self._lifeTex = self:GetUIComponent("UILocalizationText", "lifeTex")
  self._relpyTex = self:GetUIComponent("UILocalizationText", "relpyTex")
end

function UIRugueLikeRestRoomController:OnValue()
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._toastPowerIcon.sprite = atlas:GetSprite(Cfg.cfg_top_tips[RoleAssetID.RoleAssetLight].Icon)
  local roomid = self._roomInfo.room_id
  local cfg_rest_room = Cfg.cfg_maze_room[roomid]
  if cfg_rest_room then
    local hpTex = cfg_rest_room.Param[1]
    local petCountTex = cfg_rest_room.Param[4]
    local replyMS = cfg_rest_room.Param[2]
    self._relpyTex:SetText(StringTable.Get("str_maze_rest_room_btn_tex_health", petCountTex, hpTex) .. "\n" .. StringTable.Get("str_maze_rest_room_btn_tex_light", replyMS))
    local lifeCount = cfg_rest_room.Param[5]
    self._lifeTex:SetText(StringTable.Get("str_maze_rest_room_btn_tex_life", lifeCount) .. "\n" .. StringTable.Get("str_maze_rest_room_btn_tex_light", replyMS))
  else
    Log.fatal("###[Maze] 进入了休息室，cfg_maze_room is nil ! id - ", roomid)
  end
  self._timeLine = EZTL_Sequence:New({
    EZTL_Callback:New(function()
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundLevelUp)
      self:PlayVideo()
    end, "播视频"),
    EZTL_Wait:New(1000, "等1秒刷新路点"),
    EZTL_Callback:New(function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPassRestRoom)
    end, "发消息，刷新路点"),
    EZTL_Wait:New(2100, "再等2.1秒视频播完"),
    EZTL_Callback:New(function()
      self:StopVideo()
      local textContentPower = StringTable.Get("str_maze_rest_room_reply_power") .. self.powerAddValue
      self._toastRootPower.gameObject:SetActive(true)
      self._toastRootPower.anchoredPosition = self._original
      self._toastTextPower:SetText(textContentPower)
      self._toastRootPower.transform:DOLocalMoveY(self._toastRootPower.transform.localPosition.y + 100, 1.5):OnComplete(function()
      end)
    end, "弹toast"),
    EZTL_Wait:New(500, "再等0.5秒再谈一个"),
    EZTL_Callback:New(function()
      local textContentPower = ""
      if self._isLife == 2 then
        if self._rest_pets and #self._rest_pets > 0 then
          local showStr = ""
          for i = 1, #self._rest_pets do
            local pstid = self._rest_pets[i]
            local pet = self._petModule:GetPet(pstid)
            local petName = pet:GetPetName()
            if i == 1 then
              showStr = StringTable.Get(petName)
            elseif i == #self._rest_pets then
              showStr = StringTable.Get("str_maze_rest_room_show_tex_and", showStr, StringTable.Get(petName))
            else
              showStr = StringTable.Get("str_maze_rest_room_show_tex_append_point", showStr, StringTable.Get(petName))
            end
          end
          textContentPower = StringTable.Get("str_maze_rest_room_show_tex_reply", showStr)
        else
          textContentPower = StringTable.Get("str_maze_rest_room_all_pet_full_hp")
        end
      elseif self._rest_pets and #self._rest_pets > 0 then
        local showStr = ""
        for i = 1, #self._rest_pets do
          local pstid = self._rest_pets[i]
          local pet = self._petModule:GetPet(pstid)
          local petName = pet:GetPetName()
          if i == 1 then
            showStr = StringTable.Get(petName)
          elseif i == #self._rest_pets then
            showStr = StringTable.Get("str_maze_rest_room_show_tex_and", showStr, StringTable.Get(petName))
          else
            showStr = StringTable.Get("str_maze_rest_room_show_tex_append_point", showStr, StringTable.Get(petName))
          end
        end
        textContentPower = StringTable.Get("str_maze_rest_room_show_tex_life", showStr)
      end
      self._toastRootHp.gameObject:SetActive(true)
      self._toastRootHp.anchoredPosition = self._original - Vector2(0, 100)
      self._toastTextHp:SetText(textContentPower)
      self._toastRootHp.transform:DOLocalMoveY(self._toastRootHp.transform.localPosition.y + 100, 1.5):OnComplete(function()
      end)
    end, "弹toast"),
    EZTL_Wait:New(2000, "等toast,看清楚是复活还是恢复"),
    EZTL_Callback:New(function()
      self:UnLock(self:GetName())
      self:CloseDialog()
    end, "关闭界面")
  }, "休息室动画")
end

function UIRugueLikeRestRoomController:RequestRest(TT, roomIndex)
  local param
  if self._isLife == 0 then
    Log.fatal("###休息信息不对，islife为0")
    self:LockBusy(false)
    return
  elseif self._isLife == 1 then
    param = true
  elseif self._isLife == 2 then
    param = false
  end
  local res, msg = self._module:RequestEnterRoom(TT, roomIndex, param)
  self:SetShowBusy(false)
  if res:GetSucc() then
    Log.notice("###UIRugueLikeRestRoomController:LifeBtnOnClick--reply")
    self.powerAddValue = msg.add_light
    self._rest_pets = msg.effect_pstid
    self._timeLine:Start()
    self._rested = true
  else
    Log.fatal("###休息失败，错误代码：", res:GetResult())
  end
end

function UIRugueLikeRestRoomController:OnUpdate(deltaTimeMS)
  if not self._timeLine:Over() then
    self._timeLine:Update(deltaTimeMS)
  end
end

function UIRugueLikeRestRoomController:PlayVideo()
  local url = ResourceManager:GetInstance():GetAssetPath("mijing_xiuxishi.mp4", LoadType.VideoClip)
  self._videoPlayer.gameObject:SetActive(true)
  self._videoPlayer.url = url
  self._videoPlayer.targetCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._videoPlayer:Play()
end

function UIRugueLikeRestRoomController:StopVideo()
  self._videoPlayer.gameObject:SetActive(false)
end

function UIRugueLikeRestRoomController:LifeBtnOnClick()
  if self._rested then
    Log.notice("###UIRugueLikeRestRoomController:LifeBtnOnClick--rested")
    return
  end
  Log.notice("###UIRugueLikeRestRoomController:LifeBtnOnClick--task")
  local hasDie = false
  local petModule = self:GetModule(PetModule)
  local pets = petModule:GetPets()
  if pets and table.count(pets) > 0 then
    for key, value in pairs(pets) do
      local pet = value
      local pstid = pet:GetPstID()
      local mazePetInfo = self._module:GetMazePetInfoByPstId(pstid)
      if mazePetInfo.is_dead then
        hasDie = true
        break
      end
    end
    if hasDie then
      self._isLife = 1
      self:LockBusy(true)
      GameGlobal.TaskManager():StartTask(self.RequestRest, self, self._roomInfo.room_index)
    else
      ToastManager.ShowToast(StringTable.Get("str_maze_rest_room_has_not_pet_die"))
    end
  end
end

function UIRugueLikeRestRoomController:ReplyBtnOnClick()
  if self._rested then
    return
  end
  self._isLife = 2
  self:LockBusy(true)
  GameGlobal.TaskManager():StartTask(self.RequestRest, self, self._roomInfo.room_index)
end

function UIRugueLikeRestRoomController:LockBusy(isLock)
  if isLock then
    self:Lock(self:GetName())
    self:SetShowBusy(true)
  else
    self:UnLock(self:GetName())
    self:SetShowBusy(false)
  end
end

function UIRugueLikeRestRoomController:BtnOnClickByParam(nParam)
  if 1 == nParam then
    self:ReplyBtnOnClick()
  elseif 2 == nParam then
    self:LifeBtnOnClick()
  end
end
