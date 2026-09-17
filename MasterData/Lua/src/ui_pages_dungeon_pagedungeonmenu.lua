local this = class("pageDungeonMenu", G_UIPageBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:created(...)
  this.super.created(self, ...)
  self.data = {}
end

function this.bind()
  return {txt_name = ""}
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_continue = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_setting = function(self)
      L_UI:open("pageOption")
    end,
    onClick_abandon = function(self)
      local data_tip = {
        txtTitle = L_WordsTpl:getValue("ui_systemMessage_12"),
        txtContent = L_WordsTpl:getValue("ui_systemMessage_13"),
        confirmCallback = function()
          self:exit()
        end
      }
      L_GameUtil.showCommonTip(data_tip)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
end

function this:initPage()
  local dungeonId = AzurWorld.DungeonMgr.DungeonID
  local tpl = _dungeonTpl:getTplById(dungeonId)
  self.bind.txt_name = _dungeonTpl:getName(tpl)
end

function this:exit()
  AzurWorld.DungeonMgr:ReqExitDungeon()
end

return this
