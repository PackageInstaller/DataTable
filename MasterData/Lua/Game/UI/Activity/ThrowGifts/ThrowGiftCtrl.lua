local ThrowGiftCtrl = class("ThrowGiftCtrl", BaseCtrl)
local rootPath = "UI_Activity/%s.prefab"
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftCtrl._mapNodeConfig = {
  TMPLevelScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_LevelScoreTitle"
  },
  PausePanel = {
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftPauseCtrl"
  },
  rtItem = {
    nCount = 2,
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftItemUseBtnCtrl"
  },
  rtLevelRoot = {sComponentName = "Transform"},
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "Map"
  },
  TMPLevelTime = {sComponentName = "TMP_Text"},
  TMPLevelScore = {sComponentName = "TMP_Text"},
  TMPTarget = {sComponentName = "TMP_Text"},
  imgItemDescBg = {sComponentName = "Animator"},
  TMPLevelTimeAdd = {sComponentName = "Animator"},
  TMPItemDescBottom = {sComponentName = "TMP_Text"},
  imgTimeBg = {},
  btnRight = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_btnRight",
    sAction = "ThrowGiftChangeViewLeft"
  },
  btnLeft = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_btnLeft",
    sAction = "ThrowGiftChangeViewRight"
  },
  rtItemSelect = {
    sCtrlName = "Game.UI.Activity.ThrowGifts.ItemSelect.ThrowGiftItemSelectCtrl"
  },
  rtSettle = {
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftSettleCtrl"
  },
  rtTargetHint = {},
  rtTargetHintAnim = {
    sNodeName = "rtTargetHint",
    sComponentName = "Animator"
  },
  TMPTargetHint = {sComponentName = "TMP_Text"},
  TMPTitleTargetHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_ThrowGifts_WinCond"
  },
  rtBuff = {nCount = 4},
  rtBuffAnim = {
    nCount = 4,
    sNodeName = "rtBuff",
    sComponentName = "Animator"
  },
  TMPBuffTime = {nCount = 4, sComponentName = "TMP_Text"},
  rtColorAnim = {sComponentName = "Animator"},
  FX_Star = {},
  FX_Snow = {}
}
ThrowGiftCtrl._mapEventConfig = {
  ThrowGift_Exit_OnClick = "OnEvent_ThrowGift_Giveup",
  ThrowGift_Restart_OnClick = "OnEvent_ThrowGift_Restart",
  ThrowGift_Continue_OnClick = "OnEvent_ThrowGift_Continue",
  ThrowGiftSettle_Exit = "OnEvent_ThrowGift_Exit",
  ThrowGiftSettle_NextLevel = "OnEvent_ThrowGift_NextLevel",
  ThrowGiftSettle_Restart = "OnEvent_ThrowGift_Restart",
  OnBtnClick_ThrowGiftItemUseBtn = "OnEvent_ThrowGiftItemUseBtn",
  OnBtnClick_ThrowGiftItemConfirmBtn = "OnEvent_ThrowGiftItemConfirmBtn"
}
ThrowGiftCtrl._mapRedDotConfig = {}

function ThrowGiftCtrl:Awake()
  self.nCurTime = 0
  self._mapNode.rtItem[1]:SetAction(1)
  self._mapNode.rtItem[2]:SetAction(2)
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.AddGamepadUINode(self._panel.sGamepadPanelName, self.tbGamepadUINode)
end

function ThrowGiftCtrl:FadeIn()
end

function ThrowGiftCtrl:FadeOut()
end

function ThrowGiftCtrl:OnEnable()
  self:SetViewBtn(0)
  self._mapNode.rtItemSelect.gameObject:SetActive(false)
  self._mapNode.imgItemDescBg.gameObject:SetActive(false)
  self._mapNode.rtSettle.gameObject:SetActive(false)
  self.nCurItem = {0, 0}
  self.tbItemIdx = {0, 0}
  self.nCurSelectItemIdx = 0
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nLevelId = param[1]
    self.nOpenTime = param[2]
  end
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", self.nLevelId)
  if mapLevelCfgData == nil then
    return
  end
  self.mapLevelCfgData = mapLevelCfgData
  local mapFloorCfgData = ConfigTable.GetData("ThrowGiftFloor", self.mapLevelCfgData.FloorId)
  if mapFloorCfgData == nil then
    return
  end
  self.mapFloorCfgData = mapFloorCfgData
  self.actData = PlayerData.Activity:GetActivityDataById(self.mapLevelCfgData.ActivityId)
  self.mapRecordLevelData = {}
  self.mapRecordItemData = {}
  if self.actData ~= nil then
    local mapCachedData = self.actData:GetActivityData()
    self.mapRecordLevelData = mapCachedData.mapLevels
    self.mapRecordItemData = mapCachedData.mapItems
  end
  local sPath = string.format(rootPath, self.mapFloorCfgData.SceneName)
  local goLevelPerfab = GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Object))
  local goLevel = instantiate(goLevelPerfab, self._mapNode.rtLevelRoot)
  local mapCtrl = self:BindCtrlByNode(goLevel, "Game.UI.Activity.ThrowGifts.ThrowGiftsLevelCtrl")
  local rtLevel = goLevel:GetComponent("RectTransform")
  self.levelCtrl = mapCtrl
  if rtLevel ~= nil then
    rtLevel.anchoredPosition = Vector2(0, 0)
  end
  self:SetScore(0)
  if 0 < self.mapLevelCfgData.CountDownLimit then
    self:SetTime(self.mapLevelCfgData.CountDownLimit)
    self._mapNode.imgTimeBg:SetActive(true)
  else
    self._mapNode.imgTimeBg:SetActive(false)
  end
  self._mapNode.rtItem[1]:SetItem(0)
  self._mapNode.rtItem[2]:SetItem(0)
  self._mapNode.rtItem[1]:PlayAnim(2)
  self._mapNode.rtItem[2]:PlayAnim(2)
  self._mapNode.rtItem[1]:SetIdx(1)
  self._mapNode.rtItem[2]:SetIdx(2)
  self._mapNode.rtBuff[1]:SetActive(false)
  self._mapNode.rtBuff[2]:SetActive(false)
  self._mapNode.rtBuff[3]:SetActive(false)
  self._mapNode.rtBuff[4]:SetActive(false)
  self._mapNode.TMPLevelTimeAdd.gameObject:SetActive(false)
  self:SetFx({})
  EventManager.Hit(EventId.SetTransition)
  
  local function waitTransion()
    self._mapNode.rtTargetHint:SetActive(true)
    self._mapNode.rtTargetHintAnim:Play("rtTargetHint_in")
    WwiseAudioMgr:PostEvent("Mode_Present_paper")
    NovaAPI.SetTMPText(self._mapNode.TMPTargetHint, mapLevelCfgData.ThrowGiftLevelCondDesc)
    self.levelCtrl:SetLevel(self, self.nLevelId, self.actData)
    self.levelCtrl:Pause(true)
    
    local function wait()
      self._mapNode.rtTargetHintAnim:Play("rtTargetHint_out")
    end
    
    local function waitAnim()
      self.levelCtrl:Pause(false)
      self.levelCtrl:LevelStart()
      self._mapNode.rtTargetHint:SetActive(false)
    end
    
    self:AddTimer(1, 1.5, wait, true, true, true)
    self:AddTimer(1, 1.7, waitAnim, true, true, true)
  end
  
  self:AddTimer(1, 1.3, waitTransion, true, true, true)
  self:SetTarget(0)
end

function ThrowGiftCtrl:OnDisable()
end

function ThrowGiftCtrl:OnDestroy()
end

function ThrowGiftCtrl:OnRelease()
end

function ThrowGiftCtrl:SetScore(nScore)
  NovaAPI.SetTMPText(self._mapNode.TMPLevelScore, tostring(nScore))
end

function ThrowGiftCtrl:AddTimeAnim()
  if self.AddTimeAnimTimer ~= nil then
    return
  end
  
  local function callback()
    self._mapNode.TMPLevelTimeAdd.gameObject:SetActive(false)
    self.AddTimeAnimTimer = nil
  end
  
  self._mapNode.TMPLevelTimeAdd.gameObject:SetActive(true)
  self._mapNode.TMPLevelTimeAdd:Play("TMPLevelTimeAdd_in")
  self.AddTimeAnimTimer = self:AddTimer(1, 1, callback, true, true, true)
end

function ThrowGiftCtrl:SetTime(nTime)
  if math.floor(nTime) ~= self.nCurTime then
    self.nCurTime = math.floor(nTime)
    local m = math.floor(self.nCurTime / 60)
    local s = math.floor(self.nCurTime % 60)
    NovaAPI.SetTMPText(self._mapNode.TMPLevelTime, string.format("%d:%02d", m, s))
  end
end

function ThrowGiftCtrl:SetTarget(nCur)
  NovaAPI.SetTMPText(self._mapNode.TMPTarget, string.format(self.mapLevelCfgData.ThrowGiftLevelCondDesc .. " (<color=#08d3d4>%d</color>/%d)", nCur, self.mapLevelCfgData.throwGiftLevelParams))
end

function ThrowGiftCtrl:OpenItemSelect(tbItems, selectCallback)
  local pos = 1
  if self.nCurItem[1] == 0 or self.nCurItem[1] == nil then
    pos = 1
  elseif self.nCurItem[2] == 0 or self.nCurItem[2] == nil then
    pos = 2
  elseif self.tbItemIdx[1] > self.tbItemIdx[2] then
    pos = 2
  end
  
  local function callback(tbIdx)
    if selectCallback ~= nil and type(selectCallback) == "function" then
      selectCallback(tbIdx)
    end
    if #tbItems <= 1 then
      self.nCurItem[pos] = tbItems[1][tbIdx[1]]
      self.tbItemIdx[pos] = math.max(self.tbItemIdx[1], self.tbItemIdx[2]) + 1
      self._mapNode.rtItem[pos]:SetItem(tbItems[1][tbIdx[1]])
      self._mapNode.rtItem[pos]:PlayAnim(3)
    else
      self.tbItemIdx[1] = self.tbItemIdx[1] + 1
      self.tbItemIdx[2] = self.tbItemIdx[2] + 1
      self._mapNode.rtItem[1]:SetItem(tbItems[1][tbIdx[1]])
      self._mapNode.rtItem[1]:PlayAnim(3)
      self._mapNode.rtItem[2]:SetItem(tbItems[2][tbIdx[2]])
      self._mapNode.rtItem[2]:PlayAnim(3)
    end
  end
  
  self._mapNode.rtItemSelect:OpenPanel(tbItems, callback, pos)
end

function ThrowGiftCtrl:OpenSettle(bWin, nScore, nGift, nPenguin, bShowPenguin, changeInfo)
  self.mapRecordLevelData = {}
  self.mapRecordItemData = {}
  if self.actData ~= nil then
    local mapCachedData = self.actData:GetActivityData()
    self.mapRecordLevelData = mapCachedData.mapLevels
    self.mapRecordItemData = mapCachedData.mapItems
  end
  local bShowNextLevel = false
  local nNextLevelId = self.nLevelId + 1
  local mapNextCfgData = ConfigTable.GetData("ThrowGiftLevel", nNextLevelId, false)
  if mapNextCfgData ~= nil then
    bShowNextLevel = self:GetLevelUnlock(nNextLevelId)
  end
  self._mapNode.rtSettle:ShowSettle(bWin, nScore, nGift, nPenguin, bShowPenguin, bShowNextLevel, changeInfo, self.nLevelId)
end

function ThrowGiftCtrl:SetFx(mapState)
  local bShowSnow = mapState[103] ~= nil
  local bShowDouble = mapState[104] ~= nil
  self._mapNode.rtColorAnim.gameObject:SetActive(bShowSnow or bShowDouble)
  self._mapNode.FX_Star:SetActive(bShowDouble)
  self._mapNode.FX_Snow:SetActive(bShowSnow)
  if bShowSnow and bShowDouble then
    self._mapNode.rtColorAnim:Play("rtColorAnim_YB")
  elseif bShowSnow then
    self._mapNode.rtColorAnim:Play("rtColorAnim_B")
  elseif bShowDouble then
    self._mapNode.rtColorAnim:Play("rtColorAnim_Y")
  end
end

function ThrowGiftCtrl:ChangeLevel(nLevelId)
  self.levelCtrl:Pause(true)
  self:LevelEnd()
  
  local function callback()
    self.levelCtrl:ClearTrackLine()
    local goLevelBefore = self.levelCtrl.gameObject
    self:UnbindCtrlByNode(self.levelCtrl)
    destroy(goLevelBefore)
    self.nCurItem = {0, 0}
    self.tbItemIdx = {0, 0}
    self.nCurSelectItemIdx = 0
    self.nLevelId = nLevelId
    local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", self.nLevelId)
    if mapLevelCfgData == nil then
      return
    end
    self.mapLevelCfgData = mapLevelCfgData
    local mapFloorCfgData = ConfigTable.GetData("ThrowGiftFloor", self.mapLevelCfgData.FloorId)
    if mapFloorCfgData == nil then
      return
    end
    self.mapFloorCfgData = mapFloorCfgData
    self.actData = PlayerData.Activity:GetActivityDataById(self.mapLevelCfgData.ActivityId)
    self.mapRecordLevelData = {}
    self.mapRecordItemData = {}
    if self.actData ~= nil then
      local mapCachedData = self.actData:GetActivityData()
      self.mapRecordLevelData = mapCachedData.mapLevels
      self.mapRecordItemData = mapCachedData.mapItems
    end
    local sPath = string.format(rootPath, self.mapFloorCfgData.SceneName)
    local goLevelPerfab = GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Object))
    local goLevel = instantiate(goLevelPerfab, self._mapNode.rtLevelRoot)
    local mapCtrl = self:BindCtrlByNode(goLevel, "Game.UI.Activity.ThrowGifts.ThrowGiftsLevelCtrl")
    local rtLevel = goLevel:GetComponent("RectTransform")
    self.levelCtrl = mapCtrl
    if rtLevel ~= nil then
      rtLevel.anchoredPosition = Vector2(0, 0)
    end
    self:SetScore(0)
    if 0 < self.mapLevelCfgData.CountDownLimit then
      self:SetTime(self.mapLevelCfgData.CountDownLimit)
      self._mapNode.imgTimeBg:SetActive(true)
    else
      self._mapNode.imgTimeBg:SetActive(false)
    end
    self._mapNode.rtItem[1]:SetItem(0)
    self._mapNode.rtItem[2]:SetItem(0)
    self._mapNode.rtItem[1]:SetIdx(1)
    self._mapNode.rtItem[2]:SetIdx(2)
    self._mapNode.rtItem[1]:PlayAnim(2)
    self._mapNode.rtItem[2]:PlayAnim(2)
    self._mapNode.rtBuff[1]:SetActive(false)
    self._mapNode.rtBuff[2]:SetActive(false)
    self._mapNode.rtBuff[3]:SetActive(false)
    self._mapNode.rtBuff[4]:SetActive(false)
    self._mapNode.TMPLevelTimeAdd.gameObject:SetActive(false)
    self:SetFx({})
    self:SetTarget(0, self.mapLevelCfgData.throwGiftLevelParams)
    
    local function waitTransion()
      self._mapNode.rtTargetHint:SetActive(true)
      self._mapNode.rtTargetHintAnim:Play("rtTargetHint_in")
      WwiseAudioMgr:PostEvent("Mode_Present_paper")
      NovaAPI.SetTMPText(self._mapNode.TMPTargetHint, mapLevelCfgData.ThrowGiftLevelCondDesc)
      self.levelCtrl:SetLevel(self, self.nLevelId, self.actData)
      self.levelCtrl:Pause(true)
      
      local function wait()
        self._mapNode.rtTargetHintAnim:Play("rtTargetHint_out")
      end
      
      local function waitAnim()
        self.levelCtrl:Pause(false)
        self.levelCtrl:LevelStart()
        self._mapNode.rtTargetHint:SetActive(false)
      end
      
      self:AddTimer(1, 1.5, wait, true, true, true)
      self:AddTimer(1, 1.7, waitAnim, true, true, true)
    end
    
    self:AddTimer(1, 1.3, waitTransion, true, true, true)
    EventManager.Hit(EventId.SetTransition)
  end
  
  EventManager.Hit(EventId.SetTransition, self._panel.nTransition, callback)
end

function ThrowGiftCtrl:GetLevelUnlock(nLevelId)
  if self.actData == nil then
    return true
  end
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", nLevelId)
  if mapLevelCfgData == nil then
    return false
  end
  if mapLevelCfgData.DayOpen ~= 0 and mapLevelCfgData.DayOpen ~= nil and self.nOpenTime ~= 0 then
    local nServerTimeStamp = CS.ClientManager.Instance.serverTimeStamp
    local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
    local remainTime = openTime + mapLevelCfgData.DayOpen * 86400 - nServerTimeStamp
    if 0 < remainTime then
      return false
    end
  end
  if mapLevelCfgData.PreLevelId ~= 0 then
    return self.mapRecordLevelData[mapLevelCfgData.PreLevelId] ~= nil and self.mapRecordLevelData[mapLevelCfgData.PreLevelId].FirstComplete
  else
    return true
  end
end

function ThrowGiftCtrl:SetBuffShow(nBuffId, bShow)
  if nBuffId == 102 then
    self._mapNode.rtBuff[1]:SetActive(bShow)
    self._mapNode.rtBuffAnim[1]:Play("rtBuff_in")
  elseif nBuffId == 103 then
    self._mapNode.rtBuff[2]:SetActive(bShow)
    self._mapNode.rtBuffAnim[2]:Play("rtBuff_in")
  elseif nBuffId == 104 then
    self._mapNode.rtBuff[3]:SetActive(bShow)
    self._mapNode.rtBuffAnim[3]:Play("rtBuff_in")
  elseif nBuffId == 105 then
    self._mapNode.rtBuff[4]:SetActive(bShow)
    self._mapNode.rtBuffAnim[4]:Play("rtBuff_in")
  end
end

function ThrowGiftCtrl:SetBuffTime(nBuffId, nTime)
  local function formatTime(nTime)
    nTime = math.floor(nTime)
    
    local nMin = math.floor(nTime / 60)
    local nSec = nTime % 60
    return string.format("%02d:%02d", nMin, nSec)
  end
  
  if nBuffId == 102 then
    NovaAPI.SetTMPText(self._mapNode.TMPBuffTime[1], formatTime(nTime))
  elseif nBuffId == 103 then
    NovaAPI.SetTMPText(self._mapNode.TMPBuffTime[2], formatTime(nTime))
  elseif nBuffId == 104 then
    NovaAPI.SetTMPText(self._mapNode.TMPBuffTime[3], formatTime(nTime))
  elseif nBuffId == 105 then
    NovaAPI.SetTMPText(self._mapNode.TMPBuffTime[4], formatTime(nTime))
  end
end

function ThrowGiftCtrl:SetViewBtn(nType)
  self._mapNode.btnRight.gameObject:SetActive(nType == 1)
  self._mapNode.btnLeft.gameObject:SetActive(nType == 2)
end

function ThrowGiftCtrl:LevelEnd()
  self:SetViewBtn(0)
  self._mapNode.rtItemSelect.gameObject:SetActive(false)
  self._mapNode.imgItemDescBg.gameObject:SetActive(false)
  self._mapNode.rtSettle.gameObject:SetActive(false)
end

function ThrowGiftCtrl:OnEvent_ThrowGift_Exit()
  if self.levelCtrl ~= nil then
    self.levelCtrl:Pause(false)
    self._mapNode.PausePanel:Close()
  end
  WwiseAudioMgr:PostEvent("Mode_Present_all_stop")
  EventManager.Hit(EventId.ClosePanel, self._panel.nLevelPanelId)
end

function ThrowGiftCtrl:OnEvent_ThrowGift_Giveup()
  if self.levelCtrl ~= nil then
    self.levelCtrl:LevelEnd(false)
    self._mapNode.PausePanel:Close()
  end
end

function ThrowGiftCtrl:OnEvent_ThrowGift_Restart()
  if self.levelCtrl ~= nil then
    self.levelCtrl:Pause(false)
    self._mapNode.PausePanel:Close()
  end
  WwiseAudioMgr:PostEvent("Mode_Present_all_stop")
  self:ChangeLevel(self.nLevelId)
end

function ThrowGiftCtrl:OnEvent_ThrowGift_Continue()
  if self.levelCtrl ~= nil then
    self.levelCtrl:Pause(false)
    self._mapNode.PausePanel:Close()
  end
end

function ThrowGiftCtrl:OnEvent_ThrowGiftItemUseBtn(nIdx, nItemId)
  if self.nCurSelectItemIdx == nIdx then
    self._mapNode.rtItem[self.nCurSelectItemIdx]:PlayAnim(2)
    self.nCurSelectItemIdx = 0
    self._mapNode.imgItemDescBg.gameObject:SetActive(false)
    return
  end
  if self.nCurSelectItemIdx == 0 then
    self._mapNode.imgItemDescBg.gameObject:SetActive(true)
  end
  if self.nCurSelectItemIdx ~= 0 then
    self._mapNode.rtItem[self.nCurSelectItemIdx]:PlayAnim(2)
  end
  self.nCurSelectItemIdx = nIdx
  self._mapNode.rtItem[self.nCurSelectItemIdx]:PlayAnim(1)
  local mapItemCfgData = ConfigTable.GetData("ThrowGiftItem", nItemId)
  if mapItemCfgData == nil then
    self._mapNode.imgItemDescBg.gameObject:SetActive(false)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPItemDescBottom, mapItemCfgData.Desc)
end

function ThrowGiftCtrl:OnEvent_ThrowGiftItemConfirmBtn(nIdx, nItemId)
  self._mapNode.imgItemDescBg.gameObject:SetActive(false)
  self.nCurItem[nIdx] = 0
  self.levelCtrl:ActiveItem(nItemId)
  for i = 1, 2 do
    if i == nIdx then
      self._mapNode.rtItem[i]:PlayAnim(2)
      self._mapNode.rtItem[i]:SetItem(0)
    end
  end
  self.nCurSelectItemIdx = 0
end

function ThrowGiftCtrl:OnEvent_ThrowGift_NextLevel()
  local bShowNextLevel = false
  local nNextLevelId = self.nLevelId + 1
  local mapNextCfgData = ConfigTable.GetData("ThrowGiftLevel", nNextLevelId, false)
  if mapNextCfgData ~= nil then
    bShowNextLevel = self:GetLevelUnlock(nNextLevelId)
  end
  if bShowNextLevel then
    WwiseAudioMgr:PostEvent("Mode_Present_all_stop")
    self:ChangeLevel(nNextLevelId)
  end
end

function ThrowGiftCtrl:OnBtnClick_Pause()
  if self.levelCtrl ~= nil and not self.levelCtrl.bProcessing then
    self.levelCtrl:Pause(true)
    self._mapNode.PausePanel:Open(self.mapFloorCfgData.DictionaryID)
  end
end

function ThrowGiftCtrl:OnBtnClick_btnRight()
  if self.levelCtrl ~= nil then
    self.levelCtrl:ChangeView(true)
  end
end

function ThrowGiftCtrl:OnBtnClick_btnLeft()
  if self.levelCtrl ~= nil then
    self.levelCtrl:ChangeView(false)
  end
end

return ThrowGiftCtrl
