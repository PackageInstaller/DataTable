local this = class("pagePetPuzzleRoulette", G_UIPageBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local maxCount = 8

function this.bind()
  return {
    modulePetRouletteList = {
      moduleName = "pages/petPuzzleRoulette/cellPetRoulette"
    },
    petSelectRot = L_Vector3.new(0, 0, 0)
  }
end

function this.methods()
  return {
    modulePetRouletteList = {
      onClick_selectPet = function(self, isFake, id, petConfId)
        if isFake then
        else
          local pet = L_PetStore:getPetItem(id)
          if pet == nil then
            return
          end
        end
        if self.calback then
          self.calback(true, isFake, id, petConfId)
        end
        L_UI:close("pagePetPuzzleRoulette")
      end
    },
    onClick_close = function(self)
      if self.calback then
        self.calback(false)
      end
      L_UI:close("pagePetPuzzleRoulette")
    end
  }
end

function this:preOpen(options)
  self.calback = options and options.calback
  self.closeCalBack = options and options.closeCalBack
  self.fakeDatas = options and options.fakeDatas
  self.selectIndex = 0
  self:refresfPuzzleRoulette()
  local current = CS.UnityEngine.InputSystem.Mouse.current
  if current then
    local height = Unity.Screen.height / 2
    local width = Unity.Screen.width / 2
    current:WarpCursorPosition(C_Vector2(width, height))
  end
end

function this:close(options)
  if self.closeCalBack then
    self.closeCalBack()
  end
end

function this:update()
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local _, uiPos = _screenPosToUI(self.bindComponents.petRoulette, C_Vector2(mousePosition.x, mousePosition.y), C_CameraManager.uiCamera)
  local deg = 0
  if uiPos.x == 0 then
    if uiPos.y >= 0 then
      deg = 270
    else
      deg = 90
    end
  else
    deg = math.atan(uiPos.y / uiPos.x) * (180 / math.pi)
    if uiPos.x >= 0 then
      if uiPos.y < 0 then
        deg = -deg
      else
        deg = 360 - deg
      end
    else
      deg = 180 - deg
    end
  end
  deg = deg + 90 + 360 / maxCount / 2
  if 360 <= deg then
    deg = deg - 360
  end
  if 2 > math.abs(uiPos.x) and 2 > math.abs(uiPos.y) then
  else
    local angel = 360 / maxCount
    self.selectIndex = math.floor(deg / angel)
  end
  self.bind.petSelectRot = L_Vector3.new(0, 0, self.selectIndex * -45)
end

function this:refresfPuzzleRoulette()
  local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  local curPetId
  if hero then
    local petData = L_PetStore:getPetItem(L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(hero.data.UUID)))
    if petData then
      curPetId = petData.id
    end
  end
  local petList = L_PetStore:getPetList()
  self.bind.modulePetRouletteList:clear()
  local petRouletteData = {}
  local angel = 360 / maxCount
  if curPetId then
    table.insert(petRouletteData, {
      id = curPetId,
      isFake = false,
      transNodeRot = L_Vector3.new(0, 0, #petRouletteData * -angel),
      petNodeRot = L_Vector3.new(0, 0, #petRouletteData * angel)
    })
  end
  if self.fakeDatas then
    for i, pet in pairs(self.fakeDatas) do
      if #petRouletteData >= maxCount then
        break
      end
      table.insert(petRouletteData, {
        isFake = true,
        petConfId = pet.petConfId,
        transNodeRot = L_Vector3.new(0, 0, #petRouletteData * -angel),
        petNodeRot = L_Vector3.new(0, 0, #petRouletteData * angel)
      })
    end
  end
  for i, pet in pairs(petList) do
    if #petRouletteData >= maxCount then
      break
    end
    if pet.guid == curPetId then
    else
      table.insert(petRouletteData, {
        id = pet.guid,
        isFake = false,
        transNodeRot = L_Vector3.new(0, 0, #petRouletteData * -angel),
        petNodeRot = L_Vector3.new(0, 0, #petRouletteData * angel)
      })
    end
  end
  for i = #petRouletteData, maxCount - 1 do
    table.insert(petRouletteData, {
      id = 0,
      transNodeRot = L_Vector3.new(0, 0, #petRouletteData * -angel),
      petNodeRot = L_Vector3.new(0, 0, #petRouletteData * angel)
    })
  end
  self.bind.modulePetRouletteList:insert_array(petRouletteData)
end

return this
