---
--- Created by Eric.
--- DateTime: 2021/12/10 15:41
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseInteractionToyCell
---@field TextNumberRecovery            	TMPro.TextMeshProUGUI
---@field BtnReduce                     	UnityEngine.RectTransform
---@field TextNumerChoose               	TMPro.TextMeshProUGUI
---@field ChooseNumber                  	UnityEngine.RectTransform
---@field ToastArea                     	UnityEngine.RectTransform
---@field JumpArea                      	UnityEngine.RectTransform
---@field Lock                          	UnityEngine.RectTransform
---@field AttributeNode                 	UnityEngine.RectTransform
---@field IncreaseAttribute             	UnityEngine.RectTransform
---@field TextNumberStock               	TMPro.TextMeshProUGUI
---@field ImgIconStrength               	Engine.UI.RawImageAlterable
---@field TextNumberResume              	TMPro.TextMeshProUGUI
---@field TextTotalGrowthValue          	TMPro.TextMeshProUGUI
---@field TextName                      	UnityEngine.UI.Text
---@field GoodNode                      	UnityEngine.RectTransform
---@field Unlock                        	UnityEngine.RectTransform
---@field BtnContent                    	UnityEngine.RectTransform
local CatHouseInteractionToyCell = Class("CatHouseInteractionToyCell")
function CatHouseInteractionToyCell:__init()
    self.index = nil
    self.attrNodeList = {}
    self.stock = 0
end

function CatHouseInteractionToyCell:__delete()
    self.index = nil
    self.attrNodeList = nil
    self.stock = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseInteractionToyCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseInteractionToyCell:Awake()
    self:InitAction()

end

function CatHouseInteractionToyCell:InitAction()
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

function CatHouseInteractionToyCell:SetImgBgDownAction(cb)
    self.imgBgDownAction = cb
end

function CatHouseInteractionToyCell:SetImgBgUpAction(cb)
    self.imgBgUpAction = cb
end

function CatHouseInteractionToyCell:SetBtnReduceDownAction(cb)
    self.btnReduceDownAction = cb
end

function CatHouseInteractionToyCell:SetBtnReduceUpAction(cb)
    self.btnReduceUpAction = cb
end

function CatHouseInteractionToyCell:OnClickImgBgDownAction()
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

function CatHouseInteractionToyCell:OnClickImgBgUpAction()
    if self.imgBgUpAction then
        self.imgBgUpAction()
    end
end

function CatHouseInteractionToyCell:OnClickBtnReduceDownAction()
    if self.btnReduceDownAction then
        self.btnReduceDownAction()
    end
end

function CatHouseInteractionToyCell:OnBtnReduceUpAction()
    if self.btnReduceUpAction then
        self.btnReduceUpAction()
    end
end

function CatHouseInteractionToyCell:FreshBaseUI(data, index)
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
    self.TextTotalGrowthValue.text = 1
    self.TextNumberResume.text = data.strengthNum
    self.TextNumberStock.text = self.stock
    local strengthVo = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", 5)
    self.ImgIconStrength:LoadSprite(strengthVo.picture)

    local totalGrowthValue = 0
    local attrIdList = parse_strings(data.attributeId)
    local attrNumList = parse_strings(data.attributeNum)
    local goCount = self.IncreaseAttribute.transform.childCount - 1 --减去默认prefab的数量
    if goCount > #attrIdList then
        for i = #attrIdList + 1, goCount do --复用时隐藏多出来的
            KTool.SetActive(self.attrNodeList[i], false)
        end
    end
    for i = 1, #attrIdList do
        local go
        go = self.attrNodeList[i]
        if not go then
            go = CfUtils.InstantiateGo(self.AttributeNode, self.IncreaseAttribute)
            go.name = "attrNode"..i
            self.attrNodeList[i] = go
        end
        local catAttrData = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", attrIdList[i])
        CfUtils.FillImage(go.transform:Find("ImgIcon"), catAttrData.picture)
        CfUtils.FillText(go.transform:Find("TextNumber"), attrNumList[i])
        totalGrowthValue = totalGrowthValue + attrNumList[i]
        KTool.SetActive(go, true)
    end

    self.TextNumberRecovery.text = totalGrowthValue
    if isUnlock then



    end
end

function CatHouseInteractionToyCell:FreshNumText(num)
    local isChoose = num > 0
    KTool.SetActive(self.ChooseNumber, isChoose)
    self.TextNumerChoose.text = num
end

function CatHouseInteractionToyCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionToyCell