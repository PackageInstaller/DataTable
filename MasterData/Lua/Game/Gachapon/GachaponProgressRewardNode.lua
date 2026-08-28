-------------------------------------------------------------------------------
-- 抽卡 -  进度奖励节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-12 19:59:03
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Gachapon/GachaponRewardNode.prefab > name: GachaponRewardNode
---@class GachaponProgressRewardNode
---@field Env                           	GachaponProgressRewardNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgIcon2                      	UnityEngine.RectTransform               @ 奖励图标2
---@field ImgIcon                       	UnityEngine.RectTransform               @ 奖励图标
---@field TextProgress                  	UnityEngine.RectTransform               @ 进度值文本
---@field TextNumber                    	UnityEngine.RectTransform               @ 奖励数量文本
---@field ImgBg                         	UnityEngine.RectTransform               @ 圆箭头底框
local GachaponProgressRewardNode = Class('GachaponProgressRewardNode')


function GachaponProgressRewardNode:__init()
end


function GachaponProgressRewardNode:__delete()
end


function GachaponProgressRewardNode:Awake()
end


function GachaponProgressRewardNode:Start()
    SetButtonAction(self.controller, Bind(self, self.OnNodeClickHandler_))
end


function GachaponProgressRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function GachaponProgressRewardNode:GetRewardDataIndex()
    return checkInt(self.rewardDataIndex_)
end
function GachaponProgressRewardNode:SetRewardDataIndex(dataIndex)
    self.rewardDataIndex_ = checkInt(dataIndex)
end


---@return fun(sender:GachaponProgressRewardNode):void
function GachaponProgressRewardNode:GetClickNodeCB()
    return self.clickNodeCallback_
end
function GachaponProgressRewardNode:SetClickNodeCB(clickCallback)
    self.clickNodeCallback_ = clickCallback
end


---@return Constants.GetStatus
function GachaponProgressRewardNode:GetNodeDrawState()
    return self.nodeDrawState_
end
function GachaponProgressRewardNode:SetNodeDrawState(drawState)
    self.nodeDrawState_ = checkInt(drawState)
    self:UpdateNodeDrawState_()
end


---@return integer
function GachaponProgressRewardNode:GetRewardGoodsId()
    return checkInt(self.rewardGoodsId_)
end
function GachaponProgressRewardNode:SetRewardGoodsId(goodsId)
    self.rewardGoodsId_ = checkInt(goodsId)
    self:UpdateRewardGoodsIcon_()
end


---@return integer
function GachaponProgressRewardNode:GetRewardGoodsNum()
    return checkInt(self.rewardGoodsNum_)
end
function GachaponProgressRewardNode:SetRewardGoodsNum(goodsNum)
    self.rewardGoodsNum_ = checkInt(goodsNum)
    self:UpdateRewardGoodsNum_()
end


---@return integer
function GachaponProgressRewardNode:GetRewardDrawTimes()
    return checkInt(self.rewardDrawTimes_)
end
function GachaponProgressRewardNode:SetRewardDrawTimes(drawTimes)
    self.rewardDrawTimes_ = checkInt(drawTimes)
    self:UpdateRewardDrawTimes_()
end


---@return integer
function GachaponProgressRewardNode:GetPositionIndex()
    return checkInt(self.positionIndex_)
end
function GachaponProgressRewardNode:SetPositionIndex(posIndex)
    self.positionIndex_ = checkInt(posIndex)
end


-------------------------------------------------
-- public

---@param rewardIndex integer
---@param rewardData table
function GachaponProgressRewardNode:RefreshData(rewardIndex, rewardData)
    local newRewardData = checkTable(rewardData)
    local drawGoodsData = checkTable(newRewardData.reward)
    self:SetRewardGoodsId(drawGoodsData.goodsId)
    self:SetRewardGoodsNum(drawGoodsData.num)
    self:SetPositionIndex(newRewardData.level)
    self:SetRewardDrawTimes(newRewardData.times)
    self:SetRewardDataIndex(rewardIndex)
end


-------------------------------------------------
-- private

function GachaponProgressRewardNode:UpdateRewardGoodsIcon_()
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(self:GetRewardGoodsId())
    CfUtils.FillImage(self.ImgIcon2, goodsVo.photoPath)
    CfUtils.FillImage(self.ImgIcon, goodsVo.photoPath)
end


function GachaponProgressRewardNode:UpdateRewardGoodsNum_()
    CfUtils.FillText(self.TextNumber, self:GetRewardGoodsNum())
end


function GachaponProgressRewardNode:UpdateRewardDrawTimes_()
    CfUtils.FillText(self.TextProgress, self:GetRewardDrawTimes())
end


function GachaponProgressRewardNode:UpdateNodeDrawState_()
    if self:GetNodeDrawState() == Constants.GetStatus.Can then
        CfUtils.PlayAnimation(self.controller, 'UIFX_GachaponRewardNode_Available')
    else
        CfUtils.PlayAnimation(self.controller, 'UIFX_GachaponRewardNode_Default')
    end
    if self:GetNodeDrawState() == Constants.GetStatus.Has then
        CfUtils.SetUISwitchImage(self.ImgBg, 2)
        CfUtils.SetUISwitchText(self.TextNumber, 2)
        CfUtils.SetColorString(self.ImgIcon, '#8c8c8c')
    else
        CfUtils.SetUISwitchImage(self.ImgBg, 1)
        CfUtils.SetUISwitchText(self.TextNumber, 1)
        CfUtils.SetColorString(self.ImgIcon, '#FFFFFF')
    end
    CfUtils.SetUISwitchText(self.TextProgress, self:GetNodeDrawState() == Constants.GetStatus.Not and 1 or 2)
end


-------------------------------------------------
--- handler

function GachaponProgressRewardNode:OnNodeClickHandler_()
    if self:GetClickNodeCB() then
        self:GetClickNodeCB()(self)
    end
end


return GachaponProgressRewardNode
