local UIEpRoom = class("UIEpRoom", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local CS_Tweening = CS.DG.Tweening
local CS_CameraController = CS.CameraController
local fadeTweenDuration = 0.5

function UIEpRoom:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_EpRoom, self, self.OnRoomClicked)
  self.ui.tex_power.text = ""
  self.ui.img_Danger.gameObject:SetActive(false)
end

function UIEpRoom:GetRoomSize()
  return self.transform.sizeDelta
end

function UIEpRoom:InitRoomUI(roomData, resloader)
  self.resloader = resloader
  self:__InitRoomUIBase(roomData)
  self:__InitRoomTag(roomData.tagData)
  self:ResetRoomDefaultUI()
end

function UIEpRoom:InitRoomUIMidway(roomData, eRoomState, withTween, isAutoPath)
  self:__InitRoomUIBase(roomData)
  self:ChangeUIState(eRoomState, withTween, isAutoPath)
end

function UIEpRoom:__InitRoomUIBase(roomData)
  self.roomData = roomData
  self.roomType = roomData:GetRoomType(true)
  local roomTypeCfg = ConfigData.exploration_roomtype[self.roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(self.roomType))
    return
  end
  self.roomTypeCfg = roomTypeCfg
  self:__SetRoomBaseInfo()
  self:__UpdateRoomUI()
end

function UIEpRoom:__InitRoomTag(tagData)
  self.ui.obj_tag:SetActive(false)
  if tagData == nil then
    return
  end
  local tagCfg = ConfigData.room_label[tagData.tagId]
  if tagCfg == nil then
    return
  end
  if tagCfg.show_type == 1 then
    self.ui.obj_tag:SetActive(true)
    self.ui.text_tag.text = LanguageUtil.GetLocaleText(tagCfg.name)
    self.ui.text_tag.color = self.ui.color_tag[tagCfg.type + 1]
  end
end

function UIEpRoom:__SetRoomBaseInfo()
  local iconSprite = CRH:GetSprite(self.roomTypeCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.img_RoomIcon.sprite = iconSprite
  self.ui.img_RoomIconSD.sprite = iconSprite
  self.ui.tex_Tile.text = LanguageUtil.GetLocaleText(self.roomTypeCfg.title)
  self.ui.crossNode:SetActive(self.roomData:IsCrossRoom())
end

function UIEpRoom:__UpdateRoomUI()
  local colorCfg = self.roomTypeCfg.color
  local color = Color.New(colorCfg[1], colorCfg[2], colorCfg[3])
  self:SetRoomColor(color)
end

function UIEpRoom:SetRoomColor(color)
  self.ui.img_TileBG.color = color
  self.ui.img_RoomIcon.color = color
  color.a = self.ui.img_Anima.color.a
  self.ui.img_Anima.color = color
  color.a = self.ui.img_markBG.color.a
  self.ui.img_markBG.color = color
  for index, component in ipairs(self.ui.arr_CrossCols) do
    component.color = color
  end
end

function UIEpRoom:ResetRoomDefaultUI()
  self:SetSelectUIActive(false)
  self:SetRoomUIAlpha(1)
  self:SetBattleFightingActive(false)
  self.ui.normalNode.gameObject:SetActive(true)
  self.ui.completeNode.gameObject:SetActive(false)
  self.ui.stopNode:SetActive(false)
  self.ui.autoNode:SetActive(false)
  self.ui.obj_stopAlpha:SetActive(false)
end

function UIEpRoom:OnRoomClicked()
  if CS_CameraController.Instance:InDragEpMap() then
    return
  end
  if ExplorationManager:IsInEnteringRoom() then
    return
  end
  local playerCtrl = ExplorationManager.epCtrl.playerCtrl
  if playerCtrl:CheckIsEpRoomWatchingMap(self.roomData) then
    return
  end
  local autoCtrl = ExplorationManager.epCtrl.autoCtrl
  if autoCtrl:CheckAutoModeRoomClick(self.roomData) then
    return
  end
  if not self.roomData:IsCanMove() then
    return
  end
  if playerCtrl:CheckEpRoomAccess(self.roomData) then
    playerCtrl:Move(self.roomData)
  end
end

function UIEpRoom:RefreshBattleFightingPower(fightingPower, playerPower)
  if IsNull(self.gameObject) then
    return
  end
  self.ui.powerNode:SetActive(true)
  self.ui.tex_power.text = tostring(fightingPower)
  self:__ShowRoomChipPreview()
  self.ui.img_Danger.gameObject:SetActive(playerPower < fightingPower)
end

function UIEpRoom:__ShowRoomChipPreview()
  local chipPreviewIndex = self.roomData:GetRoomChipPreview()
  if chipPreviewIndex == 0 then
    self.ui.markNode:SetActive(false)
    self:ClearChipDropTween()
    return
  end
  if chipPreviewIndex <= 0 then
    self.ui.tex_MarkName.text = ""
    self.ui.img_mark.sprite = nil
    self.ui.img_markSD.sprite = nil
    return
  end
  local chipMarkCfg = ConfigData.chip_mark[chipPreviewIndex]
  if chipMarkCfg == nil then
    error("chip mark cfg is null,id:" .. tostring(chipPreviewIndex))
    return
  end
  self.ui.markNode:SetActive(true)
  self.ui.tex_MarkName.text = LanguageUtil.GetLocaleText(chipMarkCfg.name)
  local sprite = CRH:GetSprite(chipMarkCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.img_mark.sprite = sprite
  self.ui.img_markSD.sprite = sprite
end

function UIEpRoom:SetBattleFightingActive(active)
  local chipPreviewIndex = self.roomData:GetRoomChipPreview()
  self.ui.markNode:SetActive(active and 0 < chipPreviewIndex)
  self.ui.powerNode:SetActive(active)
  if active then
    local color = self.ui.img_Danger.color
    color.a = 1
    self.__dangerTween = self.ui.img_Danger:DOFade(0, 0.6):SetLoops(-1, CS_Tweening.LoopType.Yoyo):SetEase(CS_Tweening.Ease.Linear)
    self.ui.cg_markNode.alpha = 0
    self.__chipDropTween = CS_Tweening.DOTween.Sequence()
    self.__chipDropTween:Append(self.ui.cg_markNode:DOFade(1, 0.05))
    self.__chipDropTween:Append(self.ui.cg_markNode:DOFade(0, 0.05))
    self.__chipDropTween:Append(self.ui.cg_markNode:DOFade(1, 0.05))
    self.__chipDropTween:AppendCallback(function()
      self.__chipDropTween = nil
    end)
  else
    self:ClearBattleRoomTween()
  end
end

function UIEpRoom:ClearBattleRoomTween()
  if self.__dangerTween ~= nil then
    self.__dangerTween:Kill()
    self.__dangerTween = nil
  end
  self:ClearChipDropTween()
end

function UIEpRoom:ClearChipDropTween()
  if self.__chipDropTween ~= nil then
    self.__chipDropTween:Kill()
    self.__chipDropTween = nil
  end
end

function UIEpRoom:ChangeUIState(eRoomState, withTween, isAutoPath)
  self:ResetRoomDefaultUI()
  if eRoomState == ExplorationEnum.eRoomTypeState.Complete then
    if withTween then
      self:__ClearFadeTween()
      self.ui.normalNode.gameObject:SetActive(true)
      self.ui.normalNode.alpha = 1
      self.__normalNodeTween = self.ui.normalNode:DOFade(0, 0.5)
      self.ui.completeNode.gameObject:SetActive(true)
      self.ui.completeNode.alpha = 0
      self.__completeNodeTween = self.ui.completeNode:DOFade(1, 0.5)
    else
      self.ui.normalNode.gameObject:SetActive(false)
      self.ui.completeNode.gameObject:SetActive(true)
    end
  elseif eRoomState == ExplorationEnum.eRoomTypeState.CurrentStay then
  elseif eRoomState == ExplorationEnum.eRoomTypeState.AbleChoose then
    self:SetSelectUIActive(true)
    if self.roomData:IsBattleRoom() then
      self:SetBattleFightingActive(true)
    end
  elseif eRoomState == ExplorationEnum.eRoomTypeState.UnReachable then
    self:SetRoomUIAlpha(ExplorationEnum.UnReachableAlpha)
    self.ui.stopNode:SetActive(true)
  elseif eRoomState == ExplorationEnum.eRoomTypeState.CantMove then
    self:SetSelectUIActive(false)
    self.ui.stopNode:SetActive(true)
    self.ui.obj_stopAlpha:SetActive(true)
  end
  if isAutoPath then
    self.ui.autoNode:SetActive(true)
  end
end

function UIEpRoom:PlayWormholeEffect(callback)
  if self.resloader == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  UIUtil.AddOneCover("UIEpRoom")
  local effectPrefabGo = self.resloader:LoadABAsset(PathConsts:GetExplorationWormholeGoEffect())
  local effectGo = effectPrefabGo:Instantiate(self.gameObject)
  effectGo:SetActive(true)
  TimerManager:StartTimer(10, function(effect1)
    DestroyUnityObject(effect1)
    local targetPos = self.roomData:GetEpWormholeRoomTargetPos()
    local roomUI = ExplorationManager.epCtrl:GetRoomUI(targetPos)
    if roomUI == nil then
      if callback ~= nil then
        callback()
      end
      UIUtil.CloseOneCover("UIEpRoom")
      return
    end
    ExplorationManager.epCtrl.sceneCtrl.epSceneEntity:EpRoomCoverBattleMap(true, function()
      local effectPrefabIn = self.resloader:LoadABAsset(PathConsts:GetExplorationWormholeInEffect())
      local effectIn = effectPrefabIn:Instantiate(roomUI.gameObject)
      effectIn:SetActive(true)
      TimerManager:StartTimer(10, function(effect2)
        DestroyUnityObject(effect2)
        if callback ~= nil then
          callback()
        end
        UIUtil.CloseOneCover("UIEpRoom")
      end, effectIn, true, true, false)
    end, roomUI.transform.position)
  end, effectGo, true, true, false)
end

function UIEpRoom:SetRoomUIAlpha(alphaValue)
  self.ui.EpRoomAlpha.alpha = alphaValue
end

function UIEpRoom:SetSelectUIActive(active)
  self.ui.img_OnSelect:SetActive(active)
end

function UIEpRoom:SetCurrentStayActive(active)
  self.ui.img_CurrRoom:SetActive(active)
end

function UIEpRoom:__ClearFadeTween()
  if self.__normalNodeTween ~= nil then
    self.__normalNodeTween:Kill()
    self.__normalNodeTween = nil
  end
  if self.__completeNodeTween ~= nil then
    self.__completeNodeTween:Kill()
    self.__completeNodeTween = nil
  end
end

function UIEpRoom:OnDelete()
  self:ClearBattleRoomTween()
  self:__ClearFadeTween()
  self.resloader = nil
  base.OnDelete(self)
end

return UIEpRoom
