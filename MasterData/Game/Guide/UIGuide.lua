local UIGuide = class("UIGuide", UIBaseWindow)
local base = UIBaseWindow
local GuideEnum = require("Game.Guide.GuideEnum")

function UIGuide:OnInit()
  self.__permanent = true
  self.smallDialogSize = self.ui.smallDialogNode.sizeDelta
  self.talkDialogNode = self.ui.talkDialogNode.sizeDelta
  self.talkContentNodeSize = self.ui.talkContentNode.sizeDelta
  self.__specialShowType = GuideEnum.SpecialGuideShowType.None
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.OnBtnContinueClicked)
  UIUtil.AddButtonListener(self.ui.btn_SkipGuide, self, self.OnSkipClicked)
  self.__onScreenSizeChangedEvent = BindCallback(self, self.__OnScreenSizeChanged)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__onScreenSizeChangedEvent)
end

function UIGuide:SetWaitMaskActive(active)
  self.ui.waitMask:SetActive(active)
end

function UIGuide:PlayGuide(rectTransform, camera, custom_size)
  if custom_size ~= nil and #custom_size == 2 then
    return self.ui.maskOperate:Play(rectTransform, camera, custom_size[1], custom_size[2])
  end
  return self.ui.maskOperate:Play(rectTransform, camera)
end

function UIGuide:PlayGuideCollider(boxCollider, camera, custom_size)
  if custom_size ~= nil and #custom_size == 2 then
    return self.ui.maskOperate:PlayCollider(boxCollider, camera, custom_size[1], custom_size[2])
  end
  return self.ui.maskOperate:PlayCollider(boxCollider, camera)
end

function UIGuide:PlayGuideCustome(screenPoint, screenSize)
  return self.ui.maskOperate:PlayCustome(screenPoint, screenSize)
end

function UIGuide:ShowGuideAniInfo(info, info_type, info_pos, isFirst, step_type, arrow_offset)
  local position = self.ui.maskOperate.targetArea.anchoredPosition
  local sizeDelta = self.ui.maskOperate.targetArea.sizeDelta
  local sizeDeltaMax = (sizeDelta.x + sizeDelta.y) / 1.8
  local fitSize = math.clamp(sizeDeltaMax, self.ui.arrowNodeMin, self.ui.arrowNodeMax)
  local fitSizeDelta = Vector2.New(fitSize, fitSize)
  if step_type == GuideEnum.StepType.Operate then
    local pos = position
    if arrow_offset ~= nil and 2 <= #arrow_offset then
      pos = pos + Vector2.Temp(arrow_offset[1], arrow_offset[2])
    end
    self.ui.arrowNode.transform.anchoredPosition = pos
    self.ui.arrowNode.transform.sizeDelta = fitSizeDelta
    if isFirst then
      self.ui.arrowNode.gameObject:SetActive(true)
      self.ui.ani_TargetArea.gameObject:SetActive(true)
      self.ui.ani_TargetArea.transform.sizeDelta = fitSizeDelta - self.ui.ani_TargetArea.endValueV2
      self.ui.ani_TargetArea:DORestart(true)
    end
  elseif isFirst then
    self.ui.arrowNode.gameObject:SetActive(false)
  end
  if string.IsNullOrEmpty(info) then
    return
  end
  local offsetRatio
  if position.x <= 0 and position.y >= 0 then
    offsetRatio = Vector2.New(1, -1)
  elseif position.x <= 0 and position.y <= 0 then
    offsetRatio = Vector2.New(1, 1)
  elseif position.x >= 0 and position.y <= 0 then
    offsetRatio = Vector2.New(-1, 1)
  else
    offsetRatio = Vector2.New(-1, -1)
  end
  local arrowOffset = sizeDelta / 2 * offsetRatio
  local height = UIManager.BackgroundStretchSize.y / 4
  if position.y <= -height then
    arrowOffset.y = arrowOffset.y + self.talkContentNodeSize.y + 10
  end
  if 0 < info_type then
    self:ShowHeroSmallTalk(info, info_type, info_pos, position, arrowOffset, offsetRatio)
  else
    self:ShowSmallDialogNode(info, position, arrowOffset, offsetRatio)
  end
end

function UIGuide:ShowSmallDialogNode(info, position, arrowOffset, offsetRatio)
  if string.IsNullOrEmpty(info) then
    return
  end
  local dialogOffset = arrowOffset + Vector2.New((self.smallDialogSize.x / 2 + self.ui.arrowDialogOffset.x) * offsetRatio.x, self.ui.arrowDialogOffset.y * offsetRatio.y)
  self.ui.smallDialogNode.anchoredPosition = position + dialogOffset
  self.ui.smallDialogNode.gameObject:SetActive(true)
  self.ui.tex_SmallDialog.text = info
end

function UIGuide:HideSmallDialogNode()
  self.ui.smallDialogNode.gameObject:SetActive(false)
end

function UIGuide:_LoadHeroSprite(info_type, img)
  local heroCfg = ConfigData.hero_data[info_type]
  if heroCfg ~= nil then
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if itemCfg ~= nil then
      img.sprite = CRH:GetSpriteByItemConfig(itemCfg)
      return
    end
  end
  if info_type == 1 then
    local isGirl = PlayerDataCenter.inforData:GetSex()
    local headId
    if isGirl then
      headId = ConstGlobalItem.ProfessorGridHead
    else
      headId = ConstGlobalItem.ProfessorBodyHead
    end
    local cfg = ConfigData.portrait[headId]
    if cfg == nil then
      return
    end
    local icon = cfg.icon
    if not string.IsNullOrEmpty(icon) then
      img.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
    end
  end
end

function UIGuide:ShowHeroSmallTalk(info, info_type, info_pos, position, arrowOffset, offsetRatio)
  if string.IsNullOrEmpty(info) then
    return
  end
  self.ui.tex_TalkDialog.text = tostring(info)
  self:_LoadHeroSprite(info_type, self.ui.img_TalkHeroPic)
  if not string.IsNullOrEmpty(info_pos) then
    local childNode = self.ui.talkDialogPosGroup:Find(info_pos)
    if not IsNull(childNode) then
      self.ui.talkDialogNode.localPosition = childNode.localPosition
    end
  else
    position = Vector3.New(position.x, position.y, 0)
    if offsetRatio == nil then
      if position.x <= 0 and position.y >= 0 then
        offsetRatio = Vector2.New(1, -1)
      elseif position.x <= 0 and position.y <= 0 then
        offsetRatio = Vector2.New(1, 1)
      elseif position.x >= 0 and position.y <= 0 then
        offsetRatio = Vector2.New(-1, 1)
      else
        offsetRatio = Vector2.New(-1, -1)
      end
    end
    if arrowOffset == nil then
      arrowOffset = Vector2.zero
    end
    local xOffset = 0
    if offsetRatio.x < 0 then
      xOffset = self.talkDialogNode.x / 2 + self.talkContentNodeSize.x
    else
      xOffset = self.talkDialogNode.x / 2
    end
    local posX = position.x + (self.talkDialogNode.x + self.talkContentNodeSize.x + self.ui.arrowDialogOffset.x) * offsetRatio.x + arrowOffset.x
    if math.abs(posX) > UIManager.BackgroundStretchSize.x / 2 then
      arrowOffset.x = 0
      arrowOffset.y = arrowOffset.y + self.talkDialogNode.y * offsetRatio.y
    end
    local dialogOffset = arrowOffset + Vector2.New((xOffset + self.ui.arrowDialogOffset.x) * offsetRatio.x, self.ui.arrowDialogOffset.y * offsetRatio.y)
    self.ui.talkDialogNode.anchoredPosition = position + Vector3.New(dialogOffset.x, dialogOffset.y, 0)
  end
  self.ui.talkDialogNode.gameObject:SetActive(true)
end

function UIGuide:HideHeroTalkDialog()
  self.ui.talkDialogNode.gameObject:SetActive(false)
end

function UIGuide:ShowGuideLargeDialog(info, info_type, info_pos, nextAction)
  self.ui.panelDialog:SetActive(true)
  self.ui.tex_LargeDialog.text = nil
  if string.IsNullOrEmpty(info) then
    info = ""
  end
  self:__ShowBigHeroPic(info_type, info_pos)
  self.ui.tween_txt_LargeDialog.tween:ChangeEndValue(info, true)
  self.ui.tween_txt_LargeDialog:DORestart()
  self.nextAction = nextAction
  self.step_type = GuideEnum.StepType.LargeDialog
  self.ui.btn_Continue.gameObject:SetActive(true)
end

function UIGuide:ShowGuideHeroSmallTalk(info, info_type, info_pos, nextAction)
  if string.IsNullOrEmpty(info) then
    info = ""
  end
  self.ui.tex_TalkDialog.text = tostring(info)
  self:_LoadHeroSprite(info_type, self.ui.img_TalkHeroPic)
  if not string.IsNullOrEmpty(info_pos) then
    local childNode = self.ui.talkDialogPosGroup:Find(info_pos)
    if not IsNull(childNode) then
      self.ui.talkDialogNode.localPosition = childNode.localPosition
    end
  end
  self.ui.talkDialogNode.gameObject:SetActive(true)
  self.nextAction = nextAction
  self.step_type = GuideEnum.StepType.HeroSmallTalk
  self.ui.btn_Continue.gameObject:SetActive(true)
end

function UIGuide:__ShowBigHeroPic(info_type, info_pos)
  info_type = info_type or 0
  if 0 < info_type then
    if self.__lastBigImgHeroId == info_type then
      if not IsNull(self.__lastBigImgHeroId) then
        local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
        commonPicCtrl:SetPosType(info_pos)
      end
      return
    end
    self.__lastBigImgHeroId = info_type
    local heroCfg = ConfigData.hero_data[info_type]
    if heroCfg ~= nil then
      local resCfg = heroCfg:GetHeroResCfg()
      if resCfg ~= nil then
        if self.bigImgResloader ~= nil then
          self.bigImgResloader:Put2Pool()
        end
        self.bigImgResloader = CS.ResLoader.Create()
        DestroyUnityObject(self.bigImgGameObject)
        self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name), function(prefab)
          if self.__lastBigImgHeroId ~= info_type then
            return
          end
          DestroyUnityObject(self.bigImgGameObject)
          self.bigImgGameObject = prefab:Instantiate(self.ui.herolPicNode)
          local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
          commonPicCtrl:SetPosType(info_pos)
        end)
      end
    end
  else
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
      self.bigImgResloader = nil
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.__lastBigImgHeroId = nil
  end
end

function UIGuide:BindContinueBtnEvent(nextAction, step_type)
  self.nextAction = nextAction
  self.step_type = step_type
  self.ui.btn_Continue.gameObject:SetActive(true)
end

function UIGuide:OnBtnContinueClicked()
  if self.step_type == GuideEnum.StepType.LargeDialog then
    local isPlaying = self.ui.tween_txt_LargeDialog.tween:IsPlaying()
    if isPlaying then
      self.ui.tween_txt_LargeDialog:DOComplete()
    elseif self.nextAction ~= nil then
      self.nextAction()
    end
  elseif self.step_type == GuideEnum.StepType.HeroSmallTalk then
    if self.nextAction ~= nil then
      self.nextAction()
    end
  elseif self.step_type == GuideEnum.StepType.Highlight and self.nextAction ~= nil then
    self.nextAction()
  end
end

function UIGuide:BindGuideSkipEvent(skipEvent)
  self.__skipEvent = skipEvent
end

function UIGuide:OnSkipClicked()
  if self.__skipEvent ~= nil then
    self.__skipEvent()
  end
end

function UIGuide:SetSkipButtonActive(bool)
  self.ui.btn_SkipGuide.gameObject:SetActive(bool)
end

function UIGuide:CloseGuide(step_type)
  if step_type == GuideEnum.StepType.LargeDialog then
    self.ui.panelDialog:SetActive(false)
  elseif step_type == GuideEnum.StepType.Operate or step_type == GuideEnum.StepType.Highlight then
    self.ui.maskOperate:Close()
    self:HideSmallDialogNode()
    self:HideHeroTalkDialog()
  elseif step_type == GuideEnum.StepType.HeroSmallTalk then
    self.ui.talkDialogNode.gameObject:SetActive(false)
  end
  self.ui.btn_Continue.gameObject:SetActive(false)
  self.nextAction = nil
  self.step_type = nil
end

function UIGuide:PlaySlideGuide(startUIPos, endUIPos)
  self.__specialShowType = GuideEnum.SpecialGuideShowType.SlideGuide
  local lineSizeDelta = self.ui.img_SlideLine.transform.sizeDelta
  lineSizeDelta.x = Vector3.Distance(startUIPos, endUIPos)
  self.ui.img_SlideLine.transform.sizeDelta = lineSizeDelta
  self.ui.img_SlideLine.transform.localPosition = startUIPos
  local angle = CS.UnityEngine.Mathf.Atan2(endUIPos.y - startUIPos.y, endUIPos.x - startUIPos.x) * CS.UnityEngine.Mathf.Rad2Deg
  self.ui.img_SlideLine.transform.localEulerAngles = Vector3.New(0, 0, angle)
  local offsetY = self.ui.img_SlideArrows.transform.sizeDelta.y / 4
  startUIPos.y = startUIPos.y - offsetY
  endUIPos.y = endUIPos.y - offsetY
  self.ui.slideNode:SetActive(true)
  self.ui.img_SlideArrows.transform.localPosition = startUIPos
  self.ui.img_SlideArrows.tween:ChangeEndValue(Vector3.unity_vector3(endUIPos.x, endUIPos.y, 0), true)
  self.ui.img_SlideArrows:DORestart(true)
end

function UIGuide:EndSlideGuide()
  self.ui.slideNode:SetActive(false)
  if self.__specialShowType == GuideEnum.SpecialGuideShowType.SlideGuide then
    self.__specRefreshEvent = nil
    TimerManager:StopTimer(self.__opRefreshTimerId)
    self.__specialShowType = GuideEnum.SpecialGuideShowType.None
  end
end

function UIGuide:PlayHandClickGuide(startUIPos)
  self.__specialShowType = GuideEnum.SpecialGuideShowType.HandClick
  self.ui.handClick.transform.localPosition = Vector3.New(startUIPos.x, startUIPos.y, 0)
  self.ui.handClick:SetActive(true)
end

function UIGuide:EndHandClickGuide()
  self.ui.handClick:SetActive(false)
  if self.__specialShowType == GuideEnum.SpecialGuideShowType.HandClick then
    self.__specRefreshEvent = nil
    TimerManager:StopTimer(self.__opRefreshTimerId)
    self.__specialShowType = GuideEnum.SpecialGuideShowType.None
  end
end

function UIGuide:AddSpeicalGuideShowRefresh(refreshEvent)
  self.__specRefreshEvent = refreshEvent
end

function UIGuide:__OnScreenSizeChanged()
  if self.__specialShowType > 0 and self.__specRefreshEvent ~= nil then
    TimerManager:StopTimer(self.__opRefreshTimerId)
    self.__opRefreshTimerId = TimerManager:StartTimer(1, self.__specRefreshEvent, nil, false, true, true)
  end
end

function UIGuide:StartLimitGuideOpArea(rectTransform)
  self.ui.opAreaLimit.gameObject:SetActive(true)
  self.ui.opAreaLimit.targetArea = rectTransform
end

function UIGuide:EndLimitGuideOpArea()
  self.ui.opAreaLimit.gameObject:SetActive(false)
end

function UIGuide:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__onScreenSizeChangedEvent)
  self.__specRefreshEvent = nil
  TimerManager:StopTimer(self.__opRefreshTimerId)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnDelete(self)
end

return UIGuide
