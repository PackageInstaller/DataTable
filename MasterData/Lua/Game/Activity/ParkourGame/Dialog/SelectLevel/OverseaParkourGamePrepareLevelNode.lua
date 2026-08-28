---
--- 微缩世界 跑酷选关界面 关卡队列元素



local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)





--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourStartRunCell.prefab > name: OverseaParkourStartRunCell
---@class OverseaParkourGamePrepareLevelNode
---@field Env                           	OverseaParkourGamePrepareLevelNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 0    三颗星
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 1    三颗星
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 2    三颗星
---@field TextLevel                     	UnityEngine.RectTransform               	@ 3    左侧数字, "01"
---@field ImgBg                         	UnityEngine.RectTransform               	@ 4    底图, 1:未选中, 2:选中
---@field StatusLock                    	UnityEngine.RectTransform               	@ 5    锁:   /ImgSymbol: 1:选中, 2:未选中
---@field SelectNode                    	UnityEngine.RectTransform               	@ 6    选中 方括号
---@field Root                          	UnityEngine.RectTransform               	@ 7    播动画
---@field SelectBird                    	UnityEngine.RectTransform               	@ 8    鸟头
---@field NumberOfFloor                 	UnityEngine.RectTransform               	@ 9    左侧logo, 1:未选中 2:选中
local OverseaParkourGamePrepareLevelNode = Class("OverseaParkourGamePrepareLevelNode")

function OverseaParkourGamePrepareLevelNode:__init()
    self._cb = nil
end

function OverseaParkourGamePrepareLevelNode:__delete()
    self._cb = nil
end

function OverseaParkourGamePrepareLevelNode:Awake()
    SetButtonAction(self.Root, Bind(self, self.OnBtnClick))

    self.LockImgSymbol = self.StatusLock:Find("ImgSymbol")

    self:_FillSelect(false) -- 默认状态
    self.EventChangeSelect = Events.AddListener("Parkour_ChangeSelect", function( selectIdx1Based_ )
        self:_FillSelect( selectIdx1Based_ == self.idx1based )
    end)

end


function OverseaParkourGamePrepareLevelNode:Start()
    -- CfUtils.PlayAnimation(self.controller.gameObject, "ActivityCakeShopFightDialog_List_Cell_Show")
end


function OverseaParkourGamePrepareLevelNode:OnDestroy()

    if self.EventChangeSelect then
        Events.RemoveListener("Parkour_ChangeSelect", self.EventChangeSelect)
    end

    if self._co then
        cs_coroutine.stop(self._co)
        self._co = nil
    end

    self.controller = nil
    self:Delete()
    self = nil
end



---@param cb function
function OverseaParkourGamePrepareLevelNode:Refresh(idx1based_, starNum_, isLock_, isSelect_, cb)

    self.idx1based = checkInt(idx1based_)

    self.starNum = checkInt(starNum_)
    assert( self.starNum>=0 and self.starNum<=3 )

    self.isLock = isLock_==true
    self._cb = cb
    
    self:FillSelf()
    self:_FillSelect( isSelect_ == true )
end





function OverseaParkourGamePrepareLevelNode:_FillSelect( isSelect_ )
    if isSelect_ then
        CfUtils.PlayDelayShowAnimation(self.Root, 1, "OverseaParkourStartRunCell_Cell_Selected", "OverseaParkourStartRunCell_Cell_Selecting")
    else
        CfUtils.PlayAnimation(self.Root, "OverseaParkourStartRunCell_Cell_UnSelect")
    end
    local idx = isSelect_ and 2 or 1
    CfUtils.SetUISwitchText(self.TextLevel, idx)
    CfUtils.SetUISwitchImage(self.LockImgSymbol, idx)
    CfUtils.SetUISwitchImage(self.ImgBg, idx)
    CfUtils.SetActive( self.SelectNode, isSelect_ )
    CfUtils.SetActive( self.SelectBird, isSelect_ )

    CfUtils.SetUISwitchImage(self.NumberOfFloor, idx )
end



function OverseaParkourGamePrepareLevelNode:FillSelf()

    CfUtils.SetUISwitchImage(self.ImgStar1, self.starNum > 0 and 2 or 1 )
    CfUtils.SetUISwitchImage(self.ImgStar2, self.starNum > 1 and 2 or 1 )
    CfUtils.SetUISwitchImage(self.ImgStar3, self.starNum > 2 and 2 or 1 )
    ---
    CfUtils.SetActive(self.StatusLock, self.isLock == true )
    ---
    local idxStr = tostring(self.idx1based)
    if self.idx1based <= 9 then 
        idxStr = "0" .. idxStr
    end
    CfUtils.FillText(self.TextLevel, idxStr )
end


function OverseaParkourGamePrepareLevelNode:OnBtnClick()
    if self._cb ~= nil then
        self._cb(self.idx1based)
    end
end



return OverseaParkourGamePrepareLevelNode
