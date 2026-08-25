local MAX_AWAKER_NUM = 4
local CARD_SHOW_NUM_PER_ROW = 5
local CARD_X_PADDING = 10
local CARD_Y_PADDING = 5
local RELIC_CONTENT_HEIGHT = 160
local RELIC_NUM_PER_ROW = 12
local CARD_CONTENT_POS_Y = -970
local CARD_CONTENT_DELTA = 30
local ALL_CONTENT_HEIGHT = 1461
local Vector3 = CS.UnityEngine.Vector3
local CopySettleBaseView, Super = NewClass("CopySettleBaseView", BaseView)
CopySettleBaseView.uiResCls = UI_Dungeons_Panel_SurveyDataResource

function CopySettleBaseView:ctor()
  Super.ctor(self)
  self:InitViewData()
end

function CopySettleBaseView:InitViewData()
  self.model = CopySettleModel.Instance
  self.cardInfoGroup = {}
  self.frameWaiterGroup = {}
  self.cardCacheObjList = {}
  self.cardCompList = {}
  self.GetTeamDataShowValFuncMap = {
    bossBattleRoundCount = System.fn(self, self.GetShowVal_bossBattleRoundCount),
    leftHp = System.fn(self, self.GetShowVal_leftHp),
    respawnedNum = System.fn(self, self.GetShowVal_respawnedNum)
  }
end

function CopySettleBaseView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnGetCopySettleDataBack, self._OnGetCopySettleDataBack, self)
end

function CopySettleBaseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Back, System.fn(self, self.Close))
  if self.ui.Btn_Copy then
    self:AddButtonClickListener(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
  end
  if self.ui.Btn_CopyStatistics then
    self:AddButtonClickListener(self.ui.Btn_CopyStatistics, System.fn(self, self._OnClickCopyStatistics))
  end
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self._OnClickReplay))
  self:_InitRelicListView()
  self:_InitTeamDataListView()
end

function CopySettleBaseView:_InitTeamDataListView()
  local cellRT = self.ui.UI_Dungeons_Item_TeamData.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.teamDataListView = self:CreateTableview(self.ui.ScrollView_TeamData, function()
    if not self.model:Get_teamDataShowGroup() then
      return 0
    end
    return #self.model:Get_teamDataShowGroup()
  end, function(view, index)
    do return self._TeamDataCellAtIndex, self, view end
    return self._TeamDataCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.teamDataListView:ReloadData()
end

function CopySettleBaseView:_RefreshReplayBtn()
  if UIManager.Instance:GetWindow(Urls.DBGMainCopyOutPanel) then
    self:_SetBtnReplayVisible(false)
  else
    local recordStageData = self.model:GetRecordStageData()
    local wid = recordStageData and recordStageData.wid
    print("---------------refresh replay btn", wid)
    if wid then
      self:_SetBtnReplayVisible(true)
      self:_SetBtnCopyVisible(true)
    else
      self:_SetBtnCopyVisible(false)
      self:_SetBtnReplayVisible(false)
    end
  end
end

function CopySettleBaseView:_SetBtnCopyVisible(visible)
  self:SetActive(self.ui.Btn_Copy, visible)
end

function CopySettleBaseView:_SetBtnReplayVisible(visible)
  if self:_IsRailWayStage() or self.model:GetBanRecordBtn() then
    self:SetActive(self.ui.Btn_Replay, false)
    return
  end
  self:SetActive(self.ui.Btn_Replay, visible)
end

function CopySettleBaseView:_SetBtnCopyStatisticsVisible(visible)
  if not self.ui.Btn_CopyStatistics then
    return
  end
  self:SetActive(self.ui.Btn_CopyStatistics, visible)
end

function CopySettleBaseView:_HasBattleStatisticsData()
  local recordStageData = self.model:GetRecordStageData()
  if type(recordStageData) ~= "table" then
    return false
  end
  local exitList = recordStageData.battleStatPackExitList
  if type(exitList) ~= "table" then
    return false
  end
  for _, exitRow in pairs(exitList) do
    if type(exitRow) == "table" and exitRow.battleStatPack ~= nil then
      return true
    end
  end
  return false
end

function CopySettleBaseView:_CanShowBattleStatisticsBtn()
  local stageTid = self.model:Get_stageTid()
  if not stageTid or 0 == stageTid then
    return false
  end
  if CopyDataUtils.IsPrologue(stageTid) then
    return false
  end
  local stageCfg = DT.Stage[stageTid]
  if not stageCfg then
    return false
  end
  if 1 ~= (stageCfg.DataStatistics or 1) then
    return false
  end
  do return self._HasBattleStatisticsData end
  return self._HasBattleStatisticsData, self
end

function CopySettleBaseView:_RefreshCopyStatisticsBtn()
  self:_SetBtnCopyStatisticsVisible(self:_CanShowBattleStatisticsBtn())
end

function CopySettleBaseView:_IsRailWayStage()
  local stageTid = self.model:Get_stageTid()
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  return stageGroupTid == DT.GetOriginalConstant("RailWayStageGroupTid")
end

function CopySettleBaseView:_TeamDataCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Dungeons_Item_TeamData)
  local teamDataShowGroup = self.model:Get_teamDataShowGroup() or {}
  local stageDataId = teamDataShowGroup[index]
  local lightVal, darkVal = self:GetTeamDataShowVal(stageDataId)
  if stageDataId then
    local viewData = {
      stageDataId = stageDataId,
      lightVal = lightVal,
      darkVal = darkVal
    }
    self:AddViewComponentOnce(cell.gameObject, CopySettleTeamDataItem, viewData)
  end
  return cell
end

function CopySettleBaseView:_InitRelicListView()
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2.transform
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.relicListView = self:CreateTableview(self.ui.ScrollView_Relic, function()
    if not self.model:Get_relicDatas() then
      return 0
    end
    return #self.model:Get_relicDatas()
  end, function(view, index)
    do return self._RelicCellAtIndex, self, view end
    return self._RelicCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.relicListView:ReloadData()
end

function CopySettleBaseView:_RelicCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
  local relicData = self.model:Get_relicDatas()[index]
  local relicTid = relicData.tid
  local relicLayer = relicData.stateLayer or 0
  if relicTid then
    local viewData = {
      isRelic = true,
      relicTid = relicTid,
      clickFunc = function()
        local item = self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({relicTid = relicTid}), {
          stageId = self.model:Get_stageTid()
        })
        local pos = cell.gameObject.transform.position
        item:SetItemPos2(pos)
      end,
      relicBg = RelicCfgUtils.GetRelicBgImage(relicTid),
      isRelicGray = self:CheckRelicGray(relicTid, relicLayer)
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
  end
  return cell
end

function CopySettleBaseView:CheckRelicGray(relicTid, relicLayer)
  local relicConfig = RelicDataUtils.GetRelicConfig(relicTid)
  if not relicConfig then
    return false
  end
  local greyCond = relicConfig.GreyCond
  local stateId = relicConfig.State1 and relicConfig.State1[1]
  if greyCond and stateId and relicLayer == greyCond then
    return true
  end
  return false
end

function CopySettleBaseView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Dropdown_Stage:SetActive(false)
  self:_RefreshView()
end

function CopySettleBaseView:_RefreshView()
  self:_InitTitleUIElement()
  self:_InitAwakerUIElement()
  self:_InitTeamDataUIElement()
  self:_InitTeamAttrUIElement()
  self:_InitKeeperSkillUIElement()
  self:_InitPlayerLevel()
  self:_InitRelicUIElement()
  self:_InitCardUIElement()
  self:_InitStageChapter()
  self:_RefreshReplayBtn()
  self:_RefreshCopyStatisticsBtn()
  self:_InitBtnCopy()
end

function CopySettleBaseView:_InitTitleUIElement()
  local stageTid = self.model:Get_stageTid()
  local title = LT.Text("CopySettleTitle")
  if 0 ~= stageTid then
    title = string.format("%s: %s %s", LT.Text("CopySettleTitle"), LT.Text(CopyDataUtils.GetStageCfgByField("NameNumber", stageTid)), LT.Text(CopyDataUtils.GetStageCfgByField("Name", stageTid)))
  end
  self:SetText(self.ui.Text_StageName, title)
end

function CopySettleBaseView:_InitTeamDataUIElement()
  if self.teamDataListView then
    self.teamDataListView:ReloadData()
  end
end

function CopySettleBaseView:_InitStageChapter()
  local stageTid = self.model:Get_stageTid()
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_StageChapter, CopyChapterMvcItem, stageTid)
  self.ui.UI_Common_Btn_StageChapter:SetActive(stageTid and 0 ~= stageTid)
end

function CopySettleBaseView:_InitBtnCopy()
  self:_SetBtnCopyVisible(true)
end

local showAttrGroup = {
  bc.RoleProperty.occupation_master,
  bc.RoleProperty.basic_damage_per,
  bc.RoleProperty.blackcoin_upgrade_per,
  bc.RoleProperty.death_resist
}

function CopySettleBaseView:_InitTeamAttrUIElement()
  for idx, attrName in ipairs(showAttrGroup) do
    local attrTid = AttrUtils.AttrTypeMap[attrName]
    local attrNameObj = self.ui["Text_Property_" .. idx]
    local attrValObj = self.ui["Text_PropertyData_" .. idx]
    self:SetText(attrNameObj, AttrUtils.GetAttrCfgByField("Text", attrTid))
    self:SetText(attrValObj, self.model:GetTeamShowPropertyByType(attrName))
  end
end

function CopySettleBaseView:_InitKeeperSkillUIElement()
  local keeperSkillTid = self.model:Get_keeperSkillTid() or 0
  local keeperSkillCfg = DT.Item[keeperSkillTid]
  if not keeperSkillCfg then
    self.ui.keyToken:SetActive(false)
    return
  end
  self.ui.keyToken:SetActive(true)
  self:SetText(self.ui.Text_KeyToken, LT.Text(keeperSkillCfg.Name))
  self:SetImage(self.ui.Icon_keyToken, keeperSkillCfg.SpIcon)
  self:AddButtonClickListener(self.ui.Btn_Click_KeyToken, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Icon_keyToken, nil, keeperSkillTid)
  end)
end

function CopySettleBaseView:_InitPlayerLevel()
  local playerLv = self.model:Get_PlayerLv()
  if playerLv and playerLv > 0 then
    self:SetText(self.ui.Text_PlayerLevel, string.format("Lv.<color=#FFFFFF><size=28>%s</size></color>", playerLv))
  else
    self:SetText(self.ui.Text_PlayerLevel, LT.Text("CopySettleNoData"))
  end
end

function CopySettleBaseView:_InitRelicUIElement()
  local relicDatas = self.model:Get_relicDatas()
  if self.relicListView then
    self.relicListView:ReloadData()
  end
  local contentRelicHeight = RELIC_CONTENT_HEIGHT * self:GetRelicRowNum()
  CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView_Relic.transform, contentRelicHeight)
  CS.Framework.TransformUtil.SetHeight(self.ui.Viewport_Relic.transform, contentRelicHeight)
  CS.Framework.TransformUtil.SetHeight(self.ui.Content_Relic.transform, contentRelicHeight)
  if 0 == #relicDatas then
    self.ui.Group_Relic_Null:SetActive(true)
    return
  end
  self.ui.Group_Relic_Null:SetActive(false)
end

function CopySettleBaseView:_InitCardUIElement()
  self:_RecycleCardComps()
  self.cardGoWidth = self.ui.Item_Card_Base.transform.sizeDelta.x
  self.cardGoHeight = self.ui.Item_Card_Base.transform.sizeDelta.y
  self.xPadding = CARD_X_PADDING
  self.yPadding = CARD_Y_PADDING
  local rowNum, colNum = 0, 0
  local settleCardDatas = self.model:Get_settleCardDatas()
  self.cardInfoGroup = {}
  for idx, cardData in ipairs(settleCardDatas) do
    rowNum = math.ceil(idx / CARD_SHOW_NUM_PER_ROW)
    colNum = 0 == idx % CARD_SHOW_NUM_PER_ROW and CARD_SHOW_NUM_PER_ROW or idx % CARD_SHOW_NUM_PER_ROW
    self.cardInfoGroup[idx] = {
      rowNum = rowNum,
      colNum = colNum,
      cardData = cardData
    }
  end
  local relicRowNum = math.max(1, self:GetRelicRowNum())
  local cardContentPosY = CARD_CONTENT_POS_Y - (relicRowNum - 1) * (RELIC_CONTENT_HEIGHT - CARD_CONTENT_DELTA)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.CardContent.transform, self.ui.CardContent.transform.anchoredPosition.x, cardContentPosY)
  local contentAllHeight = ALL_CONTENT_HEIGHT + (rowNum - 1) * (self.cardGoHeight + self.yPadding) + (relicRowNum - 1) * (RELIC_CONTENT_HEIGHT - CARD_CONTENT_DELTA)
  CS.Framework.TransformUtil.SetHeight(self.ui.Content_All.transform, contentAllHeight)
  for idx, cardInfo in ipairs(self.cardInfoGroup) do
    self.frameWaiterGroup[idx] = FrameWaiter.OnNextFrame(function()
      local cardItem = self:_InitCardItem(cardInfo.colNum, cardInfo.rowNum, cardInfo.cardData)
      self.cardCompList[idx] = cardItem
    end, idx)
  end
end

function CopySettleBaseView:_InitCardItem(colNum, rowNum, cardData)
  local cardGO = GameObject.Instantiate(self.ui.Item_Card_Base, self.ui.Group_Card.transform)
  cardGO:SetActive(true)
  CS.Framework.TransformUtil.SetLocalPos(cardGO.transform, self:GetCardLocalPos(colNum, rowNum))
  local skillTid = cardData.tid
  local awakerTid = CardDataUtils.GetSkillCfgByField("AwakerID", skillTid)
  local awakerData = self.model:GetAwakerDataByAwakerTid(awakerTid)
  local runes = cardData.runes or {}
  local runeTid = runes[1] or 0
  local skillLevel = tonumber(cardData.level)
  if not skillLevel or skillLevel <= 0 then
    skillLevel = AwakerDataUtils.GetSkillLevelFromAwakerData(awakerData, skillTid)
  end
  local cardItem = self.binder:BindComponent(CardBaseComponent(cardGO, nil, skillTid, nil, nil, nil, nil, nil, skillLevel, {
    awakerData = awakerData,
    curSkin = awakerData and awakerData.curSkin or cd.DefaultSkinTid,
    runeTid = 0 ~= runeTid and runeTid or nil,
    stateList = cardData.stateList,
    useBattleDesc = false
  }))
  cardItem:SetSkipAutoKeywordTips(true)
  cardItem:SetClickCallback(function()
    local panelData = {
      cardTid = skillTid,
      imageBgHideFlag = false,
      cardDesc = cardItem:GetCardDesc(),
      cardLevel = skillLevel,
      awakerData = awakerData,
      runeTid = 0 ~= runeTid and runeTid or nil,
      stateList = cardData.stateList
    }
    UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
  end)
end

function CopySettleBaseView:GetCardLocalPos(colNum, rowNum)
  local x, y, z
  x = (colNum - 1) * (self.cardGoWidth + self.xPadding)
  y = -(rowNum - 1) * (self.cardGoHeight + self.yPadding)
  z = 0
  return x, y, z
end

function CopySettleBaseView:_InitAwakerUIElement()
  for i = 1, MAX_AWAKER_NUM do
    local obj = self.ui["Awaker_" .. i]
    local awakerData = self.model:Get_settleAwakerDatas()[i]
    self:SetActive(obj, nil ~= awakerData)
    if awakerData then
      local viewData = {
        awakerData = awakerData,
        weaponDatas = self.model:GetAwakerEquipedWeaponDatas(awakerData),
        trinketDatas = self.model:GetAwakerEquipedTrinketDatas(awakerData),
        specialTeamTrinketSuit = self.model:GetSpecialTeamTrinketSuit(awakerData)
      }
      self:AddViewComponentOnce(obj, CopySettleAwakerItem, viewData)
    end
  end
end

function CopySettleBaseView:RefreshOnRendered()
end

function CopySettleBaseView:OnEnterViewFinished()
end

function CopySettleBaseView:OnExitView()
  for _, waiter in ipairs(self.frameWaiterGroup) do
    FrameWaiter.RemoveWaiter(waiter)
  end
  self:_RecycleCardComps()
  CopySettleModel.Instance:SetBanRecordBtn(false)
  Super.OnExitView(self)
end

function CopySettleBaseView:GetRelicRowNum()
  local relicDatas = self.model:Get_relicDatas()
  do return math.ceil end
  return math.ceil, #relicDatas / RELIC_NUM_PER_ROW, RELIC_NUM_PER_ROW
end

function CopySettleBaseView:GetTeamDataShowVal(stageDataId)
  local lightVal, darkVal = "", ""
  local StageCfg = DT.StageData[stageDataId]
  local teamDataKey = StageCfg.Key
  if self.GetTeamDataShowValFuncMap[teamDataKey] then
    lightVal, darkVal = self.GetTeamDataShowValFuncMap[teamDataKey]()
  else
    lightVal = self.model:Get_recordStageDataByField(teamDataKey) or 0
  end
  return lightVal and tostring(lightVal) or "", darkVal and tostring(darkVal) or ""
end

function CopySettleBaseView:GetShowVal_bossBattleRoundCount()
  local bossBattleRoundCount = self.model:Get_recordStageDataByField("bossBattleRoundCount") or 0
  return 0 == bossBattleRoundCount and LT.Text("CopySettleUncleared") or bossBattleRoundCount
end

function CopySettleBaseView:GetShowVal_leftHp()
  local leftHp = self.model:Get_recordStageDataByField("leftHp") or 0
  local maxHp = self.model:Get_recordStageDataByField("maxHp") or 0
  return leftHp, string.format("/%s", maxHp)
end

function CopySettleBaseView:GetShowVal_respawnedNum()
  local respawnedNum = self.model:Get_recordStageDataByField("respawnedNum") or 0
  local stageTid = self.model:Get_stageTid() or 0
  if stageTid <= 0 then
    return respawnedNum
  end
  local cost = AbyssDataUtils.GetStageRespawnCostByStageTid(stageTid)
  if cost > 1 then
    do return math.floor end
    return math.floor, respawnedNum / cost
  end
  return respawnedNum
end

function CopySettleBaseView:_RecycleCardComps()
  if self.cardCompList then
    for i = 1, #self.cardCompList do
      if self.cardCompList[i] and self.cardCompList[i].ui then
        self:_RecycleCardObj(self.cardCompList[i].ui.uiNode)
        self.cardCompList[i].binder:teardown()
        self.cardCompList[i] = nil
      end
    end
  end
end

local FAR_POS = CS.UnityEngine.Vector3(9999, 9999, 0)

function CopySettleBaseView:_RecycleCardObj(cardObj)
  cardObj.transform.localPosition = FAR_POS
  table.insert(self.cardCacheObjList, cardObj)
end

function CopySettleBaseView:_GetCardObj()
  local isObjValid = self.ui and not IsNil(self.ui.Item_Card_Base) and not IsNil(self.ui.Group_Card.transform)
  if not isObjValid then
    return
  end
  local cardObj = table.remove(self.cardCacheObjList, 1)
  if nil == cardObj then
    cardObj = GameObject.Instantiate(self.ui.Item_Card_Base, self.ui.Group_Card.transform)
  end
  self.binder:SetActive(cardObj, true)
  return cardObj
end

function CopySettleBaseView:_OnBtnCopyTeam()
  local stageTid = self.model:Get_stageTid()
  if not stageTid or 0 == stageTid then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  if stageTid and TeamAssignDataUtils.IsForbidCopyTeam(stageTid) then
    Alert.Show("PVETeamShareCodeSpecialTeamAssignTips")
    return
  end
  local teamShareContent = CopySettleModel.Instance:GetTeamShareContent()
  if teamShareContent then
    StrUtils.CopyToClipboard(teamShareContent)
    Alert.ShowStr(LT.Text("PVETeamShareCodeCopyTips"))
    local stageGroupTid = CopyDataUtils.GetStageGroupId(stageTid)
    if stageGroupTid then
      PvpController.Instance:ReqOnCopyOpponentDeck(stageGroupTid)
    end
  end
end

function CopySettleBaseView:OnBtnCopy()
  local btnList = {
    {
      btnFunc = System.fn(self, self._OnBtnCopyTeam),
      btnText = LT.Text("CopyLineup")
    }
  }
  if not self:_IsRailWayStage() and not self.model:GetBanRecordBtn() then
    table.insert(btnList, {
      btnFunc = System.fn(self, self._OnClickCopyBattleRecord),
      btnText = LT.Text("CopyRecording")
    })
  end
  UIManager.Instance:Reopen(Urls.PvpBtnListView, self.ui.Btn_Copy, Vector3(0, 50), btnList)
end

function CopySettleBaseView:_OnClickCopyBattleRecord()
  local stageTid = self.model:Get_stageTid()
  if not stageTid or 0 == stageTid then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  if UIManager.Instance:GetWindow(Urls.DBGMainCopyOutPanel) then
    local settleData = DataCenter.copiesData.copiesSettleData or {}
    if not settleData.isFinish then
      Alert.ShowStr("PvEReplayDefeatTips")
      return
    end
  end
  local recordStageData = self.model:GetRecordStageData()
  local data = {
    stageTid = self.model:Get_stageTid(),
    wid = recordStageData.wid
  }
  PVEBattleReplayUtils.GetShareContent(data, function(shareCode)
    StrUtils.CopyToClipboard(shareCode)
    Alert.ShowStr(LT.Text("PvPReplayCode_Copy"))
  end)
end

function CopySettleBaseView:_OnClickCopyStatistics()
  if not self.ui.Btn_CopyStatistics then
    return
  end
  local recordStageData = self.model:GetRecordStageData() or {}
  local settleAwakers = self.model:Get_settleAwakerDatas() or {}
  local dungeonStatisticMO = DungeonStatisticMO()
  dungeonStatisticMO:UpdateSourceData(settleAwakers, recordStageData, CommonDefine.TeamAssistPos)
  dungeonStatisticMO:RebuildByScope(0, 0)
  UIManager.Instance:Reopen(Urls.CopyBattleStatisticsView, dungeonStatisticMO)
end

function CopySettleBaseView:_OnClickReplay()
  local stageTid = self.model:Get_stageTid()
  if not stageTid or 0 == stageTid then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  if UIManager.Instance:GetWindow(Urls.DBGMainCopyOutPanel) then
    local settleData = DataCenter.copiesData.copiesSettleData or {}
    if not settleData.isFinish then
      Alert.ShowStr("PvEReplayDefeatTips")
      return
    end
  end
  local recordStageData = self.model:GetRecordStageData()
  local wid = recordStageData.wid
  CopyRecordsController.Instance:ReqQueryRecordDetail(stageTid, wid, function(detailData)
    if detailData.battleUuid then
      CopyRecordsController.Instance:ReqPVEBattleRecord(detailData.battleUuid)
    end
  end)
end

function CopySettleBaseView:_OnGetCopySettleDataBack()
  self:_RefreshView()
end

return CopySettleBaseView
