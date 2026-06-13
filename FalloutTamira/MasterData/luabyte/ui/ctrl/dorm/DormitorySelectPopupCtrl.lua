local DormitorySelectPopupCtrl = BaseClass("DormitorySelectPopupCtrl", BaseUICtrl)
local M = DormitorySelectPopupCtrl

function M:Init()
    self._module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormItems = {}
end

function M:OnEnter()
    if #self.dormItems > 0 then
        for i = 1, #self.dormItems do
            GameUtil.DestroyGo(self.dormItems[i]._view.gameObject)
        end
    end
    local cfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    local dormItemCls = require("UI.Ctrl.Dorm.DormItemCtrl")
    for k, v in pairs(cfgs) do
        local heroItem = self._view.HeroItem:Instantiate()
        heroItem:SetParent(self._view.Content)
        heroItem:SetActive(true)
        local ctrlItem = dormItemCls.New(heroItem)
        ctrlItem:UpdateItem(v)
        table.insert(self.dormItems, ctrlItem)
    end
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true 
end

function M:_OnTaskJump()
    self:Close()
end

function M:_OnSelectDoom()
    self._view.Content:SetLayoutGroupSpace(28.0)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return DormitorySelectPopupCtrl
