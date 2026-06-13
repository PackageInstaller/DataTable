local UIItemGetCtrl = BaseClass("UIItemGetCtrl")
local M = UIItemGetCtrl

function M:__init(view)
    self._view = view
    self._data = nil
    self._tipsId = 0
    self._jumpCfg = nil
    self._isUnlock = false
    self._callback = nil
    self._view.btn:SetOnClick(self, self.OnBtnClick)
    self._view.imageLock:SetOnClick(self, self.OnClickLock)
end

function M:UpdateItem(data)
    self._data = data
    local lockId = JumpMgr:GetInstance():CheckLockByJumpId(self._data.jumpId)
    local jump = ConfigHelper.GetCfgByLua("jump", self._data.jumpId)
    self._isUnlock = not (lockId > 0)

    if not jump then
        Logger.LogError("jump is nil. @熊伟, id = " .. self._data.jumpId)
        return
    end

    self._view.btn:SetActive(self._isUnlock)
    self._view.labDesc:SetText(jump.desc or 0)
    self._view.imageUnlock:SetActive(self._isUnlock)
    self._view.imageLock:SetActive(not self._isUnlock)
    if self._isUnlock then -- 已解锁
        self._view.labDesc:SetColor(255, 255, 255, 255)
        self._view.openTag:SetActive(false)
        self._view.lockTag:SetActive(false)
    else
        self._tipsId = ConfigHelper.GetCfgPropByLua("openCondition", lockId, "tips")
        local isOpen = GameHelper.CheckLockByOpenConditionIds(jump.unlockIds)
        self._view.labDesc:SetColor(65, 65, 65, 255)
        self._view.lockTag:SetActive(not isOpen)
        self._view.openTag:SetActive(isOpen)
        self._view.labLockDesc:SetText("")
    end
    self._view.stateGet:SetState(self._data.wayLabel)
    self._jumpCfg = jump
end

function M:OnBtnClick()
    if not self._isUnlock or not self._jumpCfg then return end
    local jump = self._jumpCfg
    local jumpId = self._jumpCfg.id
    local callback = self._callback
    UIContextMgr:GetInstance():Close(UIDefine.UIItem)
    if callback then callback(jump) end
    if jump.command == "UseItem" then
        ItemHelper.ShowUsePanel(jump.param1)
    else
        GameHelper.Jump(jumpId, self.itemId)
    end
end

function M:SetCallBack(action, itemId)
    self._callback = action
    self.itemId = itemId
end

function M:OnClickLock(go)
    GameHelper.TipsById(self._tipsId)
end

function M:OnDispose()
    self._data = nil
    self._tipsId = 0
    self._jumpCfg = nil
    self._isUnlock = false
    self._callback = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIItemGetCtrl
