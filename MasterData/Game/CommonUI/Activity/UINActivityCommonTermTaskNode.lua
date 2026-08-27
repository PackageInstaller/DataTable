local UINActivityCommonTermTaskNode = class("UINActivityCommonTermTaskNode", UIBaseNode)
local base = UIBaseNode
local UINActivityCommonTermTaskItem = require("Game.CommonUI.Activity.UINActivityCommonTermTaskItem")

function UINActivityCommonTermTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickGetAll)
  self.ui.taskList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.taskList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__TaskClickCallback = BindCallback(self, self.__TaskClick)
  self._goItem = {}
end

function UINActivityCommonTermTaskNode:InitTermTaskNode()
end

function UINActivityCommonTermTaskNode:RefillTermTaskNode()
end

function UINActivityCommonTermTaskNode:__OnInstantiateItem()
end

function UINActivityCommonTermTaskNode:__OnChangeItem()
end

function UINActivityCommonTermTaskNode:RefreshTermTaskChange()
end

function UINActivityCommonTermTaskNode:OnClickGetAll()
end

function UINActivityCommonTermTaskNode:__TaskClick()
end

function UINActivityCommonTermTaskNode:__RefreshGetAllBtn(getAllActive)
  self.ui.btn_GetAll.gameObject:SetActive(getAllActive)
end

function UINActivityCommonTermTaskNode:PlayTaskNodeAnim()
  for _, item in pairs(self._taskItemDic) do
    if not IsNull(item) then
      item:PlayTermTaskAnim()
    end
  end
end

function UINActivityCommonTermTaskNode:OnDelete()
  for _, item in pairs(self._taskItemDic) do
    item:Delete()
  end
end

return UINActivityCommonTermTaskNode
