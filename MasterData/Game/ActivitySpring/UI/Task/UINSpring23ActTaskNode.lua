local base = require("Game.ActivityChristmas.UI.Task.UINChristmas22ActTaskNode")
local UINSpring23ActTaskNode = class("UINSpring23ActTaskNode", base)
local UINSpring23ActTaskItem = require("Game.ActivitySpring.UI.Task.UINSpring23ActTaskItem")
local JumpManager = require("Game.Jump.JumpManager")

function UINSpring23ActTaskNode:InitChristmas22ActTaskNode(springData)
  self._springData = springData
  self._taskitemDic = {}
  self._taskIdDic = {}
  local onceTaskIds = self._springData:GetSpringOnceTskIds()
  for _, taskId in pairs(onceTaskIds) do
    self._taskIdDic[taskId] = true
  end
end

function UINSpring23ActTaskNode:__OnInstantiateItem(go)
  local item = UINSpring23ActTaskItem.New()
  item:Init(go)
  self._goItem[go] = item
end

function UINSpring23ActTaskNode:__RefreshGetAllBtn(getAllActive)
  self.ui.img_GetAll.color = getAllActive and self.ui.color_btnActive or self.ui.color_btnDisActive
  local color_texActive = self.ui.color_texActive ~= nil and self.ui.color_texActive or Color.white
  self.ui.tex_GetAll.color = getAllActive and color_texActive or self.ui.color_texDisActive
  self.ui.btn_GetAll.interactable = getAllActive
end

function UINSpring23ActTaskNode:OnClickGetAll()
  self._springData:ReqSpringAllOnceTask(function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
  end)
end

function UINSpring23ActTaskNode:__TaskClick(taskData)
  if not taskData:CheckComplete() then
    local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
    if flag then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
    return
  end
  self._springData:ReqSpringOnceTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
  end)
end

return UINSpring23ActTaskNode
