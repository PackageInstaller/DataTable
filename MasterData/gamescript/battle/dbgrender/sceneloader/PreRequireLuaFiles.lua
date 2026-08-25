local PreRequireLuaFiles = System.NewClass("PreRequireLuaFiles")

function PreRequireLuaFiles:ctor()
end

function PreRequireLuaFiles:PreloadLuaFiles()
  if self._hasPreloaded then
    return
  end
  self._hasPreloaded = true
  local preRequireLuaList = {
    "MVC.BaseView",
    "MVC.UIViewNotificationsMgr",
    "MVC.UIViewComponentsMgr",
    "MVC.UIViewEffectMgr",
    "MVC.UIViewImagesLoader",
    "MVC.UIViewEventsMgr",
    "MVC.Components.UICompBtnCloseItem",
    "MVC.ViewComponent",
    "MVC.UIViewMaterialIconMgr",
    "MVC.Components.UICompRedDot",
    "MVC.Components.UICompCommonCurrencyGroupItem",
    "MVC.Components.UICoinInfoComponent",
    "MVC.Components.UICompAwakerPortrait",
    "MVC.Components.UICompCommonLockPrefab",
    "Managers.Icon.MaterialIconProxy",
    "Managers.Icon.MaterialIconFlag",
    "Managers.Res.GameObjectPool",
    "Battle.Expression.BattleCmdParserClient",
    "UI.Public.Item.CommonCurrencyGroupItem",
    "UI.DbgBattle.BattlePanel",
    "UI.DbgBattle.BattleRoleUI.BattleExSkillPanel",
    "Managers.UI.UIBasePanel",
    "UI.Awaker.Panel.AwakerBasePanel",
    "Battle.BattleRender",
    "Battle.BattleScene",
    "Battle.BattleManager",
    "Battle.DbgRender.SceneLoader.BattleSceneLoader",
    "UI.MainInterface.Panel.MainPanel",
    "UI.CommonFloatTips.CommonFloatTipsComponent",
    "UI.CommonFloatTips.CommonFloatTipsPanel",
    "UI.MainCopy.Panel.MainCopyChapterPanel",
    "UI.Public.Item.CommonProgressBtnGroup",
    "UI.MainCopy.Item.MainCopyChapterContainer",
    "UI.MainCopy.Item.MainCopyChapterItem",
    "Extensions.Copy.Views.CopyMainView",
    "Extensions.Copy.Views.CopyMainChapterView",
    "Managers.UI.Components.TextWidthAdapter",
    "Extensions.Copy.Components.UICompMainCopyItem",
    "Extensions.Copy.Views.CopyLargeBranchView",
    "Extensions.Copy.Components.UICompSubplotGroupItem",
    "Extensions.Copy.Views.CopySmallBranchView",
    "Extensions.Copy.Views.SubplotGroupView",
    "Extensions.Copy.Components.UICompCommonProgressBtnGroup",
    "Extensions.Copy.Components.UICompSubplotStageListItem",
    "Extensions.Bag.Views.BagView",
    "Extensions.Bag.Components.UICompBagItemDetailTipsItem",
    "Extensions.Bag.Components.UICompItemDetailTipsItemBase"
  }
  self.preRequireLuaList = preRequireLuaList
  self.requireLuaIndex = 0
  
  local function DoRequireLuaFile()
    self.requireLuaIndex = self.requireLuaIndex + 1
    if self.requireLuaIndex > #self.preRequireLuaList then
      TimerManager.Instance:StopTimer(self.requireLuaTimerId)
      self.requireLuaTimerId = nil
      return
    end
    require("GameScript." .. self.preRequireLuaList[self.requireLuaIndex])
  end
  
  self.requireLuaTimerId = TimerManager.Instance:CreateTimer(0.1, -1, DoRequireLuaFile, DoRequireLuaFile)
end

function PreRequireLuaFiles:Clear()
  if self.requireLuaTimerId then
    TimerManager.Instance:StopTimer(self.requireLuaTimerId)
    self.requireLuaTimerId = nil
  end
end

PreRequireLuaFiles.Instance = PreRequireLuaFiles()
return PreRequireLuaFiles
