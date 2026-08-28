local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local module = {}

function module:OnStart(ca)
  local pos = {x = 0, y = 0}
  if ca.uiType == "CharacterList" then
    local View = require("UICharacterList/UICharacterListView")
    local DataModel = require("UICharacterList/UICharacterListDataModel")
    local strId = tostring(ca.unitId)
    local index = 0
    for k, v in pairs(DataModel.Roles) do
      if strId == v then
        index = k
        break
      end
    end
    if 0 < index then
      View.ScrollGrid_Middle.grid.self:MoveToPos(index)
      local tran = View.ScrollGrid_Middle.grid.self:GetChildByIndex(index - 1)
      pos = tran.position
    end
  elseif ca.uiType == "SelectCharacter" then
    local View = require("UISquads/UISquadsView")
    local DataModel = require("UISquads/UISquadsDataModel")
    if View and DataModel then
      local index = 0
      for k, v in pairs(DataModel.SortRoles) do
        if v.id == ca.unitId then
          index = k
          break
        end
      end
      if 0 < index then
        local tran = View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:GetChildByIndex(index - 1)
        pos = tran.position
      end
    end
  elseif ca.uiType == "HomeSticker" then
    local View = require("UIHomeSticker/UIHomeStickerView")
    local DataModel = require("UIHomeSticker/UIHomeStickerDataModel")
    if View and DataModel then
      local index = 0
      for k, v in pairs(DataModel.allCheckInCharacters) do
        if tonumber(v.id) == tonumber(ca.unitId) then
          index = k
          break
        end
      end
      if 0 < index then
        local tran = View.Group_InviteMember.ScrollGrid_MemberList.grid.self:GetChildByIndex(index - 1)
        pos = tran.position
      end
    end
  elseif ca.uiType == "Squads" then
    local View = require("UISquads/UISquadsView")
    local DataModel = require("UISquads/UISquadsDataModel")
    if View and DataModel then
      local index = 0
      local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
      if squad then
        for k, v in pairs(squad.role_list) do
          if tonumber(v.id) == tonumber(ca.unitId) then
            index = k
            break
          end
        end
      end
      if 0 < index then
        local tran = View.StaticGrid_List.grid.self:GetChildByIndex(index - 1)
        pos = tran.position
      end
    end
  end
  UIGuidanceController.ActiveUIGuide()
  pos = UIGuidanceController.GetLocalPos(pos)
  UIGuidanceController.SetFocus(pos.x, pos.y, ca.w, ca.h, 0, 0)
  UIGuidanceController.PosOffset(ca.offsetX, ca.offsetY)
  UIGuidanceController.ShowFinger(ca.isShowFinger)
  UIGuidanceController.SetBgAlpha(ca.alpha)
end

function module:IsFinish()
  return true
end

return module
