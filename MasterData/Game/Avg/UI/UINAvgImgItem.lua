local UINAvgImgItem = class("UINAvgImgItem", UIBaseNode)
local base = UIBaseNode
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_MovieManager_ins = CS.MovieManager.Instance

function UINAvgImgItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.rawImg.enabled = false
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

function UINAvgImgItem:InitAvgImgItem(imgCfg, parent, tweenCompleteEvent)
  self.imgId = imgCfg.imgId
  self.imgCfg = imgCfg
  self.tweenCompleteEvent = tweenCompleteEvent
  self.immediateComplete = false
  self.tweenCfgList = {}
  self.transform:SetParent(parent)
  self:InitAvgImgParam()
  if self.imgCfg.imgType ~= eAvgImgType.Movie then
    self:LoadTexture()
  else
    self:LoadMovie()
  end
end

function UINAvgImgItem:InitAvgImgParam()
  local imgCfg = self.imgCfg
  local pos
  if imgCfg.posId ~= nil then
    pos = eAvgImgPosType[imgCfg.posId]
  elseif imgCfg.pos ~= nil then
    pos = Vector3.New(imgCfg.pos[1], imgCfg.pos[2], imgCfg.pos[3])
  else
    pos = Vector3.zero
  end
  self.transform.localPosition = pos
  local rot
  if imgCfg.rot == nil then
    rot = Vector3.zero
  else
    rot = Vector3.New(imgCfg.rot[1], imgCfg.rot[2], imgCfg.rot[3])
  end
  self.transform.localEulerAngles = rot
  local scale
  if imgCfg.scale == nil then
    scale = Vector3.one
  else
    scale = Vector3.New(imgCfg.scale[1], imgCfg.scale[2], imgCfg.scale[3])
  end
  self.transform.localScale = scale
  local color = imgCfg.isDark and Color.gray or Color.white
  local alpha = imgCfg.alpha == nil and self.ui.rawImg.color.a or imgCfg.alpha
  color.a = alpha
  self.ui.rawImg.color = color
end

function UINAvgImgItem:_GetImgPath()
  local imgPath = self.imgCfg.imgPath
  if not string.IsNullOrEmpty(self.imgCfg.imgPathBoy) then
    local isGirl = PlayerDataCenter.inforData ~= nil and PlayerDataCenter.inforData:GetSex()
    if not isGirl then
      imgPath = self.imgCfg.imgPathBoy
    end
  end
  return imgPath
end

function UINAvgImgItem:LoadTexture()
  self.loadResComplete = false
  self.resloader = CS_ResLoader.Create()
  local imgPath = self:_GetImgPath()
  if string.IsNullOrEmpty(imgPath) then
    self.avgCtrl:AvgLogError("imgPath is empty, imgid = " .. tostring(self.imgId))
    return
  end
  local path = PathConsts:GetAvgImgPath(imgPath)
  self.resloader:LoadABAssetAsync(path, function(texture)
    self.ui.rawImg.texture = texture
    self.ui.rawImg.enabled = true
    if self.imgCfg.imgType ~= eAvgImgType.Character then
      if self.imgCfg.fullScreen then
        self.ui.bgUIAdapter:AdaptBgUI()
      else
        self.ui.rawImg:SetNativeSize()
      end
    end
    self.loadResComplete = true
    for k, tweenCfg in ipairs(self.tweenCfgList) do
      AvgImgTweenUntil.Tween(self, tweenCfg)
    end
    self:PlayAvgImgTween()
  end)
end

function UINAvgImgItem:LoadMovie()
  self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  self.ui.rawImg.enabled = true
  self.moviePlayer:SetVideoRender(self.ui.rawImg)
  self.moviePlayer:PlayVideo(self:_GetImgPath(), nil, 1, true)
  self.ui.bgUIAdapter:AdaptBgUI()
  self.loadResComplete = true
  for k, tweenCfg in ipairs(self.tweenCfgList) do
    AvgImgTweenUntil.Tween(self, tweenCfg)
  end
  self:PlayAvgImgTween()
end

function UINAvgImgItem:GetAvgImgOrder()
  return self.imgCfg.order or 0
end

function UINAvgImgItem:ChangeAvgImgOrder(order)
  self.imgCfg.order = order
end

function UINAvgImgItem:PlayAvgImgTween()
  if self.sequence ~= nil and self.loadResComplete then
    if self.immediateComplete then
      self.sequence:Complete()
      self:OnTweenComplete()
      return
    end
    self.sequence:AppendCallback(self:GetAvgImgTweenCompleteEvent())
    self.sequence:Play()
  end
end

function UINAvgImgItem:AddAvgImgTween(tweenCfg)
  if self.loadResComplete then
    AvgImgTweenUntil.Tween(self, tweenCfg)
  else
    table.insert(self.tweenCfgList, tweenCfg)
  end
end

function UINAvgImgItem:GetAvgImgSequence()
  return self.sequence
end

function UINAvgImgItem:SetAvgImgSequence(sequence)
  self.sequence = sequence
end

function UINAvgImgItem:GetAvgImgTweenCompleteEvent()
  if self.__onTweenComplete == nil then
    self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
  end
  return self.__onTweenComplete
end

function UINAvgImgItem:OnTweenComplete()
  self.sequence = nil
  self.tweenCfgList = {}
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent(self.imgId)
  end
end

function UINAvgImgItem:AvgImgTweenDoComplete()
  if self.sequence ~= nil and self.sequence:IsPlaying() then
    self.sequence:Complete(true)
  else
    self.immediateComplete = true
  end
end

function UINAvgImgItem:AvgImgTweenDoEnd()
  if self.sequence ~= nil and self.sequence:IsPlaying() then
    self.sequence:Kill()
  end
end

function UINAvgImgItem:GetAvgImgType()
  return self.imgCfg.imgType
end

function UINAvgImgItem:OnHide()
  self:OnRecycleAvgImg()
end

function UINAvgImgItem:OnRecycleAvgImg()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  self.ui.rawImg.texture = nil
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
end

function UINAvgImgItem:OnDelete()
  self:OnRecycleAvgImg()
  base.OnDelete(self)
end

return UINAvgImgItem
