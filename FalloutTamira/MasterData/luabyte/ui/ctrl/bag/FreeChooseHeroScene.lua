local M = BaseClass("FreeChooseHeroScene", UIBaseComponent)
local nationPath = "UI/SpritePics/nation/ui_icon_nation_%d"

function M:SetHero(heroId)
    if not self._heroId then self._heroId = 0 end
    if heroId == 0 then
        if self._heroId > 0 then
            RoleBehaviorCtrl:GetInstance():RemoveGirlByHeroId(self._heroId, RoleUse.ChooseBox)
        end
        return
    end
    RoleBehaviorCtrl:GetInstance():RemoveGirlByHeroId(self._heroId, RoleUse.ChooseBox)
    self._heroId = heroId

    local role = ConfigHelper.GetCfgByLua("role", self._heroId)
    if role then
        self._view.nation:SetSprite(string.format(nationPath, role.faction))
    else
        Logger.LogError("role is nil, id = " .. heroId)
    end
    -- self._view.drag:ResetRotation()
    -- 49:英雄自选箱动作
    self._girlBeavourCtrl = RoleBehaviorCtrl:GetInstance():CreateCommonGirl(heroId, false, 49, 1, RoleUse.ChooseBox, 1)
    self._girlBeavourCtrl:Run()
    local shorGirl = self._girlBeavourCtrl:GetGirl()
    shorGirl.transform:SetParent(self._view.girlPos)
    shorGirl.transform:Reset()
end

function M:SetPos(x, y, z)
    self._view.transform:SetPos(x, y, z)
end

function M:SetCam(cam)
    local camPosTrans = self._view.camPos
    local trans = cam.transform
    trans:SetPositionAndRotation(camPosTrans)
end

function M:OnDestroy()
    RoleBehaviorCtrl:GetInstance():RemoveGirlByHeroId(self._heroId or 0, RoleUse.ChooseBox)
    self._girlBeavourCtrl = nil
    GameUtil.DestroyGo(self._view.gameObject)
    self._heroId = nil
    M.super.OnDestroy(self)
end

return M
