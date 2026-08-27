local base = UIBaseNode
local UINSEChallengePageItem = class("UINSEChallengePageItem", UIBaseNode)
local UINSEResPageItemRewardNode = require("Game.Sector.UISector.UISectorEntrance.Pages.Res.UINSEResPageItemRewardNode")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")

function UINSEChallengePageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_dungeonNode, self, self.__OnClickItem)
  self.entranceType = nil
  self.ui.img_Tag:SetActive(false)
end

function UINSEChallengePageItem:InitResPageItem(dunCfg, playModeCtrl, resloader)
  self.entranceType = dunCfg.system_id
  self.playModeCtrl = playModeCtrl
  self.resloader = resloader
  self.ui.tex_DunNameCN.text = LanguageUtil.GetLocaleText(dunCfg.name_cn)
  self.ui.tex_DunNameEN.text = dunCfg.name_en
  self:__LoadRes(dunCfg)
  self.isUnlock, self.unlockStr = self.playModeCtrl:IsSectorPlayModeUnlock(self.entranceType)
  self.ui.obj_Locked:SetActive(not self.isUnlock)
  if not self.isUnlock then
    self.ui.tex_LockCondition.text = self.unlockStr
    return
  end
  self:__RefreshState()
  self:__AddRefrshReddot()
end

function UINSEChallengePageItem:__RefreshState()
  local modeData = self.playModeCtrl:GetSectorPlayModeShowData(self.entranceType)
  if modeData == nil then
    return
  end
  local tagIndex = modeData:GetSPMTagInfo()
  local stateType, stateStrArray = modeData:GetSPMStateInfo()
  self.ui.img_Tag:SetActive(tagIndex ~= nil)
  if tagIndex ~= nil then
    self.ui.tex_tag:SetIndex(tagIndex)
  end
  self.ui.tex_State.gameObject:SetActive(stateType ~= nil)
  if stateType ~= nil then
    if stateStrArray ~= nil then
      self.ui.tex_State:SetIndex(stateType, SafeUnpack(stateStrArray))
    else
      self.ui.tex_State:SetIndex(stateType)
    end
  end
  local secondStateType, secondStateStrArray = modeData:GetSSPMStateInfo()
  self.ui.Tex_SecondState.gameObject:SetActive(secondStateType ~= nil)
  if secondStateType ~= nil then
    if stateStrArray ~= nil then
      self.ui.Tex_SecondState:SetIndex(secondStateType, SafeUnpack(secondStateStrArray))
    else
      self.ui.Tex_SecondState:SetIndex(secondStateType)
    end
  end
  local spEndTimeStr = modeData:GetSPEndTime()
  self.ui.Obj_EndTime.gameObject:SetActive(spEndTimeStr ~= nil)
  if spEndTimeStr ~= nil then
    self.ui.Tex_EndTime.text = spEndTimeStr
  end
end

function UINSEChallengePageItem:__LoadRes(dunCfg)
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorEntrance"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, dunCfg.icon)
  end)
  local nameResPath = PathConsts:GetSectorEntrancTex(dunCfg.Image)
  self.ui.img_Dungeon.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(nameResPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_Dungeon.gameObject:SetActive(true)
    self.ui.img_Dungeon.texture = texture
  end)
end

function UINSEChallengePageItem:__AddRefrshReddot()
  if IsNull(self.gameObject) then
    return
  end
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  local actNode = self.playModeCtrl:GetPlayModeReddotNode()
  
  local function RefrshActivityReddot(node)
    local isBlue, num = self.playModeCtrl:GetPlayModeReddotTypeAndNum()
    self.ui.redDot:SetActive(not isBlue and 0 < num)
    self.ui.blueDot:SetActive(isBlue and 0 < num)
    local _, sctChallengeNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge)
    local sctNode = sctChallengeNode:AddChild(self.entranceType)
    sctNode:SetRedDotCount(0 < num and 1 or 0)
  end
  
  if actNode == nil then
    RefrshActivityReddot()
    return
  end
  
  function self.removeReddotFunc()
    RedDotController:RemoveListener(actNode.nodePath, RefrshActivityReddot)
  end
  
  RedDotController:AddListener(actNode.nodePath, RefrshActivityReddot)
  RefrshActivityReddot(actNode)
end

function UINSEChallengePageItem:__OnClickItem()
  if not self.isUnlock then
    return
  end
  self.playModeCtrl:OpenSectorPlayMode(self.entranceType, nil, function()
    self:__AddRefrshReddot()
  end)
end

function UINSEChallengePageItem:OnDelete()
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  base.OnDelete(self)
end

return UINSEChallengePageItem
