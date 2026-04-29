_class("UIHomelandTestFunc", UICustomWidget)
UIHomelandTestFunc = UIHomelandTestFunc

function UIHomelandTestFunc:_GetComponents()
  self._window = self:GetGameObject("TestFuncWindow")
  self._gameobj = self:GetGameObject()
end

function UIHomelandTestFunc:OnShow(uiParams)
  self._homelandClient = GameGlobal.GetUIModule(HomelandModule):GetClient()
  self._mainCharacter = self._homelandClient:CharacterManager():MainCharacterController()
  self._petId = 1600061
  self:_GetComponents()
  self._window:SetActive(false)
  self._main = UITestFuncBtnManager:New(self, "Group_Activity")
  self:_SetContent_Main(self._main)
  self._main:SpawnBtns()
end

function UIHomelandTestFunc:OnHide()
end

function UIHomelandTestFunc:Switch(show)
  self._gameobj:SetActive(show)
end

function UIHomelandTestFunc:TestFuncEntryOnClick()
  self._window:SetActive(true)
end

function UIHomelandTestFunc:TestFuncWindowOnClick()
  self._window:SetActive(false)
end

function UIHomelandTestFunc:_SetContent_Main(manager)
  manager:AddBtn_Toggle("活动调试开关", function()
    self:_GetToggleFunc_ActivityDebug()
  end)
  manager:AddBtn_Default("剧情测试", function()
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
      self:SwitchState(UIStateType.UIHomeStoryController)
    end)
  end)
  manager:AddBtn_ShowDialog("宿舍", "UIHomeDomitory")
  manager:AddBtn_ShowDialog("商店", "UIHomelandShopController")
  manager:AddBtn_ShowDialog("打造", "UIForge")
  manager:AddBtn_Default("删除秘闻缓存", function()
    local key = "HomeSecretMsg_" .. GameGlobal.GameLogic():GetOpenId()
    LocalDB.Delete(key)
  end)
  manager:AddBtn_Default("删除家园币上限提示", function()
    local key = GameGlobal.GameLogic():GetOpenId() .. "_HomeReachCoinCeiling"
    LocalDB.Delete(key)
  end)
  manager:AddBtn_ShowDialog("交互效果-2", "UIHomelandTaskFinishEffect", {
    -2,
    nil,
    nil,
    nil
  })
  manager:AddBtn_ShowDialog("交互效果-1", "UIHomelandTaskFinishEffect", {
    -1,
    nil,
    nil,
    nil
  })
  self:_FillData_Pet(manager)
end

function UIHomelandTestFunc:_FillData_Pet(manager)
  manager:AddBtn_Default("光灵-白兰", function()
    self:_SetPetId(1400411)
  end)
  manager:AddBtn_Default("光灵-卡莲", function()
    self:_SetPetId(1600061)
  end)
  manager:AddBtn_Default("移动到光灵", function()
    self:_HomelandMoveToPet(self._petId)
  end)
  manager:AddBtn_Default("钓鱼比赛-河边", function()
    self:_HomelandMove(self._petId)
    self:_HomelandPetChangeBehavior(self._petId, HomelandPetBehaviorType.FishingMatch)
  end)
  manager:AddBtn_Default("钓鱼比赛-钓鱼", function()
    local pet = self._homelandClient:PetManager():GetPet(self._petId)
    if pet then
      local type = pet:GetPetBehavior():GetCurBehavior():GetBehaviorType()
      if type == HomelandPetBehaviorType.FishingMatch then
        pet:GetPetBehavior():GetCurBehavior():FishMatchStart(0, 1001)
      end
    end
  end)
end

function UIHomelandTestFunc:_GetToggleFunc_ActivityDebug()
  local function click()
    local key = UIActivityHelper.GetDebugOpenKey()
    
    if LocalDB.HasKey(key) then
      ToastManager.ShowToast("Close")
      LocalDB.Delete(key)
    else
      LocalDB.SetInt(key, 1)
      ToastManager.ShowToast("Open")
    end
  end
  
  local function getValue()
    local key = UIActivityHelper.GetDebugOpenKey()
    local hasKey = LocalDB.HasKey(key)
    return hasKey
  end
  
  return click, getValue
end

function UIHomelandTestFunc:_SetPetId(petId)
  self._petId = petId
  local str = "设置光灵 petId = " .. petId
  ToastManager.ShowToast(str)
end

function UIHomelandTestFunc:_HomelandMoveToPet(petId)
  local pet = self._homelandClient:PetManager():GetPet(petId)
  if pet then
    local playerPos = pet:GetPosition()
    self._mainCharacter:SetLocation(playerPos, Quaternion.identity)
  end
end

function UIHomelandTestFunc:_HomelandMove(petId)
  local pet = self._homelandClient:PetManager():GetPet(petId)
  if pet then
    local playerPos, petPos = Vector3(-94, -5, 103), Vector3(-95, -5, 102)
    pet:SetPosition(petPos)
    pet:ResetNavmeshPos()
    self._mainCharacter:SetLocation(playerPos, Quaternion.identity)
  end
end

function UIHomelandTestFunc:_HomelandPetChangeBehavior(petId, type)
  local pet = self._homelandClient:PetManager():GetPet(petId)
  if pet then
    if type == HomelandPetBehaviorType.FishingPrepare or type == HomelandPetBehaviorType.FishingMatch then
      pet:SetOccupied(HomelandPetOccupiedType.FishingMatch)
    end
    pet:ChangeBehavior(type)
  end
end
