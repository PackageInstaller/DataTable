local this = class("cellDungeonItem", G_UIModuleBase)
local starManualTpl = L_GameTpl:getStarManualTpl()
local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local DungeonTabType = {}

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    name = "",
    name_selected = "",
    show_selected_icon = false,
    lock = false,
    isEnd = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.lock == true then
        local tpl = systemUnlockTpl:getTplById(self.bind.systemId)
        if tpl then
          local msg = systemUnlockTpl:getLockTips(tpl)
          if not string.isEmpty(msg) then
            L_FlyMsgManager:showNormalMsg(msg)
            L_AudioUtil.playSound("Play_SFX_System_HUD_General_Hint_N1")
          end
        end
        return
      end
      if self.bind.show_selected_icon == true then
        return
      end
      if self.bind.starManualId == L_DungeonConst.DungeonSystemType.Gold or self.bind.starManualId == L_DungeonConst.DungeonSystemType.Break or self.bind.starManualId == L_DungeonConst.DungeonSystemType.Skill then
        L_AudioUtil.playSound("Play_SFX_System_UI_StarGuide_Tab_Click_L1")
      elseif self.bind.starManualId == L_DungeonConst.DungeonSystemType.Equip then
        L_AudioUtil.playSound("Play_SFX_System_UI_StarGuide_Tab_Click_L2")
      elseif self.bind.starManualId == L_DungeonConst.DungeonSystemType.WorldBoss then
        L_AudioUtil.playSound("Play_SFX_System_UI_StarGuide_Tab_Click_L3")
      end
      self:emit("onClick", self.bind)
    end
  }
end

function this:open()
  self.bind.name = self.bind.lock == true and string.format(" <color=#AAAAAA>%s</color>", self.bind.name) or self.bind.name
end

function this:fresh()
  self.bind.name_selected = self.bind.name
end

return this
