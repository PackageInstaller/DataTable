_class("UITowerLayerController", UIController)
UITowerLayerController = UITowerLayerController

function UITowerLayerController:LoadDataOnEnter(TT, res)
  local module = self:GetModule(TowerModule)
  local result, data = module:ReqPlayerTowerData(TT)
  if result:GetSucc() then
    Log.notice("[Tower] 请求尖塔数据成功，打开ui")
    res:SetSucc(true)
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
    res:SetSucc(false)
  end
end

function UITowerLayerController:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topButtons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:SwitchState(UIStateType.UITower)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self._elememt = uiParams[1]
  self:ShowTowerBG()
  self._module = self:GetModule(TowerModule)
  local ceiling = self._module:GetTowerCeiling(self._elememt)
  local cur = self._module:GetTowerLayer(self._elememt)
  self._passTower = false
  if ceiling <= cur then
    self._curLayer = ceiling
    self._passTower = true
  else
    self._curLayer = cur + 1
  end
  self._towerData = self._module:GetPlayerTowerData()
  local ctx = self:GetModule(MissionModule):TeamCtx()
  ctx:InitTowerTeam(self._towerData.mul_formations)
  self:Lock(self:GetName())
  self._enterTimer = GameGlobal:Timer():AddEvent(1000, function()
    self:UnLock(self:GetName())
    self._enterTimer = nil
  end)
  self:Init()
  self._curSelect = -1
  self:OnSelect(self._curLayer, false)
  self._switchPlayer = EZTL_Player:New()
  self._switchTL = EZTL_Sequence:New({
    EZTL_Callback:New(function()
      self:Lock(self:GetName())
    end, "锁ui"),
    EZTL_PlayAnimation:New(self._animation, "uieff_TowerLayer_Switch_Out", "淡出"),
    EZTL_Callback:New(function()
      self:Refresh(self._curSelect)
    end, "切ui"),
    EZTL_PlayAnimation:New(self._animation, "uieff_TowerLayer_Switch_In", "淡入"),
    EZTL_Callback:New(function()
      self:UnLock(self:GetName())
    end, "解锁ui")
  }, "尖塔切换动画")
end

function UITowerLayerController:OnHide()
  if self._enterTimer then
    GameGlobal:Timer():CancelEvent(self._enterTimer)
    self._enterTimer = nil
  end
  self._enemies = nil
end

function UITowerLayerController:InitWidget()
  self.topButtons = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.curLayer = self:GetUIComponent("UILocalizationText", "curLayer")
  self.btmMask = self:GetUIComponent("Image", "BtmMask")
  self.towerName = self:GetUIComponent("UILocalizationText", "towerName")
  self.wordParent = self:GetGameObject("wordParent")
  self.titlebg_1 = self:GetUIComponent("Image", "titlebg_1")
  self.word = self:GetUIComponent("UILocalizationText", "word")
  self.formation = self:GetUIComponent("UILocalizationText", "formation")
  self.titlebg_2 = self:GetUIComponent("Image", "titlebg_2")
  self.enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self.titlebg_3 = self:GetUIComponent("Image", "titlebg_3")
  self.recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self.recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self.awardContent = self:GetUIComponent("UISelectObjectPath", "AwardContent")
  self.titlebg_4 = self:GetUIComponent("Image", "titlebg_4")
  self.curTopLayer = self:GetUIComponent("UILocalizationText", "curTopLayer")
  self.btnBattle = self:GetUIComponent("Button", "BattleButton")
  self.imgBattle = self:GetUIComponent("Image", "BattleButton")
  self.txtChallenge = self:GetUIComponent("UILocalizationText", "txtChallenge")
  self.recommendParent = self:GetGameObject("NeedLevel")
  self.layerScrollView = self:GetUIComponent("TowerScrollView", "LayerScrollView")
  self.matTip = self:GetUIComponent("UISelectObjectPath", "MatTip")
  self._animation = self:GetUIComponent("Animation", "UITowerLayer")
  self._unreach = self:GetGameObject("unreach")
  self._hardRope = self:GetGameObject("HardRope")
  self._normalRope = self:GetGameObject("NormalRope")
  self._normalLeftBg = self:GetUIComponent("RawImageLoader", "NormalLeftBg")
  self._leftRope = self:GetUIComponent("RawImage", "LeftRope")
  self._rightRope = self:GetUIComponent("RawImage", "RightRope")
  self._leftRopeLoad = self:GetUIComponent("RawImageLoader", "LeftRope")
  self._rightRopeLoad = self:GetUIComponent("RawImageLoader", "RightRope")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self.rect = UnityEngine.Rect:New(0, 0, 1, 1)
  self.rightRect = UnityEngine.Rect:New(0, 0, 1, 1)
  self._viewport = self:GetGameObject("Viewport")
  self._layerScrollRect = self:GetUIComponent("ScrollRect", "LayerScrollView")
  self.lastvalue = nil
  self._layerScrollRect.onValueChanged:AddListener(function(value)
    if value.y < 0.001 then
      return
    end
    self:OnValueChanged(value)
  end)
end

function UITowerLayerController:SetTexture()
  self._leftRope.material.mainTexture.wrapMode = UnityEngine.TextureWrapMode.Repeat
  self._rightRope.material.mainTexture.wrapMode = UnityEngine.TextureWrapMode.Repeat
end

function UITowerLayerController:OnValueChanged(value)
  local nowvalue = value.y
  if self.lastvalue == nil then
    self.lastvalue = value.y
  end
  local change = self.lastvalue - nowvalue
  local y = self._content.rect.height / 2000
  change = change * y
  self.rect.y = self.rect.y + change
  self.rightRect.y = self.rightRect.y - change
  self._leftRope.uvRect = self.rect
  self._rightRope.uvRect = self.rightRect
  self.lastvalue = nowvalue
end

function UITowerLayerController:ShowTowerBG()
  if self._elememt > 4 then
    self._hardRope:SetActive(true)
    self._normalRope:SetActive(false)
  else
    self._hardRope:SetActive(false)
    self._normalRope:SetActive(true)
  end
end

function UITowerLayerController:Init()
  self.uiConfig = {
    [TowerElementType.TowerElementType_Blue] = {
      formateText = "str_tower_formation_water",
      BG = "tower_guanqia_frame12"
    },
    [TowerElementType.TowerElementType_Red] = {
      formateText = "str_tower_formation_fire",
      BG = "tower_guanqia_frame13"
    },
    [TowerElementType.TowerElementType_Green] = {
      formateText = "str_tower_formation_wood",
      BG = "tower_guanqia_frame14"
    },
    [TowerElementType.TowerElementType_Yellow] = {
      formateText = "str_tower_formation_thunder",
      BG = "tower_guanqia_frame15"
    },
    [TowerElementType.TowerElementType_Difficulty_Blue] = {
      formateText = "str_tower_formation_water",
      BG = "tower_guanqia2_shui",
      Rope = "ht_sl_di04"
    },
    [TowerElementType.TowerElementType_Difficulty_Red] = {
      formateText = "str_tower_formation_fire",
      BG = "tower_guanqia2_huo",
      Rope = "ht_sl_di01"
    },
    [TowerElementType.TowerElementType_Difficulty_Green] = {
      formateText = "str_tower_formation_wood",
      BG = "tower_guanqia2_sen",
      Rope = "ht_sl_di03"
    },
    [TowerElementType.TowerElementType_Difficulty_Yellow] = {
      formateText = "str_tower_formation_thunder",
      BG = "tower_guanqia2_lei",
      Rope = "ht_sl_di02"
    }
  }
  self.curTopLayer:SetText(string.format(StringTable.Get("str_tower_cur_max_layer"), self._curLayer))
  local atlas = self:GetAsset("UITower.spriteatlas", LoadType.SpriteAtlas)
  self._bossTitleBg = atlas:GetSprite("tower_guanqia_tiao2")
  self._normalTitleBg = atlas:GetSprite("tower_guanqia_tiao1")
  self._bossBtmBg = atlas:GetSprite("tower_guanqia_frame7")
  self._normalBtmBg = atlas:GetSprite("tower_guanqia_frame6")
  self._formateText = StringTable.Get(self.uiConfig[self._elememt].formateText)
  self.towerName:SetText(self._module:GetTowerName(self._elememt))
  local module = self:GetModule(TowerModule)
  self._layerData = module:GetElementTowerCfg(self._elememt)
  self._normalLeftBg:LoadImage(self.uiConfig[self._elememt].BG)
  if self._elememt > 4 then
    self._leftRopeLoad:LoadImage(self.uiConfig[self._elememt].Rope)
    self._rightRopeLoad:LoadImage(self.uiConfig[self._elememt].Rope)
    self:SetTexture()
  end
  self:InitTower()
end

function UITowerLayerController:InitTower()
  self._groupLayer = 5
  
  local function com(a, b)
    return a.stage < b.stage
  end
  
  table.sort(self._layerData, com)
  self._groupCfgs = Cfg.cfg_tower_layer_group({
    Type = self._elememt
  })
  
  local function gcom(a, b)
    return a.ID < b.ID
  end
  
  table.sort(self._groupCfgs, gcom)
  local contentHeight = 0
  self._groupHeight = 928
  local layerCountData = #self._layerData
  local laterCountTemplate = #self._groupCfgs
  local previewCount = 5
  local maxPreviewLayer = math.min(self._curLayer + previewCount - 1, layerCountData)
  local groupCount = math.floor(maxPreviewLayer / self._groupLayer)
  local extra = maxPreviewLayer % self._groupLayer
  local posY = 0
  if 0 < extra then
    local idxTpl = maxPreviewLayer % laterCountTemplate + 1
    if idxTpl < 1 or laterCountTemplate < idxTpl then
      Log.fatal("### invalid idx.", laterCountTemplate, idxTpl, maxPreviewLayer)
      idxTpl = Mathf.Clamp(idxTpl, 1, laterCountTemplate)
    end
    local gcfg = self._groupCfgs[idxTpl]
    local pcfg = Cfg.cfg_tower_layer_position[gcfg.Pos]
    posY = pcfg["Pos" .. extra][2]
  end
  contentHeight = groupCount * self._groupHeight + posY + 150
  contentHeight = Mathf.Clamp(contentHeight, self._groupHeight + 1, laterCountTemplate * self._groupHeight)
  local focusY = self:_calPosY(self._curLayer)
  self._layerItems = {}
  self.layerScrollView:Init(contentHeight, self._groupHeight, function(idx, item)
    self:NewLayerGroup(idx, item)
  end)
  self.layerScrollView:FocusPosY(focusY, false)
end

function UITowerLayerController:_calPosY(layer)
  local curGroup = math.floor(layer / self._groupLayer)
  local curGroupIdx = layer % self._groupLayer
  if 0 < curGroupIdx then
    curGroup = curGroup + 1
  else
    curGroupIdx = self._groupLayer
  end
  local curBtnPos = Cfg.cfg_tower_layer_position[self._groupCfgs[curGroup].Pos]["Pos" .. curGroupIdx]
  return (curGroup - 1) * self._groupHeight + curBtnPos[2] - 20
end

function UITowerLayerController:NewLayerGroup(index, item)
  index = index + 1
  if index > #self._groupCfgs then
    return
  end
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item)
  local group = pool:SpawnObject("UITowerLayerGroup")
  local nextGroupFirstPointPos
  local nextGroupCfg = self._groupCfgs[index + 1]
  if nextGroupCfg then
    local lastGroupPos = Cfg.cfg_tower_layer_position[nextGroupCfg.Pos]
    nextGroupFirstPointPos = Vector2(lastGroupPos.Pos1[1], lastGroupPos.Pos1[2] + self._groupHeight)
  end
  group:SetData(index, self._groupCfgs, self._groupLayer * (index - 1), self._layerData, nextGroupFirstPointPos, self._curLayer, self._passTower, self._curSelect, function(idx)
    self:OnSelect(idx, true)
  end)
end

function UITowerLayerController:OnSelect(idx, anim)
  local timer = 0
  if self._curSelect == idx then
    return
  end
  self._curSelect = idx
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TowerLayerOnSelect, idx)
  if anim then
    self._switchPlayer:Play(self._switchTL)
    self.layerScrollView:FocusPosY(self:_calPosY(idx), true)
  else
    self:Refresh(idx)
  end
end

function UITowerLayerController:Refresh(idx)
  local cfg = self._layerData[idx]
  if cfg == nil then
    Log.exception("[Tower] 找不到尖塔配置，类型：", self._elememt, "，层数：", idx)
    return
  end
  self.curLayer:SetText(string.format(StringTable.Get("str_tower_cur_layer"), idx))
  if cfg.WordBuff then
    if type(cfg.WordBuff) == "table" then
      local buffCount = #cfg.WordBuff
      if 0 < buffCount then
        local detailsStr
        for index, buffId in ipairs(cfg.WordBuff) do
          local wordCfg = Cfg.cfg_word_buff[buffId]
          if wordCfg == nil then
            Log.exception("[Tower] 找不到尖塔词缀，类型：", self._elememt, "，层数：", idx, "，词缀：", buffId)
          else
            local detail = StringTable.Get(wordCfg.Desc)
            if detailsStr then
              detailsStr = detailsStr .. "\n" .. detail
            else
              detailsStr = detail
            end
          end
        end
        self.word:SetText(detailsStr)
        self.wordParent:SetActive(true)
      else
        self.wordParent:SetActive(false)
      end
    else
      local wordCfg = Cfg.cfg_word_buff[cfg.WordBuff]
      if wordCfg == nil then
        Log.exception("[Tower] 找不到尖塔词缀，类型：", self._elememt, "，层数：", idx, "，词缀：", cfg.WordBuff)
      else
        self.word:SetText(StringTable.Get(wordCfg.Desc))
        self.wordParent:SetActive(true)
      end
    end
  else
    self.wordParent:SetActive(false)
  end
  self.formation:SetText(string.format(self._formateText, cfg.PetNumber))
  local monsters = self:GetMonsterIDs(cfg)
  if self._enemies == nil then
    self._enemies = self.enemyMsg:SpawnObject("UIEnemyMsg")
  end
  self._enemies:SetData(cfg.FightLevelid)
  self:FlushRecommendLV(cfg)
  local dropItems = UICommonHelper:GetInstance():GetDropByAwardType(StageAwardType.First, cfg)
  self.awardContent:SpawnObjects("UIItem", #dropItems)
  local items = self.awardContent:GetAllSpawnList()
  local awardText
  if idx >= self._curLayer and not self._passTower then
    awardText = StringTable.Get("str_discovery_first_award")
  else
    awardText = StringTable.Get("str_discovery_already_collect")
  end
  for i, item in ipairs(dropItems) do
    items[i]:SetForm(UIItemForm.Tower, UIItemScale.Level3)
    local cfgItem = Cfg.cfg_item[item.ItemID]
    items[i]:SetData({
      text1 = item.Count,
      icon = cfgItem.Icon,
      awardText = awardText,
      itemId = item.ItemID,
      quality = cfgItem.Color
    })
    items[i]:SetClickCallBack(function(go)
      self:OnClickAwardItem(item.ItemID, go.transform.position)
    end)
  end
  if cfg.BossLevel then
    self.titlebg_1.sprite = self._bossTitleBg
    self.titlebg_2.sprite = self._bossTitleBg
    self.titlebg_3.sprite = self._bossTitleBg
    self.titlebg_4.sprite = self._bossTitleBg
    self.btmMask.sprite = self._bossBtmBg
  else
    self.titlebg_1.sprite = self._normalTitleBg
    self.titlebg_2.sprite = self._normalTitleBg
    self.titlebg_3.sprite = self._normalTitleBg
    self.titlebg_4.sprite = self._normalTitleBg
    self.btmMask.sprite = self._normalBtmBg
  end
  if self:IsSelectedOpen() then
    self._unreach:SetActive(false)
    self.txtChallenge:SetText(StringTable.Get("str_discovery_challenge"))
  else
    self._unreach:SetActive(true)
    self.txtChallenge:SetText(StringTable.Get("str_tower_not_open"))
  end
end

function UITowerLayerController:FlushRecommendLV(cfg)
  local isOpen = self:IsSelectedOpen()
  if not isOpen then
    self.recommendParent:SetActive(true)
    self.recommendLV.gameObject:SetActive(true)
    self.recommendLV:SetText("???")
    self.recommendLV2.gameObject:SetActive(false)
    return
  end
  local needAwake = cfg.NeedAwake or 0
  local needLevel = cfg.NeedLevel or 0
  if needAwake == 0 and needLevel == 0 then
    self.recommendParent:SetActive(false)
    return
  end
  self.recommendParent:SetActive(true)
  if 0 < needAwake then
    self.recommendLV.gameObject:SetActive(true)
    self.recommendLV:SetText(StringTable.Get("str_pet_config_common_advance") .. "<size=29>" .. needAwake .. "</size>")
  else
    self.recommendLV.gameObject:SetActive(false)
  end
  if 0 < needLevel then
    self.recommendLV2.gameObject:SetActive(true)
    self.recommendLV2:SetText("LV." .. needLevel)
  else
    self.recommendLV2.gameObject:SetActive(false)
  end
end

function UITowerLayerController:GetMonsterIDs(cfg)
  local ms = {}
  local levelCfg = Cfg.cfg_level[cfg.FightLevelid]
  if levelCfg == nil then
    Log.fatal("[Tower] 找不到尖塔关卡:", cfg.FightLevelid)
    return
  end
  for _, wave in ipairs(levelCfg.MonsterWave) do
    local waveCfg = Cfg.cfg_monster_wave[wave]
    if waveCfg == nil then
      Log.fatal("[Tower] 找不到尖塔波次：", wave)
      return
    end
    local refreshCfg = Cfg.cfg_refresh[waveCfg.WaveBeginRefreshID]
    if refreshCfg == nil then
      Log.fatal("[Tower] 找不到尖塔Refresh配置：", waveCfg.WaveBeginRefreshID)
      return
    end
    local monsterIDs = refreshCfg.MonsterRefreshIDList[1]
    local monstersCfg = Cfg.cfg_refresh_monster[monsterIDs]
    if monstersCfg == nil then
      Log.fatal("[Tower] 找不到尖塔怪物波次：", monsterIDs)
      return
    end
    table.appendArray(ms, monstersCfg.MonsterIDList)
  end
  return ms
end

function UITowerLayerController:RecordButtonOnClick(go)
  local id = self._layerData[self._curSelect].ID
  self:StartTask(self.ReqTowerRecord, self, id)
end

function UITowerLayerController:BattleButtonOnClick(go)
  if not self:IsSelectedOpen() then
    ToastManager.ShowToast(StringTable.Get("str_tower_unreach"))
    return
  end
  local ceiling = self._layerData[self._curSelect].PetNumber
  local id = self._layerData[self._curSelect].ID
  local ctx = self:GetModule(MissionModule):TeamCtx()
  ctx:Init(TeamOpenerType.Tower)
  ctx:SetTowerContext(ceiling, self._elememt, id)
  self:ShowDialog("UITeams", function()
    SerialAutoFightModule.QuickSetData_Tower(self._autoFight, id)
  end)
end

function UITowerLayerController:ReqTowerRecord(TT, layerID)
  local module = self:GetModule(TowerModule)
  local result, data = module:ReqTowerPassData(TT, layerID)
  if result:GetSucc() then
    if data ~= nil and next(data) ~= nil then
      Log.notice("[Tower] 请求尖塔通关记录成功，打开ui。ID:", layerID)
      self:ShowDialog("UITowerRecordController", data)
    else
      ToastManager.ShowToast(StringTable.Get("str_tower_no_record"))
    end
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
  end
end

function UITowerLayerController:OnClickAwardItem(matId, pos)
  if self.matTipInfo == nil then
    self.matTipInfo = self.matTip:SpawnObject("UISelectInfo")
  end
  self.matTipInfo:SetData(matId, pos)
end

function UITowerLayerController:AutoFightBtnOnClick(go)
  self._autoFight = not self._autoFight
  self:GetGameObject("_autoFightSelected"):SetActive(self._autoFight)
end

function UITowerLayerController:IsSelectedOpen()
  return self._curLayer >= self._curSelect
end

function UITowerLayerController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end
