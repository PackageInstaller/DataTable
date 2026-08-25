local BuffListItem, Super = System.NewComponent("BuffListItem")
local typeof = _ENV.typeof
local Text = CS.UnityEngine.UI.Text

function BuffListItem:ctor(root, role, buff)
  Super.ctor(self)
  self.root = root
  self.role = role
  self.buff = buff
  self.ui = Item_Battle_InformationResource(root)
end

function BuffListItem:OnBind(binder)
  local stateDataClient = BattleStateDataClient(self.buff)
  binder:BindToText(self.ui.Text_Information_Name, function()
    do return stateDataClient.GetBuffName end
    return stateDataClient.GetBuffName, stateDataClient
  end)
  binder:BindToText(self.ui.Text_Buff_Count, function()
    if 0 == self.buff.layer or not self.buff.layer then
      return
    end
    do return stateDataClient.GetLifeText end
    return stateDataClient.GetLifeText, stateDataClient
  end)
  binder:BindToVisible(self.ui.Text_Buff_Count, function()
    local life = self.buff.layer or 0
    return life > 1
  end)
  binder:BindToText(self.ui.Text_Information_Explain, function()
    do return stateDataClient.GetDesc end
    return stateDataClient.GetDesc, stateDataClient
  end)
  binder:BindToImage(self.ui.Image_Information_Icon, function()
    if stateDataClient.configData.Icon ~= nil then
      return bc.ICON_PATH_PERFIX .. stateDataClient.configData.Icon
    end
  end)
  self.ui.Text_Information_Count:SetActive(false)
  self.ui.Btn_Information_Down:SetActive(false)
  binder:BindToText(self.ui.Text_Tips_Name, function()
    do return stateDataClient.GetBuffTypeDesc end
    return stateDataClient.GetBuffTypeDesc, stateDataClient
  end)
end

return BuffListItem
