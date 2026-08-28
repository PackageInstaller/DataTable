---
--- Created by Eric.
--- DateTime: 2021/10/16 14:22
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolStoreSupplyCell
---@field TextSoldOut                   	UnityEngine.RectTransform
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field TextName                      	UnityEngine.UI.Text
---@field GoodNode                      	UnityEngine.RectTransform
---@field InTheSale                     	UnityEngine.CanvasGroup
---@field StoreBtnNode                  	UnityEngine.RectTransform
local PatrolStoreSupplyCell = Class("PatrolStoreSupplyCell")
function PatrolStoreSupplyCell:__init()
    self.btnAction = nil
    self.mazeGoodVo = {}

end

function PatrolStoreSupplyCell:__delete()
    self.btnAction = nil
    self.mazeGoodVo = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function PatrolStoreSupplyCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function PatrolStoreSupplyCell:Awake()
    SetButtonAction(self.StoreBtnNode, function ()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
    --UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end
end

function PatrolStoreSupplyCell:FreshBaseUI(data)

    local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting364, "MazeGoodsVo", data.goodsId)
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.itemId, Constants.IDArea.Maze)
    local goodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    self.TextName.text = vo.name
    self.TextNumber.text = mazeGoodVo.newPrice
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
                         isShowNo = false,
                         idAreaType = Constants.IDArea.Maze
    })
end

function PatrolStoreSupplyCell:FreshSoldOutStatus(isSoldOut)
    self.InTheSale.alpha = isSoldOut and 0.5 or 1
    --KTool.SetActive(self.TextOldPrice.transform, not isSoldOut)
    KTool.SetActive(self.TextSoldOut, isSoldOut)
    KTool.SetActive(self.TextNumber.transform, not isSoldOut)
end

function PatrolStoreSupplyCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolStoreSupplyCell