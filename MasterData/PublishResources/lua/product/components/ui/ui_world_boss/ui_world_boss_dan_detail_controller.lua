_class("UIWorldBossDanDetailController", UIController)
UIWorldBossDanDetailController = UIWorldBossDanDetailController

function UIWorldBossDanDetailController:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._roleModule = self:GetModule(RoleModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._refreshRemainTimeCd = 1000
  self._defaultRefreshRemainTimeCd = 1000
  self._timeEvents = {}
  self._dicDanWidget = {}
end

function UIWorldBossDanDetailController:LoadDataOnEnter(TT, res)
  self._worldBossModule = self:GetModule(WorldBossModule)
  self._worldBossData = self._worldBossModule.m_world_boss_data
  local result = self._worldBossModule:ReqGetDanInfo(TT)
  if result:GetSucc() then
    res:SetSucc(true)
  else
    res:SetSucc(false)
  end
  local curRequest = false
  local preRequest = false
  curRequest, preRequest = self._worldBossModule:NeedRequestRank()
  if curRequest then
    self._worldBossModule:GetWorldBossRankTopN(TT, true)
  end
  if preRequest then
    self._worldBossModule:GetWorldBossRankTopN(TT, false)
  end
  self:CurRanking()
  self:PreRanking()
end

function UIWorldBossDanDetailController:OnShow(uiParams)
  self._missionId = uiParams[1]
  self._callBack = uiParams[2]
  self._hideCallBack = uiParams[3]
  self._isEliminate = uiParams[4] or false
  self._hideCallBack()
  self:CalClientDanRank()
  self:InitWidget()
  self:_RefreshUi(true)
  self:AttachEvent(GameEventType.UIQuestWorldBossRest, self.OnUIQuestWorldBossRest)
  self:Lock("UIWorldBossDanDetailController_OnShow")
  local te = GameGlobal.Timer():AddEvent(600, function()
    self:UnLock("UIWorldBossDanDetailController_OnShow")
  end)
  table.insert(self._timeEvents, te)
  self:OnShowSheet(self._idSheet)
  self:DanInAnimation()
  self:FlushCurRanking()
  self:FlushPreRanking()
end

function UIWorldBossDanDetailController:CalClientDanRank()
  self._danInfo = DanInfo:New()
  for key, value in pairs(self._worldBossModule.m_dan_info) do
    self._danInfo[key] = value
  end
  self._useClientCal = true
  if self._useClientCal then
    local rankList = self._worldBossModule.m_rank_damage_list
    self._danInfo.cur_dan, self._danInfo.my_rank, self._danInfo.promote_one = UIActivityHelper.CalClientDan(rankList, self._worldBossModule.m_dan_info.cur_dan, self._worldBossModule.m_dan_info.my_rank, self._danInfo.promote_one, self._worldBossModule.m_dan_info.total_damage, self._worldBossData.boss_mission_id)
    if self._danInfo.my_rank == 1 then
      self._danInfo.rank_first_damage = self._danInfo.total_damage
    end
  end
  if self._curRankingSelf ~= nil and self._curRankingSelf.damage == self._danInfo.total_damage then
    self._danInfo.my_rank = self._curRankingSelf.luaIndex
  end
end

function UIWorldBossDanDetailController:Test()
  local list = {
    15,
    14,
    14,
    14,
    10,
    9,
    8,
    7,
    6,
    5,
    3,
    2,
    1
  }
  local checkScore = {
    16,
    15,
    14,
    13,
    10,
    7,
    5,
    4,
    3,
    1,
    0
  }
  local rank, score
  for index, value in ipairs(checkScore) do
    score = value
    rank = UIWorldBossHelper.CheckCurRank(list, score)
    Log.debug("UIWorldBossHelper.CheckCurRank score:", score, " rank:", rank)
  end
end

function UIWorldBossDanDetailController:InitWidget()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._backBtns = self._backBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    if self._isEliminate then
      self:ShowDialog("UIHelpController", "UIWorldBossController_Eliminate")
    else
      self:ShowDialog("UIHelpController", "UIWorldBossController")
    end
  end)
  self._uianim = self:GetGameObject("uianim")
  self._myDanInfoArea = self:GetGameObject("MyDanInfoArea")
  self._myDanInfoBg = self:GetUIComponent("RawImageLoader", "MyDanInfoBg")
  self._myDanSimpleArea = self:GetGameObject("MyDanSimpleArea")
  self._myDanBadgeArea = self:GetUIComponent("UISelectObjectPath", "MyDanBadgeArea")
  self._myDanBadgeAreaGo = self:GetGameObject("MyDanBadgeArea")
  self._myDanBadgeAreaRect = self:GetUIComponent("RectTransform", "MyDanBadgeArea")
  self._myLastDanBadgeArea = self:GetUIComponent("UISelectObjectPath", "MyLastDanBadgeArea")
  self._myLastDanBadgeAreaGo = self:GetGameObject("MyLastDanBadgeArea")
  self._myLastDanBadgeAreaRect = self:GetUIComponent("RectTransform", "MyLastDanBadgeArea")
  self._myLastDanDetailAreaGo = self:GetGameObject("MyLastDanDetailArea")
  self._myLastDanNoDanAreaGo = self:GetGameObject("MyLastDanNoDanArea")
  self._myDanText = self:GetUIComponent("UILocalizationText", "MyDanText")
  self._myDanCurTopScoreArea = self:GetGameObject("MyDanCurTopScoreArea")
  self._myDanCurTopScoreNum = self:GetUIComponent("UILocalizationText", "MyDanCurTopScoreNum")
  self._myDanToNextArea = self:GetGameObject("MyDanToNextArea")
  self._myDanToNextTitle = self:GetUIComponent("UILocalizationText", "MyDanToNextTitle")
  self._myDanToNextScoreNum = self:GetUIComponent("UILocalizationText", "MyDanToNextScoreNum")
  self._myDanCurRewardListArea = self:GetUIComponent("RawImageLoader", "MyDanCurRewardListArea")
  self._myDanCurRewards = self:GetGameObject("MyDanCurRewards")
  self._myDanCurRewardsContent = self:GetUIComponent("UISelectObjectPath", "MyDanCurRewardsContent")
  self._danListArea = self:GetGameObject("DanListArea")
  self._danListScroll = self:GetUIComponent("UIDynamicScrollView", "DanListScroll")
  self._myLastDanInfoText = self:GetUIComponent("UILocalizationText", "MyDanLastDanInfoText")
  self._myLastDanHeadTipsText = self:GetUIComponent("UILocalizationText", "MyDanLastDanHeadTips")
  self._head_bg = self:GetUIComponent("UICircleMaskLoader", "HeadBg")
  self._head_bg_rect = self:GetUIComponent("RectTransform", "HeadBg")
  self._head_icon = self:GetUIComponent("RawImageLoader", "HeadIconImg")
  self._head_icon_rect = self:GetUIComponent("RectTransform", "HeadIconImg")
  self._head_frame = self:GetUIComponent("RawImageLoader", "HeadFrame")
  self._head_frame_rect = self:GetUIComponent("RectTransform", "HeadFrame")
  self._head_root_rect = self:GetUIComponent("RectTransform", "MyDanLastDanHeadIconArea")
  self._head_bg_mask_rect = self:GetUIComponent("RectTransform", "HeadBgMask")
  self._headDanBadgeGen = self:GetUIComponent("UISelectObjectPath", "HeadBadgeGen")
  self._headDanBadgeGenGo = self:GetGameObject("HeadBadgeGen")
  self._headDanBadgeGenRect = self:GetUIComponent("RectTransform", "HeadBadgeGen")
  self._remainingTime = self:GetUIComponent("UILocalizationText", "RemainingTime")
  self._playerNameText = self:GetUIComponent("UILocalizationText", "PlayerName")
  self._playerIDText = self:GetUIComponent("UILocalizationText", "PlayerId")
  local s = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self._condiTips = self:GetUIComponent("UISelectObjectPath", "CondiTips")
  self._condiTipsInfo = self._condiTips:SpawnObject("UIWorldBossDanDetailTipsContext")
  self._useBadgeAnim = false
  if self._useBadgeAnim then
    self:_InitWidgetBadgeAnim()
  end
  self._uiTopTab = self:GetUIComponent("RectTransform", "uiTopTab")
  self._tglDan = self:GetChildComponent(self._uiTopTab, "Toggle", "tglDan")
  self._tglCur = self:GetChildComponent(self._uiTopTab, "Toggle", "tglCur")
  self._tglPre = self:GetChildComponent(self._uiTopTab, "Toggle", "tglPre")
  self._uiDanRoot = self:GetUIComponent("RectTransform", "uiDanRoot")
  self._uiCurRoot = self:GetUIComponent("RectTransform", "uiCurRoot")
  self._uiPreRoot = self:GetUIComponent("RectTransform", "uiPreRoot")
  self._idDan = 1
  self._idCur = 2
  self._idPre = 3
  self._tglSheet = {
    [self._idDan] = {
      tgl = self._tglDan,
      txtUncheck = self:GetChildComponent(self._tglDan, "UILocalizationText", "txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglDan, "UILocalizationText", "txtChecked"),
      content = {
        self._uiDanRoot
      }
    },
    [self._idCur] = {
      tgl = self._tglCur,
      txtUncheck = self:GetChildComponent(self._tglCur, "UILocalizationText", "txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglCur, "UILocalizationText", "txtChecked"),
      content = {
        self._uiCurRoot
      }
    },
    [self._idPre] = {
      tgl = self._tglPre,
      txtUncheck = self:GetChildComponent(self._tglPre, "UILocalizationText", "txtUncheck"),
      txtChecked = self:GetChildComponent(self._tglPre, "UILocalizationText", "txtChecked"),
      content = {
        self._uiPreRoot
      }
    }
  }
  self._idSheet = self._idDan
  self._uiCurRoot = self:GetUIComponent("UISelectObjectPath", "uiCurRoot")
  self._uiPreRoot = self:GetUIComponent("UISelectObjectPath", "uiPreRoot")
  self._widgetCurRanking = self._uiCurRoot:SpawnObject("UIWorldBossRanking")
  self._widgetPreRanking = self._uiPreRoot:SpawnObject("UIWorldBossRanking")
end

function UIWorldBossDanDetailController:_InitWidgetBadgeAnim()
  self._anim = self:GetUIComponent("Animation", "UIWorldBossDanDetailController")
  self._rankTextFomAnim = self:GetUIComponent("UILocalizationText", "RankText")
  self._lastDanText = self:GetUIComponent("UILocalizationText", "LastDanText")
  self._lastDanTextGo = self:GetGameObject("LastDanText")
  self._lastDanTextGo:SetActive(false)
  self._curDanAreaGoForAnim = self:GetGameObject("curItem")
  self._lastDanAreaGoForAnim = self:GetGameObject("LastItem")
  self._curBadgeIconBase = self:GetUIComponent("RawImageLoader", "CurDanIcon")
  self._curBadgeIconBaseImg = self:GetUIComponent("RawImage", "CurDanIcon")
  self._curBadgeIconBaseForAnimMr = self:GetUIComponent("MeshRenderer", "CurDanIconForAnim")
  self._curBadgeMaskMr = self:GetUIComponent("MeshRenderer", "CurDanMask")
  self._curBadgeIconBaseGo = self:GetGameObject("CurDanIcon")
  self._curBadgePlusIconGo = self:GetGameObject("CurDanPlusIcon")
  self._curBadgeIconFrontGo = self:GetGameObject("CurDanIconFrontBg")
  self._curBadgeIconFrontText = self:GetUIComponent("UILocalizationText", "CurDanIconFrontText")
  self._curBadgeIconFrontTextBack = self:GetUIComponent("UILocalizationText", "CurDanIconFrontTextBack")
  self._lastBadgeIconBase = self:GetUIComponent("RawImageLoader", "LastDanIconBase")
  self._lastBadgeIconBaseGo = self:GetGameObject("LastDanIconBase")
  self._lastBadgePlusIconGo = self:GetGameObject("LastDanPlusIcon")
  self._lastBadgeIconFrontGo = self:GetGameObject("LastDanIconFrontBg")
  self._lastBadgeIconFrontText = self:GetUIComponent("UILocalizationText", "LastDanIconFrontText")
  self._lastBadgeIconFrontTextBack = self:GetUIComponent("UILocalizationText", "LastDanIconFrontTextBack")
end

function UIWorldBossDanDetailController:_FillCurBadge(danId, rankLevel)
  if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
    self._curBadgeIconBase:LoadImage("1601191_logo")
    self._curBadgeIconBaseGo:SetActive(false)
    self._curBadgeIconFrontGo:SetActive(false)
    return
  end
  local badgeBase = UIWorldBossHelper.GetDanBadgeBase(danId, rankLevel)
  if badgeBase then
    self._curBadgeIconBaseGo:SetActive(true)
    self._curBadgeIconBase:LoadImage(badgeBase)
    self._curBadgeIconBaseForAnimMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    self._curBadgeMaskMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    if 0 < rankLevel then
      self._curBadgeIconFrontGo:SetActive(true)
      self._curBadgeIconFrontText:SetText(tostring(rankLevel))
      if self._curBadgeIconFrontTextBack then
        self._curBadgeIconFrontTextBack:SetText(tostring(rankLevel))
      end
    else
      self._curBadgeIconFrontGo:SetActive(false)
    end
    local bPlus = UIWorldBossHelper.IsPlusDan(danId, rankLevel)
    self._curBadgePlusIconGo:SetActive(bPlus)
  end
  local danName = UIWorldBossHelper.GetDanName(self._danInfo.cur_dan, self._danInfo.my_rank)
  if danName then
    self._myDanText:SetText(StringTable.Get(danName))
  end
end

function UIWorldBossDanDetailController:_FillLastBadge(danId, rankLevel)
  if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
    self._lastBadgeIconBase:LoadImage("1601191_logo")
    self._lastBadgeIconBaseGo:SetActive(false)
    self._lastBadgeIconFrontGo:SetActive(false)
    return
  end
  local badgeBase = UIWorldBossHelper.GetDanBadgeBase(danId, rankLevel)
  if badgeBase then
    self._lastBadgeIconBaseGo:SetActive(true)
    self._lastBadgeIconBase:LoadImage(badgeBase)
    if 0 < rankLevel then
      self._lastBadgeIconFrontGo:SetActive(true)
      self._lastBadgeIconFrontText:SetText(tostring(rankLevel))
      if self._lastBadgeIconFrontTextBack then
        self._lastBadgeIconFrontTextBack:SetText(tostring(rankLevel))
      end
    else
      self._lastBadgeIconFrontGo:SetActive(false)
    end
    local bPlus = UIWorldBossHelper.IsPlusDan(danId, rankLevel)
    self._lastBadgePlusIconGo:SetActive(bPlus)
  end
  local danName = UIWorldBossHelper.GetDanName(danId, rankLevel)
  if danName then
    self._lastDanText:SetText(StringTable.Get(danName))
  end
end

function UIWorldBossDanDetailController:_CheckDoBadgeAnim()
  if self._oldRank > 0 and 0 < self._newRank then
    if self._oldRank <= self._newRank then
      self:_FillCurBadge(self._newDan, self._newRank)
    else
      self:_FillLastBadge(self._oldDan, self._oldRank)
      self:_FillCurBadge(self._oldDan, self._oldRank)
      self._anim:Play("uieff_WorldBoss_Dan_NewRank")
      local te = GameGlobal.Timer():AddEvent(1, function()
        self:_FillCurBadge(self._newDan, self._newRank)
      end)
      self._rankTextFomAnim:SetText(self._oldRank)
      local te1 = GameGlobal.Timer():AddEvent(1155, function()
        local duration = 0.8
        DoTweenHelper.DoUpdateInt(self._oldRank, self._newRank + 1, duration, function(val)
          local rank = math.floor(val)
          self._rankTextFomAnim:SetText(rank)
        end)
      end)
      local te1 = GameGlobal.Timer():AddEvent(2055, function()
        self._rankTextFomAnim:SetText(self._newRank)
      end)
    end
  elseif self._oldDan ~= self._newDan then
    if self._oldRank == 0 and self._newRank == 0 then
      if self._oldDan == 0 then
        self:_FillCurBadge(self._newDan, self._newRank)
      elseif UIWorldBossHelper.IsNormalTopDan(self._newDan, self._newRank) then
        self:_FillLastBadge(self._oldDan, self._oldRank)
        self:_FillCurBadge(self._oldDan, self._oldRank)
        self._anim:Play("uieff_WorldBoss_Dan_NewDan")
        local te = GameGlobal.Timer():AddEvent(1, function()
          self:_FillCurBadge(self._newDan, self._newRank)
        end)
      else
        self:_FillLastBadge(self._oldDan, self._oldRank)
        self:_FillCurBadge(self._oldDan, self._oldRank)
        self._anim:Play("uieff_WorldBoss_Dan_NewDan_Y")
        local te = GameGlobal.Timer():AddEvent(1, function()
          self:_FillCurBadge(self._newDan, self._newRank)
        end)
      end
    elseif 0 < self._newRank then
      self:_FillLastBadge(self._oldDan, self._oldRank)
      self:_FillCurBadge(self._oldDan, self._oldRank)
      self._anim:Play("uieff_WorldBoss_Dan_NewDan")
      local te = GameGlobal.Timer():AddEvent(1, function()
        self:_FillCurBadge(self._newDan, self._newRank)
        local tmpRank = 0
        self._curBadgeIconFrontText:SetText(tostring(tmpRank))
        if self._curBadgeIconFrontTextBack then
          self._curBadgeIconFrontTextBack:SetText(tostring(tmpRank))
        end
      end)
      local te1 = GameGlobal.Timer():AddEvent(3000, function()
        local duration = 0.66
        DoTweenHelper.DoUpdateInt(0, self._newRank, duration, function(val)
          local rank = math.floor(val)
          self._curBadgeIconFrontText:SetText(tostring(rank))
          if self._curBadgeIconFrontTextBack then
            self._curBadgeIconFrontTextBack:SetText(tostring(rank))
          end
        end)
      end)
    else
      self:_FillCurBadge(self._newDan, self._newRank)
    end
  end
  if UIWorldBossHelper.IsNormalTopDan(self._newDan, self._newRank) then
  end
end

function UIWorldBossDanDetailController:RemainingTimeOnClick()
  if self._useBadgeAnim then
    self._oldDan = 14
    self._oldRank = 90
    self._newDan = 14
    self._newRank = 89
    self:_CheckDoBadgeAnim()
  end
end

function UIWorldBossDanDetailController:OnUpdate(deltaTimeMS)
end

function UIWorldBossDanDetailController:_RefreshRemainTime()
  if self._worldBossData then
    local remainTime = self._worldBossData.end_time - self._svrTimeModule:GetServerTime() * 0.001
    if remainTime < 0 and 0 < self._worldBossData.boss_mission_id then
      self._danResulting = true
    else
      self._danResulting = false
    end
    if self._danResulting then
      self._remainingTime:SetText(StringTable.Get("str_world_boss_dan_resulting"))
    else
      self._remainingTime:SetText(StringTable.Get("str_world_boss_remainingtime", self:_GetRemainTime(remainTime)))
    end
  end
end

function UIWorldBossDanDetailController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), "<color=#FFFFFF>" .. timestring .. "</color>")
end

function UIWorldBossDanDetailController:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UIWorldBossDanDetailController:_InitDanListUi()
  if not self._danListUiData then
    return
  end
  self._danListScroll:InitListView(#self._danListUiData, function(scrollview, index)
    return self:_OnGetDanDetailCell(scrollview, index)
  end)
end

function UIWorldBossDanDetailController:_OnGetDanDetailCell(scrollview, index)
  local item = scrollview:NewListViewItem("RowItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIWorldBossDanDetailListItem", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    itemWidget:SetData(self._danListUiData[itemIndex], function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(go, str)
      self:ShowTopConditionTips(go, str)
    end)
    itemWidget:SetIndex(itemIndex)
    self._dicDanWidget[item:GetInstanceID()] = itemWidget
  end
  return item
end

function UIWorldBossDanDetailController:_RefreshUi(bInit)
  self:_MakeUiData(bInit)
  self:_RefreshUiMyDanArea(bInit)
  self:_RefreshUiDanListArea(bInit)
  self:_RefreshRemainTime()
end

function UIWorldBossDanDetailController:_MakeUiData(bInit)
  self._danListUiData = {}
  local normalCfgGroup = Cfg.cfg_world_boss_dan({
    MissionID = self._missionId,
    RankLevel = 0
  })
  local legendCfg = UIWorldBossHelper.GetUiLegendDanCfg(self._missionId)
  for index, value in ipairs(normalCfgGroup) do
    local uiData = DUIWorldBossDanDetailCell:New(value, self._danInfo)
    table.insert(self._danListUiData, uiData)
  end
  local uiData = DUIWorldBossDanDetailCell:New(legendCfg, self._danInfo)
  table.insert(self._danListUiData, uiData)
  UIWorldBossHelper.SortDanDetailUIData(self._danListUiData)
end

function UIWorldBossDanDetailController:_RefreshUiMyDanArea(bInit)
  local bNoDan = UIWorldBossHelper.IsNoDan(self._danInfo.cur_dan, self._danInfo.my_rank)
  self._myDanBadgeAreaGo:SetActive(not bNoDan)
  if not bNoDan then
    if self._useBadgeAnim then
      self:_FillCurBadge(self._danInfo.cur_dan, self._danInfo.my_rank)
      self._curDanAreaGoForAnim:SetActive(true)
    else
      UIWorldBossHelper.InitDanBadge(self._myDanBadgeArea, self._myDanBadgeAreaGo, self._myDanBadgeAreaRect, self._danInfo.cur_dan, self._danInfo.my_rank)
    end
  end
  local danName = UIWorldBossHelper.GetDanName(self._danInfo.cur_dan, self._danInfo.my_rank)
  if danName then
    self._myDanText:SetText(StringTable.Get(danName))
  end
  local showAnim = false
  if bInit and showAnim then
    local te = GameGlobal.Timer():AddEvent(1, function()
      local duration = 0.5
      DoTweenHelper.DoUpdateInt(0, self._danInfo.total_damage, duration, function(val)
        local tmpDamage = math.floor(val)
        self._myDanCurTopScoreNum:SetText(self:_FormatCurMaxDamageNumStr(tmpDamage))
      end)
    end)
    table.insert(self._timeEvents, te)
  else
    self._myDanCurTopScoreNum:SetText(self:_FormatCurMaxDamageNumStr(self._danInfo.total_damage))
  end
  self:_SetToNextDanArea(bInit)
  self:_SetLastDanArea(bInit)
  self:_SetLastDanPlayerInfo(bInit)
end

function UIWorldBossDanDetailController:_RefreshUiDanListArea(bInit)
  if bInit then
    self:_InitDanListUi()
  end
end

function UIWorldBossDanDetailController:_SetToNextDanArea(bInit)
  self._myDanToNextArea:SetActive(true)
  local danToNextTitleStr, danToNextInfoStr
  local bDamageNum = false
  local tarDamageNum = 0
  if 0 < self._danInfo.my_rank then
    if self._danInfo.my_rank == 1 then
      self._myDanToNextArea:SetActive(false)
    else
      local nextRank = self._danInfo.my_rank - 1
      danToNextTitleStr = StringTable.Get("str_world_boss_dan_detail_next_legend_score", nextRank)
      if self._danInfo.promote_one == 0 then
        danToNextInfoStr = StringTable.Get("str_world_boss_calculating")
      else
        danToNextInfoStr = self:_FormatToNextDamageNumStr(self._danInfo.promote_one)
        bDamageNum = true
        tarDamageNum = self._danInfo.promote_one
      end
    end
  elseif UIWorldBossHelper.IsNormalTopDan(self._danInfo.cur_dan, self._danInfo.my_rank) then
    danToNextTitleStr = StringTable.Get("str_world_boss_dan_detail_up_condition")
    if self._danInfo.promote_one == 0 then
      danToNextInfoStr = StringTable.Get("str_world_boss_calculating")
    else
      danToNextInfoStr = self:_FormatToNextDamageNumStr(self._danInfo.promote_one)
      bDamageNum = true
      tarDamageNum = self._danInfo.promote_one
    end
  else
    local nextDan
    if UIWorldBossHelper.IsNoDan(self._danInfo.cur_dan, self._danInfo.my_rank) then
      nextDan = UIWorldBossHelper.GetUiMinDanId(self._missionId)
    else
      nextDan = self._danInfo.cur_dan + 1
    end
    local tmpRankLevel = 0
    local nextNeedDamage = UIWorldBossHelper.GetDanNeedDamage(nextDan, tmpRankLevel)
    local nextDanName = UIWorldBossHelper.GetDanName(nextDan, tmpRankLevel)
    local nextDanNameStr
    if nextDanName then
      nextDanNameStr = StringTable.Get(nextDanName)
      danToNextTitleStr = StringTable.Get("str_world_boss_dan_detail_up_condition", nextDanNameStr)
      danToNextInfoStr = self:_FormatToNextDamageNumStr(nextNeedDamage)
      if nextNeedDamage then
        bDamageNum = true
        tarDamageNum = tonumber(nextNeedDamage)
      end
    end
    danToNextTitleStr = StringTable.Get("str_world_boss_dan_detail_up_condition", nextDanNameStr)
    danToNextInfoStr = self:_FormatToNextDamageNumStr(nextNeedDamage)
  end
  if danToNextTitleStr then
    self._myDanToNextTitle:SetText(danToNextTitleStr)
  end
  if danToNextInfoStr then
    local showAnim = false
    if bInit and showAnim and bDamageNum then
      local te = GameGlobal.Timer():AddEvent(1, function()
        local duration = 0.5
        DoTweenHelper.DoUpdateInt(0, tarDamageNum, duration, function(val)
          local tmpDamage = math.floor(val)
          self._myDanToNextScoreNum:SetText(self:_FormatToNextDamageNumStr(tmpDamage))
        end)
      end)
      table.insert(self._timeEvents, te)
    else
      self._myDanToNextScoreNum:SetText(danToNextInfoStr)
    end
  end
end

function UIWorldBossDanDetailController:_FormatCurMaxDamageNumStr(num)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, num)
  local fmtStr = string.format("<color=#edcc8b>%s</color><color=#edcc8b>%s</color>", preZero, tostring(num))
  return fmtStr
end

function UIWorldBossDanDetailController:_FormatToNextDamageNumStr(num)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, num)
  local fmtStr = string.format("<color=#edcc8b>%s</color><color=#edcc8b>%s</color>", preZero, tostring(num))
  return fmtStr
end

function UIWorldBossDanDetailController:_SetLastDanArea(bInit)
  self._lastDan = self._roleModule:GetWorldBossRecordDan()
  self._lastDanRank = self._roleModule:GetWorldBossRecordRank()
  local bIsNoDan = UIWorldBossHelper.IsNoDan(self._lastDan, self._lastDanRank)
  self._myLastDanDetailAreaGo:SetActive(not bIsNoDan)
  self._myLastDanNoDanAreaGo:SetActive(bIsNoDan)
  if not bIsNoDan then
    local head_dan_badge = UIWorldBossHelper.InitDanBadge(self._myLastDanBadgeArea, self._myLastDanBadgeAreaGo, self._myLastDanBadgeAreaRect, self._lastDan, self._lastDanRank)
    head_dan_badge:RankLevelTransform(Vector2(104, -160), 1.4)
  end
  local lastDanString
  if bIsNoDan then
    lastDanString = StringTable.Get("str_world_boss_dan_detail_no_last_dan")
  elseif self._lastDanRank > 0 then
    local lastDanName = UIWorldBossHelper.GetDanName(self._lastDan, self._lastDanRank)
    if lastDanName then
      lastDanString = StringTable.Get("str_world_boss_dan_detail_last_dan_info_1", StringTable.Get(lastDanName), self._lastDanRank)
    end
  else
    local lastDanName = UIWorldBossHelper.GetDanName(self._lastDan, self._lastDanRank)
    if lastDanName then
      lastDanString = StringTable.Get(lastDanName)
    end
  end
  if lastDanString then
    self._myLastDanInfoText:SetText(lastDanString)
  end
  local lastDanHeadTips
  local bSetShowBadge = self._roleModule:GetBadgeSwitch()
  if UIWorldBossHelper.IsNoDan(self._lastDan, self._lastDanRank) or not bSetShowBadge then
    lastDanHeadTips = StringTable.Get("str_world_boss_dan_detail_last_dan_tips_2")
  else
    lastDanHeadTips = StringTable.Get("str_world_boss_dan_detail_last_dan_tips_1")
  end
  if lastDanHeadTips then
    self._myLastDanHeadTipsText:SetText(lastDanHeadTips)
  end
  local playerInfo = self._roleModule:UI_GetPlayerInfo()
  local headIcon = playerInfo.m_nHeadImageID
  local cfg_header = Cfg.cfg_role_head_image[headIcon]
  if cfg_header then
    self._head_icon:LoadImage(cfg_header.Icon)
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._head_icon_rect, cfg_header.Tag)
  else
    Log.fatal("###UIWorldBossDanDetailController - cfg_header is nil ! id - ", headIcon)
  end
  local headFrame = playerInfo.m_nHeadFrameID
  if not headFrame or headFrame == 0 then
    headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  end
  local cfg_head_frame = Cfg.cfg_role_head_frame[headFrame]
  self._head_frame:LoadImage(cfg_head_frame.Icon)
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._head_bg_rect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._head_bg_mask_rect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._head_frame_rect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._head_root_rect, RoleHeadFrameSizeType.Size5)
  local headBg = playerInfo.m_nHeadColorID
  local cfg_head_bg = Cfg.cfg_player_head_bg[headBg]
  cfg_head_bg = cfg_head_bg or Cfg.cfg_player_head_bg[1]
  self._head_bg:LoadImage(cfg_head_bg.Icon)
  UIWorldBossHelper.InitSelfDanBadgeSimple(self._headDanBadgeGen, self._headDanBadgeGenGo, self._headDanBadgeGenRect)
end

function UIWorldBossDanDetailController:_SetLastDanPlayerInfo(bInit)
  local len = HelperProxy:GetInstance():GetCharLength(self._roleModule:GetName())
  local size = 32
  if 10 < len then
    size = 31
  else
    size = 40
  end
  self._playerNameText.fontSize = size
  self._playerNameText:SetText(self._roleModule:GetName())
  self._playerIDText:SetText("ID:" .. self._loginModule:GetRoleShowID())
end

function UIWorldBossDanDetailController:OnHide()
  self:CallUIMethod("UIWorldBossController", "_FillCurBadge", self._danInfo.cur_dan, self._danInfo.my_rank)
  if self._callBack then
    self._callBack(self._missionId, self._danInfo.cur_dan, self._danInfo.my_rank)
  end
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
end

function UIWorldBossDanDetailController:ShowTopConditionTips(go, str)
  self._condiTipsInfo:SetData(str, go)
end

function UIWorldBossDanDetailController:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIWorldBossDanDetailController:CurRanking()
  self._curRanking = {}
  self._curRankingSelf = nil
  local selfPstid = self._roleModule:GetPstId()
  local modRanking = self._worldBossModule.m_cur_rank_topN
  if modRanking ~= nil then
    modRanking = modRanking.infos
  else
    modRanking = nil
  end
  if modRanking == nil then
    modRanking = {}
  end
  for k, v in pairs(modRanking) do
    local item = RankShowSimpleOne:New()
    item.pstid = v.pstid
    item.head = v.head
    item.head_bg = v.head_bg
    item.frame_id = v.frame_id
    item.damage = v.damage
    item.nick = v.nick
    table.insert(self._curRanking, item)
    if selfPstid == v.pstid then
      self._curRankingSelf = item
      self._curRankingSelf.luaIndex = k
    end
  end
  local rankList = self._worldBossModule.m_rank_damage_list
  local tmp_promote = 0
  local curDan = self._worldBossData.cur_dan
  local curRank = self._worldBossData.rank
  local max_total_damage = self._worldBossData.max_total_damage
  local boss_mission_id = self._worldBossData.boss_mission_id
  local topN = self._worldBossModule.rank_max_show
  curDan, curRank = UIActivityHelper.CalClientDan(rankList, curDan, curRank, tmp_promote, max_total_damage, boss_mission_id)
  local bIsNoDan = UIWorldBossHelper.IsNoDan(curDan, curRank)
  if 0 < curRank and not bIsNoDan then
    local playerInfo = self._roleModule:UI_GetPlayerInfo()
    local headIcon = playerInfo.m_nHeadImageID
    local headBg = playerInfo.m_nHeadColorID
    local HeadFrame = playerInfo.m_nHeadFrameID
    if self._curRankingSelf ~= nil then
      self._curRankingSelf.damage = max_total_damage
    else
      self._curRankingSelf = RankShowSimpleOne:New()
      self._curRankingSelf.pstid = selfPstid
      self._curRankingSelf.head = headIcon
      self._curRankingSelf.head_bg = headBg
      self._curRankingSelf.frame_id = HeadFrame
      self._curRankingSelf.damage = max_total_damage
      self._curRankingSelf.nick = self._roleModule:GetName()
      table.insert(self._curRanking, self._curRankingSelf)
    end
    table.sort(self._curRanking, function(a, b)
      return a.damage > b.damage
    end)
    local count = #self._curRanking
    for i = topN + 1, count do
      self._curRanking[i] = nil
    end
    self._curRankingSelf = nil
    for k, v in pairs(self._curRanking) do
      if selfPstid == v.pstid then
        self._curRankingSelf = v
        self._curRankingSelf.luaIndex = k
        break
      end
    end
    if self._curRankingSelf == nil then
      self._curRankingSelf = RankShowSimpleOne:New()
      self._curRankingSelf.pstid = selfPstid
      self._curRankingSelf.head = headIcon
      self._curRankingSelf.head_bg = headBg
      self._curRankingSelf.frame_id = HeadFrame
      self._curRankingSelf.damage = max_total_damage
      self._curRankingSelf.nick = self._roleModule:GetName()
      self._curRankingSelf.luaIndex = curRank
    end
  end
  for i = topN + 1, #self._curRanking do
    local data = self._curRanking[topN + 1]
    table.remove(self._curRanking, topN + 1)
    if self._curRankingSelf == data then
      self._curRankingSelf.luaIndex = curRank
    end
  end
  if self._curRankingSelf ~= nil then
    local playerInfo = self._roleModule:UI_GetPlayerInfo()
    self._curRankingSelf.head = playerInfo.m_nHeadImageID
    self._curRankingSelf.head_bg = playerInfo.m_nHeadColorID
    self._curRankingSelf.frame_id = playerInfo.m_nHeadFrameID
    self._curRankingSelf.nick = self._roleModule:GetName()
  end
end

function UIWorldBossDanDetailController:PreRanking()
  self._preRanking = self._worldBossModule.m_last_rank_topN
  if self._preRanking ~= nil then
    self._preRanking = self._preRanking.infos
  else
    self._preRanking = nil
  end
  if self._preRanking == nil then
    self._preRanking = {}
  end
  self._preRankingSelf = nil
  local selfPstid = self._roleModule:GetPstId()
  for k, v in pairs(self._preRanking) do
    if selfPstid == v.pstid then
      self._preRankingSelf = v
      self._preRankingSelf.luaIndex = k
      break
    end
  end
  local lastDanRank = self._roleModule:GetWorldBossRecordRank()
  if 0 < lastDanRank and self._preRankingSelf == nil then
    local playerInfo = self._roleModule:UI_GetPlayerInfo()
    local headIcon = playerInfo.m_nHeadImageID
    local headBg = playerInfo.m_nHeadColorID
    local HeadFrame = playerInfo.m_nHeadFrameID
    self._preRankingSelf = RankShowSimpleOne:New()
    self._preRankingSelf.pstid = selfPstid
    self._preRankingSelf.head = headIcon
    self._preRankingSelf.head_bg = headBg
    self._preRankingSelf.frame_id = HeadFrame
    self._preRankingSelf.damage = self._roleModule:GetWorldBossRecordDamage()
    self._preRankingSelf.nick = self._roleModule:GetName()
    self._preRankingSelf.luaIndex = lastDanRank
  end
  if self._preRankingSelf ~= nil then
    local playerInfo = self._roleModule:UI_GetPlayerInfo()
    self._preRankingSelf.head = playerInfo.m_nHeadImageID
    self._preRankingSelf.head_bg = playerInfo.m_nHeadColorID
    self._preRankingSelf.frame_id = playerInfo.m_nHeadFrameID
    self._preRankingSelf.nick = self._roleModule:GetName()
  end
end

function UIWorldBossDanDetailController:OnShowSheet(sheetKey)
  self._idSheet = sheetKey
  local displaySheet = self._tglSheet[sheetKey]
  if displaySheet == nil then
    return
  end
  for k, v in pairs(self._tglSheet) do
    v.tgl.isOn = false
  end
  displaySheet.tgl.isOn = true
  for k, v in pairs(self._tglSheet) do
    v.txtUncheck.gameObject:SetActive(not v.tgl.isOn)
    v.txtChecked.gameObject:SetActive(v.tgl.isOn)
    for k, tr in pairs(v.content) do
      tr.gameObject:SetActive(v.tgl.isOn)
    end
  end
end

function UIWorldBossDanDetailController:DanInAnimation()
  local sortList = {}
  for k, v in pairs(self._dicDanWidget) do
    if v:GetGameObject().activeSelf then
      table.insert(sortList, v)
    end
  end
  table.sort(sortList, function(a, b)
    return a:GetIndex() < b:GetIndex()
  end)
  local lockName = "UIWorldBossDanDetailController:DanInAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(sortList) do
      v:GetGameObject():SetActive(false)
    end
    for k, v in pairs(sortList) do
      v:GetGameObject():SetActive(true)
      v:PlayAnimation("UIWorldBossDanDetailListItem_in")
      YIELD(TT, 30)
    end
    self:UnLock(lockName)
  end)
end

function UIWorldBossDanDetailController:TglDanOnClick(go)
  self:OnShowSheet(self._idDan)
  self:DanInAnimation()
end

function UIWorldBossDanDetailController:TglCurOnClick(go)
  self:OnShowSheet(self._idCur)
  self._widgetCurRanking:InAnimation()
end

function UIWorldBossDanDetailController:TglPreOnClick(go)
  self:OnShowSheet(self._idPre)
  self._widgetPreRanking:InAnimation()
end

function UIWorldBossDanDetailController:FlushCurRanking()
  self._widgetCurRanking:Flush(self._curRanking, self._curRankingSelf, true)
end

function UIWorldBossDanDetailController:FlushPreRanking()
  local idMission = self._worldBossData.boss_mission_id
  local cfg_mission = Cfg.cfg_world_boss_mission[idMission]
  if cfg_mission.HidePreRanking then
    self._tglPre.gameObject:SetActive(false)
  else
    self._tglPre.gameObject:SetActive(true)
    self._widgetPreRanking:Flush(self._preRanking, self._preRankingSelf, false)
  end
end

function UIWorldBossDanDetailController:OnUIQuestWorldBossRest()
  self:CloseDialog()
end
