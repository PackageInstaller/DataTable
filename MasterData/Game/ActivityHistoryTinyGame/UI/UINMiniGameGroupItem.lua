local UINMiniGameGroupItem = class("UINMiniGameGroupItem", UIBaseNode)
local base = UIBaseNode

function UINMiniGameGroupItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.gameItem, self, self.OnClickMiniGameItem)
end

function UINMiniGameGroupItem:InitMiniGameGroupItem(miniGameData, resloader, callback)
  self._miniGameData = miniGameData
  self._callback = callback
  local tinygameType = self._miniGameData:GetTinyGameType()
  self.gameObject.name = tinygameType
  local resName = "UI_MiniGameGroupListBg" .. tostring(tinygameType)
  resloader:LoadABAssetAsync(PathConsts:GetMiniGameItemPic(resName), function(texture)
    if not IsNull(self.transform) then
      self.ui.bottom.texture = texture
    end
  end)
  local gameTypeCfg = ConfigData.tiny_game_type[tinygameType]
  if gameTypeCfg ~= nil then
    self.ui.tex_GameName.text = LanguageUtil.GetLocaleText(gameTypeCfg.game_name)
  else
    error("小游戏类型不存在")
  end
  self:RefreshHTGMiniGameRank()
end

function UINMiniGameGroupItem:RefreshHTGMiniGameRank()
  local rank = self._miniGameData:GetHTGMineRank()
  if 0 < rank then
    self.ui.tex_Rank:SetIndex(0, tostring(rank))
  else
    self.ui.tex_Rank:SetIndex(1)
  end
end

function UINMiniGameGroupItem:SetHTGMiniGameLocked(flag)
  self.ui.obj_Locked:SetActive(flag)
end

function UINMiniGameGroupItem:PlayMiniGroupItemAni(delayTime)
  self:__StopAni()
  self.ui.canvasGroup:DOFade(0, 0.2):From():SetDelay(delayTime)
  self.ui.bottom.transform:DOLocalMoveY(-20, 0.2):From():SetDelay(delayTime)
end

function UINMiniGameGroupItem:__StopAni()
  self.ui.canvasGroup:DOComplete()
  self.ui.bottom.transform:DOComplete()
end

function UINMiniGameGroupItem:OnClickMiniGameItem()
  if self._callback ~= nil then
    self._callback(self._miniGameData)
  end
end

return UINMiniGameGroupItem
