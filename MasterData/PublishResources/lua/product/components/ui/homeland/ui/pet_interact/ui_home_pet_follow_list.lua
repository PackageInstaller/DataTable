_class("UIHomePetFollowList", UIController)
UIHomePetFollowList = UIHomePetFollowList

function UIHomePetFollowList:OnShow(uiParams)
  self._callback = uiParams[1]
  self._pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._downMask = self:GetGameObject("downMask")
  self:RefreshList()
end

function UIHomePetFollowList:RefreshList()
  local homeModule = GameGlobal.GetModule(HomelandModule)
  local uiHomeModule = homeModule:GetUIModule()
  local homeClient = uiHomeModule:GetClient()
  local followList = homeClient:PetManager():GetFollowPets()
  local count = table.count(followList)
  if count <= 0 then
    self:CloseDialog()
    return
  end
  self._downMask:SetActive(3 < count)
  self._pool:SpawnObjects("UIHomePetFollowListItem", count)
  local items = self._pool:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    local pet = followList[i]
    if i <= count then
      item:Active(true)
      local last = i == count
      item:SetData(i, pet, function(pet)
        self:ItemClick(pet)
      end, last)
    else
      item:Active(false)
    end
  end
end

function UIHomePetFollowList:ItemClick(pet)
  self._delPet = pet
  local title = ""
  local desc = StringTable.Get("str_homeland_pet_interact_dont_follow")
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function(param)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeInteractFollow, false, self._delPet)
      self:RefreshList()
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn)
end

function UIHomePetFollowList:BgOnClick(go)
  self:CloseDialog()
end

function UIHomePetFollowList:OnHide()
  if self._callback then
    self._callback()
  end
end

function UIHomePetFollowList:ShapeBtnOnClick(go)
  self:ShowDialog("UIHomePetFollow")
end
