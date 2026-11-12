local BaseCtrl = require("GameCore.UI.BaseCtrl")
local TowerDefenseMonsterInfoCtrl = class("TowerDefenseMonsterInfoCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local AvgData = PlayerData.Avg
TowerDefenseMonsterInfoCtrl._mapNodeConfig = {
  goWindow = {sNodeName = "t_window"},
  anit_window = {sNodeName = "t_window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "EnemyInfo_Window_Title"
  },
  goMonsterHead = {
    sNodeName = "goMonsterHead",
    sComponentName = "Transform"
  },
  txtMonsterName = {
    sNodeName = "txtMonsterName",
    sComponentName = "TMP_Text"
  },
  goMonsterType = {
    sNodeName = "goMonsterType",
    sComponentName = "GameObject"
  },
  got_fullscreen_blur_black = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  btn_Close = {
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  goAbility = {nCount = 3},
  txtAbility = {nCount = 3, sComponentName = "TMP_Text"},
  txtAbilityTitle = {nCount = 3, sComponentName = "TMP_Text"},
  txtStory = {sComponentName = "TMP_Text"},
  svEnemyList = {
    sComponentName = "LoopScrollView"
  },
  rtContent = {
    sNodeName = "rtInfoContent",
    sComponentName = "RectTransform"
  },
  goStory = {
    sComponentName = "RectTransform"
  },
  txtStoryTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDefense_Monster_Brief"
  }
}
TowerDefenseMonsterInfoCtrl._mapEventConfig = {
  OpenTowerDefenseMonsterInfo = "OnEvent_OpenTowerDefenseMonsterInfo"
}

function TowerDefenseMonsterInfoCtrl:OnEnable()
end

function TowerDefenseMonsterInfoCtrl:ShowPanel(nPreviewMonsterGroupId)
  self._mapNode.goWindow:SetActive(false)
  self._mapNode.got_fullscreen_blur_black:SetActive(true)
  self.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindow:SetActive(true)
    self._mapNode.anit_window:Play("t_window_04_t_in")
    local tbMonsterGroup = ConfigTable.GetData("PreviewMonsterGroup", nPreviewMonsterGroupId)
    if tbMonsterGroup == nil then
      printError("获取PreviewMonsterGroup配置失败！！！PreviewMonsterGroupId = " .. nPreviewMonsterGroupId)
      return
    end
    self.tbMonster = tbMonsterGroup.MonsterIds
    self.curSelect = 1
    if self.tbMonster == nil or #self.tbMonster == 0 then
      return
    end
    local bOpen = true
    for _, v in ipairs(self.tbMonster) do
      local monsterCfg = ConfigTable.GetData("Monster", v)
      if nil == monsterCfg then
        printError("读取Monster配置失败！！！monsterId = " .. v)
        bOpen = false
      end
    end
    if not bOpen then
      return
    end
    
    local function comp(a, b)
      local monsterA = ConfigTable.GetData("Monster", a)
      local monsterB = ConfigTable.GetData("Monster", b)
      if monsterA == nil or monsterB == nil then
        return
      end
      if monsterA.EpicLv ~= monsterB.EpicLv then
        return monsterA.EpicLv < monsterB.EpicLv
      else
        return a < b
      end
    end
    
    table.sort(self.tbMonster, comp)
    local nMonsterId = self.tbMonster[self.curSelect]
    self:RefreshMonsterInfo(nMonsterId)
    self._mapNode.svEnemyList:SetAnim(0.03)
    self._mapNode.svEnemyList:Init(#self.tbMonster, self, self.RefreshMonsterGrid, self.OnBtnClick_Grid)
  end
  
  cs_coroutine.start(wait)
end

function TowerDefenseMonsterInfoCtrl:RefreshMonsterGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local nMonsterId = self.tbMonster[index]
  if nMonsterId == 0 then
    return
  end
  if self.curSelect == index then
    self.curSelectMonster = goGrid
  end
  local imgIcon = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Basic--/imgIcon"):GetComponent("Image")
  local goSelect = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Common--").gameObject
  local goBoss = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goBoss").gameObject
  local goElite = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goElite").gameObject
  local goLeader = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goLeader").gameObject
  local mData = ConfigTable.GetData("Monster", nMonsterId)
  if nil == mData then
    printError("读取Monster配置失败！！！monsterId = " .. nMonsterId)
    return
  end
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  if nil == mSkin then
    printError("读取MonsterSkin配置失败！！！skinId = " .. mData.FAId)
    return
  end
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  if nil == mManual then
    printError("读取MonsterSkin配置失败！！！MonsterManualId = " .. mSkin.MonsterManual)
    return
  end
  self:SetPngSprite(imgIcon, mManual.Icon)
  goSelect:SetActive(self.curSelect == index)
  goBoss:SetActive(mData.EpicLv == GameEnum.monsterEpicType.LORD)
  goLeader:SetActive(mData.EpicLv == GameEnum.monsterEpicType.LEADER)
  goElite:SetActive(mData.EpicLv == GameEnum.monsterEpicType.ELITE)
end

function TowerDefenseMonsterInfoCtrl:RefreshMonsterInfo(nMonsterId)
  local monsterData = ConfigTable.GetData("Monster", nMonsterId)
  if nil == monsterData then
    printError(string.format("Monster数据为空！！！id = [%s]", nMonsterId))
    return
  end
  local monsterSkin = ConfigTable.GetData("MonsterSkin", monsterData.FAId)
  if nil == monsterSkin then
    printError(string.format("MonsterSkin数据为空！！！id = [%s]", monsterData.FAId))
    return
  end
  local monsterAdjust = ConfigTable.GetData("MonsterValueTempleteAdjust", monsterData.Templete)
  if nil == monsterAdjust then
    printError(string.format("MonsterValueTempleteAdjust数据为空！！！id = [%s]", monsterData.Templete))
    return
  end
  local monsterManual = ConfigTable.GetData("MonsterManual", monsterSkin.MonsterManual)
  if nil == monsterManual then
    printError(string.format("MonsterManual数据为空！！！id = [%s]", monsterSkin.MonsterManual))
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtMonsterName, monsterManual.Name)
  local imgIcon = self._mapNode.goMonsterHead:Find("--Basic--/imgIcon"):GetComponent("Image")
  self:SetPngSprite(imgIcon, monsterManual.Icon)
  if monsterData.EpicLv ~= GameEnum.monsterEpicType.NORMAL then
    self._mapNode.goMonsterType:SetActive(true)
    local goBoss = self._mapNode.goMonsterType.transform:GetChild(0).gameObject
    goBoss:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.LORD)
    local goElite = self._mapNode.goMonsterType.transform:GetChild(1).gameObject
    goElite:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.ELITE)
    local goLeader = self._mapNode.goMonsterType.transform:GetChild(2).gameObject
    goLeader:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.LEADER)
  else
    self._mapNode.goMonsterType:SetActive(false)
  end
  local tdMonsterConfig = ConfigTable.GetData("TowerDefenseMonster", nMonsterId)
  if tdMonsterConfig == nil then
    printError(string.format("TowerDefenseMonster数据为空！！！id = [%s]", nMonsterId))
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtStory, tdMonsterConfig.Brief)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goStory)
  local eets = monsterAdjust.EET
  self:RefreshAbility(monsterManual)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtContent)
end

function TowerDefenseMonsterInfoCtrl:RefreshAbility(monsterManual)
  for i = 1, 3 do
    if monsterManual["AbilityTitle" .. i] ~= nil and monsterManual["AbilityTitle" .. i] ~= "" then
      NovaAPI.SetTMPText(self._mapNode.txtAbility[i], monsterManual["AbilityDesc" .. i])
      NovaAPI.SetTMPText(self._mapNode.txtAbilityTitle[i], monsterManual["AbilityTitle" .. i])
      self._mapNode.goAbility[i]:SetActive(true)
      LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goAbility[i]:GetComponent("RectTransform"))
    else
      self._mapNode.goAbility[i]:SetActive(false)
    end
  end
end

function TowerDefenseMonsterInfoCtrl:OnBtn_ClickClose()
  self._mapNode.got_fullscreen_blur_black:SetActive(false)
  self._mapNode.anit_window:Play("t_window_04_t_out")
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
  self.tbMonster = nil
end

function TowerDefenseMonsterInfoCtrl:OnBtnClick_Grid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex ~= self.curSelect then
    local curGridName = tostring(self.curSelect - 1)
    local rtCurItem = self.curSelectMonster
    if rtCurItem ~= nil then
      rtCurItem.transform:Find("btnGrid/AnimRoot/tc_head_01/--Common--").gameObject:SetActive(false)
    end
    self.curSelect = nIndex
    self.curSelectMonster = goGrid
    goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Common--").gameObject:SetActive(true)
    local nMonsterId = self.tbMonster[nIndex]
    self:RefreshMonsterInfo(nMonsterId)
  end
end

function TowerDefenseMonsterInfoCtrl:OnEvent_OpenTowerDefenseMonsterInfo(levelId)
  local levelConfig = ConfigTable.GetData("TowerDefenseLevel", levelId)
  if levelConfig == nil then
    return
  end
  self.gameObject:SetActive(true)
  self:ShowPanel(levelConfig.MonsterPreview)
end

function TowerDefenseMonsterInfoCtrl:OnCloseAnimFinish()
  self.gameObject:SetActive(false)
end

function TowerDefenseMonsterInfoCtrl:GetAttritubeTypeSizeText(sizeType)
  if sizeType == GameEnum.attributeSizeType.High then
    return ConfigTable.GetUIText("Attribute_Size_High")
  elseif sizeType == GameEnum.attributeSizeType.Mid then
    return ConfigTable.GetUIText("Attribute_Size_Mid")
  elseif sizeType == GameEnum.attributeSizeType.Low then
    return ConfigTable.GetUIText("Attribute_Size_Low")
  else
    return ConfigTable.GetUIText("Attribute_Size_None")
  end
end

return TowerDefenseMonsterInfoCtrl
