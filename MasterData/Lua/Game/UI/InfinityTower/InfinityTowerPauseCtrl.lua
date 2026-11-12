local InfinityTowerPauseCtrl = class("InfinityTowerPauseCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
InfinityTowerPauseCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  aniWindow = {sNodeName = "--Window--", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Pause"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnGiveUp = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_End",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  btnSettings = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Settings"
  },
  btnPopSkill = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtGiveUp = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_EndBattle"
  },
  txtBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_ContinueBattle"
  },
  txtBtnSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Skill"
  },
  txtBtnSettings = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Settings"
  },
  txtTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Time"
  },
  txtTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  texAffix = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Affix"
  },
  texMonsterPre = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Monster_Preview"
  },
  texTask1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Task_Target"
  },
  texNone = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_EnemyInfo_None"
  },
  texTimeCount = {sComponentName = "TMP_Text"},
  affixSCRoot = {sComponentName = "Transform"},
  affix_ItemList = {},
  monSV = {
    sComponentName = "LoopScrollView"
  }
}
InfinityTowerPauseCtrl._mapEventConfig = {
  show_Infinity_Pause = "OnEvent_ShowInfinityPause",
  GamepadUIReopen = "OnEvent_Reopen"
}

function InfinityTowerPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  local tbConfig = {
    {
      sAction = "Skill",
      sLang = "StarTowerMap_Btn_Skill"
    },
    {
      sAction = "Settings",
      sLang = "StarTowerMap_Btn_Settings"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function InfinityTowerPauseCtrl:FadeIn()
end

function InfinityTowerPauseCtrl:FadeOut()
end

function InfinityTowerPauseCtrl:OnEnable()
end

function InfinityTowerPauseCtrl:OnDisable()
end

function InfinityTowerPauseCtrl:OnDestroy()
end

function InfinityTowerPauseCtrl:OnRelease()
end

function InfinityTowerPauseCtrl:OnEvent_ShowInfinityPause(runTime, tbChar)
  self.tbChar = tbChar
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  local lvId = PlayerData.InfinityTower:GetCurrentLv()
  local lvData = ConfigTable.GetData("InfinityTowerLevel", lvId)
  local flId = lvData.FloorId
  local flData = ConfigTable.GetData("InfinityTowerFloor", flId)
  self:ShowPanelMonsterList(flData.PreviewMonsterGroupId)
  self:ShowAffixItem(lvId)
  self:PlayInAni()
  self:ShowRunTime(runTime)
  GamepadUIManager.EnableGamepadUI("InfinityTowerPauseCtrl", self.tbGamepadUINode)
end

function InfinityTowerPauseCtrl:ShowRunTime(runTime)
  local min = math.floor(runTime / 60)
  local sec = runTime - min * 60
  local strMin = tostring(min)
  if min < 10 then
    strMin = "0" .. strMin
  end
  local strSec = tostring(sec)
  if sec < 10 then
    strSec = "0" .. strSec
  end
  NovaAPI.SetTMPText(self._mapNode.texTimeCount, string.format("%s:%s", strMin, strSec))
end

function InfinityTowerPauseCtrl:PlayInAni()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function InfinityTowerPauseCtrl:ShowAffixItem(levelId)
  local childCount = self._mapNode.affixSCRoot.childCount
  for i = 1, childCount do
    self._mapNode.affixSCRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local lvData = ConfigTable.GetData("InfinityTowerLevel", levelId)
  local flData = ConfigTable.GetData("InfinityTowerFloor", lvData.FloorId)
  local tabAffixId = flData.AffixId
  local indexAffix = 1
  if lvData.EntryCond ~= 0 then
    local obj
    if indexAffix + 1 > self._mapNode.affixSCRoot.childCount then
      obj = instantiate(self._mapNode.affix_ItemList, self._mapNode.affixSCRoot)
    else
      obj = self._mapNode.affixSCRoot:GetChild(indexAffix).gameObject
    end
    self:ShowAffixItemMsg(obj, 0, false, false, lvData.EntryCond, lvData.EntryCondParam)
    indexAffix = indexAffix + 1
  end
  for i = 1, #tabAffixId do
    local obj
    if indexAffix + 1 > self._mapNode.affixSCRoot.childCount then
      obj = instantiate(self._mapNode.affix_ItemList, self._mapNode.affixSCRoot)
    else
      obj = self._mapNode.affixSCRoot:GetChild(indexAffix).gameObject
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
      if indexAffix + 1 > self._mapNode.affixSCRoot.childCount then
        obj = instantiate(self._mapNode.affix_ItemList, self._mapNode.affixSCRoot)
      else
        obj = self._mapNode.affixSCRoot:GetChild(indexAffix).gameObject
      end
      self:ShowAffixItemMsg(obj, 0, false, true, nil, nil)
      indexAffix = indexAffix + 1
    end
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.affixSCRoot.gameObject:GetComponent("RectTransform"))
end

function InfinityTowerPauseCtrl:ShowAffixItemMsg(obj, affixId, isAffix, isEmpty, entryCond, entryCondParam)
  obj:SetActive(true)
  local goNextMsg_affix_Item_1 = obj.transform:Find("lvmsgBot_affix_Item_1").gameObject
  local goNextMsg_affix_Item_2 = obj.transform:Find("lvmsgBot_affix_Item_2").gameObject
  local goNextMsg_affix_Item_3 = obj.transform:Find("lvmsgBot_affix_Item_3").gameObject
  local goNextMsg_affix_Item_4 = obj.transform:Find("lvmsgBot_affix_Item_4").gameObject
  goNextMsg_affix_Item_1:SetActive(false)
  goNextMsg_affix_Item_2:SetActive(false)
  goNextMsg_affix_Item_3:SetActive(false)
  goNextMsg_affix_Item_4:SetActive(false)
  if isAffix then
    goNextMsg_affix_Item_1:SetActive(true)
    local tex_1 = goNextMsg_affix_Item_1.transform:Find("tex_lvmsgBot_affix_Item_1"):GetComponent("TMP_Text")
    local dataAffix = ConfigTable.GetData("InfinityTowerAffix", affixId)
    local sDesc = orderedFormat(ConfigTable.GetUIText("InfinityTowerAffix_Desc"), dataAffix.Name, dataAffix.Desc)
    NovaAPI.SetTMPText(tex_1, UTILS.ParseParamDesc(sDesc, dataAffix))
  elseif isEmpty then
    goNextMsg_affix_Item_4:SetActive(true)
  else
    goNextMsg_affix_Item_2:SetActive(true)
    local tex_2Title = goNextMsg_affix_Item_2.transform:Find("tex_lvmsgBot_affix_Item_2/Image/tex_lvmsgBot_affix_Item_2Title"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(tex_2Title, ConfigTable.GetUIText("InfinityTower_Limit_March"))
    local tex_2 = goNextMsg_affix_Item_2.transform:Find("tex_lvmsgBot_affix_Item_2"):GetComponent("TMP_Text")
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

function InfinityTowerPauseCtrl:ShowPanelMonsterList(nPreviewMonsterGroupId)
  local tbMonsterGroup = ConfigTable.GetData("PreviewMonsterGroup", nPreviewMonsterGroupId)
  if tbMonsterGroup == nil then
    return
  end
  self.tbMonster = tbMonsterGroup.MonsterIds
  if self.tbMonster == nil or #self.tbMonster == 0 then
    return
  end
  local bOpen = true
  for _, v in ipairs(self.tbMonster) do
    local monsterCfg = ConfigTable.GetData("Monster", v)
    if nil == monsterCfg then
      printError("读取PreviewMonsterList配置失败！！！monsterId = " .. v.PreviewMonsterListId)
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
  if #self.tbMonster > 0 then
    self._mapNode.monSV:Init(#self.tbMonster, self, self.RefreshMonsterGrid)
  end
  self._mapNode.texNone.gameObject:SetActive(#self.tbMonster == 0)
end

function InfinityTowerPauseCtrl:RefreshMonsterGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local nMonsterId = self.tbMonster[index]
  if nMonsterId == 0 then
    return
  end
  local imgIcon = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Basic--/imgIcon"):GetComponent("Image")
  local goSelect = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Common--").gameObject
  local goBoss = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goBoss").gameObject
  local goLeader = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goLeader").gameObject
  local goElite = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goElite").gameObject
  local btn = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local mData = ConfigTable.GetData("Monster", nMonsterId)
  btn.onClick:RemoveAllListeners()
  local _strLv = ""
  
  local function clickCb()
    local mapData = {nTid = nMonsterId, strLv = _strLv}
    EventManager.Hit(EventId.OpenPanel, PanelId.MonsterTips, btn.gameObject, mapData)
  end
  
  btn.onClick:AddListener(clickCb)
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
  if nil ~= mData then
    self:SetPngSprite(imgIcon, mManual.Icon)
    goSelect:SetActive(self.curSelect == index)
    goBoss:SetActive(mData.EpicLv == GameEnum.monsterEpicType.LORD)
    goLeader:SetActive(mData.EpicLv == GameEnum.monsterEpicType.LEADER)
    goElite:SetActive(mData.EpicLv == GameEnum.monsterEpicType.ELITE)
  end
end

function InfinityTowerPauseCtrl:OnBtnClick_End()
  self:PlayCloseAni(true)
end

function InfinityTowerPauseCtrl:OnBtnClick_Close()
  self:PlayCloseAni(false)
end

function InfinityTowerPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function InfinityTowerPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("InfinityTowerPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.aniBlur.gameObject:SetActive(false)
  self._mapNode.safeAreaRoot:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function InfinityTowerPauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar, true)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function InfinityTowerPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function InfinityTowerPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "InfinityTowerPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return InfinityTowerPauseCtrl
