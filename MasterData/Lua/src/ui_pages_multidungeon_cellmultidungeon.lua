local this = class("cellMultiDungeon", G_UIModuleBase)
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()

function this.bind()
  return {
    txt_name = nil,
    list_tag = {
      moduleName = "pages/multiDungeon/cellMultiDungeonTag"
    },
    go_complete = false,
    img_grade = nil,
    go_lock = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if not self.bind.go_lock then
        self:emit("onClick_select", self.bind)
      end
    end
  }
end

function this:open()
  self:refreshView(self.bind.dungeonId)
end

function this:refreshView(dungeonId)
  self.bind.dungeonId = dungeonId
  if not self.isBind then
    return
  end
  local serverData = L_MultiDungeonStore:getMultiDungeonInfo(dungeonId)
  local tpl_multiDungeon = _multiDungeonTpl:getTplById(self.bind.dungeonId)
  self.bind.txt_name = _multiDungeonTpl:getName(tpl_multiDungeon)
  local tag = _multiDungeonTpl:getDungeonTag(tpl_multiDungeon)
  local tmp = {}
  for i, v in pairs(tag) do
    table.insert(tmp, {txt_name = v})
  end
  self.bind.list_tag:clear()
  self.bind.list_tag:insert_array(tmp)
  self.bind.go_lock = not L_ConditionManager:isComplete(_multiDungeonTpl:getUnlockCondition(tpl_multiDungeon))
  self.bind.go_complete = serverData.status == L_Const.CampaignStatusType.CST_WIN
  self.bind.img_grade = nil
end

return this
