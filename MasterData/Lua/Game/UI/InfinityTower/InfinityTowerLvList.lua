local InfinityTowerLvList = class("InfinityTowerLvList", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
InfinityTowerLvList._mapNodeConfig = {
  lv_firstTemp = {},
  lv_firstTemp_1 = {},
  lv_firstTemp_2 = {},
  lv_endTemp = {},
  lv_endTemp_1 = {},
  lv_endTemp_2 = {},
  lvListMsgView = {},
  lvListMsgTrans = {sComponentName = "Transform"},
  lv_Temp = {},
  lvmsgRoot = {},
  tex_lvmsgTop_LvIndex = {sComponentName = "TMP_Text"},
  tex_lvmsgTop_LvName = {sComponentName = "TMP_Text"},
  tex_lvmsgTop_ReLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  tex_lvmsgTop_ReLvCount = {sComponentName = "TMP_Text"},
  img_lvmsgTop_ReCon = {sComponentName = "Image"},
  tex_lvmsgTop_ReCon = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  tex_lvmsgBot_Affix = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Affix"
  },
  lvmsgBot_affixSCRoot = {sComponentName = "Transform"},
  lvmsgBot_affix_Item = {},
  tex_lvmsgBot_Reward = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Reward"
  },
  lvmsgBot_RewardRoot = {sComponentName = "Transform"},
  lvmsgBot_RewardItem = {},
  tex_lvmsgBot_MonInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MonsterInfo"
  },
  btn_lvmsgBot_MonInfo = {
    sComponentName = "UIButton",
    callback = "OnClickMonsterInfo"
  },
  btn_go = {sComponentName = "UIButton", callback = "OnClickGo"},
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_GoWar"
  },
  obj_lvMsgPass = {},
  tex_lvMsgPass = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Pass_Level"
  },
  obj_lvMsgLock = {},
  tex_lvMsgLock = {sComponentName = "TMP_Text"},
  obj_lvMsgDontOpen = {},
  tex_lvMsgDontOpen = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Last_NotPass"
  },
  obj_lvMsgDontOpenDay = {},
  tex_lvMsgDontOpenDay = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Dont_Open"
  },
  btn_Close_lvmsgRoot = {
    sComponentName = "UIButton",
    callback = "OnClickCloseLvMsgRoot"
  }
}

function InfinityTowerLvList:Awake()
  self.rewardItem = {}
end

function InfinityTowerLvList:InitLvList(towerId, diffSort, parent)
  self.tmpChooseObj = nil
  self.tmpCloseObj = nil
  self._mapNode.lvmsgRoot:SetActive(false)
  NovaAPI.SetRectMaskPadding(self._mapNode.lvListMsgView, 0, 0, 0, 0)
  NovaAPI.SetLayoutGroupPadding(self._mapNode.lvListMsgTrans.gameObject, 0, 0, -2, 0)
  self.parent = parent
  self.selectTowerId = towerId
  self.diffSort = diffSort
  for i = 1, self._mapNode.lvListMsgTrans.childCount do
    self._mapNode.lvListMsgTrans:GetChild(i - 1).gameObject:SetActive(false)
  end
  self._mapNode.lvListMsgTrans.localPosition = Vector3(0, 0, 0)
  local towerPassFloor = PlayerData.InfinityTower:GetTowerPassFloor(towerId)
  local data = PlayerData.InfinityTower:GetTowerDiffData(towerId, diffSort)
  local dataLv = data.level
  local diffLevelCount = data.diffLevelCount
  local firstFloor = data.firstFloor
  local endFloor = data.endFloor
  local firstPass = towerPassFloor >= firstFloor
  local endPass = towerPassFloor >= endFloor
  self._mapNode.lv_firstTemp_1:SetActive(not firstPass)
  self._mapNode.lv_firstTemp_2:SetActive(firstPass)
  self._mapNode.lv_endTemp_1:SetActive(not endPass)
  self._mapNode.lv_endTemp_2:SetActive(endPass)
  local indexlvCount = 0
  local indexSpecialCount = 0
  local currentLvIndex = 0
  local xPre = 2340 / math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH)
  local diffPassAll = PlayerData.InfinityTower:GetTowerDiffPassAll(towerId, diffSort)
  local CurrentClick
  for i = firstFloor, endFloor do
    local tmpData = dataLv[i]
    if tmpData.LevelType == GameEnum.InfinityTowerLevelType.Challenge then
      indexSpecialCount = indexSpecialCount + 1
    end
    indexlvCount = indexlvCount + 1
    local objItem
    if self._mapNode.lvListMsgTrans:Find("objItem_" .. indexlvCount) ~= nil then
      objItem = self._mapNode.lvListMsgTrans:Find("objItem_" .. indexlvCount).gameObject
    else
      objItem = instantiate(self._mapNode.lv_Temp, self._mapNode.lvListMsgTrans)
      objItem.name = "objItem_" .. indexlvCount
    end
    local lv_commom_Pass = objItem.transform:Find("lv_commom_Pass").gameObject
    local lv_commom_Current = objItem.transform:Find("lv_commom_Current").gameObject
    local lv_commom_Lock = objItem.transform:Find("lv_commom_Lock").gameObject
    local lv_challenge_Pass = objItem.transform:Find("lv_challenge_Pass").gameObject
    local lv_challenge_Current = objItem.transform:Find("lv_challenge_Current").gameObject
    local lv_challenge_Lock = objItem.transform:Find("lv_challenge_Lock").gameObject
    local lv_commom_ChoosePass = objItem.transform:Find("lv_commom_ChoosePass").gameObject
    local lv_commom_ChooseCurrent = objItem.transform:Find("lv_commom_ChooseCurrent").gameObject
    local lv_commom_ChooseLock = objItem.transform:Find("lv_commom_ChooseLock").gameObject
    local lv_challenge_ChoosePass = objItem.transform:Find("lv_challenge_ChoosePass").gameObject
    local lv_challenge_ChooseCurrent = objItem.transform:Find("lv_challenge_ChooseCurrent").gameObject
    local lv_challenge_ChooseLock = objItem.transform:Find("lv_challenge_ChooseLock").gameObject
    if lv_commom_Pass ~= nil then
      lv_commom_Pass:SetActive(false)
      lv_commom_Current:SetActive(false)
      lv_commom_Lock:SetActive(false)
      lv_challenge_Pass:SetActive(false)
      lv_challenge_Current:SetActive(false)
      lv_challenge_Lock:SetActive(false)
      lv_commom_ChoosePass:SetActive(false)
      lv_commom_ChooseCurrent:SetActive(false)
      lv_commom_ChooseLock:SetActive(false)
      lv_challenge_ChoosePass:SetActive(false)
      lv_challenge_ChooseCurrent:SetActive(false)
      lv_challenge_ChooseLock:SetActive(false)
      do
        local pass = PlayerData.InfinityTower:JudgeLevelPass(self.selectTowerId, tmpData.Id)
        local current = PlayerData.InfinityTower:JudgeLevelCanChallenge(self.selectTowerId, tmpData.Id)
        local lock = PlayerData.InfinityTower:JudgeLevelLock(self.selectTowerId, tmpData.Id)
        if current then
          currentLvIndex = i
        end
        
        local function clickCb(closeObj, txt, _index)
          self:ShowLvInfo(tmpData.Id, _index)
          if diffLevelCount == 5 then
            NovaAPI.SetLayoutGroupPadding(self._mapNode.lvListMsgTrans.gameObject, 0, math.floor(200 * xPre) + 40, -2, 0)
          elseif diffLevelCount == 6 then
            NovaAPI.SetLayoutGroupPadding(self._mapNode.lvListMsgTrans.gameObject, 0, math.floor(400 * xPre) + 40, -2, 0)
          elseif 6 < diffLevelCount then
            NovaAPI.SetLayoutGroupPadding(self._mapNode.lvListMsgTrans.gameObject, 0, math.floor(600 * xPre) + 40, -2, 0)
          end
          if self.tmpChooseObj ~= nil then
            self.tmpChooseObj:SetActive(false)
          end
          if self.tmpCloseObj ~= nil then
            self.tmpCloseObj:SetActive(true)
          end
          local _choosePass = PlayerData.InfinityTower:JudgeLevelPass(self.selectTowerId, tmpData.Id)
          local _chooseCurrent = PlayerData.InfinityTower:JudgeLevelCanChallenge(self.selectTowerId, tmpData.Id)
          local _chooseLock = PlayerData.InfinityTower:JudgeLevelLock(self.selectTowerId, tmpData.Id)
          if tmpData.LevelType ~= GameEnum.InfinityTowerLevelType.Challenge then
            if _choosePass then
              local _tex = lv_commom_ChoosePass.transform:Find("btn/lv_tex_commom_Pass_Choose"):GetComponent("TMP_Text")
              local _boss = lv_commom_ChoosePass.transform:Find("btn/lv_commom_Pass_Boss_Choose").gameObject
              _tex.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
              _boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
              NovaAPI.SetTMPText(_tex, txt)
              lv_commom_ChoosePass:SetActive(true)
              self.tmpChooseObj = lv_commom_ChoosePass
            elseif _chooseCurrent then
              local _PNoPass = lv_commom_ChooseCurrent.transform:Find("lv_commom_Current_PNoPass_Choose").gameObject
              local _nextLineChoose = lv_commom_ChooseCurrent.transform:Find("lv_commom_Current_NextLine_Choose").gameObject
              local _tex = lv_commom_ChooseCurrent.transform:Find("btn/lv_tex_commom_Current_Choose"):GetComponent("TMP_Text")
              local _boss = lv_commom_ChooseCurrent.transform:Find("btn/lv_commom_Current_Boss_Choose").gameObject
              _PNoPass:SetActive(not firstPass)
              _tex.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
              _boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
              NovaAPI.SetTMPText(_tex, txt)
              lv_commom_ChooseCurrent:SetActive(true)
              self.tmpChooseObj = lv_commom_ChooseCurrent
              if _choosePass then
                _nextLineChoose:SetActive(false)
              elseif _chooseLock then
                _PNoPass:SetActive(true)
              end
            elseif _chooseLock then
              local _tex = lv_commom_ChooseLock.transform:Find("btn/lv_tex_commom_Lock_Choose"):GetComponent("TMP_Text")
              local _boss = lv_commom_ChooseLock.transform:Find("btn/lv_commom_Lock_Boss_Choose").gameObject
              _tex.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
              _boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
              NovaAPI.SetTMPText(_tex, txt)
              lv_commom_ChooseLock:SetActive(true)
              self.tmpChooseObj = lv_commom_ChooseLock
            end
          elseif _choosePass then
            local _tex = lv_challenge_ChoosePass.transform:Find("btn/lv_tex_challenge_Pass_Choose"):GetComponent("TMP_Text")
            NovaAPI.SetTMPText(_tex, txt)
            lv_challenge_ChoosePass:SetActive(true)
            self.tmpChooseObj = lv_challenge_ChoosePass
          elseif _chooseCurrent then
            local _PNoPass = lv_challenge_ChooseCurrent.transform:Find("lv_challenge_Current_PNoPass_Choose").gameObject
            local _nextLineChoose = lv_challenge_ChooseCurrent.transform:Find("lv_challenge_Current_NextLine_Choose").gameObject
            local _tex = lv_challenge_ChooseCurrent.transform:Find("btn/lv_tex_challenge_Current_Choose"):GetComponent("TMP_Text")
            NovaAPI.SetTMPText(_tex, txt)
            _PNoPass:SetActive(not firstPass)
            lv_challenge_ChooseCurrent:SetActive(true)
            self.tmpChooseObj = lv_challenge_ChooseCurrent
            if _choosePass then
              _nextLineChoose:SetActive(false)
            elseif _chooseLock then
              _PNoPass:SetActive(true)
            end
          elseif _chooseLock then
            local _tex = lv_challenge_ChooseLock.transform:Find("btn/lv_tex_challenge_Lock_Choose"):GetComponent("TMP_Text")
            NovaAPI.SetTMPText(_tex, txt)
            lv_challenge_ChooseLock:SetActive(true)
            self.tmpChooseObj = lv_challenge_ChooseLock
          end
          self.tmpCloseObj = closeObj
          closeObj:SetActive(false)
          LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.lvListMsgTrans.gameObject:GetComponent("RectTransform"))
          if 4 < diffLevelCount and tmpData.Floor - firstFloor < 2 and endFloor - tmpData.Floor >= 2 then
            local function waitOneFrame()
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
              
              self._mapNode.lvListMsgTrans:DOLocalMoveX(0, 0.2)
            end
            
            cs_coroutine.start(waitOneFrame)
          elseif 4 < diffLevelCount and tmpData.Floor - firstFloor >= 2 and endFloor - tmpData.Floor >= 2 then
            local function waitOneFrame()
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
              
              self._mapNode.lvListMsgTrans:DOLocalMoveX(-(tmpData.Floor - firstFloor - 1) * 310 + 210, 0.2)
            end
            
            cs_coroutine.start(waitOneFrame)
          elseif 4 < diffLevelCount and endFloor - tmpData.Floor == 1 then
            local function waitOneFrame()
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
              
              self._mapNode.lvListMsgTrans:DOLocalMoveX(-(tmpData.Floor - firstFloor - 1) * 310 + 210, 0.2)
            end
            
            cs_coroutine.start(waitOneFrame)
          elseif 4 < diffLevelCount and endFloor - tmpData.Floor == 0 then
            local function waitOneFrame()
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
              
              self._mapNode.lvListMsgTrans:DOLocalMoveX(-(tmpData.Floor - firstFloor - 1) * 310 + 410, 0.2)
            end
            
            cs_coroutine.start(waitOneFrame)
          end
          EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
        end
        
        if tmpData.LevelType ~= GameEnum.InfinityTowerLevelType.Challenge then
          local strIndex = indexlvCount
          if indexlvCount < 10 then
            strIndex = "0" .. indexlvCount
          end
          if current == true then
            local lv_commom_Current_PNoPass = lv_commom_Current.transform:Find("lv_commom_Current_PNoPass").gameObject
            local lv_tex_commom_Current = lv_commom_Current.transform:Find("btn/lv_tex_commom_Current"):GetComponent("TMP_Text")
            local lv_commom_Current_Boss = lv_commom_Current.transform:Find("btn/lv_commom_Current_Boss").gameObject
            lv_commom_Current_PNoPass:SetActive(not firstPass)
            lv_tex_commom_Current.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
            lv_commom_Current_Boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
            NovaAPI.SetTMPText(lv_tex_commom_Current, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lv_Index"), strIndex))
            lv_commom_Current:SetActive(true)
            local btn = lv_commom_Current.transform:Find("btn"):GetComponent("UIButton")
            btn.onClick:RemoveAllListeners()
            
            local function tmpClick()
              clickCb(lv_commom_Current, NovaAPI.GetTMPText(lv_tex_commom_Current), strIndex)
            end
            
            CurrentClick = tmpClick
            btn.onClick:AddListener(tmpClick)
          end
          if pass == true then
            local lv_tex_commom_Pass = lv_commom_Pass.transform:Find("btn/lv_tex_commom_Pass"):GetComponent("TMP_Text")
            local lv_commom_Pass_Boss = lv_commom_Pass.transform:Find("btn/lv_commom_Pass_Boss").gameObject
            lv_tex_commom_Pass.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
            lv_commom_Pass_Boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
            NovaAPI.SetTMPText(lv_tex_commom_Pass, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lv_Index"), strIndex))
            lv_commom_Pass:SetActive(true)
            local btn = lv_commom_Pass.transform:Find("btn"):GetComponent("UIButton")
            btn.onClick:RemoveAllListeners()
            
            local function tmpClick()
              clickCb(lv_commom_Pass, NovaAPI.GetTMPText(lv_tex_commom_Pass), strIndex)
            end
            
            if diffPassAll and tmpData.Floor == endFloor then
              CurrentClick = tmpClick
            end
            btn.onClick:AddListener(tmpClick)
          end
          if lock == true then
            do
              local lv_commom_Lock_Boss = lv_commom_Lock.transform:Find("btn/lv_commom_Lock_Boss").gameObject
              local lv_tex_commom_Lock = lv_commom_Lock.transform:Find("btn/lv_tex_commom_Lock"):GetComponent("TMP_Text")
              lv_tex_commom_Lock.gameObject:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Normal)
              lv_commom_Lock_Boss:SetActive(tmpData.LevelType == GameEnum.InfinityTowerLevelType.Boss)
              NovaAPI.SetTMPText(lv_tex_commom_Lock, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lv_Index"), strIndex))
              lv_commom_Lock:SetActive(true)
              local btn = lv_commom_Lock.transform:Find("btn"):GetComponent("UIButton")
              btn.onClick:RemoveAllListeners()
              
              local function tmpClick()
                clickCb(lv_commom_Lock, NovaAPI.GetTMPText(lv_tex_commom_Lock), strIndex)
              end
              
              btn.onClick:AddListener(tmpClick)
            end
          end
        else
          local strIndex = indexlvCount
          if indexSpecialCount < 10 then
            strIndex = "0" .. indexSpecialCount
          end
          if current == true then
            local lv_challenge_Current_PNoPass = lv_challenge_Current.transform:Find("lv_challenge_Current_PNoPass").gameObject
            local lv_tex_challenge_Current = lv_challenge_Current.transform:Find("btn/lv_tex_challenge_Current"):GetComponent("TMP_Text")
            lv_challenge_Current_PNoPass:SetActive(not firstPass)
            NovaAPI.SetTMPText(lv_tex_challenge_Current, orderedFormat(ConfigTable.GetUIText("InfinityTower_SpecialLv_Index"), strIndex))
            lv_challenge_Current:SetActive(true)
            local btn = lv_challenge_Current.transform:Find("btn"):GetComponent("UIButton")
            btn.onClick:RemoveAllListeners()
            
            local function tmpClick()
              clickCb(lv_challenge_Current, NovaAPI.GetTMPText(lv_tex_challenge_Current), strIndex)
            end
            
            CurrentClick = tmpClick
            btn.onClick:AddListener(tmpClick)
          end
          if pass == true then
            local lv_tex_challenge_Pass = lv_challenge_Pass.transform:Find("btn/lv_tex_challenge_Pass"):GetComponent("TMP_Text")
            NovaAPI.SetTMPText(lv_tex_challenge_Pass, orderedFormat(ConfigTable.GetUIText("InfinityTower_SpecialLv_Index"), strIndex))
            lv_challenge_Pass:SetActive(true)
            local btn = lv_challenge_Pass.transform:Find("btn"):GetComponent("UIButton")
            btn.onClick:RemoveAllListeners()
            
            local function tmpClick()
              clickCb(lv_challenge_Pass, NovaAPI.GetTMPText(lv_tex_challenge_Pass), strIndex)
            end
            
            if diffPassAll and tmpData.Floor == endFloor then
              CurrentClick = tmpClick
            end
            btn.onClick:AddListener(tmpClick)
          end
          if lock == true then
            do
              local lv_tex_challenge_Lock = lv_challenge_Lock.transform:Find("btn/lv_tex_challenge_Lock"):GetComponent("TMP_Text")
              NovaAPI.SetTMPText(lv_tex_challenge_Lock, orderedFormat(ConfigTable.GetUIText("InfinityTower_SpecialLv_Index"), strIndex))
              lv_challenge_Lock:SetActive(true)
              local btn = lv_challenge_Lock.transform:Find("btn"):GetComponent("UIButton")
              btn.onClick:RemoveAllListeners()
              
              local function tmpClick()
                clickCb(lv_challenge_Lock, NovaAPI.GetTMPText(lv_tex_challenge_Lock), strIndex)
              end
              
              btn.onClick:AddListener(tmpClick)
            end
          end
        end
        objItem:SetActive(true)
      end
    end
  end
  self._mapNode.lv_firstTemp:SetActive(true)
  self._mapNode.lv_endTemp:SetActive(true)
  self._mapNode.lv_endTemp.transform:SetAsLastSibling()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.lvListMsgTrans.gameObject:GetComponent("RectTransform"))
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if CurrentClick then
      CurrentClick()
    end
  end
  
  cs_coroutine.start(wait)
end

function InfinityTowerLvList:ShowLvInfo(levelId, index)
  self.ChooseLevelId = levelId
  local lvData = ConfigTable.GetData("InfinityTowerLevel", levelId)
  NovaAPI.SetTMPText(self._mapNode.tex_lvmsgTop_LvIndex, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lv_IndexSpace"), index))
  NovaAPI.SetTMPText(self._mapNode.tex_lvmsgTop_LvName, lvData.Name)
  NovaAPI.SetTMPText(self._mapNode.tex_lvmsgTop_ReLvCount, lvData.RecommendLv)
  local sScore = "Icon/BuildRank/BuildRank_" .. lvData.RecommendBuildRank
  self:SetPngSprite(self._mapNode.img_lvmsgTop_ReCon, sScore)
  local childRewardCount = self._mapNode.lvmsgBot_RewardRoot.childCount
  for i = 1, childRewardCount do
    self._mapNode.lvmsgBot_RewardRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local tbItem = {}
  local _base = decodeJson(lvData.BaseAwardPreview)
  for k, v in ipairs(_base) do
    table.insert(tbItem, {
      id = v[1],
      count = UTILS.ParseRewardItemCount(v)
    })
  end
  local index = 1
  for i, v in pairs(tbItem) do
    local objItem
    if index > self._mapNode.lvmsgBot_RewardRoot.childCount then
      objItem = instantiate(self._mapNode.lvmsgBot_RewardItem, self._mapNode.lvmsgBot_RewardRoot)
    else
      objItem = self._mapNode.lvmsgBot_RewardRoot:GetChild(index - 1).gameObject
    end
    local btn = objItem:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowItemTips(v.id, btn.gameObject)
    end
    
    btn.onClick:AddListener(clickCb)
    objItem:SetActive(true)
    local isGet = PlayerData.InfinityTower:JudgeLevelPass(self.selectTowerId, levelId)
    local _objR = objItem.transform:Find("AniRoot/RewardItem").gameObject
    self.rewardItem[_objR] = self:BindCtrlByNode(_objR, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.rewardItem[_objR]:SetItem(v.id, nil, v.count, nil, isGet, nil, nil, true)
    index = index + 1
  end
  local childAffixCount = self._mapNode.lvmsgBot_affixSCRoot.childCount
  for i = 1, childAffixCount do
    self._mapNode.lvmsgBot_affixSCRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local flData = ConfigTable.GetData("InfinityTowerFloor", lvData.FloorId)
  local tabAffixId = flData.AffixId
  local indexAffix = 1
  if lvData.EntryCond ~= 0 then
    local obj
    if indexAffix + 1 > self._mapNode.lvmsgBot_affixSCRoot.childCount then
      obj = instantiate(self._mapNode.lvmsgBot_affix_Item, self._mapNode.lvmsgBot_affixSCRoot)
    else
      obj = self._mapNode.lvmsgBot_affixSCRoot:GetChild(indexAffix).gameObject
    end
    self:ShowAffixItemMsg(obj, 0, false, false, lvData.EntryCond, lvData.EntryCondParam)
    indexAffix = indexAffix + 1
  end
  for i = 1, #tabAffixId do
    local obj
    if indexAffix + 1 > self._mapNode.lvmsgBot_affixSCRoot.childCount then
      obj = instantiate(self._mapNode.lvmsgBot_affix_Item, self._mapNode.lvmsgBot_affixSCRoot)
    else
      obj = self._mapNode.lvmsgBot_affixSCRoot:GetChild(indexAffix).gameObject
    end
    local affixId = 0
    if tabAffixId[i] ~= nil then
      affixId = tabAffixId[i]
    end
    self:ShowAffixItemMsg(obj, affixId, true, false, nil, nil)
    indexAffix = indexAffix + 1
  end
  if indexAffix < 5 then
    local tmpIndex = indexAffix + 1
    for i = tmpIndex, 5 do
      local obj
      if indexAffix + 1 > self._mapNode.lvmsgBot_affixSCRoot.childCount then
        obj = instantiate(self._mapNode.lvmsgBot_affix_Item, self._mapNode.lvmsgBot_affixSCRoot)
      else
        obj = self._mapNode.lvmsgBot_affixSCRoot:GetChild(indexAffix).gameObject
      end
      self:ShowAffixItemMsg(obj, 0, false, true, nil, nil)
      indexAffix = indexAffix + 1
    end
  end
  self._mapNode.lvmsgRoot:SetActive(true)
  local zPos = 700
  if self.gameObject:GetComponent("RectTransform").rect.width == 2160 then
    zPos = 780
  end
  NovaAPI.SetRectMaskPadding(self._mapNode.lvListMsgView, 0, 0, zPos, 0)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.lvmsgBot_affixSCRoot.gameObject:GetComponent("RectTransform"))
  local _isPass = PlayerData.InfinityTower:JudgeLevelPass(self.selectTowerId, self.ChooseLevelId)
  local _isOpenDay = PlayerData.InfinityTower:CheckOpenDay(self.selectTowerId)
  local _isNextLvNext = PlayerData.InfinityTower:JudgeLevelLock(self.selectTowerId, self.ChooseLevelId)
  self._mapNode.obj_lvMsgPass:SetActive(_isPass)
  self._mapNode.obj_lvMsgDontOpen:SetActive(_isNextLvNext)
  self._mapNode.btn_go.gameObject:SetActive(false)
  self._mapNode.obj_lvMsgDontOpenDay:SetActive(false)
  if _isOpenDay then
    self._mapNode.btn_go.gameObject:SetActive(not _isPass and not _isNextLvNext)
  elseif not _isNextLvNext and not _isPass then
    self._mapNode.obj_lvMsgDontOpenDay:SetActive(true)
  end
end

function InfinityTowerLvList:ShowItemTips(nTid, rtBtn)
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function InfinityTowerLvList:ShowAffixItemMsg(obj, affixId, isAffix, isEmpty, entryCond, entryCondParam)
  obj:SetActive(true)
  local lvmsgBot_affix_Item_1 = obj.transform:Find("lvmsgBot_affix_Item_1").gameObject
  local lvmsgBot_affix_Item_2 = obj.transform:Find("lvmsgBot_affix_Item_2").gameObject
  local lvmsgBot_affix_Item_3 = obj.transform:Find("lvmsgBot_affix_Item_3").gameObject
  local lvmsgBot_affix_Item_4 = obj.transform:Find("lvmsgBot_affix_Item_4").gameObject
  lvmsgBot_affix_Item_1:SetActive(false)
  lvmsgBot_affix_Item_2:SetActive(false)
  lvmsgBot_affix_Item_3:SetActive(false)
  lvmsgBot_affix_Item_4:SetActive(false)
  if isAffix then
    lvmsgBot_affix_Item_1:SetActive(true)
    local tex_1 = lvmsgBot_affix_Item_1.transform:Find("tex_lvmsgBot_affix_Item_1"):GetComponent("TMP_Text")
    local dataAffix = ConfigTable.GetData("InfinityTowerAffix", affixId)
    local sDesc = orderedFormat(ConfigTable.GetUIText("InfinityTowerAffix_Desc"), dataAffix.Name, dataAffix.Desc)
    NovaAPI.SetTMPText(tex_1, UTILS.ParseParamDesc(sDesc, dataAffix))
  elseif isEmpty then
    lvmsgBot_affix_Item_4:SetActive(true)
  else
    lvmsgBot_affix_Item_2:SetActive(true)
    local tex_2Title = lvmsgBot_affix_Item_2.transform:Find("tex_lvmsgBot_affix_Item_2/Image/tex_lvmsgBot_affix_Item_2Title"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(tex_2Title, ConfigTable.GetUIText("InfinityTower_Limit_March"))
    local tex_2 = lvmsgBot_affix_Item_2.transform:Find("tex_lvmsgBot_affix_Item_2"):GetComponent("TMP_Text")
    local strElement = ConfigTable.GetUIText("ELEMENT_" .. entryCondParam[1])
    if entryCond == GameEnum.InfinityTowerCond.MasterCharactersWithSpecificElementType then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificElementType"), strElement))
    elseif entryCond == GameEnum.InfinityTowerCond.ElementTypeWithSpecificQuantityNoLessThanQuantity then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificQuantityNoLessThanQuantity"), strElement, entryCondParam[2]))
    elseif entryCond == GameEnum.InfinityTowerCond.ElementTypeWithSpecificQuantityNoMoreThanQuantity then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificQuantityNoMoreThanQuantity"), strElement, entryCondParam[2]))
    end
  end
end

function InfinityTowerLvList:OnClickMonsterInfo()
  EventManager.Hit("OpenInfinityTowerMonsterInfo", self.ChooseLevelId)
end

function InfinityTowerLvList:OnClickCloseLvMsgRoot()
  self._mapNode.lvmsgRoot:SetActive(false)
  NovaAPI.SetRectMaskPadding(self._mapNode.lvListMsgView, 0, 0, 0, 0)
end

function InfinityTowerLvList:OnClickGo()
  local lvData = ConfigTable.GetData("InfinityTowerLevel", self.ChooseLevelId)
  local _isPass = PlayerData.InfinityTower:JudgeLevelPass(self.selectTowerId, self.ChooseLevelId)
  local _isOpenDay = PlayerData.InfinityTower:CheckOpenDay(self.selectTowerId)
  local _isNextLvNext = PlayerData.InfinityTower:JudgeLevelLock(self.selectTowerId, self.ChooseLevelId)
  local _isLockWorldClass = PlayerData.InfinityTower:CheckLockWorldClass(self.ChooseLevelId)
  local towerData = ConfigTable.GetData("InfinityTower", self.selectTowerId)
  local isUnLock = PlayerData.InfinityTower:CheckTowerUnLock(self.selectTowerId, towerData.PreTowerLevelId)
  if _isPass then
    local strTips = ConfigTable.GetUIText("RoguelikeBuild_Manage_FilterPass")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  elseif not _isOpenDay then
    local strTips = ConfigTable.GetUIText("RegionBoss_Unlock_OpenDay")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  elseif _isNextLvNext then
    local strTips = ConfigTable.GetUIText("InfinityTower_Lock_Level")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  elseif _isLockWorldClass then
    local strTips = ConfigTable.GetUIText("InfinityTower_Lock_WorldClass")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  elseif not isUnLock then
    local strTips = orderedFormat(ConfigTable.GetUIText("InfinityTower_LockTips"), towerData.Name)
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  end
  PlayerData.InfinityTower:SetAutoNextLv(false)
  self._mapNode.lvmsgRoot:SetActive(false)
  NovaAPI.SetRectMaskPadding(self._mapNode.lvListMsgView, 0, 0, 0, 0)
  EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.InfinityTower, lvData.Id, {})
end

function InfinityTowerLvList:CloseLvList()
  self.gameObject:SetActive(false)
end

function InfinityTowerLvList:OnDestroy()
  for go, ctrl in ipairs(self.rewardItem) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.rewardItem = {}
  self.parent = nil
end

return InfinityTowerLvList
