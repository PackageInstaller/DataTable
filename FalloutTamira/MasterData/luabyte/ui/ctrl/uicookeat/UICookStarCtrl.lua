-- baoruichang
-- 2022/8/31 20:44:54
local UICookStarCtrl = BaseClass("UICookStarCtrl", BaseUICtrl)
local M = UICookStarCtrl
local sfmt = string.format
local tInsert = table.insert

function M:Init()
    self._view.btnMask:onClick(Bind(self, self.Close))
end

-- 进入UI，可传参数
function M:OnEnter(star, food)
    self.Food = food
    self.star = star
    self:InitUI()
    self:InitDesc()
    self:InitStar()
end

-- 点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:InitUI()
    local name = ConfigHelper.GetCfgPropByLua("item", self.Food, "name")
    self._view.labName:SetText(name)
    self._view.imgIcon:SetItemIcon(self.Food)
end

function M:InitDesc()
    local system287 = ConfigHelper.GetSystemParams(287)
    local num1 = system287[self.star * 4 - 2]
    local num2 = system287[self.star * 4 - 1]
    local tips = ConfigHelper.GetLocalString(5607)
    tips = sfmt(tips, num1, "%", num2)
    self._view.labDesc:SetText(tips)
end

function M:InitStar()
    if self.star <= 1 then
        return
    end

    self.tabStar = {}

    for i = 2, self.star do
        local go = GameUtil.Instantiate(self._view.tfStar.gameObject, self._view.tfStar.parent)
        tInsert(self.tabStar, go)
    end
end

function M:OnDispose()
    if self.tabStar then
        for _, go in pairs(self.tabStar) do
            GameUtil.DestroyGo(go)
        end

        self.tabStar = nil
    end

    M.super.OnDispose(self)
end

-- 1,1000,0,0,
-- 2,3000,0,50,
-- 3,3000,0,100,
-- 4,2000,0,150,
-- 5,1000,0,200

return UICookStarCtrl
