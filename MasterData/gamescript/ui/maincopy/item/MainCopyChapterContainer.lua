local Vector3_Zero = CS.UnityEngine.Vector3.zero
local MainCopyChapterContainer, Super = System.NewComponent("MainCopyChapterContainer")

function MainCopyChapterContainer:ctor(uiNode, stageData, index, totalIndex, model, view)
  Super.ctor(self)
  self.ui = UI_Chaper_Item_LevelResource(uiNode)
  self.stageData = stageData
  self.index = Vue.ref(index)
  self.totalIndex = Vue.ref(totalIndex)
  self.model = model
  self.view = view
end

function MainCopyChapterContainer:OnBind(binder)
  if not self.stageData then
    binder:SetActive(self.ui.uiNode, false)
    return
  end
  binder:SetActive(self.ui.uiNode, true)
  local isBoss = CopyDataUtils.IsWorldBossStage(self.stageData.stageID)
  local prefab = binder:LoadAsset(isBoss and CommonRes.ChapterBossPrefab or CommonRes.ChapterItemPrefab)
  local chapterItemGo = binder:Instantiate(prefab, self.ui.uiNode.transform)
  local chapterItemTf = chapterItemGo.transform
  binder:UpdateLocalizedTextAndResouce(chapterItemGo)
  local isUp = 0 == (self.index.value and self.index.value % 2)
  local chapterParent = isUp and self.ui.Content_Up or self.ui.Content_Down
  chapterItemTf:SetParent(chapterParent.transform)
  chapterItemTf.localPosition = Vector3_Zero
  binder:SetActive(self.ui.Image_Line0, isUp)
  binder:SetActive(self.ui.Image_Line1, not isUp)
  binder:BindComponent(MainCopyChapterItem(chapterItemGo, self.stageData, self.model, self.view))
end

function MainCopyChapterContainer:OnTodoFunc()
end

return MainCopyChapterContainer
