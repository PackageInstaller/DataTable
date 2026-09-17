local this = class("petHouseTimelineState")
this.timelineAssetName = {
  None = "None",
  MainLoop = "MainLoop",
  BreedLoop = "BreedLoop",
  EggHouseLoop = "EggHouseLoop",
  HatchLoop = "HatchLoop",
  ShopLoop = "ShopLoop",
  BreedToMain = "BreedToMain",
  EgghouseToHatch = "EgghouseToHatch",
  EgghouseToMain = "EgghouseToMain",
  HatchToEgghouse = "HatchToEgghouse",
  MainToBreed = "MainToBreed",
  MainToEgghouse = "MainToEgghouse",
  MainToShop = "MainToShop",
  ShopToMain = "ShopToMain"
}
this.timelineNextClipMap = {
  [this.timelineAssetName.BreedToMain] = this.timelineAssetName.MainLoop,
  [this.timelineAssetName.EgghouseToHatch] = this.timelineAssetName.HatchLoop,
  [this.timelineAssetName.EgghouseToMain] = this.timelineAssetName.MainLoop,
  [this.timelineAssetName.HatchToEgghouse] = this.timelineAssetName.EggHouseLoop,
  [this.timelineAssetName.MainToBreed] = this.timelineAssetName.BreedLoop,
  [this.timelineAssetName.MainToEgghouse] = this.timelineAssetName.EggHouseLoop,
  [this.timelineAssetName.MainToShop] = this.timelineAssetName.ShopLoop,
  [this.timelineAssetName.ShopToMain] = this.timelineAssetName.MainLoop,
  [this.timelineAssetName.MainLoop] = this.timelineAssetName.MainLoop,
  [this.timelineAssetName.BreedLoop] = this.timelineAssetName.BreedLoop,
  [this.timelineAssetName.HatchLoop] = this.timelineAssetName.HatchLoop,
  [this.timelineAssetName.ShopLoop] = this.timelineAssetName.ShopLoop,
  [this.timelineAssetName.EggHouseLoop] = this.timelineAssetName.EggHouseLoop
}
this.timelineAssetNameInWhichState = {
  [this.timelineAssetName.BreedToMain] = L_Const.petTimelineState.Main,
  [this.timelineAssetName.EgghouseToHatch] = L_Const.petTimelineState.Hatch,
  [this.timelineAssetName.EgghouseToMain] = L_Const.petTimelineState.Main,
  [this.timelineAssetName.HatchToEgghouse] = L_Const.petTimelineState.EggHouse,
  [this.timelineAssetName.MainToBreed] = L_Const.petTimelineState.Breed,
  [this.timelineAssetName.MainToEgghouse] = L_Const.petTimelineState.EggHouse,
  [this.timelineAssetName.MainToShop] = L_Const.petTimelineState.Shop,
  [this.timelineAssetName.ShopToMain] = L_Const.petTimelineState.Main,
  [this.timelineAssetName.MainLoop] = L_Const.petTimelineState.Main,
  [this.timelineAssetName.BreedLoop] = L_Const.petTimelineState.Breed,
  [this.timelineAssetName.HatchLoop] = L_Const.petTimelineState.Hatch,
  [this.timelineAssetName.ShopLoop] = L_Const.petTimelineState.Shop,
  [this.timelineAssetName.EggHouseLoop] = L_Const.petTimelineState.EggHouse
}
this.timelineStateChangeMap = {
  [L_Const.petTimelineState.Main] = {
    [L_Const.petTimelineState.Breed] = this.timelineAssetName.MainToBreed,
    [L_Const.petTimelineState.EggHouse] = this.timelineAssetName.MainToEgghouse,
    [L_Const.petTimelineState.Shop] = this.timelineAssetName.MainToShop
  },
  [L_Const.petTimelineState.Shop] = {
    [L_Const.petTimelineState.Main] = this.timelineAssetName.ShopToMain
  },
  [L_Const.petTimelineState.EggHouse] = {
    [L_Const.petTimelineState.Main] = this.timelineAssetName.EgghouseToMain,
    [L_Const.petTimelineState.Hatch] = this.timelineAssetName.EgghouseToHatch
  },
  [L_Const.petTimelineState.Hatch] = {
    [L_Const.petTimelineState.EggHouse] = this.timelineAssetName.HatchToEgghouse
  },
  [L_Const.petTimelineState.Breed] = {
    [L_Const.petTimelineState.Main] = this.timelineAssetName.BreedToMain
  }
}

function this:ctor()
  self.control = nil
end

function this:dispose()
  self.control = nil
end

function this:getIsStartAni(timelineAssetName)
  if timelineAssetName == self.timelineAssetName.None then
    return true
  end
  return false
end

function this:getIsTransition(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  local isTransition = false
  isTransition = self.timelineNextClipMap[timelineAssetName] ~= timelineAssetName
  return isTransition
end

function this:getState(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  if curState == nil then
    curState = L_Const.petTimelineState.Main
  end
  return curState
end

function this:getNextStateTransitionAssetName(timelineAssetName, targetState)
  local curState = self:getState(timelineAssetName)
  if self:getIsTransition(timelineAssetName) then
    if curState ~= targetState and self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
      return self.timelineStateChangeMap[curState][targetState]
    end
    return self.timelineNextClipMap[timelineAssetName]
  end
  if curState == targetState then
    return self.timelineNextClipMap[timelineAssetName]
  end
  if curState == L_Const.petTimelineState.Main then
    if targetState == L_Const.petTimelineState.Main then
      return self.timelineAssetName.None
    else
      return self.timelineAssetName.None
    end
  end
  if self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
    return self.timelineStateChangeMap[curState][targetState]
  end
  print("state change fail curState:" .. curState .. " targetState: " .. targetState)
  return self.timelineNextClipMap[timelineAssetName]
end

return this
