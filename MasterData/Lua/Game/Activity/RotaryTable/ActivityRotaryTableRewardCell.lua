-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 奖励节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-20 12:03:00
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRewardCell122501.prefab
---@class ActivityRotaryTableRewardCell
---@field Env                           	ActivityRotaryTableRewardCell        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GetNode                       	UnityEngine.RectTransform
---@field TxtNumber                     	UnityEngine.RectTransform
---@field NumberNode                    	UnityEngine.RectTransform
---@field ImgBigRewardTips              	UnityEngine.RectTransform
---@field GoodNode                      	UnityEngine.RectTransform
---@field ImgLightSelect                	UnityEngine.RectTransform
---@field ImgBigRewardBg                	UnityEngine.RectTransform
local ActivityRotaryTableRewardCell = Class("ActivityRotaryTableRewardCell")


function ActivityRotaryTableRewardCell:__init()
    ---@type GoodNodeMB
    self.goodsNodeEvn_ = nil
end


function ActivityRotaryTableRewardCell:__delete()
    self.goodsNodeEvn_ = nil
end


function ActivityRotaryTableRewardCell:Awake()
    self.goodsNodeEvn_ = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
end


function ActivityRotaryTableRewardCell:Start()
end


function ActivityRotaryTableRewardCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return boolean
function ActivityRotaryTableRewardCell:IsSelectLight()
    return checkBool(self.isSelectLight_)
end
function ActivityRotaryTableRewardCell:SetSelectLight(isSelect)
    self.isSelectLight_ = checkBool(isSelect)
    CfUtils.SetActive(self.ImgLightSelect, self:IsSelectLight())
end


-------------------------------------------------
-- public

---@param tableRewardVo ActivityRotaryTableRewardVo
function ActivityRotaryTableRewardCell:UpdateRewardInfo(tableRewardVo)
    CfUtils.FillText(self.TxtNumber, "∞")

    -- update bigReward info
    local isBigReward = checkInt(tableRewardVo.rewardType) == 1
    CfUtils.SetActive(self.ImgBigRewardBg, isBigReward)
    CfUtils.SetActive(self.ImgBigRewardTips, isBigReward)
    CfUtils.SetUISwitchImage(self.NumberNode, isBigReward and 2 or 1)

    -- update goodsNode info
    self.goodsNodeEvn_:Reload({
        goodsId  = checkInt(tableRewardVo.reward),
        text     = string.format('x%d', checkInt(tableRewardVo.rewardNum)),
        isShowNo = true,
    })
    
    self.goodsNodeEvn_:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(tableRewardVo.reward)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(self.ImgBigRewardTips.gameObject, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
end


return ActivityRotaryTableRewardCell
