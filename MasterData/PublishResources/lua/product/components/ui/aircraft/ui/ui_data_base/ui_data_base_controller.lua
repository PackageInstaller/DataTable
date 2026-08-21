_class("UIDataBaseController", UIController)
UIDataBaseController = UIDataBaseController

function UIDataBaseController:OnShow(uiParams)
  local id = uiParams[1]
  self._cb = uiParams[2]
  if not id then
    Log.error("###[UIDataBaseController] id is nil !")
  end
  Log.debug("###[UIDataBaseController] id --> ", id)
  self._module = GameGlobal.GetModule(AircraftModule)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._awardid = 0
  self._data = self:_CreateDataByID(id)
  if not self._data then
    Log.error("###[UIDataBaseController] self._data is nil !")
  end
  self:GetComponents()
  self:OnValue()
  self:AddListeners()
end

function UIDataBaseController:_CreateDataByID(id)
  local lock = true
  local allPassInfo = self._module:GetThemeList()
  if allPassInfo[id] then
    lock = false
  else
    local cfg = Cfg.cfg_tactical_db_theme[id]
    local preids = cfg.PreThemeID
    if not preids then
      lock = false
    else
      local allNodeUnLock = true
      for i = 1, #preids do
        local preid = preids[i]
        local preNodeData = allPassInfo[preid]
        if preNodeData then
          local pre_unlock_infos = preNodeData.unlock_info_list
          local cfg_pre = Cfg.cfg_tactical_db_theme[preid]
          local pre_infos = cfg_pre.InfoIDList
          local allInfoUnLock = true
          for i = 1, #pre_infos do
            local infoid = pre_infos[i]
            if not table.icontains(pre_unlock_infos, infoid) then
              allInfoUnLock = false
              break
            end
          end
          if not allInfoUnLock then
            allNodeUnLock = false
            break
          end
        else
          allNodeUnLock = false
          break
        end
      end
      if allNodeUnLock then
        lock = false
      end
    end
  end
  local passList = {}
  if allPassInfo[id] and allPassInfo[id].unlock_info_list and table.count(allPassInfo[id].unlock_info_list) > 0 then
    passList = allPassInfo[id].unlock_info_list
  end
  local got = false
  local themeDataList = self._module:GetThemeList()
  if themeDataList and table.count(themeDataList) > 0 then
    local themeData = themeDataList[id]
    if themeData and themeData.rewarded then
      got = true
    end
  end
  local data = DataBaseNodeData:New(id, lock, got, passList)
  return data
end

function UIDataBaseController:BackBtn()
  self:CloseDialog()
end

function UIDataBaseController:OnHide()
  if self._cb then
    self._cb()
  end
end

function UIDataBaseController:HelpBtn()
  self:ShowDialog("UIHelpController", "UIDataBase")
end

function UIDataBaseController:GetComponents()
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:BackBtn()
  end, nil, nil, true)
  local sop = self:GetUIComponent("UISelectObjectPath", "menu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._dataInfoPool = self:GetUIComponent("UISelectObjectPath", "dataInfoPool")
  self._conditionPool = self:GetUIComponent("UISelectObjectPath", "conditionPool")
  self._conditionGo_group = self:GetUIComponent("CanvasGroup", "conditionPool")
  self._getInfoBtn_group = self:GetUIComponent("CanvasGroup", "getInfoBtn")
  self._infoLockTips_group = self:GetUIComponent("CanvasGroup", "infoLockTips")
  self._descScrollView_group = self:GetUIComponent("CanvasGroup", "descScrollView")
  self._descTex = self:GetUIComponent("UILocalizationText", "descTex")
  self._awardTex = self:GetUIComponent("UILocalizationText", "awardTex")
  self._gotAward = self:GetGameObject("gotAward")
  self._getAward = self:GetGameObject("getAward")
  self._awardName = self:GetUIComponent("UILocalizationText", "awardName")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._db_atlas = self:GetAsset("UIAircraftDataBase.spriteatlas", LoadType.SpriteAtlas)
  self._sp1 = self._db_atlas:GetSprite("n8_database_tag1")
  self._sp2 = self._db_atlas:GetSprite("n8_database_tag2")
  self._uiItemGo = self:GetGameObject("uiitem")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._uiItem = sop:SpawnObject("UIItem")
  self._uiItem:SetForm(UIItemForm.Base, UIItemScale.Level1)
  self._uiItem:SetClickCallBack(function()
    self:awardItemOnClick()
  end)
end

function UIDataBaseController:awardItemOnClick()
  self._tips:SetData(self._awardid, self._uiItemGo.transform.position)
end

function UIDataBaseController:AddListeners()
  self:AttachEvent(GameEventType.ItemCountChanged, self.RefreshItemInfo)
end

function UIDataBaseController:OnValue()
  self:RefreshItemInfo()
  self:Icon()
  self:DataInfos()
  self:Award()
  self:Desc()
end

function UIDataBaseController:RefreshItemInfo()
  local cfg_value = Cfg.cfg_aircraft_values[37].StringValue
  local s1 = string.split(cfg_value, "|")
  local topTips = {}
  local cfg_top_tips = Cfg.cfg_top_tips({})
  self._id2sprite = {}
  for i = 1, #s1 do
    local id = tonumber(s1[i])
    table.insert(topTips, id)
    local icon = cfg_top_tips[id].Icon
    local sprite = self.atlas:GetSprite(icon)
    self._id2sprite[id] = sprite
  end
  self.currencyMenu:SetData(topTips, true)
end

function UIDataBaseController:Icon()
  local icon = self._data:GetIcon()
  self._icon:LoadImage(icon)
  local name = self._data:GetName()
  self._name:SetText(StringTable.Get(name))
end

function UIDataBaseController:DataInfos()
  self._dataInfos = self._data:GetDataInfos()
  if not self._dataInfos or table.count(self._dataInfos) <= 0 then
    Log.error("###[UIDataBaseController] dataInfos is nil or 0 !")
  end
  self._dataInfoPool:SpawnObjects("UIDataBaseInfoItem", #self._dataInfos)
  local items = self._dataInfoPool:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    local info = self._dataInfos[i]
    item:SetData(i, info, self._sp1, self._sp2, function(idx)
      self:InfoClick(idx)
    end)
  end
  self._infoIdx = 1
  self._info = self._dataInfos[self._infoIdx]
end

function UIDataBaseController:InfoClick(idx)
  if self._infoIdx == idx then
    return
  end
  self._infoIdx = idx
  self._info = self._dataInfos[self._infoIdx]
  self:Desc(true)
end

function UIDataBaseController:Award()
  local award = self._data:GetAward()
  self._awardid = award.assetid or 0
  self._awardcount = award.count or 0
  local cfg_item = Cfg.cfg_item[award.assetid]
  if not cfg_item then
    Log.error("###[UIDataBaseController] cfg_item is nil ! id --> ", self._awardid)
  end
  self._awardName:SetText(StringTable.Get(cfg_item.Name))
  self._awardTex:SetText(StringTable.Get(self._data:GetAwardDec()))
  local got = self._data:AwardGot()
  if got then
    self._gotAward:SetActive(true)
    self._getAward:SetActive(false)
  else
    self._gotAward:SetActive(false)
    local infos = self._data:GetDataInfos()
    local lock = false
    for i = 1, #infos do
      local info = infos[i]
      if info:GetLock() then
        lock = true
        break
      end
    end
    if lock then
      self._getAward:SetActive(false)
    else
      self._getAward:SetActive(true)
    end
  end
  self:SetAwardData()
end

function UIDataBaseController:SetAwardData()
  local v = Award:New()
  v:InitWithCount(self._awardid, self._awardcount)
  local icon = v.icon
  local quality = v.color
  local text1 = v.count
  local itemId = v.id
  self._uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = itemId
  })
end

function UIDataBaseController:DescAnim(anim)
  local time
  if anim then
    time = 0.2
  else
    time = 0
  end
  local alpha1 = 0
  local alpha2 = 0
  local alpha3 = 0
  if self._infoState == 3 then
    alpha3 = 1
  end
  if self._infoState == 2 then
    alpha2 = 1
  end
  if self._infoState == 1 then
    alpha1 = 1
  end
  self._descScrollView_group:DOFade(alpha3, time)
  self._infoLockTips_group:DOFade(alpha1, time)
  self._getInfoBtn_group:DOFade(alpha2, time)
  self._conditionGo_group:DOFade(alpha2, time)
  self._descScrollView_group.blocksRaycasts = self._infoState == 3
  self._infoLockTips_group.blocksRaycasts = self._infoState == 1
  self._getInfoBtn_group.blocksRaycasts = self._infoState == 2
  self._conditionGo_group.blocksRaycasts = self._infoState == 2
end

function UIDataBaseController:Desc(anim)
  local lock = self._data:GetLock()
  local infoLock = self._info:GetLock()
  if lock then
    self._infoState = 1
  elseif infoLock then
    self._infoState = 2
  else
    self._infoState = 3
  end
  self:DescAnim(anim)
  if not lock then
    if infoLock then
      local conditions = self._info:GetConditions()
      self._conditionPool:SpawnObjects("UIDataBaseConditionItem", #conditions)
      local items = self._conditionPool:GetAllSpawnList()
      for i = 1, #items do
        local item = items[i]
        local condition = conditions[i]
        item:SetData(i, condition, self._id2sprite[condition:GetID()])
      end
    else
      local tex = self._info:GetDesc()
      self._descTex:SetText(StringTable.Get(tex))
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDataBaseInfoItemClick, self._infoIdx, anim)
end

function UIDataBaseController:getInfoBtnOnClick(go)
  local lock = self._data:GetLock()
  if not lock then
    local red = self._info:GetRed()
    if not red then
      local tex = "str_aircraft_tip_mat_not_enough"
      ToastManager.ShowToast(StringTable.Get(tex))
    else
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_aircraft_tactic_db_info_pop_title"), function(param)
        self:OnGetInfoBtnOnClick()
      end, nil, function(param)
        Log.debug("###[UIDataBaseController] getInfoBtnOnClick cancel ..")
      end, nil)
    end
  else
    local tex = "str_aircraft_tactic_db_info_node_lock"
    ToastManager.ShowToast(StringTable.Get(tex))
  end
end

function UIDataBaseController:OnGetInfoBtnOnClick()
  self:Lock("UIDataBaseController:getInfoBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.UnLockInfo, self)
end

function UIDataBaseController:UnLockInfo(TT)
  local infoid = self._info:GetID()
  local nodeid = self._data:GetID()
  self._info:UnLock()
  Log.debug("###[UIDataBaseController] :UnLockInfo(TT) nifoid --> ", infoid, "| nodeid --> ", nodeid)
  local res = self._module:TacticGetInformation(TT, nodeid, infoid)
  self:UnLock("UIDataBaseController:getInfoBtnOnClick")
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_tactic_db_info_succ_tips"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDataBaseInfoUnLock)
    self._info:UnLock()
    self:Desc()
    self:Award()
  else
    local result = res:GetResult()
    Log.error("###[UIDataBaseController] GetUnLockInfo fail ! result --> ", result)
  end
end

function UIDataBaseController:getAwardOnClick(go)
  self:Lock("UIDataBaseController:getAwardOnClick")
  GameGlobal.TaskManager():StartTask(self.OnGetAward, self)
end

function UIDataBaseController:OnGetAward(TT)
  local res = self._module:TacticUnlockTheme(TT, self._data:GetID())
  self:UnLock("UIDataBaseController:getAwardOnClick")
  if res:GetSucc() then
    self._data:GotAward()
    self:Award()
    local awards = {}
    local award = self._data:GetAward()
    awards[1] = award
    self:_ShowAwards(awards)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDataBaseInfoGetAward)
  else
    local result = res:GetResult()
    Log.error("###[UIDataBaseController] OnGetAward fail ! result --> ", result)
  end
end

function UIDataBaseController:_ShowAwards(awards)
  local tempPets = {}
  if 0 < #awards then
    for i = 1, #awards do
      local ispet = self._petModule:IsPetID(awards[i].assetid)
      if ispet then
        table.insert(tempPets, awards[i])
      end
    end
  end
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", awards)
    end)
  else
    self:ShowDialog("UIGetItemController", awards)
  end
end
