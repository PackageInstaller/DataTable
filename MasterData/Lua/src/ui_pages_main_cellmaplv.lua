local this = class("cellMapLv", G_UIModuleBase)
local colorSelect = "#ffffff"
local colorUncelect = "#000000"

function this.bind()
  return {
    txtName = "",
    goIcon = false,
    goLock = false,
    goActive = false,
    goLine = false,
    goNew = false,
    txtLv = "",
    img_lv = ""
  }
end

function this.methods()
  return {
    onClickSelect = function(self)
      local isComplete = L_ConditionManager:isComplete(self.bind.tpl.condition)
      if isComplete and not self.bind.isReddotFinish then
        L_WorldMapLvStore:req_worldMapReddot(self.bind.tpl.mapid, self.bind.tpl.difficultLv)
      end
      if self.bind.selectedLv == self.bind.tpl.difficultLv then
        return
      end
      local isComplete = L_ConditionManager:isComplete(self.bind.tpl.condition)
      if isComplete then
        if self.bind.callback ~= nil then
          self.bind.callback(self)
        end
      else
        local desc = L_ConditionManager:getDescs(self.bind.tpl.condition)
        L_FlyMsgManager:showNormalMsg(desc[1])
      end
    end
  }
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  self.bind.txtName = L_Config:provider(self.bind.tpl.name)
  self.bind.txtLv = L_Config:provider(self.bind.tpl.desc)
  self.bind.goActive = self.bind.selectedLv == self.bind.tpl.difficultLv
  local isComplete = L_ConditionManager:isComplete(self.bind.tpl.condition)
  self.bind.goLock = not isComplete
  self.bind.goLine = not self.bind.isLast
  self.bind.goNew = isComplete and not self.bind.isReddotFinish
  local color
  if isComplete then
    color = colorSelect
  else
    color = colorUncelect
  end
  local _, c = C_ColorUtility.TryParseHtmlString(color)
  local path_img_lv = "UI/Atlas/Common/tex_mapLv_word_nd0%d.png"
  self.bind.img_lv = string.format(path_img_lv, self.bind.tpl.difficultLv)
end

function this:setSelected(selectedLv)
  self.bind.selectedLv = selectedLv
  self:refreshView()
end

function this:setReddotFinish(isReddotFinish)
  self.bind.isReddotFinish = isReddotFinish
  local isComplete = L_ConditionManager:isComplete(self.bind.tpl.condition)
  self.bind.goNew = isComplete and not self.bind.isReddotFinish
end

return this
