local SceneTitleNameItem, Super = System.NewComponent("SceneTitleNameItem")

function SceneTitleNameItem:ctor(uiNode, tid)
  Super.ctor(self)
  self.sceneTid = tid
  self.ui = Func_City_TitleNameResource(uiNode)
end

function SceneTitleNameItem:OnBind(binder)
  Logger.Info("SceneTitleNameItem:OnBind(), 创建 UI")
  local config = DT.InteractionConfig[self.sceneTid]
  binder:SetText(self.ui.Text_City_Title_CN, LT.Text(config.Name))
  self.ui.Text_City_Title_EN:SetActive(false)
  self.ui.uiNode.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
  self.ui.uiNode.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
end

return SceneTitleNameItem
