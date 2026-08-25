local RelicIconComponent, Super = System.NewComponent("RelicIconComponent")

function RelicIconComponent:ctor(node, relicTid, stageId, hideName)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_Award_CreationResource(node)
  self.relicTid = relicTid
  self.stageId = stageId
  self.hideName = hideName
end

function RelicIconComponent:OnBind(binder)
  self.binder = binder
  self.ui.Image:SetActive(not self.hideName)
  self.ui.Relic_Name:SetActive(not self.hideName)
  local config = DT.RelicConfig[self.relicTid]
  if config then
    local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
    self.binder:SetImage(self.ui.Image_icon, config.Icon)
    self.binder:SetImage(self.ui.Image_Quality, DT.ItemQuality[config.Quality].ItemQualityFrame)
    self.binder:SetText(self.ui.Relic_Name, config.Name)
    self.binder:SetText(self.ui.Text_Creation_Name, enchantTypeMap[config.Quality])
    local tipRoot = UIManager.GetTipPopRoot()
    self.binder:BindButtonClick(self.ui.Image_icon, function()
      local item = binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({
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

return RelicIconComponent
