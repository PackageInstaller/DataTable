local FmtHeroEntity = class("FmtHeroEntity")
local CS_ResLoader = CS.ResLoader
local infoPosOffset = Vector3.New(0, 1.1, 0)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local FmtHeroEntityState = {
  Init = 1,
  Loading = 2,
  Loaded = 3,
  Delete = 4
}

function FmtHeroEntity:ctor(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
end

function FmtHeroEntity:InitFmtHeroEntity(go, heroData, camera)
  self.gameObject = go
  self.transform = go.transform
  self.heroData = heroData
  self.camera = camera
  self.modelPath = nil
  self.resloader = CS_ResLoader.Create()
  self.__entityState = FmtHeroEntityState.Init
  return self:LoadModel()
end

function FmtHeroEntity:LoadModel()
  local modelPath = PathConsts:GetCharacterModelPathEx(self.heroData:GetResModelName())
  
  local function coroutineFunc()
    if self.modelPath == modelPath then
      return
    end
    if self.__entityState == FmtHeroEntityState.Delete then
      return
    end
    self.__entityState = FmtHeroEntityState.Loading
    local modelWait = self.resloader:LoadABAssetAsyncAwait(modelPath)
    while not modelWait.IsDone do
      if self.__entityState == FmtHeroEntityState.Delete then
        return
      end
      coroutine.yield(nil)
    end
    if self.__entityState == FmtHeroEntityState.Delete then
      return
    end
    if self.heroGo ~= nil then
      DestroyUnityObject(self.heroGo)
    end
    self.modelPath = modelPath
    self.heroGo = modelWait.Result:Instantiate(self.transform)
    self.heroGo.transform.localEulerAngles = Vector3.New(0, 180, 0)
    self.animator = self.heroGo:FindComponent(eUnityComponentID.Animator)
    if self.animator.isActiveAndEnabled then
      self.animator:SetBool("InFormation", true)
    end
    self:FmtHeroOnDrag(self.__inDrag)
    local gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.None
    local heroId = self.heroData.dataId
    if self.enterFmtData ~= nil then
      if self.enterFmtData:IsFmtTdSpecHero(heroId) then
        gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.TD
      elseif self.heroData.isOfficialSupport then
        gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.OfficialSupport
      elseif self.enterFmtData:IsFmtHeroRecommend(heroId) then
        gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.Recommend
      end
    end
    self.fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if self.fmtWindow ~= nil then
      local heroInfoItem = self.fmtWindow:CreatFmtHeroInfo(self.heroData, self:__GetInfoPos())
      if heroInfoItem ~= nil then
        heroInfoItem:SetFmtSpecialGameHeroActive(gameTypeAdapter)
      end
    end
    self.__entityState = FmtHeroEntityState.Loaded
    return self
  end
  
  return coroutineFunc
end

function FmtHeroEntity:GetHeroEntityLoadedResloader()
  local resloader = self.resloader
  if self.__entityState == FmtHeroEntityState.Loaded and resloader ~= nil then
    self.resloader = nil
    return resloader
  end
  return nil
end

function FmtHeroEntity:FmtHeroOnDrag(drag)
  self.__inDrag = drag or false
  if IsNull(self.animator) or not self.animator.isActiveAndEnabled then
    return
  end
  self.animator:SetBool("DeployFloat", self.__inDrag)
  if self.fmtWindow ~= nil then
    self.fmtWindow:ShowFmtHeroInfo(self.heroData.dataId, not self.__inDrag)
  end
end

function FmtHeroEntity:__GetInfoPos()
  local pos = UIManager:World2UIPosition(self.transform.position + infoPosOffset, nil, nil, self.camera)
  return pos
end

function FmtHeroEntity:UpdateInfoPos()
  if self.fmtWindow ~= nil then
    self.fmtWindow:UpdateFmtHeroInfo(self.heroData, self:__GetInfoPos(), true)
  end
end

function FmtHeroEntity:UpdateFmtHeroEntityHeadInfo()
  if self.fmtWindow ~= nil then
    self.fmtWindow:UpdateFmtHeroInfo(self.heroData, self:__GetInfoPos())
  end
end

function FmtHeroEntity:DragHeroEndTweenHeroDetailItem(position)
  if self.__updateInfoPosFunc == nil then
    self.__updateInfoPosFunc = BindCallback(self, self.UpdateInfoPos)
  end
  self:__ClearDragHeroEndTween()
  self.__dragEndTween = self.transform:DOMove(position, 0.1):OnUpdate(self.__updateInfoPosFunc)
end

function FmtHeroEntity:SetFmtHeroEntityPos(position)
  self:__ClearDragHeroEndTween()
  self.transform.position = position
  self:UpdateInfoPos()
end

function FmtHeroEntity:__ClearDragHeroEndTween()
  if self.__dragEndTween ~= nil then
    self.__dragEndTween:Kill()
    self.__dragEndTween = nil
  end
end

function FmtHeroEntity:GetFmtHeroEntityData()
  return self.heroData
end

function FmtHeroEntity:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.__entityState = FmtHeroEntityState.Delete
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtWindow ~= nil then
    fmtWindow:ReturnFmtHeroInfo(self.heroData.dataId)
  end
  self:__ClearDragHeroEndTween()
  DestroyUnityObject(self.gameObject)
end

return FmtHeroEntity
