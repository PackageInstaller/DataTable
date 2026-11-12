local DormContactBtnListCtrl = class("DormContactBtnListCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DormContactBtnListCtrl._mapNodeConfig = {
  pool = {sComponentName = "Transform"},
  btnInteractiveList = {},
  ContentInteractiveList = {sComponentName = "Transform"},
  rtCharInteractive = {},
  rtInteractiveBtn = {},
  btnInteractive1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Interactive1"
  },
  txtBtnInteractive1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Contact_Interactive1"
  },
  btnInteractive2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Interactive2"
  },
  txtBtnInteractive2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Contact_Interactive2"
  },
  btnInteractive3 = {sComponentName = "UIButton"},
  btnCloseCharInteractive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ExitCharActive"
  },
  goCharHudRoot = {},
  rtCharInteractiveHide = {},
  CharInteractiveHideAnim = {
    sNodeName = "rtCharInteractiveHide",
    sComponentName = "Animator"
  },
  btnCloseCharPresent = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_CloseCharPresent"
  },
  rtGiftRoot = {
    sCtrlName = "Game.UI.Dorm.DormContact.DormInteractiveGiftCtrl"
  },
  goFavorHint = {sComponentName = "Animator"},
  TMPHudFavorHint = {sComponentName = "TMP_Text"}
}
DormContactBtnListCtrl._mapEventConfig = {}
DormContactBtnListCtrl._mapRedDotConfig = {}

function DormContactBtnListCtrl:Awake()
  self.mapListBtn = {}
  self.tbListBtnPool = {}
  self._timerInteractive = nil
  self.mapCurCharInfo = nil
end

function DormContactBtnListCtrl:FadeIn()
end

function DormContactBtnListCtrl:FadeOut()
end

function DormContactBtnListCtrl:OnEnable()
  self._mapNode.rtGiftRoot.parent = self
  self._mapNode.TMPHudFavorHint.gameObject:SetActive(false)
  self._mapNode.rtCharInteractive:SetActive(false)
  self._mapNode.btnInteractive3.gameObject:SetActive(false)
end

function DormContactBtnListCtrl:OnDisable()
  if self._timerInteractive ~= nil then
    self._timerInteractive:Cancel()
    self._timerInteractive = nil
  end
  self._mapNode.rtCharInteractiveHide:SetActive(true)
end

function DormContactBtnListCtrl:OnDestroy()
end

function DormContactBtnListCtrl:OnRelease()
end

function DormContactBtnListCtrl:GetBtnItem()
  if #self.tbListBtnPool > 0 then
    local goItem = table.remove(self.tbListBtnPool, 1)
    goItem.transform:SetParent(self._mapNode.ContentInteractiveList)
    goItem.transform.localScale = Vector3.one
    return goItem
  else
    local go = instantiate(self._mapNode.btnInteractiveList)
    local goComp = go:GetComponent("UIButton")
    goComp.transform:SetParent(self._mapNode.ContentInteractiveList)
    goComp.transform.localScale = Vector3.one
    goComp.gameObject:SetActive(true)
    return goComp
  end
end

function DormContactBtnListCtrl:RecycleBtnItem(goItem)
  local animtor = goItem:GetComponent("Animator")
  if animtor ~= nil then
    animtor:Play("Interactive_out")
  end
  self:AddTimer(1, 0.16, function()
    goItem.transform:SetParent(self._mapNode.pool)
    table.insert(self.tbListBtnPool, goItem)
  end, true, true, true, nil)
end

function DormContactBtnListCtrl:AddInteractiveBtn(rtTarget, nType, nId, nEntityId)
  if self.mapListBtn[nEntityId] ~= nil then
    for index, mapData in ipairs(self.mapListBtn[nEntityId]) do
      if mapData.nType == nType then
        return
      end
    end
  end
  local goItem = self:GetBtnItem()
  if self.mapListBtn[nEntityId] == nil then
    self.mapListBtn[nEntityId] = {}
  end
  table.insert(self.mapListBtn[nEntityId], {
    goItem = goItem,
    objTarget = rtTarget,
    nType = nType,
    nDataId = nId,
    nEntityId = nEntityId
  })
  local compTMP = goItem.transform:Find("AnimRoot/imgBg/TMPName"):GetComponent("TMP_Text")
  local animtor = goItem:GetComponent("Animator")
  local imgIcon = goItem.transform:Find("AnimRoot/imgBg/imgIcon"):GetComponent("Image")
  if nType == 0 then
    self:SetPngSprite(imgIcon, "Icon/ZZZOther/dorminter_role_small")
  elseif nType == 1 then
    self:SetPngSprite(imgIcon, "Icon/ZZZOther/dorminter_furniture_small")
  else
    local mapFurnitureCfgData = ConfigTable.GetData("DormFurniture", nId)
    if mapFurnitureCfgData ~= nil then
      local sPath = mapFurnitureCfgData.BubbleIcon .. "_small"
      self:SetPngSprite(imgIcon, sPath)
    end
  end
  if animtor ~= nil then
    animtor:Play("Interactive_in")
  end
  local mapItemCfgData = ConfigTable.GetData_Item(nId)
  if mapItemCfgData ~= nil then
    NovaAPI.SetTMPText(compTMP, mapItemCfgData.Title)
  end
  goItem.onClick:RemoveAllListeners()
  goItem.onClick:AddListener(function()
    self:DormContactBtnClick(nEntityId, nType, nId)
  end)
end

function DormContactBtnListCtrl:RemoveRewardHud(nEntityId, nFurId)
  if self.mapListBtn[nEntityId] == nil or #self.mapListBtn[nEntityId] == 0 then
    return
  end
  local removedIdx = 0
  for nIdx, mapInfo in ipairs(self.mapListBtn[nEntityId]) do
    if mapInfo.nType == 4 and mapInfo.nDataId == nFurId then
      removedIdx = nIdx
    end
  end
  local removedInfo = table.remove(self.mapListBtn[nEntityId], removedIdx)
  self:RecycleBtnItem(removedInfo.goItem)
end

function DormContactBtnListCtrl:RemoveInteractiveBtn(nEntityId)
  if self.mapListBtn[nEntityId] ~= nil then
    for _, mapBtnInfo in ipairs(self.mapListBtn[nEntityId]) do
      mapBtnInfo.goItem.onClick:RemoveAllListeners()
      self:RecycleBtnItem(mapBtnInfo.goItem)
    end
    self.mapListBtn[nEntityId] = nil
  end
end

function DormContactBtnListCtrl:RemoveAllInteractiveBtn()
  for nEntityId, tbInfo in pairs(self.mapListBtn) do
    for _, goBtn in ipairs(tbInfo) do
      goBtn.goItem.onClick:RemoveAllListeners()
      self:RecycleBtnItem(goBtn.goItem)
    end
  end
  self.mapListBtn = {}
end

function DormContactBtnListCtrl:EnterCharActive(nEntityId)
  if self._timerInteractive ~= nil then
    self._timerInteractive:Cancel()
    self._timerInteractive = nil
  end
  if self.mapListBtn[nEntityId] == nil or #self.mapListBtn[nEntityId] == 0 then
    return
  end
  local mapInfo = self.mapListBtn[nEntityId][1]
  self._mapNode.rtCharInteractiveHide:SetActive(true)
  self._mapNode.goCharHudRoot:SetActive(true)
  self._mapNode.rtCharInteractive:SetActive(true)
  self._mapNode.rtInteractiveBtn:SetActive(false)
  local rtTarget = mapInfo.objTarget
  self.mapCurCharInfo = mapInfo
  EventManager.Hit("DormShowInteractiveBtns", false)
  self._mapNode.CharInteractiveHideAnim:Play("DormCharInteractiveHide_in")
  safe_call_cs_func(CS.DormModuleHelper.SetHudFollowTarget, self._mapNode.goCharHudRoot, rtTarget, Vector3(0, 1.8, 0))
end

function DormContactBtnListCtrl:EnterCharActiveViewMode(rtTransform, nType, nDataId, nEntityId)
  if self._timerInteractive ~= nil then
    self._timerInteractive:Cancel()
    self._timerInteractive = nil
  end
  if nDataId == 9100 or nDataId == 9101 then
    self._mapNode.rtCharInteractiveHide:SetActive(false)
  else
    self._mapNode.rtCharInteractiveHide:SetActive(true)
  end
  self._mapNode.goCharHudRoot:SetActive(true)
  self._mapNode.rtCharInteractive:SetActive(true)
  self._mapNode.rtInteractiveBtn:SetActive(false)
  self._mapNode.CharInteractiveHideAnim:Play("DormCharInteractiveHide_in")
  local rtTarget = rtTransform
  self.mapCurCharInfo = {
    goItem = nil,
    objTarget = rtTarget,
    nType = nType,
    nDataId = nDataId,
    nEntityId = nEntityId
  }
  EventManager.Hit("DormShowInteractiveBtns", false)
  safe_call_cs_func(CS.DormModuleHelper.SetHudFollowTarget, self._mapNode.goCharHudRoot, rtTarget, Vector3(0, 1.5, 0))
end

function DormContactBtnListCtrl:PerformanceTimer(nTime, callback)
  if self._timerInteractive ~= nil then
    self._timerInteractive:Cancel()
    self._timerInteractive = nil
  end
  
  local function TimerCallback()
    self._mapNode.rtCharInteractiveHide:SetActive(true)
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
  end
  
  self._mapNode.rtCharInteractiveHide:SetActive(false)
  self._timerInteractive = self:AddTimer(1, nTime, TimerCallback, true, true, true, nil)
  EventManager.Hit(EventId.TemporaryBlockInput, nTime)
end

function DormContactBtnListCtrl:ExitCharActive()
  self.mapCurCharInfo = nil
  self._mapNode.goCharHudRoot:SetActive(false)
  self._mapNode.rtCharInteractive:SetActive(false)
  self._mapNode.rtInteractiveBtn:SetActive(true)
  if self._timerInteractive ~= nil then
    self._timerInteractive:Cancel()
    self._timerInteractive = nil
  end
  self._mapNode.rtCharInteractiveHide:SetActive(true)
  self._mapNode.CharInteractiveHideAnim:Play("DormCharInteractiveHide_in")
  self._mapNode.rtGiftRoot:Exit()
  EventManager.Hit("DormShowInteractiveBtns", true)
  NovaAPI.DispatchEventWithData("DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK", nil, {0})
end

function DormContactBtnListCtrl:OnBtnClick_Interactive1()
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  if self.mapCurCharInfo == nil then
    DormGuideAdapter.NoteCaressRejected()
    self:ExitCharActive()
    return
  end
  local nRoomId = self._panel.nCurRoom
  
  local function callback(tbAffinityData, changeInfo)
    NovaAPI.DispatchEventWithData("DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK", nil, {
      self.mapCurCharInfo.nEntityId
    })
    
    local function FinishChain()
      DormGuideAdapter.NoteCaressDone()
    end
    
    local function PerformanceTimerCallback()
      if tbAffinityData ~= nil and 0 < #tbAffinityData then
        local Info = tbAffinityData[1].AffinityInfo
        local mapItem = tbAffinityData[1].ItemInfo
        
        local function ItemCallback()
          if Info.nLevelChange > 0 then
            DormGuideAdapter.NoteCaressPhase("level")
            DormGuideAdapter.WatchPanel(PanelId.CharFavourLevelUp)
            EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, Info.CharId, Info.AffinityLevel, Info.nBeforeLevel, Info.AffinityExp, Info.nBeforeExp)
          else
            FinishChain()
          end
        end
        
        if mapItem ~= nil and 0 < mapItem.Tid then
          DormGuideAdapter.NoteCaressPhase("reward")
          UTILS.OpenReceiveByDisplayItem({mapItem}, changeInfo, ItemCallback)
        else
          ItemCallback()
        end
      else
        FinishChain()
      end
    end
    
    DormGuideAdapter.NoteCaressPhase("performing")
    self:PerformanceTimer(3, PerformanceTimerCallback)
    if tbAffinityData ~= nil and 0 < #tbAffinityData then
      local nAffinity = tbAffinityData[1].AffinityInfo.nExpChange or 0
      NovaAPI.SetTMPText(self._mapNode.TMPHudFavorHint, orderedFormat(ConfigTable.GetUIText("Dorm_AffinityUp"), nAffinity))
      self._mapNode.goFavorHint:Play("CharInterActiveAffinityHintIn")
      WwiseAudioMgr:PostEvent("Home_UI_char_up")
    end
  end
  
  if PlayerData.PlayerDormData:CheckRoleInteraction(self.mapCurCharInfo.nDataId) then
    callback(nil)
    return
  end
  self:DormCharInteractive({
    {
      RoleId = self.mapCurCharInfo.nDataId,
      DormRoomId = nRoomId
    }
  }, callback)
end

function DormContactBtnListCtrl:OnBtnClick_Interactive2()
  local nDayCount = PlayerData.PlayerDormData:GetCharGiftCountDay(self.mapCurCharInfo.nDataId)
  if nDayCount < 1 then
    local tips = ConfigTable.GetUIText("Dorm_GiftCountMaxHint")
    EventManager.Hit(EventId.OpenMessageBox, tips)
    return
  end
  self._mapNode.rtGiftRoot.gameObject:SetActive(true)
  self._mapNode.rtCharInteractiveHide:SetActive(false)
  self._mapNode.rtGiftRoot:OpenGiftChoose(self.mapCurCharInfo.nDataId, self)
end

function DormContactBtnListCtrl:OnBtnClick_ExitCharActive()
  local bHit, rtChar, nDataId, nEntityId = safe_call_cs_func2(CS.DormModuleHelper_HotFix.TryPickActorAtLastPressDown)
  if not bHit then
    self:ExitCharActive()
  elseif nEntityId == self.mapCurCharInfo.nEntityId then
    return
  else
    self:EnterCharActiveViewMode(rtChar, 2, nDataId, nEntityId)
  end
end

function DormContactBtnListCtrl:OnBtnClick_CloseCharPresent()
  self._mapNode.rtGiftRoot:Exit()
  self._mapNode.rtCharInteractiveHide:SetActive(true)
end

function DormContactBtnListCtrl:SendGiftResult(nRoomId, nCharId, tbGift)
  local function callback(Info)
    NovaAPI.DispatchEventWithData("DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK", nil, {
      self.mapCurCharInfo.nEntityId
    })
    self:OnBtnClick_CloseCharPresent()
    
    local function PerformanceTimerCallback()
      if Info ~= nil and Info.nLevelChange > 0 then
        EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, Info.CharId, Info.AffinityLevel, Info.nBeforeLevel, Info.AffinityExp, Info.nBeforeExp)
      end
    end
    
    self:PerformanceTimer(3, PerformanceTimerCallback)
    if Info ~= nil then
      local nAffinity = Info.nExpChange or 0
      NovaAPI.SetTMPText(self._mapNode.TMPHudFavorHint, orderedFormat(ConfigTable.GetUIText("Dorm_AffinityUp"), nAffinity))
      self._mapNode.goFavorHint:Play("CharInterActiveAffinityHintIn")
      WwiseAudioMgr:PostEvent("Home_UI_char_up")
    end
  end
  
  self:DormCharGift(nRoomId, nCharId, tbGift, callback)
end

function DormContactBtnListCtrl:DormCharInteractive(tbCharId, callback)
  local tbCheck = {}
  for _, mapRoleInfo in ipairs(tbCharId) do
    if not PlayerData.PlayerDormData:CheckRoleInteraction(mapRoleInfo.RoleId) then
      table.insert(tbCheck, mapRoleInfo)
    end
  end
  if #tbCheck < 1 then
    if callback ~= nil and type(callback == "function") then
      callback(nil)
    end
    return
  end
  
  local function netCallback(InfoList, changeinfo)
    if callback ~= nil and type(callback == "function") then
      callback(InfoList, changeinfo)
    end
  end
  
  PlayerData.PlayerDormData:DormRoleInteraction(tbCheck, netCallback)
end

function DormContactBtnListCtrl:DormCharGift(nRoomId, nCharId, tbGift, callback)
  if PlayerData.PlayerDormData:CheckRoleSendGift(nCharId) then
    print("该角色今天已被赠送过礼物")
    if callback ~= nil and type(callback == "function") then
      callback(nil)
    end
    return
  end
  
  local function netCallback(Info)
    if callback ~= nil and type(callback == "function") then
      callback(Info)
    end
  end
  
  PlayerData.PlayerDormData:DormAffinityGiftSend(nRoomId, nCharId, tbGift, netCallback)
end

function DormContactBtnListCtrl:DormContactBtnClick(nEntityId, nType, nDataId)
  if nType == 0 then
    NovaAPI.DispatchEventWithData("DORM_LUA_SELECT_ACTOR_CALLBACK", nil, {nEntityId})
    self:EnterCharActive(nEntityId)
  elseif nType == 1 then
    NovaAPI.DispatchEventWithData("BUTTON_DORM_INTERACTIVE_HUD", nil, {nEntityId, nType})
  else
    EventManager.Hit("FurnitureFunctionBtnClick", nEntityId, nDataId)
  end
end

return DormContactBtnListCtrl
