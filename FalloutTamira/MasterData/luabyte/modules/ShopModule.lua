local M = BaseClass("ShopModule", require("Framework.Module.BaseGameModule"))
local AutoBackground = CS.AutoBackground
local showHeroId = 120002

function M:OnEnter(shopType, rechargeType)
    IRoleActionMgr:Reset()
    self.shopType = shopType
    self.rechargeType = rechargeType
    OtakuFurniturDataMgr:GetFurnituresByPage(-1, Bind(self, self.GetFurnitureDataCallBack))
end

function M:GetFurnitureDataCallBack(data)
    ShopDataMgr:RequestEnterShop(self.shopType, self.rechargeType, Bind(self, self.EnterShopCallBack))
end

function M:EnterShopCallBack(shopType, rechargeType, isSuc)
    if not isSuc then
        self.hasError = true
        return
    end
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self.LoadSceneComplete))
    else
        self:LoadSceneComplete(self:GetViewAndCtrl("Display02"))
    end
end

function M:LoadSceneComplete(_, ctrl)
    --self:CreateLandlady()
    EventMgr:Broadcast(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, "ShopBg")
    --ctrl:ChangeDisplay("ShopBg")
    --AutoBackground.ReDrawAll()
    UIContextMgr:GetInstance():Show("ShopUI", self.shopType, self.rechargeType)
    self:Ready()
end

-- function M:CreateLandlady()
--     local model = CS.UnityEngine.GameObject.Find("ShopModel").transform
--     if self.landlady then
--         UIContextMgr:GetInstance():Show("ShopUI", self.shopType, self.rechargeType)
--     else
--         RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
--         UIContextMgr:GetInstance():Show("ShopUI", self.shopType, self.rechargeType)
--         self.landlady = RoleBehaviorCtrl:GetInstance():CreateGirl(showHeroId, false,
--             require("RoleBehavior.Ctrls.CommonShowCtrl"), RoleUse.Shop)
--         self.landlady.transform:SetParent(model)
--         self.landlady:SetCanTouch(false)
--         self.landlady.transform:Reset()
--     end
--     self.landlady:Run()
-- end

function M:OnExit()
    self.shopType = nil
    self.rechargeType = nil
    self.landlady = nil
    UIContextMgr:GetInstance():Close("ShopUI")
    RoleBehaviorCtrl:GetInstance():RemoveGirl(showHeroId, RoleUse.Shop)
    M.super.OnExit(self)
end

return M
