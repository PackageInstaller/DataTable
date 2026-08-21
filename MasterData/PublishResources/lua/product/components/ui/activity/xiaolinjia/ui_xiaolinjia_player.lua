_class("UIXiaoLinJiaPlayer", Object)
UIXiaoLinJiaPlayer = UIXiaoLinJiaPlayer

function UIXiaoLinJiaPlayer:Constructor(uiView, owner, atlas, index)
  self._uiView = uiView
  self._owner = owner
  self._atlas = atlas
  self._index = index
  self.icon = self._uiView:GetUIComponent("Image", "icon")
  self.text = self._uiView:GetUIComponent("UILocalizationText", "text")
  self.dialogRoot = self._uiView:GetGameObject("dialog")
  self.answering = self._uiView:GetGameObject("answering")
  self.bgImage = self._uiView:GetUIComponent("Image", "bg")
  self.bg1 = self._uiView:GetGameObject("bg1")
  self.bg2 = self._uiView:GetGameObject("bg2")
  self.bgImg1 = self._uiView:GetUIComponent("Image", "bg1")
  self.bgImg2 = self._uiView:GetUIComponent("Image", "bg2")
  self.dialogBGImage = self._uiView:GetUIComponent("Image", "dialogBG")
  self.anim = self._uiView:GetUIComponent("Animation", "anim")
  self.isSelectOption = false
  self.selectBGColorMap = {
    [1] = self.bg2,
    [2] = self.bg1
  }
  self.AnimInTimeStr = {
    [1] = 60,
    [2] = 120,
    [3] = 240,
    [4] = 180
  }
  local animStrL = {
    [1] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_in_L",
    [2] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_loop_L",
    [3] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_out_L",
    [4] = "uieffanim_UIXiaoLinJiaStoryController_player_in_L",
    [5] = "uieffanim_UIXiaoLinJiaStoryController_player_out_L",
    [6] = "uieffanim_UIXiaoLinJiaStoryController_player_dialog_in_L"
  }
  local animStrR = {
    [1] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_in_R",
    [2] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_loop_R",
    [3] = "uieffanim_UIXiaoLinJiaStoryController_player_answering_out_R",
    [4] = "uieffanim_UIXiaoLinJiaStoryController_player_in_R",
    [5] = "uieffanim_UIXiaoLinJiaStoryController_player_out_R",
    [6] = "uieffanim_UIXiaoLinJiaStoryController_player_dialog_in_R"
  }
  self.colorAnimStr = "uieffanim_UIXiaoLinJiaStoryController_player_color"
  local left = self._index == 1 or self._index == 3
  self.animStr = left and animStrL or animStrR
  GameGlobal.UIStateManager():Lock("UIXiaoLinJiaPlayer_AnimIn" .. self._index)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, self.AnimInTimeStr[self._index])
    self._uiView:GetGameObject():SetActive(true)
    self.anim:Play(self.animStr[4])
    GameGlobal.UIStateManager():UnLock("UIXiaoLinJiaPlayer_AnimIn" .. self._index)
  end)
end

function UIXiaoLinJiaPlayer:SetFaceIcon(icon)
  self.icon.sprite = self._atlas:GetSprite(icon)
end

function UIXiaoLinJiaPlayer:SetSpeakContent(content, contentBG)
  if content then
    self.text:SetText(content)
    self.dialogBGImage.sprite = self._atlas:GetSprite(contentBG)
    self:ShowDialog(true)
    self:ShowDialogAnim(true)
  else
    self:ShowDialog(false)
  end
end

function UIXiaoLinJiaPlayer:ShowDialogAnim(flag)
  if flag then
    self.anim:Play(self.animStr[6])
  else
    self.anim:Play(self.animStr[5])
  end
end

function UIXiaoLinJiaPlayer:ShowDialog(flag)
  self.dialogRoot:SetActive(flag)
end

function UIXiaoLinJiaPlayer:ChangeToSelectBG()
  self.selectBGColorMap[self.selectIndex]:SetActive(true)
  self.anim:Play(self.colorAnimStr)
  self.colorTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 333)
    self.bgImg1.color = Color(1, 1, 1, 1)
    self.bgImg2.color = Color(1, 1, 1, 1)
    self.colorTask = nil
  end)
end

function UIXiaoLinJiaPlayer:ResetSelectBG()
  self.bg1:SetActive(false)
  self.bg2:SetActive(false)
end

function UIXiaoLinJiaPlayer:IsFinishSelect()
  return self.isSelectOption
end

function UIXiaoLinJiaPlayer:SetPlayerSelect(selectIndex)
  self.selectIndex = selectIndex
end

function UIXiaoLinJiaPlayer:DoSelectingAnim()
  self.isSelectOption = false
  self.answering:SetActive(true)
  self.anim:Play(self.animStr[1])
  local waitTime = math.random(1, 3) * 1000
  waitTime = 1167 < waitTime and waitTime or 1167
  local leastTime = waitTime - 1167
  self.selectTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, waitTime)
    if not tolua.isnull(self.anim) then
      self.anim:Play(self.animStr[2])
    end
    YIELD(TT, leastTime)
    if not tolua.isnull(self.anim) then
      self.anim:Play(self.animStr[3])
    end
    YIELD(TT, 200)
    self.isSelectOption = true
    if not tolua.isnull(self.answering) then
      self.answering:SetActive(false)
    end
    self.selectTask = nil
  end)
end

function UIXiaoLinJiaPlayer:OnDispose()
  if self.selectTask then
    GameGlobal.TaskManager():KillTask(self.selectTask)
    self.selectTask = nil
  end
  if self.colorTask then
    GameGlobal.TaskManager():KillTask(self.colorTask)
    self.colorTask = nil
  end
end
