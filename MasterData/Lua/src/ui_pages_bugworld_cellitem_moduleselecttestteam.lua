local this = class("moduleSelectTestTeam", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_select = nil,
    txt_select = "",
    go_list = false,
    go_arrowOpen = false,
    go_arrowClose = true,
    scrollList_filter = {
      moduleName = "pages/bugWorld/cellItem/cellTeamTestItem"
    }
  }
end

function this.methods()
  return {
    onClick_filer = function(self)
    end,
    scrollList_filter = {}
  }
end

return this
