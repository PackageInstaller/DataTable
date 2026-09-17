local this = class("moduleMapEntrustTaskNpcInfo", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    icon = "",
    icon_detail = "",
    name = "",
    mapAreaName = "",
    desc = "",
    show_desc = true,
    moduleDoubleRewardTipItem = {
      moduleName = "pages/gameAct/doubleDrop/moduleDoubleRewardTipItem"
    },
    moduleActivityMaoDetail = {
      moduleName = "pages/gameAct/moduleGameActivityMapDetail"
    }
  }
end

function this.methods()
  return {
    onClick_goto = function(self)
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.entrustTask)
      if not result then
        return
      end
      self.parent:excuteNodeFunction()
    end
  }
end

function this:initModule(node)
  self.node = node
  self.bind.icon = node.iconPath
  self.bind.icon_detail = node.iconPath
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.desc = node.desc
  self.bind.name = node.name
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_bg)
  self.bind.mapAreaName = node.mapAreaName
  self.modules.moduleDoubleRewardTipItem:refreshVisible()
end

return this
