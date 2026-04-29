_class("UIActivityN33DatePetController", UIController)
UIActivityN33DatePetController = UIActivityN33DatePetController

function UIActivityN33DatePetController:LoadDataOnEnter(TT, res, uiParams)
  self._allRead = false
end

function UIActivityN33DatePetController:OnShow(uiParams)
  self._cfg = uiParams[1]
  self._activityConst = uiParams[2]
  self:AttackEvent()
  self:_GetComponent()
  self:_Init()
  self:_CheckGuide()
end

function UIActivityN33DatePetController:AttackEvent()
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIActivityN33DatePetController:_GetComponent()
  self._petImg = self:GetUIComponent("RawImageLoader", "petImg")
  self._talkInfo = self:GetUIComponent("UILocalizationText", "talkInfo")
  self._building = self:GetUIComponent("UISelectObjectPath", "building")
  self._petName = self:GetUIComponent("UILocalizationText", "petName")
  self._petInfo = self:GetUIComponent("UILocalizationText", "petInfo")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._inviteMaskObj = self:GetGameObject("inviteMask")
  self._inviteObj = self:GetGameObject("Invite")
end

function UIActivityN33DatePetController:Refresh()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnInviteEventEnd)
end

function UIActivityN33DatePetController:_Init()
  self._petImg:LoadImage(self._cfg.PetImg)
  local randomNum = math.random(1, #self._cfg.TalkID)
  local talkInfoTxt = Cfg.cfg_n33_date_talk[self._cfg.TalkID[randomNum]].TalkTxt
  self._talkInfo:SetText(StringTable.Get(talkInfoTxt))
  local petName = Cfg.cfg_pet[self._cfg.PetId].Name
  self._petName:SetText(StringTable.Get(petName))
  self._petInfo:SetText(StringTable.Get(self._cfg.DateIntro))
  self._buildContent = self._building:SpawnObject("UIActivityN33DateManuaBuildContent")
  local cfgs = self._activityConst:GetDatePetList()[self._cfg.PetId]
  self._buildContent:SetData(cfgs, self._activityConst, false, function()
    self:CloseDialog()
  end)
  for i, v in pairs(cfgs) do
    if 2 < i then
      self._allRead = true
      break
    end
    if self._activityConst:CheckStoryConditionIsOver(v.ID) and not self._activityConst:CheckStoryIsRead(v.ID) then
      self._canReadCfg = v
      break
    end
  end
  self._inviteObj:SetActive(not self._allRead)
  self._inviteMaskObj:SetActive(not self._canReadCfg)
end

function UIActivityN33DatePetController:SubmitSimulationOperationStory(TT)
  local comp = self._activityConst:GetComponent()
  local archId = 1
  local cfgs = Cfg.cfg_component_simulation_operation({})
  for _, cfg in pairs(cfgs) do
    if table.icontains(cfg.StoryList, self._cfg.ID) then
      archId = cfg.ArchitectureId
      break
    end
  end
  local res = AsyncRequestRes:New()
  local ret, rewards = comp:HandleSubmitSimulationOperationStory(TT, res, archId, self._cfg.ID, false)
  if res:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards, function()
      self:Refresh()
    end)
  else
    Log.fatal("剧情完成失败")
  end
end

function UIActivityN33DatePetController:InviteBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  if self._allRead then
    return
  end
  if self._canReadCfg then
    self:StartTask(self._CloseAnim, self, function()
      self:ShowDialog("UIActivityN33DateInviteController", self._canReadCfg, true, function()
        self:StartTask(self.SubmitSimulationOperationStory, self)
      end)
    end)
  else
    ToastManager.ShowToast(StringTable.Get("不满足条件，无法开启邀约"))
  end
end

function UIActivityN33DatePetController:_ShowTips(itemId, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(itemId, pos)
end

function UIActivityN33DatePetController:BackBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:StartTask(self._CloseAnim, self)
end

function UIActivityN33DatePetController:_CloseAnim(TT, callback)
  self._anim:Play("uieffanim_UIActivityN33DatePetController_out")
  self:Lock("uieffanim_UIActivityN33DatePetController_out")
  YIELD(TT, 334)
  self:UnLock("uieffanim_UIActivityN33DatePetController_out")
  if callback then
    callback()
  end
  self:CloseDialog()
end

function UIActivityN33DatePetController:_CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(123007) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33DatePetController)
  end
end
