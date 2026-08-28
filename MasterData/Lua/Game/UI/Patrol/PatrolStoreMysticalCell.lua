---
--- Created by Eric.
--- DateTime: 2021/10/18 15:35
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolStoreMysticalCell
---@field TextSoldOut                   	UnityEngine.RectTransform
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field TextNowPrice                  	TMPro.TextMeshProUGUI
---@field TextOldPrice                  	TMPro.TextMeshProUGUI
---@field TextName                      	UnityEngine.UI.Text
---@field GoodNode                      	UnityEngine.RectTransform
---@field InTheSale                     	UnityEngine.CanvasGroup
---@field StoreBtnNode                  	UnityEngine.RectTransform
local PatrolStoreMysticalCell = Class("PatrolStoreMysticalCell")
function PatrolStoreMysticalCell:__init()
    self.btnAction = nil
    self.mazeGoodVo = {}
end

function PatrolStoreMysticalCell:__delete()
    self.btnAction = nil
    self.mazeGoodVo = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function PatrolStoreMysticalCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function PatrolStoreMysticalCell:Awake()
    SetButtonAction(self.StoreBtnNode, function ()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
    UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
    end
end

function PatrolStoreMysticalCell:FreshBaseUI(data)
    --printInfo("Item=====>>"..table.dump(data,nil,3))
    local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting363, "MazeGoodsVo", data.goodsId)
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.itemId)
    local goodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    self.TextName.text = vo.name
    self.TextOldPrice.text = mazeGoodVo.oldPrice
    self.TextNowPrice.text = mazeGoodVo.newPrice
    local currency = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.goodsConsum)
    self.ImgIcon:LoadSprite(currency.photoPath)
    self:FreshSoldOutStatus(data.num <= 0)
    goodNodeEnv:SetClickButtonAction(function()
        if data.num > 0 then
            if isTable(vo) then
                GameUtils.ShowCommonTipsBoard(self.GoodNode.gameObject, vo.name, vo.desc, vo.quality, vo.id)
            end
        end
    end)
    goodNodeEnv:Reload({ goodsId = mazeGoodVo.itemId,
                 isShowNo = true, text = 'x' .. mazeGoodVo.itemNum
    })
end

function PatrolStoreMysticalCell:FreshSoldOutStatus(isSoldOut)
    self.InTheSale.alpha = isSoldOut and 0.5 or 1
    KTool.SetActive(self.TextOldPrice.transform, not isSoldOut)
    KTool.SetActive(self.TextSoldOut, isSoldOut)
    KTool.SetActive(self.StoreBtnNode.transform:Find("AnimRoot/UIFX_PatrolMysticalStorePanel").gameObject, not isSoldOut)
    if isSoldOut then
        --local goodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
        --goodNodeEnv:Reload({ goodsId = mazeGoodVo.itemId,
        --                     isShowNo = true, text = 'x' .. FormatCurrencyNum(0)
        --})
    end
end

function PatrolStoreMysticalCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolStoreMysticalCell