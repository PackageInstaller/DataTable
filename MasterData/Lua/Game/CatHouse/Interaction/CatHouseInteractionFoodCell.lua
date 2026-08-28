---
--- Created by Eric.
--- DateTime: 2021/12/10 15:42
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseInteractionFoodCell
---@field BtnReduce                     	UnityEngine.RectTransform
---@field TextNumerChoose               	TMPro.TextMeshProUGUI
---@field ChooseNumber                  	UnityEngine.RectTransform
---@field ToastArea                     	UnityEngine.RectTransform
---@field JumpArea                      	UnityEngine.RectTransform
---@field Lock                          	UnityEngine.RectTransform
---@field ImgIconStrength               	Engine.UI.ImageAlterable
---@field TextNumberRecovery            	TMPro.TextMeshProUGUI
---@field Recovery                      	UnityEngine.RectTransform
---@field TextNumberStock               	TMPro.TextMeshProUGUI
---@field Stock                         	UnityEngine.RectTransform
---@field TextName                      	UnityEngine.UI.Text
---@field GoodNode                      	UnityEngine.RectTransform
---@field BtnContent                    	UnityEngine.RectTransform
---@field Unlock                        	UnityEngine.RectTransform
local CatHouseInteractionFoodCell = Class("CatHouseInteractionFoodCell")
function CatHouseInteractionFoodCell:__init()
    self.index = nil
    self.stock = 0

end

function CatHouseInteractionFoodCell:__delete()
    self.index = nil
    self.stock = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseInteractionFoodCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseInteractionFoodCell:Awake()
    self:InitAction()

end

function CatHouseInteractionFoodCell:InitAction()
    --UIEventProxy.Create(self.ImgIcon.gameObject).onPointerClick = Bind(self, self.OnClickGoodsIconAction)
    UIEventProxy.Create(self.Unlock.gameObject).onPointerDown = Bind(self, self.OnClickImgBgDownAction)
    UIEventProxy.Create(self.Unlock.gameObject).onPointerUp = Bind(self, self.OnClickImgBgUpAction)
    UIEventProxy.Create(self.BtnReduce.gameObject).onPointerDown = Bind(self, self.OnClickBtnReduceDownAction)
    UIEventProxy.Create(self.BtnReduce.gameObject).onPointerUp = Bind(self, self.OnBtnReduceUpAction)
    SetButtonAction(self.JumpArea, function ()
        if self.stock <= 0 then
            ---商城按钮点击的逻辑
            local StoreUtils = import('Game.UI.Store.StoreUtils')
            ---@type StoreConstants
            local StoreConstants = import('Game.UI.Store.StoreConstants')
            StoreUtils.OpenStore(StoreConstants.OpenIds.StoreCatHouse)
            --GameUtils.Toast(localize("数量不足"))
        end
    end)
    SetButtonAction(self.ToastArea, function ()
        if self.stock <= 0 then
            GameUtils.Toast(localize("_name_库存不足，请去购买",{_name_ = self.TextName.text}))
        end
    end)
end



function CatHouseInteractionFoodCell:SetImgBgDownAction(cb)
    self.imgBgDownAction = cb
end

function CatHouseInteractionFoodCell:SetImgBgUpAction(cb)
    self.imgBgUpAction = cb
end

function CatHouseInteractionFoodCell:SetBtnReduceDownAction(cb)
    self.btnReduceDownAction = cb
end

function CatHouseInteractionFoodCell:SetBtnReduceUpAction(cb)
    self.btnReduceUpAction = cb
end

function CatHouseInteractionFoodCell:OnClickImgBgDownAction()
    if self.stock > 0 then
        if self.imgBgDownAction then
            self.imgBgDownAction(self.index)
        end
    else
        -----商城按钮点击的逻辑
        --local StoreUtils = import('Game.UI.Store.StoreUtils')
        -----@type StoreConstants
        --local StoreConstants = import('Game.UI.Store.StoreConstants')
        --StoreUtils.OpenStore(StoreConstants.OpenIds.StoreCatHouse)
        ----GameUtils.Toast(localize("数量不足"))
    end
end

function CatHouseInteractionFoodCell:OnClickImgBgUpAction()
    if self.imgBgUpAction then
        self.imgBgUpAction()
    end
end

function CatHouseInteractionFoodCell:OnClickBtnReduceDownAction()
    if self.btnReduceDownAction then
        self.btnReduceDownAction()
    end
end

function CatHouseInteractionFoodCell:OnBtnReduceUpAction()
    if self.btnReduceUpAction then
        self.btnReduceUpAction()
    end
end

function CatHouseInteractionFoodCell:FreshBaseUI(data, index)
    self.index = index
    self.stock = GoodsUtils.GetThingNo(data.id)
    local isUnlock = self.stock > 0
    --KTool.SetActive(self.Unlock, isUnlock)
    KTool.SetActive(self.Lock, not isUnlock)
    local goodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    goodNodeEnv:SetClickButtonAction(function()
        GameUtils.ShowCommonTipsBoard(self.GoodNode, data.name, data.desc, data.quality, data.id)
    end)
    goodNodeEnv:Reload(
            {
                goodsId = data.id,
                isShowNo = false
            }
    )
    self.TextName.text = data.name
    self.TextNumberStock.text = self.stock
    self.TextNumberRecovery.text = data.effectNum
    local strengthVo = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", 5)
    self.ImgIconStrength:LoadSprite(strengthVo.picture)
    if isUnlock then



    end

end

function CatHouseInteractionFoodCell:FreshNumText(num)
    local isChoose = num > 0
    KTool.SetActive(self.ChooseNumber, isChoose)
    self.TextNumerChoose.text = num

end

function CatHouseInteractionFoodCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionFoodCell