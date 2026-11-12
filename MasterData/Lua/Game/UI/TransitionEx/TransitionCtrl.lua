local TransitionCtrl = class("TransitionCtrl", BaseCtrl)
local starTowerLoadingImgList = {
  "bg_sky_dusk_a",
  "bg_sky_night_a",
  "bg_sky_tower"
}
TransitionCtrl._mapNodeConfig = {
  TransitionRoot = {sComponentName = "Transform"}
}
TransitionCtrl._mapEventConfig = {
  [EventId.SetTransition] = "OnEvent_SetTrans",
  __OpenLoadingView = "OnEvent_OpenLoadingView",
  __CloseLoadingView = "OnEvent_CloseLoadingView",
  __UpdateLoadingView = "OnEvent_UpdateLoadingView"
}

function TransitionCtrl:Awake()
  self.tbCallback_In = {}
  self.tbCallback_Out = {}
  self.nStarTowerImgIndex = 0
end

function TransitionCtrl:DestroyUnusedIns()
  local nChildCount = self._mapNode.TransitionRoot.childCount - 1
  if 0 < nChildCount then
    for i = nChildCount, 0, -1 do
      local trChild = self._mapNode.TransitionRoot:GetChild(i)
      if trChild ~= nil and trChild:IsNull() == false and trChild.gameObject.activeSelf == false then
        destroy(trChild.gameObject)
      end
    end
  end
end

function TransitionCtrl:_DoRemove(tbCallback)
  local nCount = #tbCallback
  for i = nCount, 1, -1 do
    local tb = tbCallback[i]
    if tb[2] == true then
      table.remove(tbCallback, i)
    end
  end
end

function TransitionCtrl:_DoCallback(bIn)
  self:_DoRemove(self.tbCallback_In)
  self:_DoRemove(self.tbCallback_Out)
  local tbCallback = bIn == true and self.tbCallback_In or self.tbCallback_Out
  local nCount = #tbCallback
  local sFrameCount = tostring(CS.UnityEngine.Time.frameCount)
  printLog("[转场]执行" .. (bIn == true and " 落幕 " or " 开幕 ") .. "回调，数量: " .. tostring(nCount) .. "。frameCount: " .. sFrameCount)
  for i, v in ipairs(tbCallback) do
    local func_callback = v[1]
    local bDone = v[2]
    if func_callback ~= nil and bDone ~= true then
      tbCallback[i][2] = true
      func_callback()
    end
  end
end

function TransitionCtrl:_MarkCallback(cb, bIn)
  if cb == nil then
    return
  end
  local tbCallback = bIn == true and self.tbCallback_In or self.tbCallback_Out
  table.insert(tbCallback, {cb, false})
end

function TransitionCtrl:_In(sEventFrom, nType, callback, nParam, bIgnoreCSEvent)
  local sFrameCount = tostring(CS.UnityEngine.Time.frameCount)
  if self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.IsPlayingInAnim then
    printLog("[转场]重复落幕(" .. sEventFrom .. ")，落幕 anim playing，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, true)
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.InAnimDone then
    printLog("[转场]重复落幕(" .. sEventFrom .. ")，落幕 anim done，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, true)
    self:_DoCallback(true)
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.IsPlayingOutAnim then
    printLog("[转场]错误落幕(" .. sEventFrom .. ")，开幕 anim playing，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, true)
    if bIgnoreCSEvent ~= true then
      if self.timerAnim ~= nil then
        self.timerAnim:Cancel(true)
        self.timerAnim = nil
      end
      self:OpenTransition(nType, nParam)
    end
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.OutAnimDone then
    printLog("[转场]正常落幕(" .. sEventFrom .. ")，开幕 anim done，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, true)
    if bIgnoreCSEvent ~= true then
      self:OpenTransition(nType, nParam)
    end
  end
end

function TransitionCtrl:_Out(sEventFrom, callback, bIgnoreCSEvent)
  local sFrameCount = tostring(CS.UnityEngine.Time.frameCount)
  if self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.IsPlayingInAnim then
    printLog("[转场]错误开幕(" .. sEventFrom .. ")，落幕 anim playing，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, false)
    if bIgnoreCSEvent ~= true then
      if self.timerAnim ~= nil then
        self.timerAnim:Cancel(true)
        self.timerAnim = nil
      end
      self:CloseTransition()
    end
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.InAnimDone then
    printLog("[转场]正常开幕(" .. sEventFrom .. ")，落幕 anim done，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, false)
    if bIgnoreCSEvent ~= true then
      self:CloseTransition()
      EventManager.Hit("InputEnable", false, true)
    else
      self:_DoCallback(false)
    end
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.IsPlayingOutAnim then
    printLog("[转场]重复开幕(" .. sEventFrom .. ")，开幕 anim playing，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, false)
  elseif self._panel:GetTransitionStatus() == AllEnum.TransitionStatus.OutAnimDone then
    printLog("[转场]重复开幕(" .. sEventFrom .. ")，开幕 anim done，frameCount: " .. sFrameCount)
    self:_MarkCallback(callback, false)
    self:_DoCallback(false)
  end
end

function TransitionCtrl:OnEvent_SetTrans(nType, callback, nParam)
  if nType ~= nil then
    self:_In("Lua", nType, callback, nParam)
  else
    self:_Out("Lua", callback)
  end
end

function TransitionCtrl:OnEvent_OpenLoadingView(callback, delayTime, fadeTime, tag, nType)
  self:_In("C#", nType, callback, nil, PanelManager.IGNORE_CS_TRANS_EVENT)
end

function TransitionCtrl:OnEvent_CloseLoadingView(callback, delayTime, fadeTime)
  self:_Out("C#", callback, PanelManager.IGNORE_CS_TRANS_EVENT)
end

function TransitionCtrl:OnEvent_UpdateLoadingView(nProgress, sMsg)
  if PanelManager.IGNORE_CS_TRANS_EVENT == true then
    return
  end
  if self.cs_loading_img ~= nil and self.cs_loading_img:IsNull() == false then
    NovaAPI.SetImageFillAmount(self.cs_loading_img, nProgress)
  end
  if self.cs_loading_txt ~= nil and self.cs_loading_txt:IsNull() == false then
    NovaAPI.SetText(self.cs_loading_txt, sMsg)
  end
end

function TransitionCtrl:OpenTransition(nType, nParam)
  self._panel:ChangeStatus(AllEnum.TransitionStatus.IsPlayingInAnim)
  EventManager.Hit(EventId.BlockInput, true)
  local sName
  if type(nType) == "number" then
    sName = string.format("style_%d", nType)
    self.nType = nType
  else
    sName = tostring(nType)
    local sStyle = string.gsub(sName, "style_", "")
    self.nType = tonumber(sStyle)
  end
  self.animStyle = nil
  local goStyle
  goStyle = self._mapNode.TransitionRoot:Find(sName)
  if goStyle ~= nil and goStyle:IsNull() == false then
    goStyle = goStyle.gameObject
  else
    local stylePrefab = self:LoadAsset(string.format("UI/TransitionEx/%s.prefab", sName))
    goStyle = instantiate(stylePrefab, self._mapNode.TransitionRoot)
    goStyle.name = sName
  end
  if goStyle ~= nil and goStyle:IsNull() == false then
    goStyle:SetActive(true)
    self._mapNode.TransitionRoot.localScale = Vector3.one
    local func_Set = self[string.format("Set_%d", self.nType)]
    if type(func_Set) == "function" then
      func_Set(self, goStyle, nParam)
    end
    self.animStyle = goStyle:GetComponent("Animator")
    if self.animStyle ~= nil and self.animStyle:IsNull() == false then
      self:PlayAnim(true)
    else
      printError("[转场]错误！！此转场动效预设体上没有 animator 组件，不符合约定规范。" .. tostring(CS.UnityEngine.Time.frameCount))
    end
  else
    printError("[转场]错误！！转场动效预设体未找到，类型：" .. tostring(nType) .. ", " .. tostring(CS.UnityEngine.Time.frameCount))
  end
end

function TransitionCtrl:CloseTransition()
  self._panel:ChangeStatus(AllEnum.TransitionStatus.IsPlayingOutAnim)
  self:PlayAnim(false)
end

function TransitionCtrl:PlayAnim(bIn)
  local nAnimLength = 1
  if self.animStyle ~= nil and self.animStyle:IsNull() == false then
    local sFormat = "style%d_in"
    if bIn ~= true then
      sFormat = "style%d_out"
    end
    local sAnimName = string.format(sFormat, self.nType)
    self.animStyle:Play(sAnimName)
    nAnimLength = NovaAPI.GetAnimClipLength(self.animStyle, {sAnimName})
  end
  local sFrameCount = tostring(CS.UnityEngine.Time.frameCount)
  printLog("[转场]开始播" .. (bIn == true and " 落幕 " or " 开幕 ") .. "动画，时长：" .. tostring(nAnimLength) .. "，frameCount: " .. sFrameCount)
  self.timerAnim = self:AddTimer(1, nAnimLength, self.OnTimer_AnimDone, true, true, true, bIn == true)
end

function TransitionCtrl:OnTimer_AnimDone(timer, bIn)
  local sFrameCount = tostring(CS.UnityEngine.Time.frameCount)
  printLog("[转场]" .. (bIn == true and " 落幕 " or " 开幕 ") .. "动画播完了，frameCount: " .. sFrameCount)
  self._panel:ChangeStatus(bIn == true and AllEnum.TransitionStatus.InAnimDone or AllEnum.TransitionStatus.OutAnimDone)
  self.timerAnim = nil
  if bIn == true then
    self:_DoCallback(bIn)
    EventManager.Hit(EventId.TransAnimInClear)
  else
    self:DestroyUnusedIns()
    if self.animStyle ~= nil and self.animStyle:IsNull() == false then
      self.animStyle.gameObject:SetActive(false)
    end
    self.animStyle = nil
    self.nType = nil
    self._mapNode.TransitionRoot.localScale = Vector3.zero
    EventManager.Hit("InputEnable", true, true)
    EventManager.Hit(EventId.BlockInput, false)
    self:_DoCallback(bIn)
    EventManager.Hit(EventId.TransAnimOutClear)
  end
end

function TransitionCtrl:TimeStamp(strTime)
  local pattern = "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)([%+%-]%d+):(%d+)"
  local y, m, d, H, M, S, zh, zm = strTime:match(pattern)
  local timestamp = os.time({
    year = y,
    month = m,
    day = d,
    hour = H,
    min = M,
    sec = S,
    isdst = false
  })
  return timestamp
end

function TransitionCtrl:RandomMangaConfig()
  local tbMangaList = {}
  local nTotalWeight = 0
  local mangaConfig
  local time_Now = CS.ClientManager.Instance.serverTimeStamp
  
  local function add2List(mapLineData)
    if mapLineData.ConditionType == GameEnum.mangaLoadingCondition.Time then
      if mapLineData.StartTime ~= "" and mapLineData.EndTime ~= "" and time_Now >= self:TimeStamp(mapLineData.StartTime) and time_Now <= self:TimeStamp(mapLineData.EndTime) then
        table.insert(tbMangaList, mapLineData)
        nTotalWeight = nTotalWeight + mapLineData.Weight
      end
    elseif mapLineData.ConditionType == GameEnum.mangaLoadingCondition.None then
      table.insert(tbMangaList, mapLineData)
      nTotalWeight = nTotalWeight + mapLineData.Weight
    end
  end
  
  ForEachTableLine(DataTable.MangaLoading, add2List)
  if #tbMangaList == 0 then
    return nil
  end
  local nRandomIndex = math.random(nTotalWeight)
  local tempNum = 0
  for _, v in ipairs(tbMangaList) do
    tempNum = tempNum + v.Weight
    if nRandomIndex <= tempNum then
      mangaConfig = v
      break
    end
  end
  return mangaConfig
end

function TransitionCtrl:Set_3(goStyle, nParam)
  self.cs_loading_cg = goStyle:GetComponent("CanvasGroup")
  local tr = goStyle.transform
  local cs_loading_txt = tr:Find("txtProgress"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(cs_loading_txt, ConfigTable.GetUIText("Loading"))
end

function TransitionCtrl:Set_8(goStyle)
  local sUIText_A = ConfigTable.GetUIText("InfinityTower_Transition_Type1")
  if sUIText_A == nil then
    printError("[转场]UIText缺失配置:InfinityTower_Transition_Type1")
    sUIText_A = ""
  end
  local sUIText_B = ConfigTable.GetUIText("InfinityTower_Transition_Type2")
  if sUIText_B == nil then
    printError("[转场]UIText缺失配置:InfinityTower_Transition_Type2")
    sUIText_B = ""
  end
  local tr = goStyle.transform
  local trTop = tr:Find("top/topList")
  local trBottom = tr:Find("bottom/bottomList")
  for i = 1, 5 do
    if i % 2 == 1 then
      NovaAPI.SetTMPText(trTop:Find(string.format("top_%d/txt_a", i)):GetComponent("TMP_Text"), sUIText_A)
      NovaAPI.SetTMPText(trBottom:Find(string.format("bottom_%d/txt_a", i)):GetComponent("TMP_Text"), sUIText_A)
    else
      NovaAPI.SetTMPText(trTop:Find(string.format("top_%d/txt_b", i)):GetComponent("TMP_Text"), sUIText_A)
      NovaAPI.SetTMPText(trBottom:Find(string.format("bottom_%d/txt_b", i)):GetComponent("TMP_Text"), sUIText_A)
    end
  end
end

function TransitionCtrl:Set_6(goStyle, nParam)
  local tr = goStyle.transform
  for i = AllEnum.MainViewCorner.Role, AllEnum.MainViewCorner.Dorm do
    tr:GetChild(i).gameObject:SetActive(i == nParam)
  end
end

function TransitionCtrl:Set_17(goStyle, nParam)
  local img_manga = goStyle.transform:Find("img_manga")
  local txt_title = goStyle.transform:Find("img_titleBg/txt_title")
  local mangaConfig = self:RandomMangaConfig()
  if mangaConfig == nil then
    return
  end
  NovaAPI.SetTMPText(txt_title:GetComponent("TMP_Text"), mangaConfig.Title)
  self:SetPngSprite(img_manga:GetComponent("Image"), mangaConfig.Source)
end

function TransitionCtrl:Set_18(goStyle, nParam)
  local img_manga = goStyle.transform:Find("img_manga")
  local txt_title = goStyle.transform:Find("img_titleBg/txt_title")
  local mangaConfig = self:RandomMangaConfig()
  if mangaConfig == nil then
    return
  end
  NovaAPI.SetTMPText(txt_title:GetComponent("TMP_Text"), mangaConfig.Title)
  self:SetPngSprite(img_manga:GetComponent("Image"), mangaConfig.Source)
end

function TransitionCtrl:Set_22(goStyle, nParam)
  local tbImage = {}
  for i = 1, 3 do
    local img = goStyle.transform:Find("SkyMask/imgSky" .. tostring(i))
    img.gameObject:SetActive(false)
    table.insert(tbImage, img)
  end
  self.nStarTowerImgIndex = self.nStarTowerImgIndex % 3 + 1
  local showImage = tbImage[self.nStarTowerImgIndex]
  showImage.gameObject:SetActive(true)
end

return TransitionCtrl
