local this = class("soliderManager", G_EventManagerBase)
local _wordsTpl = L_GameTpl:getWordsTpl()
local propertyIconData = {
  [L_Const.battleAtt.MAXHP] = "BSCommon/tex_icon_status_hp",
  [L_Const.battleAtt.ATK] = "BSCommon/tex_icon_status_atk",
  [L_Const.battleAtt.DEF] = "BSCommon/tex_icon_status_def",
  [L_Const.battleAtt.MDEF] = "BSCommon/tex_icon_status_res"
}

function this:getPropertyIcon(str)
  return propertyIconData[str]
end

function this:hintInfo(num)
  local switch = {
    [1] = function()
      L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_soldier_recruitSuccess"))
    end,
    [2] = function()
      L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_hero_lackLevel"))
    end,
    [3] = function()
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_shortageMaterial"))
    end,
    [4] = function()
      L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("menu_common_activation"))
    end,
    [5] = function()
      L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_soldier_recruitSuccess"))
    end,
    [6] = function()
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_stageSuccess"))
    end
  }
  local f = switch[num]
  if f then
    return f()
  else
  end
end

return this
