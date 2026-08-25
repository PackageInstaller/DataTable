local UICompRelicIconItem, Super = NewViewComponent("UICompRelicIconItem")

function UICompRelicIconItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Award_CreationResource(uiNode)
  self.relicTid = data.relicTid
  self.stageId = data.stageId
  self.hideName = data.hideName
end

function UICompRelicIconItem:OnEnterComponent()
  self.ui.Image:SetActive(not self.hideName)
  self.ui.Relic_Name:SetActive(not self.hideName)
  self:SetText(self.ui.Text_Tab_Nor, LT.Text("ThisWeek"))
  local config = DT.RelicConfig[self.relicTid]
  if config then
    local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
    self:SetImage(self.ui.Image_icon, config.Icon)
    self:SetImage(self.ui.Image_Quality, DT.ItemQuality[config.Quality].ItemQualityFrame)
    self:SetText(self.ui.Relic_Name, LT.Text(config.Name))
    self:SetText(self.ui.Text_Creation_Name, LT.Text(enchantTypeMap[config.Quality]))
    local tipRoot = UIManager.GetTipPopRoot()
    self:AddButtonClickListener(self.ui.Image_icon, function()
      local item = self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({
        relicTid = self.relicTid
      }), {
        stageId = self.stageId
      })
      local uiCamera = CameraManager:GetUICamera()
      local posVec2 = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.ui.Image_icon.transform.position, tipRoot:GetComponent(typeof(CS.UnityEngine.RectTransform)), uiCamera)
      item:SetItemPosition(posVec2)
    end)
  else
    Logger.Error("造物配置没找到,Id为：" .. self.relicTid)
  end
end

return UICompRelicIconItem
