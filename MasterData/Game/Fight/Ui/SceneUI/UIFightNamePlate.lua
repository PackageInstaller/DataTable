local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightSceneUiItem = require("Game.Fight.Ui.SceneUI.UIFightSceneUiItem")
local UIFightNamePlate = class("UIFightNamePlate", UIFightSceneUiItem)

function UIFightNamePlate:SetName(name)
  self.ui.tex_Name.text = name or ""
end

function UIFightNamePlate:SetSelfStyle(isSelf)
  self.ui.obj_Name:SetActive(not isSelf)
  self.ui.obj_Target:SetActive(isSelf)
end

function UIFightNamePlate:GetSceneUiType()
  return DormFightConst.SceneUiType.NamePlate
end

return UIFightNamePlate
