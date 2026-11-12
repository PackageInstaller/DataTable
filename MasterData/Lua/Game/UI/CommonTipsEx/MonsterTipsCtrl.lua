local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local MonsterTipsCtrl = class("MonsterTipsCtrl", BaseCtrl)
MonsterTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePanel"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  rtContentCanvasGroup = {
    sNodeName = "rtContent",
    sComponentName = "CanvasGroup"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  TMP_monsterInfo = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  goMonsterType = {},
  goBoss = {},
  goElite = {},
  goLeader = {},
  txtPropertyNone = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "EnemyInfo_Window_Property_None"
  },
  txtProperty1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "EnemyInfo_Window_Property_1"
  },
  txtProperty2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "EnemyInfo_Window_Property_2"
  },
  goPropertyList = {nCount = 2, sComponentName = "Transform"},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
MonsterTipsCtrl._mapEventConfig = {}

function MonsterTipsCtrl:Awake()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 0)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function MonsterTipsCtrl:FadeIn()
end

function MonsterTipsCtrl:FadeOut()
end

function MonsterTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  self:RefreshMonsterInfo(self.mapData.nTid)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 1)
  end
  
  cs_coroutine.start(wait)
end

function MonsterTipsCtrl:RefreshMonsterInfo(nMonsterId)
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
  NovaAPI.SetTMPText(self._mapNode.txtName, monsterManual.Name)
  NovaAPI.SetTMPText(self._mapNode.TMP_monsterInfo, monsterManual.Desc)
  self:RefreshElement(self._mapNode.goPropertyList[1], monsterAdjust.WeakEET, 1)
  self:RefreshElement(self._mapNode.goPropertyList[2], monsterAdjust.ResistEET, 2)
  if monsterData.EpicLv ~= GameEnum.monsterEpicType.NORMAL then
    self._mapNode.goMonsterType:SetActive(true)
    self._mapNode.goBoss:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.LORD)
    self._mapNode.goElite:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.ELITE)
    self._mapNode.goLeader:SetActive(monsterData.EpicLv == GameEnum.monsterEpicType.LEADER)
  else
    self._mapNode.goMonsterType:SetActive(false)
  end
end

function MonsterTipsCtrl:RefreshElement(goParent, elementType, index)
  local bNone = true
  for i = 1, 3 do
    local icon = goParent:GetChild(i - 1):GetComponent("Image")
    if elementType[i] ~= nil then
      icon.gameObject:SetActive(true)
      local sName = AllEnum.ElementIconType.Icon .. elementType[i]
      self:SetAtlasSprite(icon, "12_rare", sName)
      bNone = false
    else
      icon.gameObject:SetActive(false)
    end
  end
  self._mapNode.txtPropertyNone[index].gameObject:SetActive(bNone)
end

function MonsterTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function MonsterTipsCtrl:OnDestroy()
end

function MonsterTipsCtrl:OnRelease()
end

function MonsterTipsCtrl:OnBtnClick_ClosePanel(btn)
  EventManager.Hit(EventId.ClosePanel, PanelId.MonsterTips)
end

return MonsterTipsCtrl
