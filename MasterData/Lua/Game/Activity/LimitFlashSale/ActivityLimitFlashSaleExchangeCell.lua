
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Activity/LimitFlashSaleExchangePopup140001.prefab > name: Cell
---@class ActivityLimitFlashSaleExchangeCell
---@field Env                           	ActivityLimitFlashSaleExchangeCell      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgNone                       	UnityEngine.RectTransform               
---@field TextRemainTimes               	CustomText                              
---@field FontStyleButton               	Game.Native.Common.FontStyleButton               
---@field TxtDesc                       	CustomText                              
---@field RightGoodsList                	UnityEngine.RectTransform               
---@field RightScrollView               	Engine.UI.NestedScrollRect              
---@field LeftScrollView                	Engine.UI.NestedScrollRect              
---@field LeftGoodsList                 	UnityEngine.RectTransform               
local ActivityLimitFlashSaleExchangeCell = Class('ActivityLimitFlashSaleExchangeCell')

function ActivityLimitFlashSaleExchangeCell:__init()

end


function ActivityLimitFlashSaleExchangeCell:__delete()

end


function ActivityLimitFlashSaleExchangeCell:Awake()
    
    self.RightGoodsList.pivot = Vector2.New(0, 0.5)
end


function ActivityLimitFlashSaleExchangeCell:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
end


function ActivityLimitFlashSaleExchangeCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ActivityLimitFlashSaleExchangeCell:FreshUI(data)
    self._data = data
    --- 需求
    local demands = data.consume
    UICommonUtils.FillCommonGoodsListLight(self.LeftGoodsList, demands, false, false, true, true, true) 
    -- self.LeftScrollView.horizontalNormalizedPosition = 0

    --- 奖励
    local rewards = data.rewards
    UICommonUtils.FillCommonGoodsListLight(self.RightGoodsList, rewards, false, false, true, false, true) 
    -- CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.RightGoodsList)
    self.RightGoodsList.anchoredPosition = Vector2.New(0, 0)
    
    -- self.RightScrollView.horizontalNormalizedPosition = 0

    local remain = checkNumber(data.remain)
    --- 全局剩余次数
    self.TxtDesc.text = localize("全服剩余兑换次数：_num_", {_num_ = remain})

    local leftTimes = checkNumber(data.playerRemain)
    --- 自己剩余次数
    self.TextRemainTimes.text = localize("个人剩余兑换次数：_num_", {_num_ = leftTimes}) 

    local isCanExchange = (remain == -1 or remain > 0) and (leftTimes == -1 or leftTimes > 0)
    self._isCanExchange = isCanExchange
    self.FontStyleButton:ResetFontStyle(isCanExchange and "B12" or "B19", isCanExchange and localize("兑换") or localize("无次数"))

    CfUtils.SetActive(self.ImgNone, not isCanExchange)

end


--endregion 


--region get/set 

function ActivityLimitFlashSaleExchangeCell:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function ActivityLimitFlashSaleExchangeCell:OnClickBtnAction()
    print("OnClickBtnAction")
    if not self._isCanExchange then
        GameUtils.Toast(localize("剩余兑换次数不足"))
        return
    end
    if self._callback then
        self._callback(self._data)
    end
end

---endregion 


return ActivityLimitFlashSaleExchangeCell
